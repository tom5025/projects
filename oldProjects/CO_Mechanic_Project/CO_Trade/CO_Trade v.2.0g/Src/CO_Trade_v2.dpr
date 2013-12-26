program CO_Trade_v2;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  Lib_Chaines in 'Lib_Chaines.pas',
  Class_FormMove in 'Class_FormMove.pas',
  Resultats in 'Resultats.pas' {FrmResults},
  ParamsDlg in 'ParamsDlg.pas' {FrmParamsDlg};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmResults, FrmResults);
  Application.CreateForm(TFrmParamsDlg, FrmParamsDlg);
  if FrmMain.BatchStart then begin
    FrmMain.CaptureRGA();
    FrmParamsDlg.DeactivateCtrls();
  end;
  Application.Run;
end.
