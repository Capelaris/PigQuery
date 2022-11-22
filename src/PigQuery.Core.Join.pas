unit PigQuery.Core.Join;

interface

uses
  PigQuery.Commons, PigQuery.Interfaces, PigQuery.Helpers,
  PigQuery.Core.Condition, PigQuery.Core.Table, JSON;

type
  TJoin = class(TInterfacedObject, IJoin)
  private
    tJoinType  : TJoinType;
    oTable     : ITable;
    aConditions: TArray<ICondition>;

    function GetType: string;

    procedure SetJoinType(Value: TJoinType);
    function GetJoinType: TJoinType;
    procedure SetTable(Value: ITable);
    function GetTable: ITable;
    procedure SetConditions(Value: TArray<ICondition>);
    function GetConditions: TArray<ICondition>;
  public
    constructor Create(pJoinType: TJoinType; pTable: ITable;
      pConditions: TArray<ICondition>); overload;
    constructor Create(pJoinType: TJoinType; pTable: string;
      pConditions: TArray<ICondition>); overload;
    constructor Create(pTable: ITable; pConditions: TArray<ICondition>); overload;
    constructor Create(pTable: string; pConditions: TArray<ICondition>); overload;

    function GenerateSQL(pSpaces: Integer = 0; pTableLabel: string = ''): string;
    function Serialize: TJSONObject;

    property JoinType  : TJoinType          read GetJoinType   write SetJoinType;
    property Table     : ITable             read GetTable      write SetTable;
    property Conditions: TArray<ICondition> read GetConditions write SetConditions;
  end;

implementation

{ TJoin }

constructor TJoin.Create(pJoinType: TJoinType; pTable: ITable;
  pConditions: TArray<ICondition>);
begin
  inherited Create;
  tJoinType   := pJoinType;
  oTable      := pTable;
  aConditions := pConditions;
end;

constructor TJoin.Create(pJoinType: TJoinType; pTable: string;
  pConditions: TArray<ICondition>);
begin
  Create(pJoinType, TTable.Create(pTable), pConditions);
end;

constructor TJoin.Create(pTable: ITable;
  pConditions: TArray<ICondition>);
begin
  Create(jtNone, pTable, pConditions);
end;

constructor TJoin.Create(pTable: string;
  pConditions: TArray<ICondition>);
begin
  Create(jtNone, TTable.Create(pTable), pConditions);
end;

function TJoin.GenerateSQL(pSpaces: Integer; pTableLabel: string): string;
var
  i: Integer;
begin
  Result := Spaces(pSpaces) + GetType + oTable.GetName + ' ' +
      Coalesce([pTableLabel, oTable.GetAlias]) + ' on';

  for i := 0 to (Length(aConditions) - 1) do
    Result := Result + #13#10 + aConditions[i].GenerateSQL(pSpaces, (i <> 0));
end;

function TJoin.GetConditions: TArray<ICondition>;
begin
  Result := Self.aConditions;
end;

function TJoin.GetJoinType: TJoinType;
begin
  Result := Self.tJoinType;
end;

function TJoin.GetTable: ITable;
begin
  Result := Self.oTable;
end;

function TJoin.GetType: string;
begin
  Result := '';
  if tJoinType = jtInner then
    Result := 'inner '
  else if tJoinType = jtLeft then
    Result := 'left '
  else if tJoinType = jtRight then
    Result := 'right '
  else if tJoinType = jtOuter then
    Result := 'outer ';
end;

function TJoin.Serialize: TJSONObject;
begin
  Result := TJSONObject.Create;
  with Result do
  begin
    AddPair('Type', Self.tJoinType.ToString);
    AddPair('Table', Self.oTable.Serialize);
    AddPair('Conditions', TArrayUtils<ICondition>.SerializeArray(Self.aConditions));
  end;
end;

procedure TJoin.SetConditions(Value: TArray<ICondition>);
begin
  Self.aConditions := Value;
end;

procedure TJoin.SetJoinType(Value: TJoinType);
begin
  Self.tJoinType := Value;
end;

procedure TJoin.SetTable(Value: ITable);
begin
  Self.oTable := Value;
end;

end.
