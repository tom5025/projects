program CO_MechaniC;

uses
  Forms,
  CapturerDlg in 'CapturerDlg.pas' {FrmCapture},
  MainDlg in 'MainDlg.pas' {FrmMain},
  ConsultDlg in 'ConsultDlg.pas' {FrmConsult},
  DBUtils in 'DBUtils.pas',
  SearchDlg in 'SearchDlg.pas' {FrmSearch};

{$R *.res}

begin                               
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmSearch, FrmSearch);
  Application.Run;
end.
