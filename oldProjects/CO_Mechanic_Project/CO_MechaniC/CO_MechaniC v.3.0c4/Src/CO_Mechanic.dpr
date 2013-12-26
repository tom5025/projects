program CO_Mechanic;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  FonctionChaines in 'FonctionChaines.pas',
  AboutBox in 'AboutBox.pas' {FrmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'CO MechaniC';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmAbout, FrmAbout);
  Application.Run;
end.
