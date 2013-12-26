unit Main;

interface

uses
  Windows, Messages, SysUtils,
  Classes,Controls, Forms,
  StdCtrls, scktcomp, HttpProt;
type
  TForm1 = class(TForm)
    Memo1: TMemo;
    btExecute13000: TButton;
    SocketA: TClientSocket;
    HttpCli1: THttpCli;
    procedure btExecute13000Click(Sender: TObject);
    procedure SocketADisconnect(Sender: TObject; Socket: TCustomWinSocket);
  private
    { Private declarations }
  public
    //Login
    procedure FirstTimeLoginData(Sender: TObject; Socket: TCustomWinSocket);
//    procedure FirstTimeRGAData(Sender:TObject;Socket:TCustomWinSocket);
    //Refresh
//    procedure RefreshData(Sender:TObject;Socket:TCustomWinSocket);
  end;

var
  Form1: TForm1;

const
  crlf=#13#10;


implementation

{$R *.dfm}

uses fonctionChaines;

//---------LOGIN------------

procedure TForm1.btExecute13000Click(Sender: TObject);
var
  dataout:string;
  DataIn:string;
  Buffer:string;
begin
  SocketA.Active:=true;

  Application.processMessages();
  DataOut:='POST /index.asp HTTP/1.0'+crlf+
           'Accept: image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, */*'+crlf+
           'Content-Type: application/x-www-form-urlencoded'+crlf+
           'User-Agent: Mozilla/3.0 (compatible)'+crlf+
           'Host: www.cotations.com'+crlf+
           'Content-Length: 29'+crlf+
           'Connection: close'+crlf+
           'user=gremy1&password=ymer21AM'+crlf+crlf;

  SocketA.OnRead:=FirstTimeLoginData;
  SocketA.Socket.SendText(DataOut);


end;

procedure TForm1.FirstTimeLoginData(Sender: TObject; Socket: TCustomWinSocket);
begin
  SocketA.Socket.ReceiveText();
end;

procedure TForm1.SocketADisconnect(Sender: TObject;Socket: TCustomWinSocket);
begin
  MessageBox(0,pchar('bubi'),nil,0);
end;

end.
