unit Resultats;

interface

uses
  class_formmove,  Controls, Forms,  
  Menus, Classes, ComCtrls, Grids,
  windows,graphics,inifiles,sysutils;

type
  TFrmResults = class(TForm)
    pmResults: TPopupMenu;
    mClose: TMenuItem;
    sgResults: TStringGrid;
    procedure mCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure sgResultsDrawCell(Sender: TObject; ACol, ARow: Integer;Rect: TRect; State: TGridDrawState);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MoveForm:TMoveForm;
  end;

var
  FrmResults: TFrmResults;

implementation

uses Main;

{$R *.dfm}

//--Memoire--

procedure TFrmResults.mCloseClick(Sender: TObject);
begin
  close();
end;

procedure TFrmResults.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FrmMain.mResults.checked:=false;
end;

procedure TFrmResults.FormCreate(Sender: TObject);
var
  ini:tinifile;
begin
  //Rubriques des résultats
  with sgResults do begin
    Cells[0,0]:='Hour';
    Cells[1,0]:='QTE.';
    Cells[2,0]:='NB.';
    Cells[3,0]:='Crs.';
    Cells[4,0]:='R.HA.';
    Cells[5,0]:='Ratio';
    Cells[6,0]:='R.Vte.';
    Cells[7,0]:='Vol-';
    Cells[8,0]:='Sens';
    Cells[9,0]:='Vol+';
    Cells[10,0]:='Vol.';
    Cells[11,0]:='DVol.';
  end;
  //Read position
  ini:=TIniFile.Create(extractfilepath(application.Exename)+'init.ini');
  try
    top:=ini.readinteger('FrmResults','top',109);
    left:=ini.readinteger('FrmResults','left',462);
    height:=ini.readinteger('FrmResults','height',315);
    width:=ini.readinteger('FrmResults','width',369);
  finally
    ini.free();
  end;
end;

procedure TFrmResults.sgResultsDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  Format:integer;
begin
  sgResults.canvas.fillrect(Rect);
  sgResults.Canvas.font.name:='Arial';
  if ARow = 0 then begin //Ligne des entêtes
    Format:=DT_CENTER;
    sgResults.canvas.Font.Style:=[fsBold];
  end else begin //Autres lignes
    Format:=DT_RIGHT;
    case (ACol) of
     1,2:begin
           if pos('-',sgResults.Cells[ACol,ARow])<>0 then
             sgResults.Canvas.Font.color:=clRed
           else
             sgResults.Canvas.Font.Color:=clGreen;
         end;

     5,8:begin
           if pos('-',sgResults.Cells[ACol,ARow])<>0 then
             sgResults.Canvas.Font.color:=clRed
           else
             sgResults.Canvas.Font.Color:=clGreen;
           sgResults.canvas.font.Style:=[fsbold];
         end;

    END;
  end;

  DrawText(sgResults.Canvas.Handle,PChar(sgResults.Cells[ACol,ARow]),-1,Rect,Format);
end;

procedure TFrmResults.FormDestroy(Sender: TObject);
var
  ini:tinifile;
begin
  ini:=TIniFile.Create(extractfilepath(application.Exename)+'init.ini');
  try
    ini.writeinteger('FrmResults','top',top);
    ini.writeinteger('FrmResults','left',left);
    ini.writeinteger('FrmResults','height',height);
    ini.writeinteger('FrmResults','width',width);
  finally
    ini.free();
  end;
end;

end.
