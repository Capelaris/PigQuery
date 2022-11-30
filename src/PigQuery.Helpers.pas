unit PigQuery.Helpers;

interface

uses
  PigQuery.Commons, System.StrUtils, System.Generics.Defaults, System.Math, Rtti,
  JSON, Dialogs, SysUtils;

type
  TArrayUtils<T: class> = class
    class procedure Append(var Arr: TArray<T>; Value: T); overload;
    class procedure Append(var Arr: TArray<T>; Values: TArray<T>); overload;
    class function Contains(const anArray: array of T; const x: T) : Boolean;
    class function Count(const anArray: array of T; const x: T) : Integer;
    class function SerializeArray(Arr: TArray<T>): TJSONArray; overload;
  end;

  TValueHelper = record helper for TValue
    function ToSQL: string;
  end;

function GetWords(Text: string): TArray<string>;
function Spaces(Number: Integer = 0): string;
function Coalesce(Values: TArray<string>): string;
function GetTableLabel(Index: Integer): string;
function GetTValueJSONValue(Value: TValue): TJSONValue;

implementation

function GetWords(Text: string): TArray<string>;
begin
  Result := TArray<string>(SplitString(Text, ' '));
end;

function Spaces(Number: Integer = 0): string;
begin
  Result := '';

  while Number > 0 do
  begin
    Result := Result + ' ';
    Number := Number - 1;
  end;
end;

function Coalesce(Values: TArray<string>): string;
var
  Value: string;
begin
  Result := '';

  for Value in Values do
  begin
    if Value <> '' then
    begin
      Result := Value;
      Exit;
    end;
  end;
end;

function GetTableLabel(Index: Integer): string;
const
  Alphabet: string = 'abcdfghijklmnopqrstuvwxyz';
var
  Value: Integer;
begin
  Result := '';

  if Index >= Length(Alphabet) then
  begin
    while Index >= Length(Alphabet) do
    begin
      Value := Floor(Index / Length(Alphabet));
      Index := Index - (Value * Length(Alphabet));

      Result := Result + Alphabet[Value];
    end;
  end;

  Result := Result + Alphabet[Index];
end;

function GetTValueJSONValue(Value: TValue): TJSONValue;
begin
  Result := TJSONNull.Create;
  if Value.Kind in [tkInteger, tkInt64] then
    Result := TJSONNumber.Create(Value.AsInt64)
  else if Value.Kind in [tkEnumeration, tkFloat] then
    Result := TJSONNumber.Create(Value.AsExtended)
  else if Value.Kind in [tkChar, tkString, tkWChar, tkLString,
      tkWString, tkUString, tkAnsiChar, tkWideChar, tkUnicodeString,
      tkAnsiString, tkWideString, tkShortString, tkVariant] then
    Result := TJSONString.Create(Value.AsString);
end;

{ TArrayUtils<T> }

class procedure TArrayUtils<T>.Append(var Arr: TArray<T>; Value: T);
begin
  SetLength(Arr, Length(Arr)+1);
  Arr[High(Arr)] := Value;
end;

class procedure TArrayUtils<T>.Append(var Arr: TArray<T>; Values: TArray<T>);
var
  Obj: T;
begin
  for Obj in Values do
    TArrayUtils<T>.Append(Arr, Obj);
end;

class function TArrayUtils<T>.Contains(const anArray: array of T;
  const x: T): Boolean;
var
  y : T;
  lComparer: IEqualityComparer<T>;
begin
  lComparer := TEqualityComparer<T>.Default;
  for y in anArray do
  begin
    if lComparer.Equals(x, y) then
      Exit(True);
  end;
  Exit(False);
end;


class function TArrayUtils<T>.Count(const anArray: array of T;
  const x: T): Integer;
var
  y : T;
  lComparer: IEqualityComparer<T>;
begin
  Result := 0;
  lComparer := TEqualityComparer<T>.Default;
  for y in anArray do
  begin
    if lComparer.Equals(x, y) then
      Result := Result + 1;
  end;
end;

class function TArrayUtils<T>.SerializeArray(Arr: TArray<T>): TJSONArray;
var
  Obj: T;
  Ctx: TRttiContext;
  Tp : TRttiType;
  Mtd: TRttiMethod;
begin
  Result := TJSONArray.Create;
  Ctx := TRttiContext.Create;
  try
    Tp  := Ctx.GetType(T);
    Mtd := Tp.GetMethod('Serialize');

    if Mtd <> nil then
    begin
      for Obj in Arr do
      begin
        Result.AddElement(TJSONValue(Mtd.Invoke(Obj, []).AsObject));
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

{ TValueHelper }

function TValueHelper.ToSQL: string;
begin
  Result := 'null';
  if Self.Kind in [tkInteger, tkInt64] then
    Result := IntToStr(Self.AsInt64)
  else if Self.Kind in [tkEnumeration, tkFloat] then
    Result := FloatToStr(Self.AsExtended)
  else if Self.Kind in [tkChar, tkString, tkWChar, tkLString,
      tkWString, tkUString, tkAnsiChar, tkWideChar, tkUnicodeString,
      tkAnsiString, tkWideString, tkShortString, tkVariant] then
    Result := QuotedStr(Self.AsString);
end;

end.
