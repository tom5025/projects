unit MainDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls;

type
  TFrmMain = class(TForm)
    MainMenu: TMainMenu;
    mFile: TMenuItem;
    mQuit: TMenuItem;
    mConsult: TMenuItem;
    mSearch: TMenuItem;
    mCapturer: TMenuItem;
    procedure mQuitClick(Sender: TObject);
    procedure mCapturerClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses CapturerDlg,DBUtils, ConsultDlg, SearchDlg;

procedure TFrmMain.mQuitClick(Sender: TObject);
begin
  close();
end;

procedure TFrmMain.mCapturerClick(Sender: TObject);
begin
  FrmCapture:=TFrmCapture.Create(self);
  FrmCapture.Show();
end;

end.
