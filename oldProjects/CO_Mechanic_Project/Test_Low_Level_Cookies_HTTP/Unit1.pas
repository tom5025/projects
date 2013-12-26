unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Winsock,sockets, StdCtrls, WSocket, ExtCtrls, HttpProt, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Psock, NMHttp;

type
  TCotationsThread = class (TThread)
  private

  protected
    procedure Execute();override;
    procedure EndThread(Sender:TObject);
  public
    constructor Create(CreateSuspended:boolean);
  end;

  TFrmMain = class(TForm)
    btGet13000: TButton;
    Memo1: TMemo;
    btRefresh13000: TButton;
    lblkos: TLabel;
    lblko: TLabel;
    Timer1: TTimer;
    Memo2: TMemo;
    Label1: TLabel;
    procedure btGet13000Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CurrentTime:integer;
    CurrentCookies:string;
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}
{$H+}

uses Cotations_SDK;


var
  CotationsThread:TCotationsThread;
  a:string;
  b:string;

constructor TCotationsThread.Create(CreateSuspended:boolean);
begin
  inherited create(CreateSuspended);
  FreeOnTerminate:=true;
  priority:=tpHighest;
  OnTerminate:=EndThread;
  frmmain.btGet13000.enabled:=false;
end;

procedure TCotationsThread.Execute();
begin
  frmMain.Memo1.text:=_Refresh('13000',FrmMain.CurrentCookies,FrmMain.CurrentCookies);
end;

procedure TCotationsThread.EndThread(Sender:TObject);
begin
  frmMain.btGet13000.Enabled:=true;
end;

procedure TFrmMain.btGet13000Click(Sender: TObject);

begin
  //CotationsThread:=TCotationsThread.Create(false);
  memo1.text:=_Refresh('13000',a,a);
  memo2.text:=_Refresh('13000',b,b);
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  a:=_Login();
  b:=_Login();
end;

procedure TFrmMain.Timer1Timer(Sender: TObject);
begin
  label1.Caption:=inttostr(memo1.SelLength);
end;

end.
