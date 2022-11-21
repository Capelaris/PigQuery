program Sample;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {FrmMainForm},
  PigQuery in '..\..\src\PigQuery.pas',
  PigQuery.Commons in '..\..\src\PigQuery.Commons.pas',
  PigQuery.Constants in '..\..\src\PigQuery.Constants.pas',
  PigQuery.Core.Columns in '..\..\src\PigQuery.Core.Columns.pas',
  PigQuery.Core.Table in '..\..\src\PigQuery.Core.Table.pas',
  PigQuery.Helpers in '..\..\src\PigQuery.Helpers.pas',
  PigQuery.Interfaces in '..\..\src\PigQuery.Interfaces.pas',
  PigQuery.Core.Param in '..\..\src\PigQuery.Core.Param.pas',
  PigQuery.Core.Join in '..\..\src\PigQuery.Core.Join.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMainForm, FrmMainForm);
  Application.Run;
end.
