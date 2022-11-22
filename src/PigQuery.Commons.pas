unit PigQuery.Commons;

interface

type
  TColumnType = (
    //Unknown
    ctUnknown,
    //Integers
    ctSmallInt, ctInteger, ctBigInt,
    //Floats
    ctDecimal, ctNumeric, ctFloat, ctDoublePrecision,
    //Dates and Times
    ctDate, ctTime, ctTimeStamp,
    //Strings
    ctChar, ctVarchar,
    //Blobs
    ctBlobBinary, ctBlobText);

  TJoinType = (jtNone, jtInner, jtLeft, jtRight, jtOuter);

  TQueryType = (qtSelect, qtUpdate, qtDelete, qtInsert);

  TColumnTypeHelper = record helper for TColumnType
    function ToString: string;
  end;

  TJoinTypeHelper = record helper for TJoinType
    function ToString: string;
  end;

  TQueryTypeHelper = record helper for TQueryType
    function ToString: string;
  end;

implementation

{ TColumnTypeHelper }

function TColumnTypeHelper.ToString: string;
begin
  case Self of
    ctUnknown:         Result := 'Unknown';
    ctSmallInt:        Result := 'SmallInt';
    ctInteger:         Result := 'Integer';
    ctBigInt:          Result := 'BigInt';
    ctDecimal:         Result := 'Decimal';
    ctNumeric:         Result := 'Numeric';
    ctFloat:           Result := 'Float';
    ctDoublePrecision: Result := 'Double precision';
    ctDate:            Result := 'Date';
    ctTime:            Result := 'Time';
    ctTimeStamp:       Result := 'TimeStamp';
    ctChar:            Result := 'Char';
    ctVarchar:         Result := 'Varchar';
    ctBlobBinary:      Result := 'Blob Binary';
    ctBlobText:        Result := 'Blob Text';
  end;
end;

{ TJoinTypeHelper }

function TJoinTypeHelper.ToString: string;
begin
  case Self of
    jtNone:  Result := 'None';
    jtInner: Result := 'Inner';
    jtLeft:  Result := 'Left';
    jtRight: Result := 'Right';
    jtOuter: Result := 'Outer';
  end;
end;

{ TQueryTypeHelper }

function TQueryTypeHelper.ToString: string;
begin
  case Self of
    qtSelect: Result := 'Select';
    qtUpdate: Result := 'Update';
    qtDelete: Result := 'Delete';
    qtInsert: Result := 'Insert';
  end;
end;

end.
