unit PigQuery.Core.Pair;

interface

uses
  PigQuery.Commons, PigQuery.Interfaces, PigQuery.Helpers, Rtti, JSON;

type
  TPair = class(TInterfacedObject, IPair)
  private
    oColumn: IColumn;
    oValue : TValue;

    procedure SetColumn(Value: IColumn);
    function GetColumn: IColumn;
    procedure SetValue(Value: TValue);
    function GetValue: TValue;
  public
    constructor Create(pColumn: IColumn; pValue: TValue); overload;
    constructor Create(pColumn: IColumn; pValue: string); overload;
    constructor Create(pColumn: IColumn; pValue: Extended); overload;
    constructor Create(pColumn: IColumn; pValue: Integer); overload;
    constructor Create(pColumn: IColumn; pValue: TDateTime); overload;

    function Serialize: TJSONObject;

    property Column: IColumn read GetColumn write SetColumn;
    property Value : TValue  read GetValue  write SetValue;
  end;

implementation

{ TPair }

constructor TPair.Create(pColumn: IColumn; pValue: TValue);
begin
  inherited Create;
  Self.oColumn := pColumn;
  Self.oValue  := pValue;
end;

constructor TPair.Create(pColumn: IColumn; pValue: string);
begin
  inherited Create;
  Self.oColumn := pColumn;
  Self.oValue  := TValue.From(pValue);
end;

constructor TPair.Create(pColumn: IColumn; pValue: Extended);
begin
  inherited Create;
  Self.oColumn := pColumn;
  Self.oValue  := TValue.From(pValue);
end;

constructor TPair.Create(pColumn: IColumn; pValue: Integer);
begin
  inherited Create;
  Self.oColumn := pColumn;
  Self.oValue  := TValue.From(pValue);
end;

constructor TPair.Create(pColumn: IColumn; pValue: TDateTime);
begin
  inherited Create;
  Self.oColumn := pColumn;
  Self.oValue  := TValue.From(pValue);
end;

function TPair.GetColumn: IColumn;
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

procedure TPair.SetColumn(Value: IColumn);
begin
  Self.oColumn := Value;
end;

procedure TPair.SetValue(Value: TValue);
begin
  Self.oValue := Value;
end;

end.
