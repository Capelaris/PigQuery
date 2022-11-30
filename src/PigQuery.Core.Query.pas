unit PigQuery.Core.Query;

interface

uses
  PigQuery.Helpers, PigQuery.Commons, PigQuery.Core.Table, PigQuery.Core.Columns,
  PigQuery.Core.Condition, PigQuery.Core.Join, PigQuery.Core.Pair,
  Rtti, Variants, SysUtils, JSON;

type
  TQuery = class
  private
    tQueryType: TQueryType;
    oTable    : TTable;
    aWhere    : TArray<TCondition>;

    procedure SetQueryType(Value: TQueryType);
    function GetQueryType: TQueryType;
    procedure SetTable(Value: TTable);
    function GetTable: TTable;

    procedure AddWhere(pCondition: TCondition);
    function GenerateSQL: string; virtual; abstract;

    function Where(pCond: string): TQuery; overload;
    function Where(pLeftField, pRightField: string): TQuery; overload;
    function Where(pLeftField, pCond, pRightField: string): TQuery; overload;
    function Where(pLeftField, pCond: string; pValues: TArray<string>): TQuery; overload;
    function Where(pLeftField, pRightField: TColumn): TQuery; overload;
    function Where(pLeftField: TColumn; pCond: string; pRightField: TColumn): TQuery; overload;
    function Where(pLeftField: TColumn; pCond: string; pValues: TArray<string>): TQuery; overload;
    function WhereIn(pLeftField: string; pValues: TArray<string>): TQuery; overload;
    function WhereIn(pLeftField: TColumn; pValues: TArray<string>): TQuery; overload;
    function WhereNotIn(pLeftField: string; pValues: TArray<string>): TQuery; overload;
    function WhereNotIn(pLeftField: TColumn; pValues: TArray<string>): TQuery; overload;

    function OrWhere(pCond: string): TQuery; overload;
    function OrWhere(pLeftField, pRightField: string): TQuery; overload;
    function OrWhere(pLeftField, pCond, pRightField: string): TQuery; overload;
    function OrWhere(pLeftField, pCond: string; pValues: TArray<string>): TQuery; overload;
    function OrWhere(pLeftField, pRightField: TColumn): TQuery; overload;
    function OrWhere(pLeftField: TColumn; pCond: string; pRightField: TColumn): TQuery; overload;
    function OrWhere(pLeftField: TColumn; pCond: string; pValues: TArray<string>): TQuery; overload;
    function OrWhereIn(pLeftField: string; pValues: TArray<string>): TQuery; overload;
    function OrWhereIn(pLeftField: TColumn; pValues: TArray<string>): TQuery; overload;
    function OrWhereNotIn(pLeftField: string; pValues: TArray<string>): TQuery; overload;
    function OrWhereNotIn(pLeftField: TColumn; pValues: TArray<string>): TQuery; overload;
  public
    constructor Create(pTable: string); overload;
    constructor Create(pTable: TTable); overload;

    function Serialize: TJSONObject;

    property QueryType: TQueryType read GetQueryType write SetQueryType;
    property Table    : TTable     read GetTable     write SetTable;
  end;

  TSelectQuery = class(TQuery)
  private
    aColumns  : TArray<TColumn>;
    aJoins    : TArray<TJoin>;
    aOrderBy  : TArray<TColumn>;
    sSQL      : string;

    procedure AddJoin(pJoin: TJoin);
    function GenerateSQL: string; override;
  public
    constructor Create(pTable: string); overload;
    constructor Create(pTable: TTable); overload;

    function SetColumns(pColumns: TArray<TColumn>): TSelectQuery; overload;
    function SetColumns(pColumns: TArray<string>): TSelectQuery; overload;

    function Join(pJoinType: TJoinType; pTable: TTable; pConditions: TArray<TCondition>): TSelectQuery; overload;
    function Join(pJoinType: TJoinType; pTable: string; pConditions: TArray<TCondition>): TSelectQuery; overload;
    function Join(pTable: TTable; pConditions: TArray<TCondition>): TSelectQuery; overload;
    function Join(pTable: string; pConditions: TArray<TCondition>): TSelectQuery; overload;
    function InnerJoin(pTable: TTable; pConditions: TArray<TCondition>): TSelectQuery; overload;
    function InnerJoin(pTable: string; pConditions: TArray<TCondition>): TSelectQuery; overload;
    function LeftJoin(pTable: TTable; pConditions: TArray<TCondition>): TSelectQuery; overload;
    function LeftJoin(pTable: string; pConditions: TArray<TCondition>): TSelectQuery; overload;
    function RightJoin(pTable: TTable; pConditions: TArray<TCondition>): TSelectQuery; overload;
    function RightJoin(pTable: string; pConditions: TArray<TCondition>): TSelectQuery; overload;
    function OuterJoin(pTable: TTable; pConditions: TArray<TCondition>): TSelectQuery; overload;
    function OuterJoin(pTable: string; pConditions: TArray<TCondition>): TSelectQuery; overload;

    function Where(pCond: string): TSelectQuery; overload;
    function Where(pLeftField, pRightField: string): TSelectQuery; overload;
    function Where(pLeftField, pCond, pRightField: string): TSelectQuery; overload;
    function Where(pLeftField, pCond: string; pValues: TArray<string>): TSelectQuery; overload;
    function Where(pLeftField, pRightField: TColumn): TSelectQuery; overload;
    function Where(pLeftField: TColumn; pCond: string; pRightField: TColumn): TSelectQuery; overload;
    function Where(pLeftField: TColumn; pCond: string; pValues: TArray<string>): TSelectQuery; overload;
    function WhereIn(pLeftField: string; pValues: TArray<string>): TSelectQuery; overload;
    function WhereIn(pLeftField: TColumn; pValues: TArray<string>): TSelectQuery; overload;
    function WhereNotIn(pLeftField: string; pValues: TArray<string>): TSelectQuery; overload;
    function WhereNotIn(pLeftField: TColumn; pValues: TArray<string>): TSelectQuery; overload;

    function OrWhere(pCond: string): TSelectQuery; overload;
    function OrWhere(pLeftField, pRightField: string): TSelectQuery; overload;
    function OrWhere(pLeftField, pCond, pRightField: string): TSelectQuery; overload;
    function OrWhere(pLeftField, pCond: string; pValues: TArray<string>): TSelectQuery; overload;
    function OrWhere(pLeftField, pRightField: TColumn): TSelectQuery; overload;
    function OrWhere(pLeftField: TColumn; pCond: string; pRightField: TColumn): TSelectQuery; overload;
    function OrWhere(pLeftField: TColumn; pCond: string; pValues: TArray<string>): TSelectQuery; overload;
    function OrWhereIn(pLeftField: string; pValues: TArray<string>): TSelectQuery; overload;
    function OrWhereIn(pLeftField: TColumn; pValues: TArray<string>): TSelectQuery; overload;
    function OrWhereNotIn(pLeftField: string; pValues: TArray<string>): TSelectQuery; overload;
    function OrWhereNotIn(pLeftField: TColumn; pValues: TArray<string>): TSelectQuery; overload;

    function OrderBy(pColumn: TColumn): TSelectQuery; overload;
    function OrderBy(pColumn: string): TSelectQuery; overload;
    function OrderBy(pColumns: TArray<TColumn>): TSelectQuery; overload;
    function OrderBy(pColumns: TArray<string>): TSelectQuery; overload;

    function GetSQL: string; overload;
    function GetSQL(pColumns: TArray<TColumn>): string; overload;
    function GetSQL(pColumns: TArray<string>): string; overload;

    function Serialize: TJSONObject;

    property QueryType;
    property Table;
  end;

  TDeleteQuery = class(TQuery)
  private
    sSQL: string;
    function GenerateSQL: string; override;
  public
    constructor Create(pTable: string); overload;
    constructor Create(pTable: TTable); overload;

    function Where(pCond: string): TDeleteQuery; overload;
    function Where(pLeftField, pRightField: string): TDeleteQuery; overload;
    function Where(pLeftField, pCond, pRightField: string): TDeleteQuery; overload;
    function Where(pLeftField, pCond: string; pValues: TArray<string>): TDeleteQuery; overload;
    function Where(pLeftField, pRightField: TColumn): TDeleteQuery; overload;
    function Where(pLeftField: TColumn; pCond: string; pRightField: TColumn): TDeleteQuery; overload;
    function Where(pLeftField: TColumn; pCond: string; pValues: TArray<string>): TDeleteQuery; overload;
    function WhereIn(pLeftField: string; pValues: TArray<string>): TDeleteQuery; overload;
    function WhereIn(pLeftField: TColumn; pValues: TArray<string>): TDeleteQuery; overload;
    function WhereNotIn(pLeftField: string; pValues: TArray<string>): TDeleteQuery; overload;
    function WhereNotIn(pLeftField: TColumn; pValues: TArray<string>): TDeleteQuery; overload;

    function OrWhere(pCond: string): TDeleteQuery; overload;
    function OrWhere(pLeftField, pRightField: string): TDeleteQuery; overload;
    function OrWhere(pLeftField, pCond, pRightField: string): TDeleteQuery; overload;
    function OrWhere(pLeftField, pCond: string; pValues: TArray<string>): TDeleteQuery; overload;
    function OrWhere(pLeftField, pRightField: TColumn): TDeleteQuery; overload;
    function OrWhere(pLeftField: TColumn; pCond: string; pRightField: TColumn): TDeleteQuery; overload;
    function OrWhere(pLeftField: TColumn; pCond: string; pValues: TArray<string>): TDeleteQuery; overload;
    function OrWhereIn(pLeftField: string; pValues: TArray<string>): TDeleteQuery; overload;
    function OrWhereIn(pLeftField: TColumn; pValues: TArray<string>): TDeleteQuery; overload;
    function OrWhereNotIn(pLeftField: string; pValues: TArray<string>): TDeleteQuery; overload;
    function OrWhereNotIn(pLeftField: TColumn; pValues: TArray<string>): TDeleteQuery; overload;

    function GetSQL: string;

    function Serialize: TJSONObject;

    property QueryType;
    property Table;
  end;

  TInsertQuery = class(TQuery)
  private
    sSQL  : string;
    aPairs: TArray<TPair>;

    procedure AddPair(pColumn: TColumn; pValue: TValue);
    function GenerateSQL: string; override;
  public
    constructor Create(pTable: string); overload;
    constructor Create(pTable: TTable); overload;

    function SetPair(pColumn, pValue: string): TInsertQuery; overload;
    function SetPair(pColumn: string; pValue: TValue): TInsertQuery; overload;
    function SetPair(pColumn: TColumn; pValue: string): TInsertQuery; overload;
    function SetPair(pColumn: TColumn; pValue: TValue): TInsertQuery; overload;

    function SetNullPair(pColumn: string): TInsertQuery; overload;
    function SetNullPair(pColumn: TColumn): TInsertQuery; overload;

    function GetSQL: string;

    function Serialize: TJSONObject;

    property QueryType;
    property Table;
  end;

  TUpdateQuery = class(TQuery)
  private
    sSQL  : string;
    aPairs: TArray<TPair>;

    procedure AddPair(pColumn: TColumn; pValue: TValue);
    function GenerateSQL: string; override;
  public
    constructor Create(pTable: string); overload;
    constructor Create(pTable: TTable); overload;

    function Where(pCond: string): TUpdateQuery; overload;
    function Where(pLeftField, pRightField: string): TUpdateQuery; overload;
    function Where(pLeftField, pCond, pRightField: string): TUpdateQuery; overload;
    function Where(pLeftField, pCond: string; pValues: TArray<string>): TUpdateQuery; overload;
    function Where(pLeftField, pRightField: TColumn): TUpdateQuery; overload;
    function Where(pLeftField: TColumn; pCond: string; pRightField: TColumn): TUpdateQuery; overload;
    function Where(pLeftField: TColumn; pCond: string; pValues: TArray<string>): TUpdateQuery; overload;
    function WhereIn(pLeftField: string; pValues: TArray<string>): TUpdateQuery; overload;
    function WhereIn(pLeftField: TColumn; pValues: TArray<string>): TUpdateQuery; overload;
    function WhereNotIn(pLeftField: string; pValues: TArray<string>): TUpdateQuery; overload;
    function WhereNotIn(pLeftField: TColumn; pValues: TArray<string>): TUpdateQuery; overload;

    function OrWhere(pCond: string): TUpdateQuery; overload;
    function OrWhere(pLeftField, pRightField: string): TUpdateQuery; overload;
    function OrWhere(pLeftField, pCond, pRightField: string): TUpdateQuery; overload;
    function OrWhere(pLeftField, pCond: string; pValues: TArray<string>): TUpdateQuery; overload;
    function OrWhere(pLeftField, pRightField: TColumn): TUpdateQuery; overload;
    function OrWhere(pLeftField: TColumn; pCond: string; pRightField: TColumn): TUpdateQuery; overload;
    function OrWhere(pLeftField: TColumn; pCond: string; pValues: TArray<string>): TUpdateQuery; overload;
    function OrWhereIn(pLeftField: string; pValues: TArray<string>): TUpdateQuery; overload;
    function OrWhereIn(pLeftField: TColumn; pValues: TArray<string>): TUpdateQuery; overload;
    function OrWhereNotIn(pLeftField: string; pValues: TArray<string>): TUpdateQuery; overload;
    function OrWhereNotIn(pLeftField: TColumn; pValues: TArray<string>): TUpdateQuery; overload;

    function SetPair(pColumn, pValue: string): TUpdateQuery; overload;
    function SetPair(pColumn: string; pValue: TValue): TUpdateQuery; overload;
    function SetPair(pColumn: TColumn; pValue: string): TUpdateQuery; overload;
    function SetPair(pColumn: TColumn; pValue: TValue): TUpdateQuery; overload;

    function SetNullPair(pColumn: string): TUpdateQuery; overload;
    function SetNullPair(pColumn: TColumn): TUpdateQuery; overload;

    function GetSQL: string;

    function Serialize: TJSONObject;
  end;

