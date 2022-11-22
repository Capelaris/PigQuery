unit PigQuery.Core.Condition;

interface

uses
  PigQuery.Commons, PigQuery.Interfaces, PigQuery.Helpers, PigQuery.Core.Columns,
  SysUtils, JSON;

type
  TCondition = class(TInterfacedObject, ICondition)
  private
    sCondition    : string;
    sLeftCondition: string;

    procedure SetCondition(Value: string);
    function GetCondition: string;
    procedure SetLeftCondition(Value: string);
    function GetLeftCondition: string;
  public
    constructor Create(Cond: string); overload;
    constructor Create(LeftField, RightField: string); overload;
    constructor Create(LeftField, Cond, RightField: string); overload;
    constructor Create(LeftField: string; Values: TArray<string>); overload;
    constructor Create(LeftField, Cond: string; Values: TArray<string>); overload;
    constructor Create(LeftField, RightField: IColumn); overload;
    constructor Create(LeftField: IColumn; Cond: string; RightField: IColumn); overload;
    constructor Create(LeftField: IColumn; Values: TArray<string>); overload;
    constructor Create(LeftField: IColumn; Cond: string; Values: TArray<string>); overload;

    function Left(pCond: string): ICondition;
    function GenerateSQL(pSpaces: Integer = 0; pLeftCond: Boolean = False): string;
    function Serialize: TJSONObject;

    property Condition    : string read GetCondition;
    property LeftCondition: string read GetLeftCondition write SetLeftCondition;
  end;

implementation

{ TCondition }

constructor TCondition.Create(Cond: string);
begin
  inherited Create;
  sLeftCondition := 'and';
  sCondition     := Cond;
end;

constructor TCondition.Create(LeftField, RightField: string);
begin
  Create(LeftField, '=', RightField);
end;

constructor TCondition.Create(LeftField, Cond, RightField: string);
begin
  Create(LeftField + ' ' + Cond + ' ' + RightField);
end;

constructor TCondition.Create(LeftField: string; Values: TArray<string>);
begin
  Create(LeftField, 'in', Values);
end;

constructor TCondition.Create(LeftField, Cond: string; Values: TArray<string>);
var
  ValueStr: string;
  i: Integer;
begin
  ValueStr := '(';
  for I := 0 to (Length(Values) - 1) do
    ValueStr := ValueStr + QuotedStr(Values[i]) + ', ';
  SetLength(ValueStr, Length(ValueStr) - Length(', '));
  ValueStr := ValueStr + ')';
  Create(LeftField + ' ' + Cond + ' ' + ValueStr);
end;

constructor TCondition.Create(LeftField: IColumn; Cond: string;
  RightField: IColumn);
begin
  Create(LeftField.GetName, Cond, RightField.GetName);
end;

constructor TCondition.Create(LeftField, RightField: IColumn);
begin
  Create(LeftField.GetName, RightField.GetName);
end;

function TCondition.Left(pCond: string): ICondition;
begin
  Result := Self;
  Self.sLeftCondition := pCond;
end;

function TCondition.Serialize: TJSONObject;
begin
  Result := TJSONObject.Create;
  with Result do
  begin
    AddPair('LeftCondition', Self.sLeftCondition);
    AddPair('Condition', Self.sCondition);
  end;
end;

procedure TCondition.SetCondition(Value: string);
begin
  Self.sCondition := Value;
end;

procedure TCondition.SetLeftCondition(Value: string);
begin
  Self.sLeftCondition := Value;
end;

constructor TCondition.Create(LeftField: IColumn; Cond: string;
  Values: TArray<string>);
begin
  Create(LeftField.GetName, Cond, Values);
end;

function TCondition.GenerateSQL(pSpaces: Integer; pLeftCond: Boolean): string;
begin
  Result := sCondition;

  if pLeftCond then
    Result := ' ' + sLeftCondition + #13#10 + Spaces(pSpaces) + Result;
end;

function TCondition.GetCondition: string;
begin
  Result := Self.sCondition;
end;

function TCondition.GetLeftCondition: string;
begin
  Result := Self.sLeftCondition;
end;

constructor TCondition.Create(LeftField: IColumn; Values: TArray<string>);
begin
  Create(LeftField.GetName, Values);
end;

end.
