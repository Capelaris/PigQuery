unit PigQuery.Core.Query;

interface

uses
  PigQuery.Helpers, PigQuery.Commons, PigQuery.Interfaces,
  PigQuery.Core.Table, PigQuery.Core.Columns, PigQuery.Core.Condition,
  PigQuery.Core.Join, PigQuery.Core.Param, PigQuery.Core.Pair,
  Rtti, Variants, SysUtils, JSON;

type
  TQuery = class(TInterfacedObject, IQuery)
  private
    tQueryType: TQueryType;
    oTable    : ITable;
    aWhere    : TArray<ICondition>;

    procedure SetQueryType(Value: TQueryType);
    function GetQueryType: TQueryType;
    procedure SetTable(Value: ITable);
    function GetTable: ITable;

    procedure AddWhere(pCondition: ICondition);
    function GenerateSQL: string; virtual; abstract;

    function Where(pCond: string): IQuery; overload;
    function Where(pLeftField, pRightField: string): IQuery; overload;
    function Where(pLeftField, pCond, pRightField: string): IQuery; overload;
    function Where(pLeftField, pCond: string; pValues: TArray<string>): IQuery; overload;
    function Where(pLeftField, pRightField: IColumn): IQuery; overload;
    function Where(pLeftField: IColumn; pCond: string; pRightField: IColumn): IQuery; overload;
    function Where(pLeftField: IColumn; pCond: string; pValues: TArray<string>): IQuery; overload;
    function WhereIn(pLeftField: string; pValues: TArray<string>): IQuery; overload;
    function WhereIn(pLeftField: IColumn; pValues: TArray<string>): IQuery; overload;
    function WhereNotIn(pLeftField: string; pValues: TArray<string>): IQuery; overload;
    function WhereNotIn(pLeftField: IColumn; pValues: TArray<string>): IQuery; overload;

    function OrWhere(pCond: string): IQuery; overload;
    function OrWhere(pLeftField, pRightField: string): IQuery; overload;
    function OrWhere(pLeftField, pCond, pRightField: string): IQuery; overload;
    function OrWhere(pLeftField, pCond: string; pValues: TArray<string>): IQuery; overload;
    function OrWhere(pLeftField, pRightField: IColumn): IQuery; overload;
    function OrWhere(pLeftField: IColumn; pCond: string; pRightField: IColumn): IQuery; overload;
    function OrWhere(pLeftField: IColumn; pCond: string; pValues: TArray<string>): IQuery; overload;
    function OrWhereIn(pLeftField: string; pValues: TArray<string>): IQuery; overload;
    function OrWhereIn(pLeftField: IColumn; pValues: TArray<string>): IQuery; overload;
    function OrWhereNotIn(pLeftField: string; pValues: TArray<string>): IQuery; overload;
    function OrWhereNotIn(pLeftField: IColumn; pValues: TArray<string>): IQuery; overload;
  public
    constructor Create(pTable: string); overload;
    constructor Create(pTable: ITable); overload;

    function Serialize: TJSONObject;

    property QueryType: TQueryType read GetQueryType write SetQueryType;
    property Table    : ITable     read GetTable     write SetTable;
  end;

  TSelectQuery = class(TQuery, ISelectQuery)
  private
    aColumns  : TArray<IColumn>;
    aJoins    : TArray<IJoin>;
    aOrderBy  : TArray<IColumn>;
    sSQL      : string;

    procedure AddJoin(pJoin: IJoin);
    function GenerateSQL: string; override;
  public
    constructor Create(pTable: string); overload;
    constructor Create(pTable: ITable); overload;

    function SetColumns(pColumns: TArray<IColumn>): ISelectQuery;

    function Join(pJoinType: TJoinType; pTable: ITable; pConditions: TArray<ICondition>): ISelectQuery; overload;
    function Join(pJoinType: TJoinType; pTable: string; pConditions: TArray<ICondition>): ISelectQuery; overload;
    function Join(pTable: ITable; pConditions: TArray<ICondition>): ISelectQuery; overload;
    function Join(pTable: string; pConditions: TArray<ICondition>): ISelectQuery; overload;
    function InnerJoin(pTable: ITable; pConditions: TArray<ICondition>): ISelectQuery; overload;
    function InnerJoin(pTable: string; pConditions: TArray<ICondition>): ISelectQuery; overload;
    function LeftJoin(pTable: ITable; pConditions: TArray<ICondition>): ISelectQuery; overload;
    function LeftJoin(pTable: string; pConditions: TArray<ICondition>): ISelectQuery; overload;
    function RightJoin(pTable: ITable; pConditions: TArray<ICondition>): ISelectQuery; overload;
    function RightJoin(pTable: string; pConditions: TArray<ICondition>): ISelectQuery; overload;
    function OuterJoin(pTable: ITable; pConditions: TArray<ICondition>): ISelectQuery; overload;
    function OuterJoin(pTable: string; pConditions: TArray<ICondition>): ISelectQuery; overload;

    function Where(pCond: string): ISelectQuery; overload;
    function Where(pLeftField, pRightField: string): ISelectQuery; overload;
    function Where(pLeftField, pCond, pRightField: string): ISelectQuery; overload;
    function Where(pLeftField, pCond: string; pValues: TArray<string>): ISelectQuery; overload;
    function Where(pLeftField, pRightField: IColumn): ISelectQuery; overload;
    function Where(pLeftField: IColumn; pCond: string; pRightField: IColumn): ISelectQuery; overload;
    function Where(pLeftField: IColumn; pCond: string; pValues: TArray<string>): ISelectQuery; overload;
    function WhereIn(pLeftField: string; pValues: TArray<string>): ISelectQuery; overload;
    function WhereIn(pLeftField: IColumn; pValues: TArray<string>): ISelectQuery; overload;
    function WhereNotIn(pLeftField: string; pValues: TArray<string>): ISelectQuery; overload;
    function WhereNotIn(pLeftField: IColumn; pValues: TArray<string>): ISelectQuery; overload;

    function OrWhere(pCond: string): ISelectQuery; overload;
    function OrWhere(pLeftField, pRightField: string): ISelectQuery; overload;
    function OrWhere(pLeftField, pCond, pRightField: string): ISelectQuery; overload;
    function OrWhere(pLeftField, pCond: string; pValues: TArray<string>): ISelectQuery; overload;
    function OrWhere(pLeftField, pRightField: IColumn): ISelectQuery; overload;
    function OrWhere(pLeftField: IColumn; pCond: string; pRightField: IColumn): ISelectQuery; overload;
    function OrWhere(pLeftField: IColumn; pCond: string; pValues: TArray<string>): ISelectQuery; overload;
    function OrWhereIn(pLeftField: string; pValues: TArray<string>): ISelectQuery; overload;
    function OrWhereIn(pLeftField: IColumn; pValues: TArray<string>): ISelectQuery; overload;
    function OrWhereNotIn(pLeftField: string; pValues: TArray<string>): ISelectQuery; overload;
    function OrWhereNotIn(pLeftField: IColumn; pValues: TArray<string>): ISelectQuery; overload;

    function OrderBy(pColumn: IColumn): ISelectQuery; overload;
    function OrderBy(pColumn: string): ISelectQuery; overload;
    function OrderBy(pColumns: TArray<IColumn>): ISelectQuery; overload;
    function OrderBy(pColumns: TArray<string>): ISelectQuery; overload;

    function GetSQL: string; overload;
    function GetSQL(pColumns: TArray<IColumn>): string; overload;
    function GetSQL(pColumns: TArray<string>): string; overload;

    function Serialize: TJSONObject;

    property QueryType;
    property Table;
  end;

  TDeleteQuery = class(TQuery, IDeleteQuery)
  private
    sSQL: string;
    function GenerateSQL: string; override;
  public
    function Where(pCond: string): IDeleteQuery; overload;
    function Where(pLeftField, pRightField: string): IDeleteQuery; overload;
    function Where(pLeftField, pCond, pRightField: string): IDeleteQuery; overload;
    function Where(pLeftField, pCond: string; pValues: TArray<string>): IDeleteQuery; overload;
    function Where(pLeftField, pRightField: IColumn): IDeleteQuery; overload;
    function Where(pLeftField: IColumn; pCond: string; pRightField: IColumn): IDeleteQuery; overload;
    function Where(pLeftField: IColumn; pCond: string; pValues: TArray<string>): IDeleteQuery; overload;
    function WhereIn(pLeftField: string; pValues: TArray<string>): IDeleteQuery; overload;
    function WhereIn(pLeftField: IColumn; pValues: TArray<string>): IDeleteQuery; overload;
    function WhereNotIn(pLeftField: string; pValues: TArray<string>): IDeleteQuery; overload;
    function WhereNotIn(pLeftField: IColumn; pValues: TArray<string>): IDeleteQuery; overload;

    function OrWhere(pCond: string): IDeleteQuery; overload;
    function OrWhere(pLeftField, pRightField: string): IDeleteQuery; overload;
    function OrWhere(pLeftField, pCond, pRightField: string): IDeleteQuery; overload;
    function OrWhere(pLeftField, pCond: string; pValues: TArray<string>): IDeleteQuery; overload;
    function OrWhere(pLeftField, pRightField: IColumn): IDeleteQuery; overload;
    function OrWhere(pLeftField: IColumn; pCond: string; pRightField: IColumn): IDeleteQuery; overload;
    function OrWhere(pLeftField: IColumn; pCond: string; pValues: TArray<string>): IDeleteQuery; overload;
    function OrWhereIn(pLeftField: string; pValues: TArray<string>): IDeleteQuery; overload;
    function OrWhereIn(pLeftField: IColumn; pValues: TArray<string>): IDeleteQuery; overload;
    function OrWhereNotIn(pLeftField: string; pValues: TArray<string>): IDeleteQuery; overload;
    function OrWhereNotIn(pLeftField: IColumn; pValues: TArray<string>): IDeleteQuery; overload;

    function GetSQL: string;

    function Serialize: TJSONObject;

    property QueryType;
    property Table;
  end;

  TInsertQuery = class(TQuery, IInsertQuery)
  private
    sSQL  : string;
    aPairs: TArray<IPair>;

    function GenerateSQL: string; override;
  public
    function GetSQL: string;

    function Serialize: TJSONObject;

    property QueryType;
    property Table;
  end;

  TUpdateQuery = class(TQuery, IUpdateQuery)
  private
    sSQL  : string;
    aPairs: TArray<IPair>;

    procedure AddPair(pColumn: IColumn; pValue: TValue);
    function GenerateSQL: string; override;
  public
    function Where(pCond: string): IUpdateQuery; overload;
    function Where(pLeftField, pRightField: string): IUpdateQuery; overload;
    function Where(pLeftField, pCond, pRightField: string): IUpdateQuery; overload;
    function Where(pLeftField, pCond: string; pValues: TArray<string>): IUpdateQuery; overload;
    function Where(pLeftField, pRightField: IColumn): IUpdateQuery; overload;
    function Where(pLeftField: IColumn; pCond: string; pRightField: IColumn): IUpdateQuery; overload;
    function Where(pLeftField: IColumn; pCond: string; pValues: TArray<string>): IUpdateQuery; overload;
    function WhereIn(pLeftField: string; pValues: TArray<string>): IUpdateQuery; overload;
    function WhereIn(pLeftField: IColumn; pValues: TArray<string>): IUpdateQuery; overload;
    function WhereNotIn(pLeftField: string; pValues: TArray<string>): IUpdateQuery; overload;
    function WhereNotIn(pLeftField: IColumn; pValues: TArray<string>): IUpdateQuery; overload;

    function OrWhere(pCond: string): IUpdateQuery; overload;
    function OrWhere(pLeftField, pRightField: string): IUpdateQuery; overload;
    function OrWhere(pLeftField, pCond, pRightField: string): IUpdateQuery; overload;
    function OrWhere(pLeftField, pCond: string; pValues: TArray<string>): IUpdateQuery; overload;
    function OrWhere(pLeftField, pRightField: IColumn): IUpdateQuery; overload;
    function OrWhere(pLeftField: IColumn; pCond: string; pRightField: IColumn): IUpdateQuery; overload;
    function OrWhere(pLeftField: IColumn; pCond: string; pValues: TArray<string>): IUpdateQuery; overload;
    function OrWhereIn(pLeftField: string; pValues: TArray<string>): IUpdateQuery; overload;
    function OrWhereIn(pLeftField: IColumn; pValues: TArray<string>): IUpdateQuery; overload;
    function OrWhereNotIn(pLeftField: string; pValues: TArray<string>): IUpdateQuery; overload;
    function OrWhereNotIn(pLeftField: IColumn; pValues: TArray<string>): IUpdateQuery; overload;

    function SetPair(pColumn, pValue: string): IUpdateQuery; overload;
    function SetPair(pColumn: string; pValue: TValue): IUpdateQuery; overload;
    function SetPair(pColumn: IColumn; pValue: string): IUpdateQuery; overload;
    function SetPair(pColumn: IColumn; pValue: TValue): IUpdateQuery; overload;

    function SetNullPair(pColumn: string): IUpdateQuery; overload;
    function SetNullPair(pColumn: IColumn): IUpdateQuery; overload;

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
    AddPair('Where', TArrayUtils<ICondition>.SerializeArray(Self.aWhere));
  end;