implementation

{ TQuery }

function TQuery.Serialize: TJSONObject;
begin
  Result := TJSONObject.Create;
  with Result do
  begin
    AddPair('Type', Self.tQueryType.ToString);
    AddPair('Table', Self.oTable.Serialize);
    AddPair('Where', TArrayUtils<TCondition>.SerializeArray(Self.aWhere));
  end;
end;

procedure TQuery.SetQueryType(Value: TQueryType);
begin
  Self.tQueryType := Value;
end;

procedure TQuery.SetTable(Value: TTable);
begin
  Self.oTable := Value;
end;

procedure TQuery.AddWhere(pCondition: TCondition);
begin
  TArrayUtils<TCondition>.Append(Self.aWhere, pCondition);
end;

constructor TQuery.Create(pTable: string);
begin
  Create(TTable.Create(pTable, 'a'));
end;

constructor TQuery.Create(pTable: TTable);
begin
  inherited Create;
  Self.oTable := pTable;
end;

function TQuery.GetQueryType: TQueryType;
begin
  Result := Self.tQueryType;
end;

function TQuery.GetTable: TTable;
begin
  Result := Self.oTable;
end;

function TQuery.Where(pLeftField, pRightField: string): TQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, '=', pRightField).Left('and'));
end;

function TQuery.Where(pCond: string): TQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pCond).Left('and'));
end;

