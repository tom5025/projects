unit HourTool;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Psock, NMHttp, NMTime;

type
  TFrmHour = class(TForm)
    NMHTTP: TNMHTTP;
    lblHour: TLabel;
    NMTime1: TNMTime;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmHour: TFrmHour;

implementation

{$R *.dfm}

procedure TFrmHour.FormShow(Sender: TObject);
var
  SysTime:TSystemTime;
begin
  //NMHTTP.Get('http://www.role-expert.com/nwn-t4c/usr/horloge.php');

  //Parsage de la page d'heure
  {if  (StrToIntDef(copy(NMHTTP.Body,142,2),-1)=-1) then begin
    MessageBox(0,Pchar('Impossible de recuperer l''heure.'),PChar('Erreur'),MB_ICONWARNING);
    exit;
  end;}
  {SysTime.wHour:=strToInt(copy(NMHTTP.Body,142,2))-1;
  SysTime.wMinute:=strToInt(copy(NMHTTP.Body,151,2));}
  lblHour.Caption:='Heure recuperee sur le serveur : '+NMTime1.TimeStr;
end;

end.
