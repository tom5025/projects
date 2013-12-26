unit SrcDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TFrmSrc = class(TForm)
    mmSrc: TMemo;
    StatusBar1: TStatusBar;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSrc: TFrmSrc;

implementation

uses Main;

{$R *.dfm}

procedure TFrmSrc.FormShow(Sender: TObject);
begin
  mmSrc.Text:=FrmMain.WebB.OleObject.Document.Body.InnerHTML;
end;

end.
