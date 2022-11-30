unit PigQuery.Core.Join;

interface

uses
  PigQuery.Commons, PigQuery.Helpers, PigQuery.Core.Condition,
  PigQuery.Core.Table, JSON;

type
  TJoin = class
  private
    tJoinType  : TJoinType;
    oTable     : TTable;
    aConditions: TArray<TCondition>;

    function GetType: string;

    procedure SetJoinType(Value: TJoinType);
    function GetJoinType: TJoinType;
    procedure SetTable(Value: TTable);
    function GetTable: TTable;
    procedure SetConditions(Value: TArray<TCondition>);
    function GetConditions: TArray<TCondition>;
  public
    constructor Create(pJoinType: TJoinType; pTable: TTable;
      pConditions: TArray<TCondition>); overload;
    constructor Create(pJoinType: TJoinType; pTable: string;
      pConditions: TArray<TCondition>); overload;
    constructor Create(pTable: TTable; pConditions: TArray<TCondition>); overload;
    constructor Create(pTable: string; pConditions: TArray<TCondition>); overload;

    function GenerateSQL(pSpaces: Integer = 0; pTableLabel: string = ''): string;
    function Serialize: TJSONObject;

    property JoinType  : TJoinType          read GetJoinType   write SetJoinType;
    property Table     : TTable             read GetTable      write SetTable;
    property Conditions: TArray<TCondition> read GetConditions write SetConditions;
  end;

implementation

{ TJoin }

constructor TJoin.Create(pJoinType: TJoinType; pTable: TTable;
  pConditions: TArray<TCondition>);
begin
  inherited Create;
  tJoinType   := pJoinType;
  oTable      := pTable;
  aConditions := pConditions;
end;

constructor TJoin.Create(pJoinType: TJoinType; pTable: string;
  pConditions: TArray<TCondition>);
begin
  Create(pJoinType, TTable.Create(pTable), pConditions);
end;

constructor TJoin.Create(pTable: TTable;
  pConditions: TArray<TCondition>);
begin
  Create(jtNone, pTable, pConditions);
end;

constructor TJoin.Create(pTable: string;
  pConditions: TArray<TCondition>);
begin
  Create(jtNone, TTable.Create(pTable), pConditions);
end;

function TJoin.GenerateSQL(pSpaces: Integer; pTableLabel: string): string;
var
  i: Integer;
begin
  Result := Spaces(pSpaces) + GetType + oTable.Name + ' ' +
      Coalesce([pTableLabel, oTable.Alias]) + ' on';

  for i := 0 to (Length(aConditions) - 1) do
    Result := Result + #13#10 + aConditions[i].GenerateSQL(pSpaces, (i <> 0));
end;

function TJoin.GetConditions: TArray<TCondition>;
begin
  Result := Self.aConditions;
end;

function TJoin.GetJoinType: TJoinType;
begin
  Result := Self.tJoinType;
end;

function TJoin.GetTable: TTable;
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
    AddPair('Conditions', TArrayUtils<TCondition>.SerializeArray(Self.aConditions));
  end;
end;

procedure TJoin.SetConditions(Value: TArray<TCondition>);
begin
  Self.aConditions := Value;
end;

procedure TJoin.SetJoinType(Value: TJoinType);
begin
  Self.tJoinType := Value;
end;

procedure TJoin.SetTable(Value: TTable);
begin
  Self.oTable := Value;
end;

end.
