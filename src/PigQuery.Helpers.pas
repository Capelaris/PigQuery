unit PigQuery.Helpers;

interface

uses
  PigQuery.Commons, PigQuery.Interfaces, System.StrUtils,
  System.Generics.Defaults, System.Math, Rtti, JSON;

type
  TArrayUtils<T> = class
    class procedure Append(var Arr: TArray<T>; Value: T); overload;
    class procedure Append(var Arr: TArray<T>; Values: TArray<T>); overload;
    class function Contains(const anArray: array of T; const x: T) : Boolean;
    class function Count(const anArray: array of T; const x: T) : Integer;
    class function SerializeArray(Arr: TArray<ISerializable>): TJSONArray; overload;
    class function SerializeArray(Arr: TArray<IColumn>): TJSONArray; overload;
    class function SerializeArray(Arr: TArray<ITable>): TJSONArray; overload;
    class function SerializeArray(Arr: TArray<IParam>): TJSONArray; overload;
    class function SerializeArray(Arr: TArray<ICondition>): TJSONArray; overload;
    class function SerializeArray(Arr: TArray<IJoin>): TJSONArray; overload;
    class function SerializeArray(Arr: TArray<IPair>): TJSONArray; overload;
    class function SerializeArray(Arr: TArray<IQuery>): TJSONArray; overload;
    class function SerializeArray(Arr: TArray<ISelectQuery>): TJSONArray; overload;
    class function SerializeArray(Arr: TArray<IDeleteQuery>): TJSONArray; overload;
    class function SerializeArray(Arr: TArray<IInsertQuery>): TJSONArray; overload;
    class function SerializeArray(Arr: TArray<IUpdateQuery>): TJSONArray; overload;
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
  Result := TJSONValue.Create;
  //if Value.TypeInfo.TypeData. then

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

class function TArrayUtils<T>.SerializeArray(Arr: TArray<IJoin>): TJSONArray;
var
  Obj: IJoin;
begin
  Result := TJSONArray.Create;
  for Obj in Arr do
  begin
    Result.AddElement(Obj.Serialize);
  end;
end;

class function TArrayUtils<T>.SerializeArray(
  Arr: TArray<ICondition>): TJSONArray;
var
  Obj: ICondition;
begin
  Result := TJSONArray.Create;
  for Obj in Arr do
  begin
    Result.AddElement(Obj.Serialize);
  end;
end;

class function TArrayUtils<T>.SerializeArray(Arr: TArray<IParam>): TJSONArray;
var
  Obj: IParam;
begin
  Result := TJSONArray.Create;
  for Obj in Arr do
  begin
    Result.AddElement(Obj.Serialize);
  end;
end;

class function TArrayUtils<T>.SerializeArray(Arr: TArray<ITable>): TJSONArray;
var
  Obj: ITable;
begin
  Result := TJSONArray.Create;
  for Obj in Arr do
  begin
    Result.AddElement(Obj.Serialize);
  end;
end;

class function TArrayUtils<T>.SerializeArray(Arr: TArray<IColumn>): TJSONArray;
var
  Obj: IColumn;
begin
  Result := TJSONArray.Create;
  for Obj in Arr do
  begin
    Result.AddElement(Obj.Serialize);
  end;
end;

class function TArrayUtils<T>.SerializeArray(Arr: TArray<IPair>): TJSONArray;
var
  Obj: IPair;
begin
  Result := TJSONArray.Create;
  for Obj in Arr do
  begin
    Result.AddElement(Obj.Serialize);
  end;
end;

class function TArrayUtils<T>.SerializeArray(
  Arr: TArray<IUpdateQuery>): TJSONArray;
var
  Obj: IUpdateQuery;
begin
  Result := TJSONArray.Create;
  for Obj in Arr do
  begin
    Result.AddElement(Obj.Serialize);
  end;
end;

class function TArrayUtils<T>.SerializeArray(
  Arr: TArray<IInsertQuery>): TJSONArray;
var
  Obj: IInsertQuery;
begin
  Result := TJSONArray.Create;
  for Obj in Arr do
  begin
    Result.AddElement(Obj.Serialize);
  end;
end;

class function TArrayUtils<T>.SerializeArray(
  Arr: TArray<IDeleteQuery>): TJSONArray;
var
  Obj: IDeleteQuery;
begin
  Result := TJSONArray.Create;
  for Obj in Arr do
  begin
    Result.AddElement(Obj.Serialize);
  end;
end;

class function TArrayUtils<T>.SerializeArray(
  Arr: TArray<ISelectQuery>): TJSONArray;
var
  Obj: ISelectQuery;
begin
  Result := TJSONArray.Create;
  for Obj in Arr do
  begin
    Result.AddElement(Obj.Serialize);
  end;
end;

class function TArrayUtils<T>.SerializeArray(Arr: TArray<IQuery>): TJSONArray;
var
  Obj: IQuery;
begin
  Result := TJSONArray.Create;
  for Obj in Arr do
  begin
    Result.AddElement(Obj.Serialize);
  end;
end;

class function TArrayUtils<T>.SerializeArray(Arr: TArray<ISerializable>): TJSONArray;
var
  Obj: ISerializable;
begin
  Result := TJSONArray.Create;
  for Obj in Arr do
  begin
    Result.AddElement(Obj.Serialize);
  end;
end;

{ TValueHelper }

function TValueHelper.ToSQL: string;
begin
  Result := '';
end;

end.
