unit PigQuery.Core.Columns;

interface

uses
  PigQuery.Commons, PigQuery.Interfaces, PigQuery.Helpers, Rtti, Variants, DB,
  SysUtils, JSON;

type
  TPrimaryKey = class(TCustomAttribute)
  private
    aKeys: TArray<string>;
  public
    constructor Create(pKeys: TArray<string>); overload;
    constructor Create(pKey: string); overload;

    function IsKey(pColumnName: string): Boolean;
    property Keys: TArray<string> read aKeys write aKeys;
  end;

  TColumn = class(TCustomAttribute, IColumn, ISerializable)
  private
    sName      : string;
    sTableLabel: string;
    iSize      : Integer;
    iScale     : Integer;
    bNotNull   : Boolean;
    tFieldType : TColumnType;
    sCharset   : string;
    sCollate   : string;
    oDefaultVal: TValue;

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
  protected
    [Volatile] FRefCount: Integer;
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    constructor Create(pName: string; pType: TColumnType; pSize, pScale: Integer;
      pNotNull: Boolean; pCharset, pCollate: string; pDefaultVal: TValue;
      pTableLabel: string = '');

    function GetValue(pField: TField): TValue; virtual;
    class function Copy(pObject: IColumn): IColumn;
    function Serialize: TJSONObject;

    property Name      : string      read sName       write sName;
    property TableLabel: string      read sTableLabel write sTableLabel;
    property Size      : Integer     read iSize       write iSize;
    property Scale     : Integer     read iScale      write iScale;
    property NotNull   : Boolean     read bNotNull    write bNotNull;
    property FieldType : TColumnType read tFieldType;
    property Charset   : string      read sCharset    write sCharset;
    property Collate   : string      read sCollate    write sCollate;
    property DefaultVal: TValue      read oDefaultVal write oDefaultVal;
  end;

  TSmallIntColumn = class(TColumn)
  public
    constructor Create(pName: string; pNotNull: Boolean = False;
      pDefaultVal: Int16 = 0);
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TIntegerColumn = class(TColumn)
  public
    constructor Create(pName: string; pNotNull: Boolean = False;
      pDefaultVal: Int32 = 0);
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TBigIntColumn = class(TColumn)
  public
    constructor Create(pName: string; pNotNull: Boolean = False;
      pDefaultVal: Int64 = 0);
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TDecimalColumn = class(TColumn)
  public
    constructor Create(pName: string; pSize, pScale: Integer;
      pNotNull: Boolean = False; pDefaultVal: Double = 0);
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property Size;
    property Scale;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TNumericColumn = class(TColumn)
  public
    constructor Create(pName: string; pSize, pScale: Integer;
      pNotNull: Boolean = False; pDefaultVal: Double = 0);
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property Size;
    property Scale;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TFloatColumn = class(TColumn)
  public
    constructor Create(pName: string; pSize, pScale: Integer;
      pNotNull: Boolean = False; pDefaultVal: Double = 0);
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property Size;
    property Scale;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TDoublePrecisionColumn = class(TColumn)
  public
    constructor Create(pName: string; pSize: Integer; pNotNull: Boolean = False;
      pDefaultVal: Double = 0);
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property Size;
    property Scale;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TDateColumn = class(TColumn)
  public
    constructor Create(pName: string; pNotNull: Boolean = False;
      pDefaultVal: TDate = 0);
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TTimeColumn = class(TColumn)
  public
    constructor Create(pName: string; pNotNull: Boolean = False;
      pDefaultVal: TTime = 0);
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TTimeStampColumn = class(TColumn)
  public
    constructor Create(pName: string; pNotNull: Boolean = False;
      pDefaultVal: TDateTime = 0);
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TCharColumn = class(TColumn)
  public
    constructor Create(pName: string; pNotNull: Boolean = False;
      pCharset: string = ''; pCollate: string = ''; pDefaultVal: Char = #0);
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property Size;
    property NotNull;
    property FieldType;
    property Charset;
    property Collate;
    property DefaultVal;
  end;

  TVarcharColumn = class(TColumn)
  public
    constructor Create(pName: string; pSize: Integer; pNotNull: Boolean = False;
      pCharset: string = ''; pCollate: string = ''; pDefaultVal: string = '');
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property Size;
    property NotNull;
    property FieldType;
    property Charset;
    property Collate;
    property DefaultVal;
  end;

  TBlobBinaryColumn = class(TColumn)
  public
    constructor Create(pName: string; pSize: Integer; pNotNull: Boolean;
      pDefaultVal: string = '');
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property Size;
    property NotNull;
    property FieldType;
    property DefaultVal;
  end;

  TBlobTextColumn = class(TColumn)
  public
    constructor Create(pName: string; pSize: Integer; pNotNull: Boolean = False;
      pCharset: string = ''; pCollate: string = ''; pDefaultVal: string = '');
    function GetValue(pField: TField): TValue; override;

    property Name;
    property TableLabel;
    property Size;
    property NotNull;
    property FieldType;
    property Charset;
    property Collate;
    property DefaultVal;
  end;

implementation

{ TColumn }

class function TColumn.Copy(pObject: IColumn): IColumn;
begin
  Result := TColumn.Create(
        pObject.GetName,
        pObject.GetFieldType,
        pObject.GetSize,
        pObject.GetScale,
        pObject.GetNotNull,
        pObject.GetCharset,
        pObject.GetCollate,
        pObject.GetDefaultVal,
        pObject.GetTableLabel);
end;

constructor TColumn.Create(pName: string; pType: TColumnType; pSize,
  pScale: Integer; pNotNull: Boolean; pCharset, pCollate: string;
  pDefaultVal: TValue; pTableLabel: string);
begin
  inherited Create;

  with Self do
  begin
    sName       := pName;
    sTableLabel := pTableLabel;
    tFieldType  := pType;
    iSize       := pSize;
    iScale      := pScale;
    bNotNull    := pNotNull;
    sCharset    := pCharset;
    sCollate    := pCollate;
    oDefaultVal := pDefaultVal;
  end;
end;

function TColumn.GetCharset: string;
begin
  Result := Self.sCharset;
end;

function TColumn.GetCollate: string;
begin
  Result := Self.sCollate;
end;

function TColumn.GetDefaultVal: TValue;
begin
  Result := Self.oDefaultVal;
end;

function TColumn.GetFieldType: TColumnType;
begin
  Result := Self.tFieldType;
end;

function TColumn.GetName: string;
begin
  Result := Self.sName;
end;

function TColumn.GetNotNull: Boolean;
begin
  Result := Self.bNotNull;
end;

function TColumn.GetScale: Integer;
begin
  Result := Self.iScale;
end;

function TColumn.GetSize: Integer;
begin
  Result := Self.iSize;
end;

function TColumn.GetTableLabel: string;
begin
  Result := Self.sTableLabel;
end;

function TColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := TValue.FromVariant(pField.AsVariant);
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + ')->' + E.Message);
  end;
