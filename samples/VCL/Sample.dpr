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
  PigQuery.Core.Join in '..\..\src\PigQuery.Core.Join.pas',
  PigQuery.Core.Condition in '..\..\src\PigQuery.Core.Condition.pas',
  PigQuery.Core.Query in '..\..\src\PigQuery.Core.Query.pas',
  PigQuery.Core.Pair in '..\..\src\PigQuery.Core.Pair.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Tablet Light');
  Application.CreateForm(TFrmMainForm, FrmMainForm);
  Application.Run;
end.