end;

procedure TQuery.SetQueryType(Value: TQueryType);
begin
  Self.tQueryType := Value;
end;

procedure TQuery.SetTable(Value: ITable);
begin
  Self.oTable := Value;
end;

procedure TQuery.AddWhere(pCondition: ICondition);
begin
  TArrayUtils<ICondition>.Append(Self.aWhere, pCondition);
end;

constructor TQuery.Create(pTable: string);
begin
  Create(TTable.Create(pTable, 'a'));
end;

constructor TQuery.Create(pTable: ITable);
begin
  inherited Create;
  Self.oTable := pTable;
end;

function TQuery.GetQueryType: TQueryType;
begin
  Result := Self.tQueryType;
end;

function TQuery.GetTable: ITable;
begin
  Result := Self.oTable;
end;

function TQuery.Where(pLeftField, pRightField: string): IQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, '=', pRightField).Left('and'));
end;

function TQuery.Where(pCond: string): IQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pCond).Left('and'));
end;

function TQuery.Where(pLeftField, pCond, pRightField: string): IQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, pCond, pRightField).Left('and'));
end;

function TQuery.Where(pLeftField: IColumn; pCond: string;
  pValues: TArray<string>): IQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, pCond, pValues).Left('and'));
end;

function TQuery.Where(pLeftField: IColumn; pCond: string;
  pRightField: IColumn): IQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, pCond, pRightField).Left('and'));