end;

function TColumn.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TColumn.Serialize: TJSONObject;
begin
  Result := TJSONObject.Create;
  with Result do
  begin
    AddPair('Name',       Self.sName);
    AddPair('TableLabel', Self.sTableLabel);
    AddPair('Size',       TJSONNumber.Create(Self.iSize));
    AddPair('Scale',      TJSONNumber.Create(Self.iScale));
    AddPair('NotNull',    TJSONBool.Create(Self.bNotNull));
    AddPair('FieldType',  Self.tFieldType.ToString);
    AddPair('Charset',    Self.sCharset);
    AddPair('Collate',    Self.sCollate);
    AddPair('DefaultVal', GetTValueJSONValue(Self.oDefaultVal));
  end;
end;

procedure TColumn.SetCharset(Value: string);
begin
  Self.sCharset := Value;
end;

procedure TColumn.SetCollate(Value: string);
begin
  Self.sCollate := Value;
end;

procedure TColumn.SetDefaultVal(Value: TValue);
begin
  Self.oDefaultVal := Value;
end;

procedure TColumn.SetFieldType(Value: TColumnType);
begin
  Self.tFieldType := Value;
end;

procedure TColumn.SetName(Value: string);
begin
  Self.sName := Value;
end;

procedure TColumn.SetNotNull(Value: Boolean);
begin
  Self.bNotNull := Value;
end;

procedure TColumn.SetScale(Value: Integer);
begin
  Self.iScale := Value;
end;

procedure TColumn.SetSize(Value: Integer);
begin
  Self.iSize := Value;
end;

procedure TColumn.SetTableLabel(Value: string);
begin
  Self.sTableLabel := Value;
end;

function TColumn._AddRef: Integer;
begin
{$IFNDEF AUTOREFCOUNT}
  Result := AtomicIncrement(FRefCount);
{$ELSE}
  Result := __ObjAddRef;
{$ENDIF}
end;

function TColumn._Release: Integer;
begin
{$IFNDEF AUTOREFCOUNT}
  Result := AtomicDecrement(FRefCount);
  if Result = 0 then
  begin
    // Mark the refcount field so that any refcounting during destruction doesn't infinitely recurse.
    Destroy;
  end;
{$ELSE}
  Result := __ObjRelease;
{$ENDIF}
end;

{ TSmallIntColumn }

constructor TSmallIntColumn.Create(pName: string; pNotNull: Boolean;
  pDefaultVal: Int16);
begin
  inherited Create(pName, ctSmallInt, -1, -1, pNotNull, '', '', pDefaultVal);
end;

function TSmallIntColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsInteger;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TIntegerColumn }

constructor TIntegerColumn.Create(pName: string; pNotNull: Boolean;
  pDefaultVal: Int32);
