unit PigQuery;

interface

uses
  PigQuery.Commons,
  PigQuery.Constants,
  PigQuery.Helpers,
  PigQuery.Interfaces,
  PigQuery.Core.Columns,
  PigQuery.Core.Table,
  PigQuery.Core.Pair,
  PigQuery.Core.Join,
  PigQuery.Core.Param,
  PigQuery.Core.Condition,
  PigQuery.Core.Query;

type
  { Commons }
  TColumnType = PigQuery.Commons.TColumnType;
  TJoinType   = PigQuery.Commons.TJoinType;
  TQueryType  = PigQuery.Commons.TQueryType;

  { Columns }
  TPrimaryKey            = PigQuery.Core.Columns.TPrimaryKey;
  TColumn                = PigQuery.Core.Columns.TColumn;
  TSmallIntColumn        = PigQuery.Core.Columns.TSmallIntColumn;
  TIntegerColumn         = PigQuery.Core.Columns.TIntegerColumn;
  TBigIntColumn          = PigQuery.Core.Columns.TBigIntColumn;
  TDecimalColumn         = PigQuery.Core.Columns.TDecimalColumn;
  TNumericColumn         = PigQuery.Core.Columns.TNumericColumn;
  TFloatColumn           = PigQuery.Core.Columns.TFloatColumn;
  TDoublePrecisionColumn = PigQuery.Core.Columns.TDoublePrecisionColumn;
  TDateColumn            = PigQuery.Core.Columns.TDateColumn;
  TTimeColumn            = PigQuery.Core.Columns.TTimeColumn;
  TTimeStampColumn       = PigQuery.Core.Columns.TTimeStampColumn;
  TCharColumn            = PigQuery.Core.Columns.TCharColumn;
  TVarcharColumn         = PigQuery.Core.Columns.TVarcharColumn;
  TBlobBinaryColumn      = PigQuery.Core.Columns.TBlobBinaryColumn;
  TBlobTextColumn        = PigQuery.Core.Columns.TBlobTextColumn;

  { Table }
  TTable = PigQuery.Core.Table.TTable;

  { Pair }
  TPair = PigQuery.Core.Pair.TPair;

  { Join }
  TJoin = PigQuery.Core.Join.TJoin;

  { Param }
  TParam = PigQuery.Core.Param.TParam;

  { Condition }
  TCondition = PigQuery.Core.Condition.TCondition;

  { Query }
  TQuery       = PigQuery.Core.Query.TQuery;
  TSelectQuery = PigQuery.Core.Query.TSelectQuery;
  TDeleteQuery = PigQuery.Core.Query.TDeleteQuery;
  TInsertQuery = PigQuery.Core.Query.TInsertQuery;
  TUpdateQuery = PigQuery.Core.Query.TUpdateQuery;

const
  { Commons }
  ctUnknown         = PigQuery.Commons.TColumnType.ctUnknown;
  ctSmallInt        = PigQuery.Commons.TColumnType.ctSmallInt;
  ctInteger         = PigQuery.Commons.TColumnType.ctInteger;
  ctBigInt          = PigQuery.Commons.TColumnType.ctBigInt;
  ctDecimal         = PigQuery.Commons.TColumnType.ctDecimal;
  ctNumeric         = PigQuery.Commons.TColumnType.ctNumeric;
  ctFloat           = PigQuery.Commons.TColumnType.ctFloat;
  ctDoublePrecision = PigQuery.Commons.TColumnType.ctDoublePrecision;
  ctDate            = PigQuery.Commons.TColumnType.ctDate;
  ctTime            = PigQuery.Commons.TColumnType.ctTime;
  ctTimeStamp       = PigQuery.Commons.TColumnType.ctTimeStamp;
  ctChar            = PigQuery.Commons.TColumnType.ctChar;
  ctVarchar         = PigQuery.Commons.TColumnType.ctVarchar;
  ctBlobBinary      = PigQuery.Commons.TColumnType.ctBlobBinary;
  ctBlobText        = PigQuery.Commons.TColumnType.ctBlobText;

  jtNone  = PigQuery.Commons.TJoinType.jtNone;
  jtInner = PigQuery.Commons.TJoinType.jtInner;
  jtLeft  = PigQuery.Commons.TJoinType.jtLeft;
  jtRight = PigQuery.Commons.TJoinType.jtRight;
  jtOuter = PigQuery.Commons.TJoinType.jtOuter;

  qtSelect = PigQuery.Commons.TQueryType.qtSelect;
  qtUpdate = PigQuery.Commons.TQueryType.qtUpdate;
  qtDelete = PigQuery.Commons.TQueryType.qtDelete;
  qtInsert = PigQuery.Commons.TQueryType.qtInsert;

implementation

end.
