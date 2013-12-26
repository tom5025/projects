program CO_Trade_v3;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
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
  if FrmMain.StartParams.bBatchStart then begin
    FrmMain.CaptureRGA();
    FrmParamsDlg.DeactivateCtrls();
  end;
  Application.Run;
end.
