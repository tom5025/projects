unit CapturerDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Buttons;

type
  TFrmCapture = class(TForm)
    sbStop: TSpeedButton;
    sbPlay: TSpeedButton;
    sbPause: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCapture: TFrmCapture;

implementation

{$R *.dfm}

procedure TFrmCapture.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

end.
