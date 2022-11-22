unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, PigQuery;

type
  TFrmMainForm = class(TForm)
    mmoQuery: TMemo;
    pnlButtons: TPanel;
    btnSelect: TButton;
    btnInsert: TButton;
    btnUpdate: TButton;
    btnDelete: TButton;
    procedure btnSelectClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMainForm: TFrmMainForm;

implementation

{$R *.dfm}

procedure TFrmMainForm.btnDeleteClick(Sender: TObject);
begin
  mmoQuery.Lines.Text := TDeleteQuery.Create('Table1')
    .Where('column1', 'test')
    .GetSQL;
end;

procedure TFrmMainForm.btnInsertClick(Sender: TObject);
begin
  mmoQuery.Lines.Text := TInsertQuery.Create('Table1')
    .SetPair('column1', 'value 1')
    .SetPair('column2', 'value 2')
    .GetSQL;
end;

procedure TFrmMainForm.btnSelectClick(Sender: TObject);
begin
  mmoQuery.Lines.Text := TSelectQuery.Create('Table1')
    .Where('column1', 'test')
    .GetSQL(['column1', 'column2']);
end;

procedure TFrmMainForm.btnUpdateClick(Sender: TObject);
begin
  mmoQuery.Lines.Text := TUpdateQuery.Create('Table1')
    .SetPair('column1', 'value 1')
    .SetPair('column2', 'value 2')
    .Where('column1', 'test')
    .GetSQL;
end;

end.