function TQuery.Where(pLeftField, pCond, pRightField: string): TQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, pCond, pRightField).Left('and'));
end;

function TQuery.Where(pLeftField: TColumn; pCond: string;
  pValues: TArray<string>): TQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, pCond, pValues).Left('and'));
end;

function TQuery.Where(pLeftField: TColumn; pCond: string;
  pRightField: TColumn): TQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, pCond, pRightField).Left('and'));
end;

function TQuery.Where(pLeftField, pCond: string;
  pValues: TArray<string>): TQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, pCond, pValues).Left('and'));
end;

function TQuery.Where(pLeftField, pRightField: TColumn): TQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, '=', pRightField).Left('and'));
end;

function TQuery.WhereIn(pLeftField: string; pValues: TArray<string>): TQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, 'in', pValues).Left('and'));
end;

function TQuery.WhereIn(pLeftField: TColumn; pValues: TArray<string>): TQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, 'in', pValues).Left('and'));
end;

function TQuery.WhereNotIn(pLeftField: string; pValues: TArray<string>): TQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, 'not in', pValues).Left('and'));
end;

function TQuery.WhereNotIn(pLeftField: TColumn;
  pValues: TArray<string>): TQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, 'not in', pValues).Left('and'));
end;

function TQuery.OrWhere(pLeftField, pRightField: string): TQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, '=', pRightField).Left('or'));
end;

function TQuery.OrWhere(pCond: string): TQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pCond).Left('or'));
end;

function TQuery.OrWhere(pLeftField, pCond, pRightField: string): TQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, pCond, pRightField).Left('or'));
end;

function TQuery.OrWhere(pLeftField: TColumn; pCond: string;
  pValues: TArray<string>): TQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, pCond, pValues).Left('or'));
end;

function TQuery.OrWhere(pLeftField: TColumn; pCond: string;
  pRightField: TColumn): TQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, pCond, pRightField).Left('or'));
end;

function TQuery.OrWhere(pLeftField, pCond: string;
  pValues: TArray<string>): TQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, pCond, pValues).Left('or'));
end;

function TQuery.OrWhere(pLeftField, pRightField: TColumn): TQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, '=', pRightField).Left('or'));
end;

function TQuery.OrWhereIn(pLeftField: string; pValues: TArray<string>): TQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, 'in', pValues).Left('or'));
end;

function TQuery.OrWhereIn(pLeftField: TColumn; pValues: TArray<string>): TQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, 'in', pValues).Left('or'));
end;