end;

function TQuery.Where(pLeftField, pCond: string;
  pValues: TArray<string>): IQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, pCond, pValues).Left('and'));
end;

function TQuery.Where(pLeftField, pRightField: IColumn): IQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, '=', pRightField).Left('and'));
end;

function TQuery.WhereIn(pLeftField: string; pValues: TArray<string>): IQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, 'in', pValues).Left('and'));
end;

function TQuery.WhereIn(pLeftField: IColumn; pValues: TArray<string>): IQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, 'in', pValues).Left('and'));
end;

function TQuery.WhereNotIn(pLeftField: string; pValues: TArray<string>): IQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, 'not in', pValues).Left('and'));
end;

function TQuery.WhereNotIn(pLeftField: IColumn;
  pValues: TArray<string>): IQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, 'not in', pValues).Left('and'));
end;

function TQuery.OrWhere(pLeftField, pRightField: string): IQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, '=', pRightField).Left('or'));
end;

function TQuery.OrWhere(pCond: string): IQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pCond).Left('or'));
end;

function TQuery.OrWhere(pLeftField, pCond, pRightField: string): IQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, pCond, pRightField).Left('or'));
end;

function TQuery.OrWhere(pLeftField: IColumn; pCond: string;
  pValues: TArray<string>): IQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, pCond, pValues).Left('or'));
