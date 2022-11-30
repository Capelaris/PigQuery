unit PigQuery.Core.Table;

interface

uses
  PigQuery.Helpers, Rtti, JSON;

type
  TTable = class(TCustomAttribute)
  private
    sName : string;
    sAlias: string;

    procedure SetName(Value: string);
    function GetName: string;
    procedure SetAlias(Value: string);
    function GetAlias: string;
  public
    constructor Create(pName, pAlias: string); overload;
    constructor Create(pName: string); overload;

    class function Copy(pObject: TTable): TTable;
    function Serialize: TJSONObject;

    property Name : string read GetName  write SetName;
    property Alias: string read GetAlias write SetAlias;
  end;

implementation

{ TTable }

class function TTable.Copy(pObject: TTable): TTable;
begin
  Result := TTable.Create(pObject.sName, pObject.sAlias);
end;

constructor TTable.Create(pName: string);
var
  ArrStr: TArray<string>;
begin
  ArrStr := GetWords(pName);

  if Length(ArrStr) > 1 then
    Self.Create(ArrStr[0], ArrStr[1])
  else
    Self.Create(ArrStr[0], '');
end;

function TTable.GetAlias: string;
begin
  Result := Self.sAlias;
end;

function TTable.GetName: string;
begin
  Result := Self.sName;
end;

function TTable.Serialize: TJSONObject;
begin
  Result := TJSONObject.Create;
  with Result do
  begin
    AddPair('Name',  Self.sName);
    AddPair('Alias', Self.sAlias);
  end;
end;

procedure TTable.SetAlias(Value: string);
begin
  Self.sAlias := Value;
end;

procedure TTable.SetName(Value: string);
begin
  Self.sName := Value;
end;

constructor TTable.Create(pName, pAlias: string);
begin
  inherited Create;

  with Self do
  begin
    sName  := pName;
    sAlias := pAlias;
  end;
end;

end.
