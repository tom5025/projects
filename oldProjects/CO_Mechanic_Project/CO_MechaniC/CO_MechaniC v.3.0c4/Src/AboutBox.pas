unit AboutBox;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmAbout = class(TForm)
    lblLogiciel: TLabel;
    Memo1: TMemo;
    btOK: TButton;
    procedure btOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAbout: TFrmAbout;

implementation

{$R *.dfm}

uses main;

procedure TFrmAbout.btOKClick(Sender: TObject);
begin
  close();
end;

procedure TFrmAbout.FormCreate(Sender: TObject);
begin
  lblLogiciel.Caption:=main.version_info;
end;

end.