end;

function TQuery.OrWhere(pLeftField: IColumn; pCond: string;
  pRightField: IColumn): IQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, pCond, pRightField).Left('or'));
end;

function TQuery.OrWhere(pLeftField, pCond: string;
  pValues: TArray<string>): IQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, pCond, pValues).Left('or'));
end;

function TQuery.OrWhere(pLeftField, pRightField: IColumn): IQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, '=', pRightField).Left('or'));
end;

function TQuery.OrWhereIn(pLeftField: string; pValues: TArray<string>): IQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, 'in', pValues).Left('or'));
end;

function TQuery.OrWhereIn(pLeftField: IColumn; pValues: TArray<string>): IQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, 'in', pValues).Left('or'));
end;

function TQuery.OrWhereNotIn(pLeftField: string; pValues: TArray<string>): IQuery;
begin
  Result := Self;
  AddWhere(TCondition.Create(pLeftField, 'not in', pValues).Left('or'));
end;

function TQuery.OrWhereNotIn(pLeftField: IColumn;
  pValues: TArray<string>): IQuery;
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
    AddPair('Columns', TArrayUtils<IColumn>.SerializeArray(Self.aColumns));
    AddPair('Table', Self.oTable.Serialize);
    AddPair('Joins', TArrayUtils<IJoin>.SerializeArray(Self.aJoins));
    AddPair('Where', TArrayUtils<ICondition>.SerializeArray(Self.aWhere));
    AddPair('OrderBy', TArrayUtils<IColumn>.SerializeArray(Self.aOrderBy));
  end;
end;

constructor TSelectQuery.Create(pTable: string);
begin
  inherited Create(pTable);
  Self.QueryType := qtSelect;
end;

procedure TSelectQuery.AddJoin(pJoin: IJoin);
begin
  TArrayUtils<IJoin>.Append(Self.aJoins, pJoin);
end;

