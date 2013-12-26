program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {FrmMain},
  Cotations_SDK in 'Cotations_SDK.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
