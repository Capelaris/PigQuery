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

implementation

end.
