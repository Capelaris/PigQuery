unit PigQuery.Core.Param;

interface

uses
  PigQuery.Core.Columns, PigQuery.Interfaces, Rtti, JSON;

type
  TParam = class(TInterfacedObject, IParam, ISerializable)
  private
    sFieldName: string;
    sParamName: string;
    oValue    : TValue;

    procedure SetFieldName(Value: string);
    function GetFieldName: string;
    procedure SetParamName(Value: string);
    function GetParamName: string;
    procedure SetValue(Value: TValue);
    function GetValue: TValue;
  public
    constructor Create(pFieldName, pParamName: string; pValue: TValue); overload;
    constructor Create(pFieldName: string; pValue: TValue); overload;
    constructor Create(pColumn: TColumn; pValue: TValue); overload;
    constructor Create(pColumn: TColumn; pParamName: string; pValue: TValue); overload;
    function Serialize: TJSONObject;

    property FieldName: string read GetFieldName write SetFieldName;
    property ParamName: string read GetParamName write SetParamName;
    property Value    : TValue read GetValue     write SetValue;
  end;

implementation

{ TParam }

constructor TParam.Create(pFieldName, pParamName: string; pValue: TValue);
begin
  inherited Create;

  with Self do
  begin
    sFieldName := FieldName;
    sParamName := pParamName;
    oValue     := pValue;
  end;
end;

constructor TParam.Create(pFieldName: string; pValue: TValue);
begin
  Create(pFieldName, pFieldName, pValue);
end;

constructor TParam.Create(pColumn: TColumn; pValue: TValue);
begin
  Create(pColumn.Name, pColumn.Name, pValue);
end;

constructor TParam.Create(pColumn: TColumn; pParamName: string;
  pValue: TValue);
begin
  Create(pColumn.Name, pParamName, pValue);
end;

function TParam.GetFieldName: string;
begin
  Result := Self.sFieldName;
end;

function TParam.GetParamName: string;
begin
  Result := Self.sParamName;
end;

function TParam.GetValue: TValue;
begin
  Result := Self.oValue;
end;

function TParam.Serialize: TJSONObject;
begin
  Result := TJSONObject.Create;
  With Result do
  begin
    AddPair('FieldName', Self.sFieldName);
    AddPair('ParamName', Self.sParamName);
    AddPair('Value',     Self.oValue.AsString);
  end;
end;

procedure TParam.SetFieldName(Value: string);
begin
  Self.sFieldName := Value;
end;

procedure TParam.SetParamName(Value: string);
begin
  Self.sParamName := Value;
end;

procedure TParam.SetValue(Value: TValue);
begin
  Self.oValue := Value;
end;

end.
