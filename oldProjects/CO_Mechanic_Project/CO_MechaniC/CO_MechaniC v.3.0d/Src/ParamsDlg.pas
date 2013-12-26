unit ParamsDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TFrmParams = class(TForm)
    gbParams: TGroupBox;
    StatusBar1: TStatusBar;
    lblDelayLimit: TLabel;
    lblTicksLimit: TLabel;
    lblRGACode: TLabel;
    lblStartup: TLabel;
    lblCloseAtEnd: TLabel;
    lblAutoSave: TLabel;
    lblSaveFilename: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmParams: TFrmParams;

implementation

uses Main;

{$R *.dfm}

procedure TFrmParams.FormShow(Sender: TObject);
begin
 //
end;

end.
