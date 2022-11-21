unit PigQuery.Core.Join;

interface

uses
  PigQuery.Commons, PigQuery.Interfaces, PigQuery.Helpers,
  PigQuery.Core.Condition, PigQuery.Core.Table;

type
  TJoin = class(TObject)
  private
    tJoinType  : TJoinType;
    oTable     : ITable;
    aConditions: TArray<ICondition>;

    function GetType: string;
  public
    constructor Create(pJoinType: TJoinType; pTable: ITable;
      pConditions: TArray<ICondition>); overload;
    constructor Create(pJoinType: TJoinType; pTable: string;
      pConditions: TArray<ICondition>); overload;
    constructor Create(pTable: ITable; pConditions: TArray<ICondition>); overload;
    constructor Create(pTable: string; pConditions: TArray<TQueryICondition>); overload;

    function GenerateSQL(pSpaces: Integer = 0; pTableLabel: string = ''): string;

    property JoinType  : TJoinType          read tJoinType   write tJoinType;
    property Table     : ITable             read oTable      write oTable;
    property Conditions: TArray<ICondition> read aConditions write aConditions;
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

end.
