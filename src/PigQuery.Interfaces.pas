unit PigQuery.Interfaces;

interface

uses
  PigQuery.Commons, Rtti, JSON, DB;

type
  ISerializable = interface(IUnknown)
  ['{550F6F96-83FF-4A83-9EB2-9E69A54D269C}']
    function Serialize: TJSONObject;
  end;

  IColumn = interface(ISerializable)
  ['{35D2045A-1D73-4393-8DEC-B7601A47FB7B}']
    procedure SetName(Value: string);
    function GetName: string;
    procedure SetTableLabel(Value: string);
    function GetTableLabel: string;
    procedure SetSize(Value: Integer);
    function GetSize: Integer;
    procedure SetScale(Value: Integer);
    function GetScale: Integer;
    procedure SetNotNull(Value: Boolean);
    function GetNotNull: Boolean;
    procedure SetFieldType(Value: TColumnType);
    function GetFieldType: TColumnType;
    procedure SetCharset(Value: string);
    function GetCharset: string;
    procedure SetCollate(Value: string);
    function GetCollate: string;
    procedure SetDefaultVal(Value: TValue);
    function GetDefaultVal: TValue;

    function GetValue(pField: TField): TValue;
  end;

  ITable = interface(ISerializable)
  ['{BC998FA5-AC58-4458-8112-B8D4DA3FA27C}']
    procedure SetName(Value: string);
    function GetName: string;
    procedure SetAlias(Value: string);
    function GetAlias: string;
  end;

  IParam = interface(ISerializable)
  ['{153A2D32-6758-4037-B29F-F94EB1CF717A}']
    procedure SetFieldName(Value: string);
    function GetFieldName: string;
    procedure SetParamName(Value: string);
    function GetParamName: string;
    procedure SetValue(Value: TValue);
    function GetValue: TValue;
  end;

  ICondition = interface(ISerializable)
  ['{557D4B00-E141-4C07-B951-104E3B755C0B}']
    procedure SetCondition(Value: string);
    function GetCondition: string;
    procedure SetLeftCondition(Value: string);
    function GetLeftCondition: string;

    function Left(pCond: string): ICondition;
    function GenerateSQL(pSpaces: Integer = 0; pLeftCond: Boolean = False): string;
  end;

  IJoin = interface(ISerializable)
  ['{6D2BA359-7723-42D3-8857-86AE50B7D6D1}']
    procedure SetJoinType(Value: TJoinType);
    function GetJoinType: TJoinType;
    procedure SetTable(Value: ITable);
    function GetTable: ITable;
    procedure SetConditions(Value: TArray<ICondition>);
    function GetConditions: TArray<ICondition>;

    function GenerateSQL(pSpaces: Integer = 0; pTableLabel: string = ''): string;
  end;

  IPair = interface(ISerializable)
  ['{7EED2520-BB31-44B0-BBAB-25489FEF8533}']
    procedure SetColumn(Value: IColumn);
    function GetColumn: IColumn;
    procedure SetValue(Value: TValue);
    function GetValue: TValue;
  end;

  IQuery = interface(ISerializable)
  ['{0EC2A603-B5FC-4903-867A-EEAA914257B5}']
    procedure SetQueryType(Value: TQueryType);
    function GetQueryType: TQueryType;
    procedure SetTable(Value: ITable);
    function GetTable: ITable;

    procedure AddWhere(pCondition: ICondition);

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
  end;

  ISelectQuery = interface(IQuery)
  ['{84AC3367-65E7-430F-9D63-42A97EBC4389}']
    procedure AddJoin(pJoin: IJoin);

    function SetColumns(pColumns: TArray<IColumn>): ISelectQuery; overload;
    function SetColumns(pColumns: TArray<string>): ISelectQuery; overload;

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
    function OrWhere(pLeftField: IColumn; pCond: string; ISelectQuery: IColumn): ISelectQuery; overload;
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
  end;

  IDeleteQuery = interface(IQuery)
  ['{61328390-1E76-445A-879C-EE77629D5713}']
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
  end;

  IInsertQuery = interface(IQuery)
  ['{2C1538C1-A0EB-491A-A7FE-26015467686B}']
    procedure AddPair(pColumn: IColumn; pValue: TValue);

    function SetPair(pColumn, pValue: string): IInsertQuery; overload;
    function SetPair(pColumn: string; pValue: TValue): IInsertQuery; overload;
    function SetPair(pColumn: IColumn; pValue: string): IInsertQuery; overload;
    function SetPair(pColumn: IColumn; pValue: TValue): IInsertQuery; overload;

    function SetNullPair(pColumn: string): IInsertQuery; overload;
    function SetNullPair(pColumn: IColumn): IInsertQuery; overload;

    function GetSQL: string;
  end;

  IUpdateQuery = interface(IQuery)
  ['{7DE1A1FB-362F-4F2E-A091-5BAB8ACA1D25}']
    procedure AddPair(pColumn: IColumn; pValue: TValue);

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
  end;

implementation

end.