constructor TSelectQuery.Create(pTable: ITable);
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

      Self.sSQL := Self.sSQL + Coalesce([Self.aColumns[i].GetTableLabel, GetTableLabel(1)]) +
          '.' + Self.aColumns[i].GetName + ',' + #13#10;
    end;

    SetLength(Self.sSQL, Length(Self.sSQL) - Length(',' + #13#10));

    Self.sSQL := Self.sSQL + #13#10 + 'from ' + Self.oTable.GetName + ' ' + Coalesce([Self.oTable.GetAlias, GetTableLabel(1)]);

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

        Self.sSQL := Self.sSQL + Coalesce([Self.aOrderBy[i].GetTableLabel, oTable.GetAlias]) +
            '.' + Self.aOrderBy[i].GetName + ',' + #13#10;
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

function TSelectQuery.GetSQL(pColumns: TArray<IColumn>): string;
begin
  Self.SetColumns(pColumns);
  Result := GetSQL;
end;

function TSelectQuery.GetSQL(pColumns: TArray<string>): string;
var
  Columns: TArray<IColumn>;
  Column : string;
begin
  for Column in pColumns do
    TArrayUtils<IColumn>.Append(Columns, TColumn.Create(Column, ctUnknown, -1, -1, False, '', '', TValue.From<Variant>(Null)));
  Result := GetSQL(Columns);
end;

function TSelectQuery.InnerJoin(pTable: string;
  pConditions: TArray<ICondition>): ISelectQuery;
begin
  Result := Self;
  AddJoin(TJoin.Create(jtInner, pTable, pConditions));
end;

function TSelectQuery.InnerJoin(pTable: ITable;
  pConditions: TArray<ICondition>): ISelectQuery;
begin
  Result := Self;
  AddJoin(TJoin.Create(jtInner, pTable, pConditions));
end;

function TSelectQuery.Join(pJoinType: TJoinType; pTable: string;
  pConditions: TArray<ICondition>): ISelectQuery;
begin
  Result := Self;
  AddJoin(TJoin.Create(pJoinType, pTable, pConditions));
end;

function TSelectQuery.Join(pJoinType: TJoinType; pTable: ITable;
  pConditions: TArray<ICondition>): ISelectQuery;
begin
  Result := Self;
  AddJoin(TJoin.Create(pJoinType, pTable, pConditions));
end;

function TSelectQuery.Join(pTable: string;
  pConditions: TArray<ICondition>): ISelectQuery;
begin
  Result := Self;
  AddJoin(TJoin.Create(jtNone, pTable, pConditions));
end;

function TSelectQuery.Join(pTable: ITable;
  pConditions: TArray<ICondition>): ISelectQuery;
begin
  Result := Self;
  AddJoin(TJoin.Create(jtNone, pTable, pConditions));
end;

function TSelectQuery.LeftJoin(pTable: ITable;
  pConditions: TArray<ICondition>): ISelectQuery;
begin
  Result := Self;
  AddJoin(TJoin.Create(jtLeft, pTable, pConditions));
end;

function TSelectQuery.LeftJoin(pTable: string;
  pConditions: TArray<ICondition>): ISelectQuery;
begin
  Result := Self;
  AddJoin(TJoin.Create(jtLeft, pTable, pConditions));
end;

function TSelectQuery.OuterJoin(pTable: ITable;
  pConditions: TArray<ICondition>): ISelectQuery;
begin
  Result := Self;
  AddJoin(TJoin.Create(jtOuter, pTable, pConditions));
end;

function TSelectQuery.OrderBy(pColumn: IColumn): ISelectQuery;
begin
  Result := OrderBy([pColumn]);
end;

function TSelectQuery.OrderBy(pColumn: string): ISelectQuery;
begin
  Result := OrderBy(TColumn.Create(pColumn, ctUnknown, -1, -1, False, '', '', TValue.From<Variant>(Null)));
end;

function TSelectQuery.OrderBy(pColumns: TArray<IColumn>): ISelectQuery;
begin
  Result := Self;
  TArrayUtils<IColumn>.Append(aOrderBy, pColumns);
end;

function TSelectQuery.OrderBy(pColumns: TArray<string>): ISelectQuery;
var
  Columns: TArray<IColumn>;
  Column : string;
begin
  for Column in pColumns do
    TArrayUtils<IColumn>.Append(Columns, TColumn.Create(Column, ctUnknown, -1, -1, False, '', '', TValue.From<Variant>(Null)));
  Result := OrderBy(Columns);
end;

function TSelectQuery.OrWhere(pLeftField, pCond,
  pRightField: string): ISelectQuery;
begin
  inherited OrWhere(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TSelectQuery.OrWhere(pLeftField, pRightField: string): ISelectQuery;
begin
  inherited OrWhere(pLeftField, pRightField);
  Result := Self;
end;

function TSelectQuery.OrWhere(pCond: string): ISelectQuery;
begin
  inherited OrWhere(pCond);
  Result := Self;
end;

function TSelectQuery.OrWhere(pLeftField, pCond: string;
  pValues: TArray<string>): ISelectQuery;
begin
  inherited OrWhere(pLeftField, pCond, pValues);
  Result := Self;
end;

function TSelectQuery.OrWhere(pLeftField: IColumn; pCond: string;
  pValues: TArray<string>): ISelectQuery;
begin
  inherited OrWhere(pLeftField, pCond, pValues);
  Result := Self;
end;

function TSelectQuery.OrWhere(pLeftField: IColumn; pCond: string;
  pRightField: IColumn): ISelectQuery;
begin
  inherited OrWhere(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TSelectQuery.OrWhere(pLeftField, pRightField: IColumn): ISelectQuery;
begin
  inherited OrWhere(pLeftField, pRightField);
  Result := Self;
end;

function TSelectQuery.OrWhereIn(pLeftField: string;
  pValues: TArray<string>): ISelectQuery;
begin
  inherited OrWhereIn(pLeftField, pValues);
  Result := Self;
end;

function TSelectQuery.OrWhereIn(pLeftField: IColumn;
  pValues: TArray<string>): ISelectQuery;
begin
  inherited OrWhereIn(pLeftField, pValues);
  Result := Self;
end;

function TSelectQuery.OrWhereNotIn(pLeftField: IColumn;
  pValues: TArray<string>): ISelectQuery;
begin
  inherited OrWhereNotIn(pLeftField, pValues);
  Result := Self;
end;

function TSelectQuery.OrWhereNotIn(pLeftField: string;
  pValues: TArray<string>): ISelectQuery;
begin
  inherited OrWhereNotIn(pLeftField, pValues);
  Result := Self;
end;

function TSelectQuery.OuterJoin(pTable: string;
  pConditions: TArray<ICondition>): ISelectQuery;
begin
  Result := Self;
  AddJoin(TJoin.Create(jtOuter, pTable, pConditions));
end;

function TSelectQuery.RightJoin(pTable: ITable;
  pConditions: TArray<ICondition>): ISelectQuery;
begin
  Result := Self;
  AddJoin(TJoin.Create(jtRight, pTable, pConditions));
end;

function TSelectQuery.RightJoin(pTable: string;
  pConditions: TArray<ICondition>): ISelectQuery;
begin
  Result := Self;
  AddJoin(TJoin.Create(jtRight, pTable, pConditions));
end;

function TSelectQuery.SetColumns(pColumns: TArray<IColumn>): ISelectQuery;
begin
  aColumns := pColumns;
  Result   := Self;
end;

function TSelectQuery.Where(pLeftField, pRightField: string): ISelectQuery;
begin
  inherited Where(pLeftField, pRightField);
  Result := Self;
end;

function TSelectQuery.Where(pCond: string): ISelectQuery;
begin
  inherited Where(pCond);
  Result := Self;
end;

function TSelectQuery.Where(pLeftField, pCond,
  pRightField: string): ISelectQuery;
begin
  inherited Where(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TSelectQuery.Where(pLeftField: IColumn; pCond: string;
  pValues: TArray<string>): ISelectQuery;
begin
  inherited Where(pLeftField, pCond, pValues);
  Result := Self;
end;

function TSelectQuery.Where(pLeftField: IColumn; pCond: string;
  pRightField: IColumn): ISelectQuery;
begin
  inherited Where(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TSelectQuery.Where(pLeftField, pCond: string;
  pValues: TArray<string>): ISelectQuery;
begin
  inherited Where(pLeftField, pCond, pValues);
  Result := Self;
end;

function TSelectQuery.Where(pLeftField, pRightField: IColumn): ISelectQuery;
begin
  inherited Where(pLeftField, pRightField);
  Result := Self;
end;

function TSelectQuery.WhereIn(pLeftField: string;
  pValues: TArray<string>): ISelectQuery;
begin
  inherited WhereIn(pLeftField, pValues);
  Result := Self;
end;

function TSelectQuery.WhereIn(pLeftField: IColumn;
  pValues: TArray<string>): ISelectQuery;
begin
  inherited WhereIn(pLeftField, pValues);
  Result := Self;
end;

function TSelectQuery.WhereNotIn(pLeftField: string;
  pValues: TArray<string>): ISelectQuery;
begin
  inherited WhereNotIn(pLeftField, pValues);
  Result := Self;
end;

function TSelectQuery.WhereNotIn(pLeftField: IColumn;
  pValues: TArray<string>): ISelectQuery;
begin
  inherited WhereNotIn(pLeftField, pValues);
  Result := Self;
end;

{ TDeleteQuery }

function TDeleteQuery.Serialize: TJSONObject;
begin
  Result := TJSONObject.Create;
  with Result do
  begin
    AddPair('Type', Self.tQueryType.ToString);
    AddPair('Table', Self.oTable.Serialize);
    AddPair('Where', TArrayUtils<ICondition>.SerializeArray(Self.aWhere));
  end;
end;

function TDeleteQuery.GenerateSQL: string;
var
  i: Integer;
begin
  try
    sSQL := 'delete from ' + oTable.GetName + ' ' + oTable.GetAlias;

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
  pRightField: string): IDeleteQuery;
begin
  inherited OrWhere(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TDeleteQuery.OrWhere(pLeftField, pRightField: string): IDeleteQuery;
begin
  inherited OrWhere(pLeftField, pRightField);
  Result := Self;
end;

function TDeleteQuery.OrWhere(pCond: string): IDeleteQuery;
begin
  inherited OrWhere(pCond);
  Result := Self;
end;

function TDeleteQuery.OrWhere(pLeftField, pCond: string;
  pValues: TArray<string>): IDeleteQuery;
begin
  inherited OrWhere(pLeftField, pCond, pValues);
  Result := Self;
end;

function TDeleteQuery.OrWhere(pLeftField: IColumn; pCond: string;
  pValues: TArray<string>): IDeleteQuery;
begin
  inherited OrWhere(pLeftField, pCond, pValues);
  Result := Self;
end;

function TDeleteQuery.OrWhere(pLeftField: IColumn; pCond: string;
  pRightField: IColumn): IDeleteQuery;
begin
  inherited OrWhere(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TDeleteQuery.OrWhere(pLeftField, pRightField: IColumn): IDeleteQuery;
begin
  inherited OrWhere(pLeftField, pRightField);
  Result := Self;
end;

function TDeleteQuery.OrWhereIn(pLeftField: string;
  pValues: TArray<string>): IDeleteQuery;
begin
  inherited OrWhereIn(pLeftField, pValues);
  Result := Self;
end;

function TDeleteQuery.OrWhereIn(pLeftField: IColumn;
  pValues: TArray<string>): IDeleteQuery;
begin
  inherited OrWhereIn(pLeftField, pValues);
  Result := Self;
end;

function TDeleteQuery.OrWhereNotIn(pLeftField: IColumn;
  pValues: TArray<string>): IDeleteQuery;
begin
  inherited OrWhereNotIn(pLeftField, pValues);
  Result := Self;
end;

function TDeleteQuery.OrWhereNotIn(pLeftField: string;
  pValues: TArray<string>): IDeleteQuery;
begin
  inherited OrWhereNotIn(pLeftField, pValues);
  Result := Self;
end;

function TDeleteQuery.Where(pLeftField, pRightField: string): IDeleteQuery;
begin
  inherited Where(pLeftField, pRightField);
  Result := Self;
end;

function TDeleteQuery.Where(pCond: string): IDeleteQuery;
begin
  inherited Where(pCond);
  Result := Self;
end;

function TDeleteQuery.Where(pLeftField, pCond,
  pRightField: string): IDeleteQuery;
begin
  inherited Where(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TDeleteQuery.Where(pLeftField: IColumn; pCond: string;
  pValues: TArray<string>): IDeleteQuery;
begin
  inherited Where(pLeftField, pCond, pValues);
  Result := Self;
end;

function TDeleteQuery.Where(pLeftField: IColumn; pCond: string;
  pRightField: IColumn): IDeleteQuery;
begin
  inherited Where(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TDeleteQuery.Where(pLeftField, pCond: string;
  pValues: TArray<string>): IDeleteQuery;
begin
  inherited Where(pLeftField, pCond, pValues);
  Result := Self;
end;

function TDeleteQuery.Where(pLeftField, pRightField: IColumn): IDeleteQuery;
begin
  inherited Where(pLeftField, pRightField);
  Result := Self;
end;

function TDeleteQuery.WhereIn(pLeftField: string;
  pValues: TArray<string>): IDeleteQuery;
begin
  inherited WhereIn(pLeftField, pValues);
  Result := Self;
end;

function TDeleteQuery.WhereIn(pLeftField: IColumn;
  pValues: TArray<string>): IDeleteQuery;
begin
  inherited WhereIn(pLeftField, pValues);
  Result := Self;
end;

function TDeleteQuery.WhereNotIn(pLeftField: string;
  pValues: TArray<string>): IDeleteQuery;
begin
  inherited WhereNotIn(pLeftField, pValues);
  Result := Self;
end;

function TDeleteQuery.WhereNotIn(pLeftField: IColumn;
  pValues: TArray<string>): IDeleteQuery;
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
    {AddPair('Columns', TArrayUtils<IColumn>.SerializeArray(Self.aColumns));
    AddPair('Table', Self.oTable.Serialize);
    AddPair('Joins', TArrayUtils<IJoin>.SerializeArray(Self.aJoins));
    AddPair('Where', TArrayUtils<ICondition>.SerializeArray(Self.aWhere));
    AddPair('OrderBy', TArrayUtils<IColumn>.SerializeArray(Self.aOrderBy));}
  end;
end;

function TInsertQuery.GenerateSQL: string;
begin
  //
end;

function TInsertQuery.GetSQL: string;
begin
  //
end;

{ TUpdateQuery }

function TUpdateQuery.Serialize: TJSONObject;
begin
  Result := TJSONObject.Create;
  with Result do
  begin
    AddPair('Type', Self.tQueryType.ToString);
    AddPair('Table', Self.oTable.Serialize);
    AddPair('Joins', TArrayUtils<IPair>.SerializeArray(Self.aPairs));
    AddPair('Where', TArrayUtils<ICondition>.SerializeArray(Self.aWhere));
  end;
end;

procedure TUpdateQuery.AddPair(pColumn: IColumn; pValue: TValue);
begin
  TArrayUtils<IPair>.Append(Self.aPairs, TPair.Create(pColumn, pValue));
end;

function TUpdateQuery.SetNullPair(pColumn: string): IUpdateQuery;
begin
  Self.AddPair(TColumn.Create(pColumn, ctUnknown, -1, -1, False, '', '', nil),
      'null');
end;

function TUpdateQuery.SetNullPair(pColumn: IColumn): IUpdateQuery;
begin
  Self.AddPair(pColumn, 'null');
end;

function TUpdateQuery.SetPair(pColumn: string; pValue: TValue): IUpdateQuery;
begin
  Self.AddPair(TColumn.Create(pColumn, ctUnknown, -1, -1, False, '', '', nil),
      pValue);
end;

function TUpdateQuery.SetPair(pColumn, pValue: string): IUpdateQuery;
begin
  Self.AddPair(TColumn.Create(pColumn, ctUnknown, -1, -1, False, '', '', nil),
      TValue.From(pValue));
end;

function TUpdateQuery.SetPair(pColumn: IColumn; pValue: string): IUpdateQuery;
begin
  Self.AddPair(pColumn, TValue.From(pValue));
end;

function TUpdateQuery.SetPair(pColumn: IColumn; pValue: TValue): IUpdateQuery;
begin
  Self.AddPair(pColumn, pValue);
end;

function TUpdateQuery.GenerateSQL: string;
begin
  //
end;

function TUpdateQuery.GetSQL: string;
begin
  //
end;

function TUpdateQuery.OrWhere(pLeftField, pCond,
  pRightField: string): IUpdateQuery;
begin
  inherited OrWhere(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TUpdateQuery.OrWhere(pLeftField, pRightField: string): IUpdateQuery;
begin
  inherited OrWhere(pLeftField, pRightField);
  Result := Self;
end;

function TUpdateQuery.OrWhere(pCond: string): IUpdateQuery;
begin
  inherited OrWhere(pCond);
  Result := Self;
end;

function TUpdateQuery.OrWhere(pLeftField, pCond: string;
  pValues: TArray<string>): IUpdateQuery;
begin
  inherited OrWhere(pLeftField, pCond, pValues);
  Result := Self;
end;

function TUpdateQuery.OrWhere(pLeftField: IColumn; pCond: string;
  pValues: TArray<string>): IUpdateQuery;
begin
  inherited OrWhere(pLeftField, pCond, pValues);
  Result := Self;
end;

function TUpdateQuery.OrWhere(pLeftField: IColumn; pCond: string;
  pRightField: IColumn): IUpdateQuery;
begin
  inherited OrWhere(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TUpdateQuery.OrWhere(pLeftField, pRightField: IColumn): IUpdateQuery;
begin
  inherited OrWhere(pLeftField, pRightField);
  Result := Self;
end;

function TUpdateQuery.OrWhereIn(pLeftField: string;
  pValues: TArray<string>): IUpdateQuery;
begin
  inherited OrWhereIn(pLeftField, pValues);
  Result := Self;
end;

function TUpdateQuery.OrWhereIn(pLeftField: IColumn;
  pValues: TArray<string>): IUpdateQuery;
begin
  inherited OrWhereIn(pLeftField, pValues);
  Result := Self;
end;

function TUpdateQuery.OrWhereNotIn(pLeftField: IColumn;
  pValues: TArray<string>): IUpdateQuery;
begin
  inherited WhereNotIn(pLeftField, pValues);
  Result := Self;
end;

function TUpdateQuery.OrWhereNotIn(pLeftField: string;
  pValues: TArray<string>): IUpdateQuery;
begin
  inherited OrWhereNotIn(pLeftField, pValues);
  Result := Self;
end;

function TUpdateQuery.Where(pLeftField, pRightField: string): IUpdateQuery;
begin
  inherited Where(pLeftField, pRightField);
  Result := Self;
end;

function TUpdateQuery.Where(pCond: string): IUpdateQuery;
begin
  inherited Where(pCond);
  Result := Self;
end;

function TUpdateQuery.Where(pLeftField, pCond,
  pRightField: string): IUpdateQuery;
begin
  inherited Where(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TUpdateQuery.Where(pLeftField: IColumn; pCond: string;
  pValues: TArray<string>): IUpdateQuery;
begin
  inherited Where(pLeftField, pCond, pValues);
  Result := Self;
end;

function TUpdateQuery.Where(pLeftField: IColumn; pCond: string;
  pRightField: IColumn): IUpdateQuery;
begin
  inherited Where(pLeftField, pCond, pRightField);
  Result := Self;
end;

function TUpdateQuery.Where(pLeftField, pCond: string;
  pValues: TArray<string>): IUpdateQuery;
begin
  inherited Where(pLeftField, pCond, pValues);
  Result := Self;
end;

function TUpdateQuery.Where(pLeftField, pRightField: IColumn): IUpdateQuery;
begin
  inherited Where(pLeftField, pRightField);
  Result := Self;
end;

function TUpdateQuery.WhereIn(pLeftField: string;
  pValues: TArray<string>): IUpdateQuery;
begin
  inherited WhereIn(pLeftField, pValues);
  Result := Self;
end;

function TUpdateQuery.WhereIn(pLeftField: IColumn;
  pValues: TArray<string>): IUpdateQuery;
begin
  inherited WhereIn(pLeftField, pValues);
  Result := Self;
end;

function TUpdateQuery.WhereNotIn(pLeftField: string;
  pValues: TArray<string>): IUpdateQuery;
begin
  inherited WhereNotIn(pLeftField, pValues);
  Result := Self;
end;

function TUpdateQuery.WhereNotIn(pLeftField: IColumn;
  pValues: TArray<string>): IUpdateQuery;
begin
  inherited WhereNotIn(pLeftField, pValues);
  Result := Self;
end;

end.
