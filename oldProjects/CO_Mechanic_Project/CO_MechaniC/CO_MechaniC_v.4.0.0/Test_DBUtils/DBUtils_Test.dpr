program DBUtils_Test;

uses
  Forms,
  Main in 'Main.pas' {Form1},
  DBUtils in 'DBUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
