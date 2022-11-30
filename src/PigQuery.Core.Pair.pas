unit PigQuery.Core.Pair;

interface

uses
  PigQuery.Commons, PigQuery.Core.Columns, PigQuery.Helpers, Rtti, JSON;

type
  TPair = class
  private
    oColumn: TColumn;
    oValue : TValue;

    procedure SetColumn(Value: TColumn);
    function GetColumn: TColumn;
    procedure SetValue(Value: TValue);
    function GetValue: TValue;
  public
    constructor Create(pColumn: TColumn; pValue: TValue); overload;
    constructor Create(pColumn: TColumn; pValue: string); overload;
    constructor Create(pColumn: TColumn; pValue: Extended); overload;
    constructor Create(pColumn: TColumn; pValue: Integer); overload;
    constructor Create(pColumn: TColumn; pValue: TDateTime); overload;

    function Serialize: TJSONObject;

    property Column: TColumn read GetColumn write SetColumn;
    property Value : TValue  read GetValue  write SetValue;
  end;

implementation

{ TPair }

constructor TPair.Create(pColumn: TColumn; pValue: TValue);
begin
  inherited Create;
  Self.oColumn  := pColumn;
  if pValue.AsString = 'null' then
    Self.oValue := pValue.From(nil)
  else
    Self.oValue := pValue;
end;

constructor TPair.Create(pColumn: TColumn; pValue: string);
begin
  inherited Create;
  Self.oColumn := pColumn;
  Self.oValue  := TValue.From(pValue);
end;

constructor TPair.Create(pColumn: TColumn; pValue: Extended);
begin
  inherited Create;
  Self.oColumn := pColumn;
  Self.oValue  := TValue.From(pValue);
end;

constructor TPair.Create(pColumn: TColumn; pValue: Integer);
begin
  inherited Create;
  Self.oColumn := pColumn;
  Self.oValue  := TValue.From(pValue);
end;

constructor TPair.Create(pColumn: TColumn; pValue: TDateTime);
begin
  inherited Create;
  Self.oColumn := pColumn;
  Self.oValue  := TValue.From(pValue);
end;

function TPair.GetColumn: TColumn;
begin
  Result := Self.oColumn;
end;

function TPair.GetValue: TValue;
begin
  Result := Self.oValue;
end;

function TPair.Serialize: TJSONObject;
begin
  Result := TJSONObject.Create;
  with Result do
  begin
    AddPair('Column', Self.oColumn.Serialize);
    AddPair('Value', GetTValueJSONValue(Self.oValue));
  end;
end;

procedure TPair.SetColumn(Value: TColumn);
begin
  Self.oColumn := Value;
end;

procedure TPair.SetValue(Value: TValue);
begin
  Self.oValue := Value;
end;

end.