function TQuery.OrWhereNotIn(pLeftField: string; pValues: TArray<string>): TQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, 'not in', pValues).Left('or'));
end;

function TQuery.OrWhereNotIn(pLeftField: TColumn;
  pValues: TArray<string>): TQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, 'not in', pValues).Left('or'));
end;

{ TSelectQuery }

function TSelectQuery.Serialize: TJSONObject;
begin
  Result := TJSONObject.Create;
  with Result do
  begin
    AddPair('Type', Self.tQueryType.ToString);
    AddPair('Columns', TArrayUtils<TColumn>.SerializeArray(Self.aColumns));
    AddPair('Table', Self.oTable.Serialize);
    AddPair('Joins', TArrayUtils<TJoin>.SerializeArray(Self.aJoins));
    AddPair('Where', TArrayUtils<TCondition>.SerializeArray(Self.aWhere));
    AddPair('OrderBy', TArrayUtils<TColumn>.SerializeArray(Self.aOrderBy));
  end;
end;

function TSelectQuery.SetColumns(pColumns: TArray<string>): TSelectQuery;
var
  Columns: TArray<TColumn>;
  Column : string;
begin
  for Column in pColumns do
    TArrayUtils<TColumn>.Append(Columns, TColumn.Create(Column, ctUnknown, -1, -1, False, '', '', TValue.From<Variant>(Null)));
  Self.SetColumns(Columns);
  Result := Self;
end;

constructor TSelectQuery.Create(pTable: string);
begin
  inherited Create(pTable);
  Self.QueryType := qtSelect;
end;

procedure TSelectQuery.AddJoin(pJoin: TJoin);
begin
  TArrayUtils<TJoin>.Append(Self.aJoins, pJoin);
end;

constructor TSelectQuery.Create(pTable: TTable);
begin
  inherited Create(pTable);
  Self.QueryType := qtSelect;
end;

function TSelectQuery.GenerateSQL: string;
var
  i: Integer;