begin
  inherited Create(pName, ctInteger, -1, -1, pNotNull, '', '', pDefaultVal);
end;

function TIntegerColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsInteger;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TBigIntColumn }

constructor TBigIntColumn.Create(pName: string; pNotNull: Boolean;
  pDefaultVal: Int64);
begin
  inherited Create(pName, ctBigInt, -1, -1, pNotNull, '', '', pDefaultVal);
end;

function TBigIntColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsLargeInt;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TDecimalColumn }

constructor TDecimalColumn.Create(pName: string; pSize, pScale: Integer;
  pNotNull: Boolean; pDefaultVal: Double);
begin
  inherited Create(pName, ctDecimal, pSize, pScale, pNotNull, '', '', pDefaultVal);
end;

function TDecimalColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsFloat;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TNumericColumn }

constructor TNumericColumn.Create(pName: string; pSize, pScale: Integer;
  pNotNull: Boolean; pDefaultVal: Double);
begin
  inherited Create(pName, ctNumeric, pSize, pScale, pNotNull, '', '', pDefaultVal);
end;

function TNumericColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsFloat;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TFloatColumn }

constructor TFloatColumn.Create(pName: string; pSize, pScale: Integer;
  pNotNull: Boolean; pDefaultVal: Double);
begin
  inherited Create(pName, ctNumeric, pSize, pScale, pNotNull, '', '', pDefaultVal);
end;

function TFloatColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsFloat;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TDoublePrecisionColumn }

constructor TDoublePrecisionColumn.Create(pName: string; pSize: Integer;
  pNotNull: Boolean; pDefaultVal: Double);
begin
  inherited Create(pName, ctNumeric, pSize, -1, pNotNull, '', '', pDefaultVal);
end;

function TDoublePrecisionColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsFloat;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TDateColumn }

constructor TDateColumn.Create(pName: string; pNotNull: Boolean;
  pDefaultVal: TDate);
begin
  inherited Create(pName, ctDate, -1, -1, pNotNull, '', '', pDefaultVal);
end;

function TDateColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsDateTime;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TTimeColumn }

constructor TTimeColumn.Create(pName: string; pNotNull: Boolean;
  pDefaultVal: TTime);
begin
  inherited Create(pName, ctTime, -1, -1, pNotNull, '', '', pDefaultVal);
end;

function TTimeColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsDateTime;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TTimeStampColumn }

constructor TTimeStampColumn.Create(pName: string; pNotNull: Boolean;
  pDefaultVal: TDateTime);
begin
  inherited Create(pName, ctTimeStamp, -1, -1, pNotNull, '', '', pDefaultVal);
end;

function TTimeStampColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsDateTime;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TCharColumn }

constructor TCharColumn.Create(pName: string; pNotNull: Boolean;
  pCharset, pCollate: string; pDefaultVal: Char);
begin
  inherited Create(pName, ctChar, 1, -1, pNotNull, pCharset, pCollate, pDefaultVal);
end;

function TCharColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsString;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TVarcharColumn }

constructor TVarcharColumn.Create(pName: string; pSize: Integer;
  pNotNull: Boolean; pCharset, pCollate: string; pDefaultVal: string);
begin
  inherited Create(pName, ctVarchar, pSize, -1, pNotNull, pCharset, pCollate, pDefaultVal);
end;

function TVarcharColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsString;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TBlobBinaryColumn }

constructor TBlobBinaryColumn.Create(pName: string; pSize: Integer;
  pNotNull: Boolean; pDefaultVal: string);
begin
  inherited Create(pName, ctVarchar, pSize, -1, pNotNull, '', '', pDefaultVal);
end;

function TBlobBinaryColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsString;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + '): ' + E.Message);
  end;
end;

{ TBlobTextColumn }

constructor TBlobTextColumn.Create(pName: string; pSize: Integer;
  pNotNull: Boolean; pCharset, pCollate: string; pDefaultVal: string);
begin
  inherited Create(pName, ctVarchar, pSize, -1, pNotNull, pCharset, pCollate, pDefaultVal);
end;

function TBlobTextColumn.GetValue(pField: TField): TValue;
begin
  Result := TValue.Empty;
  try
    Result := pField.AsString;
  except
    on E: Exception do
      raise Exception.Create('GetValue(' + pField.FieldName + ')->' + E.Message);
  end;
end;

{ TPrimaryKey }

constructor TPrimaryKey.Create(pKeys: TArray<string>);
begin
  inherited Create;
  Self.aKeys := pKeys;
end;

constructor TPrimaryKey.Create(pKey: string);
begin
  inherited Create();
  Self.aKeys := [pKey];
end;

function TPrimaryKey.IsKey(pColumnName: string): Boolean;
var
  ArrVal: string;
begin
  for ArrVal in Self.aKeys do
  begin
    if pColumnName.ToLower = ArrVal.ToLower then
      Exit(True);
  end;
  Exit(False);
end;

end.