begin
  try
    Self.sSQL := 'select ';
    for i := 0 to (Length(Self.aColumns) - 1) do
    begin
      if i <> 0 then
        Self.sSQL := Self.sSQL + Spaces(7);

      Self.sSQL := Self.sSQL + Coalesce([Self.aColumns[i].TableLabel, GetTableLabel(1)]) +
          '.' + Self.aColumns[i].Name + ',' + #13#10;
    end;

    SetLength(Self.sSQL, Length(Self.sSQL) - Length(',' + #13#10));

    Self.sSQL := Self.sSQL + #13#10 + 'from ' + Self.oTable.Name + ' ' + Coalesce([Self.oTable.Alias, GetTableLabel(1)]);

    if Length(Self.aJoins) > 0 then
    begin
      for i := 0 to (Length(Self.aJoins) - 1) do
        Self.sSQL := Self.sSQL + #13#10 + Self.aJoins[i].GenerateSQL(0, GetTableLabel(i + 2));
    end;

    if Length(Self.aWhere) > 0 then
    begin
      Self.sSQL := Self.sSQL + #13#10 + 'where ';
      for i := 0 to (Length(Self.aWhere) - 1) do
        Self.sSQL := Self.sSQL + Self.aWhere[i].GenerateSQL(6, (i <> 0));
    end;

    if Length(Self.aOrderBy) > 0 then
    begin
      Self.sSQL := Self.sSQL + #13#10 + 'order by ';
      for i := 0 to (Length(Self.aOrderBy) - 1) do
      begin
        if i <> 0 then
          Self.sSQL := Self.sSQL + Spaces(9);

        Self.sSQL := Self.sSQL + Coalesce([Self.aOrderBy[i].TableLabel, oTable.Alias]) +
            '.' + Self.aOrderBy[i].Name + ',' + #13#10;
      end;

      SetLength(Self.sSQL, Length(Self.sSQL) - Length(',' + #13#10));
    end;
  except
    on E: Exception do
    begin
      Self.sSQL := '';
      raise Exception.Create('Erro ao gerar SelectSQL: ' + E.Message);
    end;
  end;

  Result := Self.sSQL;
end;

function TSelectQuery.GetSQL: string;
begin
  Result := GenerateSQL;
end;

function TSelectQuery.GetSQL(pColumns: TArray<TColumn>): string;
begin
  Self.SetColumns(pColumns);
  Result := GetSQL;
end;

function TSelectQuery.GetSQL(pColumns: TArray<string>): string;
var
  Columns: TArray<TColumn>;
  Column : string;
begin
  for Column in pColumns do
    TArrayUtils<TColumn>.Append(Columns, TColumn.Create(Column, ctUnknown, -1, -1, False, '', '', TValue.From<Variant>(Null)));
  Result := GetSQL(Columns);
end;

function TSelectQuery.InnerJoin(pTable: string;
  pConditions: TArray<TCondition>): TSelectQuery;
begin
  Result := Self;
  AddJoin(TJoin.Create(jtInner, pTable, pConditions));
end;

function TSelectQuery.InnerJoin(pTable: TTable;
  pConditions: TArray<TCondition>): TSelectQuery;
begin
  Result := Self;
  AddJoin(TJoin.Create(jtInner, pTable, pConditions));
end;

function TSelectQuery.Join(pJoinType: TJoinType; pTable: string;
  pConditions: TArray<TCondition>): TSelectQuery;
begin
  Result := Self;
  AddJoin(TJoin.Create(pJoinType, pTable, pConditions));
end;

function TSelectQuery.Join(pJoinType: TJoinType; pTable: TTable;
  pConditions: TArray<TCondition>): TSelectQuery;
begin
  Result := Self;
  AddJoin(TJoin.Create(pJoinType, pTable, pConditions));
end;

function TSelectQuery.Join(pTable: string;
  pConditions: TArray<TCondition>): TSelectQuery;
begin
  Result := Self;
  AddJoin(TJoin.Create(jtNone, pTable, pConditions));
end;

function TSelectQuery.Join(pTable: TTable;
  pConditions: TArray<TCondition>): TSelectQuery;
begin
  Result := Self;
  AddJoin(TJoin.Create(jtNone, pTable, pConditions));
end;

function TSelectQuery.LeftJoin(pTable: TTable;
  pConditions: TArray<TCondition>): TSelectQuery;
begin
  Result := Self;
  AddJoin(TJoin.Create(jtLeft, pTable, pConditions));
end;

function TSelectQuery.LeftJoin(pTable: string;
  pConditions: TArray<TCondition>): TSelectQuery;
begin
  Result := Self;
  AddJoin(TJoin.Create(jtLeft, pTable, pConditions));
end;

function TSelectQuery.OuterJoin(pTable: TTable;
  pConditions: TArray<TCondition>): TSelectQuery;
begin
  Result := Self;
  AddJoin(TJoin.Create(jtOuter, pTable, pConditions));
end;

function TSelectQuery.OrderBy(pColumn: TColumn): TSelectQuery;
begin
  Result := OrderBy([pColumn]);
end;

function TSelectQuery.OrderBy(pColumn: string): TSelectQuery;
begin
  Result := OrderBy(TColumn.Create(pColumn, ctUnknown, -1, -1, False, '', '', TValue.From<Variant>(Null)));
end;

function TSelectQuery.OrderBy(pColumns: TArray<TColumn>): TSelectQuery;
begin
  Result := Self;
  TArrayUtils<TColumn>.Append(aOrderBy, pColumns);
end;

function TSelectQuery.OrderBy(pColumns: TArray<string>): TSelectQuery;
var
  Columns: TArray<TColumn>;
  Column : string;
begin
  for Column in pColumns do
    TArrayUtils<TColumn>.Append(Columns, TColumn.Create(Column, ctUnknown, -1, -1, False, '', '', TValue.From<Variant>(Null)));
  Result := OrderBy(Columns);
end;

function TSelectQuery.OrWhere(pLeftField, pCond,
  pRightField: string): TSelectQuery;
begin
  inherited OrWhere(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TSelectQuery.OrWhere(pLeftField, pRightField: string): TSelectQuery;
begin
  inherited OrWhere(pLeftField, pRightField);
  Result := Self;
end;

function TSelectQuery.OrWhere(pCond: string): TSelectQuery;
begin
  inherited OrWhere(pCond);
  Result := Self;
end;

function TSelectQuery.OrWhere(pLeftField, pCond: string;
  pValues: TArray<string>): TSelectQuery;
begin
  inherited OrWhere(pLeftField, pCond, pValues);
  Result := Self;
end;

function TSelectQuery.OrWhere(pLeftField: TColumn; pCond: string;
  pValues: TArray<string>): TSelectQuery;
begin
  inherited OrWhere(pLeftField, pCond, pValues);
  Result := Self;
end;

function TSelectQuery.OrWhere(pLeftField: TColumn; pCond: string;
  pRightField: TColumn): TSelectQuery;
begin
  inherited OrWhere(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TSelectQuery.OrWhere(pLeftField, pRightField: TColumn): TSelectQuery;
begin
  inherited OrWhere(pLeftField, pRightField);
  Result := Self;
end;

function TSelectQuery.OrWhereIn(pLeftField: string;
  pValues: TArray<string>): TSelectQuery;
begin
  inherited OrWhereIn(pLeftField, pValues);
  Result := Self;
end;

function TSelectQuery.OrWhereIn(pLeftField: TColumn;
  pValues: TArray<string>): TSelectQuery;
begin
  inherited OrWhereIn(pLeftField, pValues);
  Result := Self;
end;

function TSelectQuery.OrWhereNotIn(pLeftField: TColumn;
  pValues: TArray<string>): TSelectQuery;
begin
  inherited OrWhereNotIn(pLeftField, pValues);
  Result := Self;
end;

function TSelectQuery.OrWhereNotIn(pLeftField: string;
  pValues: TArray<string>): TSelectQuery;
begin
  inherited OrWhereNotIn(pLeftField, pValues);
  Result := Self;
end;

function TSelectQuery.OuterJoin(pTable: string;
  pConditions: TArray<TCondition>): TSelectQuery;
begin
  Result := Self;
  AddJoin(TJoin.Create(jtOuter, pTable, pConditions));
end;

function TSelectQuery.RightJoin(pTable: TTable;
  pConditions: TArray<TCondition>): TSelectQuery;
begin
  Result := Self;
  AddJoin(TJoin.Create(jtRight, pTable, pConditions));
end;

function TSelectQuery.RightJoin(pTable: string;
  pConditions: TArray<TCondition>): TSelectQuery;
begin
  Result := Self;
  AddJoin(TJoin.Create(jtRight, pTable, pConditions));
end;

function TSelectQuery.SetColumns(pColumns: TArray<TColumn>): TSelectQuery;
begin
  aColumns := pColumns;
  Result   := Self;
end;

function TSelectQuery.Where(pLeftField, pRightField: string): TSelectQuery;
begin
  inherited Where(pLeftField, pRightField);
  Result := Self;
end;

function TSelectQuery.Where(pCond: string): TSelectQuery;
begin
  inherited Where(pCond);
  Result := Self;
end;

function TSelectQuery.Where(pLeftField, pCond,
  pRightField: string): TSelectQuery;
begin
  inherited Where(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TSelectQuery.Where(pLeftField: TColumn; pCond: string;
  pValues: TArray<string>): TSelectQuery;
begin
  inherited Where(pLeftField, pCond, pValues);
  Result := Self;
end;

function TSelectQuery.Where(pLeftField: TColumn; pCond: string;
  pRightField: TColumn): TSelectQuery;
begin
  inherited Where(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TSelectQuery.Where(pLeftField, pCond: string;
  pValues: TArray<string>): TSelectQuery;
begin
  inherited Where(pLeftField, pCond, pValues);
  Result := Self;
end;

function TSelectQuery.Where(pLeftField, pRightField: TColumn): TSelectQuery;
begin
  inherited Where(pLeftField, pRightField);
  Result := Self;
end;

function TSelectQuery.WhereIn(pLeftField: string;
  pValues: TArray<string>): TSelectQuery;
begin
  inherited WhereIn(pLeftField, pValues);
  Result := Self;
end;

function TSelectQuery.WhereIn(pLeftField: TColumn;
  pValues: TArray<string>): TSelectQuery;
begin
  inherited WhereIn(pLeftField, pValues);
  Result := Self;
end;

function TSelectQuery.WhereNotIn(pLeftField: string;
  pValues: TArray<string>): TSelectQuery;
begin
  inherited WhereNotIn(pLeftField, pValues);
  Result := Self;
end;

function TSelectQuery.WhereNotIn(pLeftField: TColumn;
  pValues: TArray<string>): TSelectQuery;
begin
  inherited WhereNotIn(pLeftField, pValues);
  Result := Self;
end;

{ TDeleteQuery }

constructor TDeleteQuery.Create(pTable: string);
begin
  inherited Create(pTable);
  Self.tQueryType := qtDelete;
end;

constructor TDeleteQuery.Create(pTable: TTable);
begin
  inherited Create(pTable);
  Self.tQueryType := qtDelete;
end;

function TDeleteQuery.Serialize: TJSONObject;
begin
  Result := TJSONObject.Create;
  with Result do
  begin
    AddPair('Type', Self.tQueryType.ToString);
    AddPair('Table', Self.oTable.Serialize);
    AddPair('Where', TArrayUtils<TCondition>.SerializeArray(Self.aWhere));
  end;
end;

function TDeleteQuery.GenerateSQL: string;
var
  i: Integer;
begin
  try
    sSQL := 'delete from ' + oTable.Name + ' ' + oTable.Alias;

    if Length(aWhere) > 0 then
    begin
      sSQL := sSQL + #13#10 + 'where ';
      for i := 0 to (Length(aWhere) - 1) do
        sSQL := sSQL + aWhere[i].GenerateSQL(6, (i <> 0));
    end;
  except
    on E: Exception do
    begin
      sSQL := '';
      raise Exception.Create('Erro ao gerar DeleteSQL: ' + E.Message);
    end;
  end;

  Result := sSQL;
end;

function TDeleteQuery.GetSQL: string;
begin
  Result := GenerateSQL;
end;

function TDeleteQuery.OrWhere(pLeftField, pCond,
  pRightField: string): TDeleteQuery;
begin
  inherited OrWhere(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TDeleteQuery.OrWhere(pLeftField, pRightField: string): TDeleteQuery;
begin
  inherited OrWhere(pLeftField, pRightField);
  Result := Self;
end;

function TDeleteQuery.OrWhere(pCond: string): TDeleteQuery;
begin
  inherited OrWhere(pCond);
  Result := Self;
end;

function TDeleteQuery.OrWhere(pLeftField, pCond: string;
  pValues: TArray<string>): TDeleteQuery;
begin
  inherited OrWhere(pLeftField, pCond, pValues);
  Result := Self;
end;

function TDeleteQuery.OrWhere(pLeftField: TColumn; pCond: string;
  pValues: TArray<string>): TDeleteQuery;
begin
  inherited OrWhere(pLeftField, pCond, pValues);
  Result := Self;
end;

function TDeleteQuery.OrWhere(pLeftField: TColumn; pCond: string;
  pRightField: TColumn): TDeleteQuery;
begin
  inherited OrWhere(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TDeleteQuery.OrWhere(pLeftField, pRightField: TColumn): TDeleteQuery;
begin
  inherited OrWhere(pLeftField, pRightField);
  Result := Self;
end;

function TDeleteQuery.OrWhereIn(pLeftField: string;
  pValues: TArray<string>): TDeleteQuery;
begin
  inherited OrWhereIn(pLeftField, pValues);
  Result := Self;
end;

function TDeleteQuery.OrWhereIn(pLeftField: TColumn;
  pValues: TArray<string>): TDeleteQuery;
begin
  inherited OrWhereIn(pLeftField, pValues);
  Result := Self;
end;

function TDeleteQuery.OrWhereNotIn(pLeftField: TColumn;
  pValues: TArray<string>): TDeleteQuery;
begin
  inherited OrWhereNotIn(pLeftField, pValues);
  Result := Self;
end;

function TDeleteQuery.OrWhereNotIn(pLeftField: string;
  pValues: TArray<string>): TDeleteQuery;
begin
  inherited OrWhereNotIn(pLeftField, pValues);
  Result := Self;
end;

function TDeleteQuery.Where(pLeftField, pRightField: string): TDeleteQuery;
begin
  inherited Where(pLeftField, pRightField);
  Result := Self;
end;

function TDeleteQuery.Where(pCond: string): TDeleteQuery;
begin
  inherited Where(pCond);
  Result := Self;
end;

function TDeleteQuery.Where(pLeftField, pCond,
  pRightField: string): TDeleteQuery;
begin
  inherited Where(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TDeleteQuery.Where(pLeftField: TColumn; pCond: string;
  pValues: TArray<string>): TDeleteQuery;
begin
  inherited Where(pLeftField, pCond, pValues);
  Result := Self;
end;

function TDeleteQuery.Where(pLeftField: TColumn; pCond: string;
  pRightField: TColumn): TDeleteQuery;
begin
  inherited Where(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TDeleteQuery.Where(pLeftField, pCond: string;
  pValues: TArray<string>): TDeleteQuery;
begin
  inherited Where(pLeftField, pCond, pValues);
  Result := Self;
end;

function TDeleteQuery.Where(pLeftField, pRightField: TColumn): TDeleteQuery;
begin
  inherited Where(pLeftField, pRightField);
  Result := Self;
end;

function TDeleteQuery.WhereIn(pLeftField: string;
  pValues: TArray<string>): TDeleteQuery;
begin
  inherited WhereIn(pLeftField, pValues);
  Result := Self;
end;

function TDeleteQuery.WhereIn(pLeftField: TColumn;
  pValues: TArray<string>): TDeleteQuery;
begin
  inherited WhereIn(pLeftField, pValues);
  Result := Self;
end;

function TDeleteQuery.WhereNotIn(pLeftField: string;
  pValues: TArray<string>): TDeleteQuery;
begin
  inherited WhereNotIn(pLeftField, pValues);
  Result := Self;
end;

function TDeleteQuery.WhereNotIn(pLeftField: TColumn;
  pValues: TArray<string>): TDeleteQuery;
begin
  inherited WhereNotIn(pLeftField, pValues);
  Result := Self;
end;

{ TInsertQuery }

function TInsertQuery.Serialize: TJSONObject;
begin
  Result := TJSONObject.Create;
  with Result do
  begin
    AddPair('Type', Self.tQueryType.ToString);
    AddPair('Pairs', TArrayUtils<TPair>.SerializeArray(Self.aPairs));
    AddPair('Table', Self.oTable.Serialize);
  end;
end;

function TInsertQuery.SetNullPair(pColumn: TColumn): TInsertQuery;
begin
  Self.AddPair(pColumn, 'null');
  Result := Self;
end;

function TInsertQuery.SetNullPair(pColumn: string): TInsertQuery;
begin
  Self.AddPair(TVarcharColumn.Create(pColumn, -1), 'null');
  Result := Self;
end;

function TInsertQuery.SetPair(pColumn: TColumn; pValue: TValue): TInsertQuery;
begin
  Self.AddPair(pColumn, pValue);
  Result := Self;
end;

function TInsertQuery.SetPair(pColumn, pValue: string): TInsertQuery;
begin
  Self.AddPair(TVarcharColumn.Create(pColumn, -1), pValue);
  Result := Self;
end;

function TInsertQuery.SetPair(pColumn: string; pValue: TValue): TInsertQuery;
begin
  Self.AddPair(TVarcharColumn.Create(pColumn, -1), pValue);
  Result := Self;
end;

function TInsertQuery.SetPair(pColumn: TColumn; pValue: string): TInsertQuery;
begin
  Self.AddPair(pColumn, pValue);
  Result := Self;
end;

procedure TInsertQuery.AddPair(pColumn: TColumn; pValue: TValue);
begin
  TArrayUtils<TPair>.Append(Self.aPairs, TPair.Create(pColumn, pValue));
end;

constructor TInsertQuery.Create(pTable: string);
begin
  inherited Create(pTable);
  Self.tQueryType := qtInsert;
end;

constructor TInsertQuery.Create(pTable: TTable);
begin
  inherited Create(pTable);
  Self.tQueryType := qtInsert;
end;

function TInsertQuery.GenerateSQL: string;
var
  i: Integer;
begin
  try
    Self.sSQL := 'insert into ' + Self.oTable.Name + ' (';
    for i := 0 to (Length(Self.aPairs) - 1) do
    begin
      if i <> 0 then
        Self.sSQL := Self.sSQL + Spaces(Length('insert into ' + Self.oTable.Name + ' ('));

      Self.sSQL := Self.sSQL + Self.aPairs[i].Column.Name + ',' + #13#10;
    end;

    SetLength(Self.sSQL, Length(Self.sSQL) - Length(',' + #13#10));

    Self.sSQL := Self.sSQL + ')' + #13#10 + 'values (';

    for i := 0 to (Length(Self.aPairs) - 1) do
    begin
      if i <> 0 then
        Self.sSQL := Self.sSQL + Spaces(8);

      Self.sSQL := Self.sSQL + Self.aPairs[i].Value.ToSQL + ',' + #13#10;
    end;

    SetLength(Self.sSQL, Length(Self.sSQL) - Length(',' + #13#10));

    Self.sSQL := Self.sSQL + ')';
  except
    on E: Exception do
    begin
      Self.sSQL := '';
      raise Exception.Create('Erro ao gerar SelectSQL: ' + E.Message);
    end;
  end;

  Result := Self.sSQL;
end;

function TInsertQuery.GetSQL: string;
begin
  Result := Self.GenerateSQL;
end;

{ TUpdateQuery }

function TUpdateQuery.Serialize: TJSONObject;
begin
  Result := TJSONObject.Create;
  with Result do
  begin
    AddPair('Type', Self.tQueryType.ToString);
    AddPair('Table', Self.oTable.Serialize);
    AddPair('Joins', TArrayUtils<TPair>.SerializeArray(Self.aPairs));
    AddPair('Where', TArrayUtils<TCondition>.SerializeArray(Self.aWhere));
  end;
end;

procedure TUpdateQuery.AddPair(pColumn: TColumn; pValue: TValue);
begin
  TArrayUtils<TPair>.Append(Self.aPairs, TPair.Create(pColumn, pValue));
end;

function TUpdateQuery.SetNullPair(pColumn: string): TUpdateQuery;
begin
  Self.AddPair(TVarcharColumn.Create(pColumn, -1), 'null');
  Result := Self;
end;

function TUpdateQuery.SetNullPair(pColumn: TColumn): TUpdateQuery;
begin
  Self.AddPair(pColumn, 'null');
  Result := Self;
end;

function TUpdateQuery.SetPair(pColumn: string; pValue: TValue): TUpdateQuery;
begin
  Self.AddPair(TVarcharColumn.Create(pColumn, -1), pValue);
  Result := Self;
end;

function TUpdateQuery.SetPair(pColumn, pValue: string): TUpdateQuery;
begin
  Self.AddPair(TVarcharColumn.Create(pColumn, -1), TValue.From(pValue));
  Result := Self;
end;

function TUpdateQuery.SetPair(pColumn: TColumn; pValue: string): TUpdateQuery;
begin
  Self.AddPair(pColumn, TValue.From(pValue));
  Result := Self;
end;

function TUpdateQuery.SetPair(pColumn: TColumn; pValue: TValue): TUpdateQuery;
begin
  Self.AddPair(pColumn, pValue);
  Result := Self;
end;

constructor TUpdateQuery.Create(pTable: string);
begin
  inherited Create(pTable);
  Self.tQueryType := qtUpdate;
end;

constructor TUpdateQuery.Create(pTable: TTable);
begin
  inherited Create(pTable);
  Self.tQueryType := qtUpdate;
end;

function TUpdateQuery.GenerateSQL: string;
var
  i: Integer;
begin
  try
    Self.sSQL := 'update ' + Self.oTable.Name + ' ' +
        Coalesce([Self.oTable.Alias, GetTableLabel(1)]) + #13#10 + 'set ';
    for i := 0 to (Length(Self.aPairs) - 1) do
    begin
      if i <> 0 then
        Self.sSQL := Self.sSQL + Spaces(4);

      Self.sSQL := Self.sSQL + Coalesce([Self.aPairs[i].Column.TableLabel, GetTableLabel(1)]) +
          '.' + Self.aPairs[i].Column.Name + ' = ' + Self.aPairs[i].Value.ToSQL + ',' + #13#10;
    end;

    SetLength(Self.sSQL, Length(Self.sSQL) - Length(',' + #13#10));

    if Length(Self.aWhere) > 0 then
    begin
      Self.sSQL := Self.sSQL + #13#10 + 'where ';
      for i := 0 to (Length(Self.aWhere) - 1) do
        Self.sSQL := Self.sSQL + Self.aWhere[i].GenerateSQL(6, (i <> 0));
    end;
  except
    on E: Exception do
    begin
      Self.sSQL := '';
      raise Exception.Create('Erro ao gerar SelectSQL: ' + E.Message);
    end;
  end;

  Result := Self.sSQL;
end;

function TUpdateQuery.GetSQL: string;
begin
  Result := Self.GenerateSQL;
end;

function TUpdateQuery.OrWhere(pLeftField, pCond,
  pRightField: string): TUpdateQuery;
begin
  inherited OrWhere(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TUpdateQuery.OrWhere(pLeftField, pRightField: string): TUpdateQuery;
begin
  inherited OrWhere(pLeftField, pRightField);
  Result := Self;
end;

function TUpdateQuery.OrWhere(pCond: string): TUpdateQuery;
begin
  inherited OrWhere(pCond);
  Result := Self;
end;

function TUpdateQuery.OrWhere(pLeftField, pCond: string;
  pValues: TArray<string>): TUpdateQuery;
begin
  inherited OrWhere(pLeftField, pCond, pValues);
  Result := Self;
end;

function TUpdateQuery.OrWhere(pLeftField: TColumn; pCond: string;
  pValues: TArray<string>): TUpdateQuery;
begin
  inherited OrWhere(pLeftField, pCond, pValues);
  Result := Self;
end;

function TUpdateQuery.OrWhere(pLeftField: TColumn; pCond: string;
  pRightField: TColumn): TUpdateQuery;
begin
  inherited OrWhere(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TUpdateQuery.OrWhere(pLeftField, pRightField: TColumn): TUpdateQuery;
begin
  inherited OrWhere(pLeftField, pRightField);
  Result := Self;
end;

function TUpdateQuery.OrWhereIn(pLeftField: string;
  pValues: TArray<string>): TUpdateQuery;
begin
  inherited OrWhereIn(pLeftField, pValues);
  Result := Self;
end;

function TUpdateQuery.OrWhereIn(pLeftField: TColumn;
  pValues: TArray<string>): TUpdateQuery;
begin
  inherited OrWhereIn(pLeftField, pValues);
  Result := Self;
end;

function TUpdateQuery.OrWhereNotIn(pLeftField: TColumn;
  pValues: TArray<string>): TUpdateQuery;
begin
  inherited WhereNotIn(pLeftField, pValues);
  Result := Self;
end;

function TUpdateQuery.OrWhereNotIn(pLeftField: string;
  pValues: TArray<string>): TUpdateQuery;
begin
  inherited OrWhereNotIn(pLeftField, pValues);
  Result := Self;
end;

function TUpdateQuery.Where(pLeftField, pRightField: string): TUpdateQuery;
begin
  inherited Where(pLeftField, pRightField);
  Result := Self;
end;

function TUpdateQuery.Where(pCond: string): TUpdateQuery;
begin
  inherited Where(pCond);
  Result := Self;
end;

function TUpdateQuery.Where(pLeftField, pCond,
  pRightField: string): TUpdateQuery;
begin
  inherited Where(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TUpdateQuery.Where(pLeftField: TColumn; pCond: string;
  pValues: TArray<string>): TUpdateQuery;
begin
  inherited Where(pLeftField, pCond, pValues);
  Result := Self;
end;

function TUpdateQuery.Where(pLeftField: TColumn; pCond: string;
  pRightField: TColumn): TUpdateQuery;
begin
  inherited Where(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TUpdateQuery.Where(pLeftField, pCond: string;
  pValues: TArray<string>): TUpdateQuery;
begin
  inherited Where(pLeftField, pCond, pValues);
  Result := Self;
end;

function TUpdateQuery.Where(pLeftField, pRightField: TColumn): TUpdateQuery;
begin
  inherited Where(pLeftField, pRightField);
  Result := Self;
end;

function TUpdateQuery.WhereIn(pLeftField: string;
  pValues: TArray<string>): TUpdateQuery;
begin
  inherited WhereIn(pLeftField, pValues);
  Result := Self;
end;

function TUpdateQuery.WhereIn(pLeftField: TColumn;
  pValues: TArray<string>): TUpdateQuery;
begin
  inherited WhereIn(pLeftField, pValues);
  Result := Self;
end;

function TUpdateQuery.WhereNotIn(pLeftField: string;
  pValues: TArray<string>): TUpdateQuery;
begin
  inherited WhereNotIn(pLeftField, pValues);
  Result := Self;
end;

function TUpdateQuery.WhereNotIn(pLeftField: TColumn;
  pValues: TArray<string>): TUpdateQuery;
begin
  inherited WhereNotIn(pLeftField, pValues);
  Result := Self;
end;

end.
