unit Main;

interface

uses
  Windows,SysUtils,Classes,
  Forms,graphics,Menus,Grids,
  inifiles,StdCtrls,Controls, ExtCtrls, HttpProt, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

type
  //-- results pile --
  TResultData = record
    px:string;
    volp,volm,sensvol:single;
    nb,qte,vol:integer;
    RatioHA,RatioVT,Ratio:single;
    Hour:string;
  end;
  //-- Overrided Edit --
  TEdit = class(StdCtrls.TEdit)
   private
     FAlignment : TAlignment;
     procedure SetAlignment(Value: TAlignment);
   protected
     procedure CreateParams(var Params: TCreateParams); override;
   public
     property Alignment: TAlignment read FAlignment write SetAlignment;
  end;
  //-- Main form --
  TFrmMain = class(TForm)
    pnInfos: TPanel;
    tbRGA: TEdit;
    tbTitre: TEdit;
    lblRga: TLabel;
    lblTitre: TLabel;
    lblVarVeille: TLabel;
    tbVarVeille: TEdit;
    tbFirst: TEdit;
    tbLow: TEdit;
    tbHigh: TEdit;
    tbLast: TEdit;
    lblFirst: TLabel;
    lblBas: TLabel;
    lblhaut: TLabel;
    lblLast: TLabel;
    tbCac: TEdit;
    lblCac40: TLabel;
    lblCacVarVeille: TLabel;
    tbVarVeilleCac: TEdit;
    lbVolsDiff: TListBox;
    pmMain: TPopupMenu;
    mResults: TMenuItem;
    TimerMain: TTimer;
    N1: TMenuItem;
    mClose: TMenuItem;
    mParams: TMenuItem;
    lblRefresh: TLabel;
    tbVolsDiffResult: TEdit;
    tbOpenVar: TEdit;
    lblOpenVar: TLabel;
    sgCO: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mResultsClick(Sender: TObject);
    procedure mCloseClick(Sender: TObject);
    procedure mParamsClick(Sender: TObject);
    procedure sgCODrawCell(Sender: TObject; ACol, ARow: Integer;Rect: TRect; State: TGridDrawState);
    procedure HttpCliCookie(Sender: TObject; const Data: String;
      var Accept: Boolean);
    procedure HttpCliDocData(Sender: TObject; Buffer: Pointer;
      Len: Integer);
  private
    { Private declarations }
    //Variables utilisees
    FResultsPile:array of TResultData;
    FVolsPile:array of integer;
    GlobalCookies:TStringList;
    PageData:string;
    bFirstTime:boolean;
    sCurrentRefresh:integer;
  public
    { Public declarations }
    //Parametres de demarrage
    sRGA:string;
    sRefresh:integer;
    BatchStart:boolean;
    bSaveCO:boolean;
    bSaveResults:boolean;
    FCOFilename:string;
    FRSFilename:string;
    //Fonctions
    procedure CaptureRga();
    procedure RefreshPage();
    procedure Affiche(FirstTime:Boolean);
    procedure StopCapture();
    procedure PauseCapture();
    procedure ResumeCapture();
    procedure RegisterCO();
    procedure RegisterResults();
    //Evenements
    procedure TimerProc(sender:TObject);
    procedure OnFinishLogin(Sender:TObject);
    procedure OnFinishPage(sender:TObject);
  end;

var
  FrmMain: TFrmMain;

const
  MAX_RESULTS = 200;
  Ver_Info = 'CO TradE 3.0a';

implementation

{$R *.dfm}

uses Lib_Chaines, Resultats, ParamsDlg;

//-- Overrided Edit --

procedure TEdit.CreateParams(var Params: TCreateParams);
const
 Alignments : array[TAlignment] of LongWord= (ES_Left,ES_Right, ES_Center);
begin
 inherited CreateParams(Params);
 Params.Style := Params.Style or Alignments[FAlignment];
end;

procedure TEdit.SetAlignment(Value: TAlignment);
begin
 if FAlignment <> Value then
 begin
   FAlignment := Value;
   RecreateWnd;
 end;
end;

//--Utils--

function GetParsedValue(sSection:string;sOpenTag,sCloseTag:string;iTagIndex:integer):string;
begin
  //We get the right section in a buffer
                                               //Parsed Section-------------------//
  Result:=Gauche(sCloseTag, NDroite(sOpenTag,sSection,iTagIndex)  );
end;

function GetSection(sData,sStart,sEnd:string):string;
begin
  result:=Droite(sStart,Gauche(sEnd,sData));
end;

function FormatPt(data:string):string;
begin
  if pos(',',data)<>0 then
    result:=gauche(',',data)+'.'+droite(',',data)
  else
    result:=data;
end;

//-- Navigation --

procedure TFrmMain.PauseCapture();
begin
  TimerMain.Enabled:=false;
end;

procedure TFrmMain.ResumeCapture();
begin
  TimerMain.Enabled:=true;
end;

procedure TFrmMain.StopCapture();
var
  ACol,ARow:byte;
begin
  SetLength(FResultsPile,0);
  SetLength(FVolsPile,0);
  TimerMain.Enabled:=false;
  tbRGA.Clear();
  tbTitre.Clear();
  tbVarVeille.Clear();
  tbVarVeilleCac.clear();
  tbCac.clear();
  tbFirst.clear();
  tbLast.Clear();
  tbOpenVar.Clear();
  tbLow.clear();
  tbHigh.clear();
  lbVolsDiff.clear();
  tbVolsDiffResult.Clear();
  lblRefresh.Caption:='';
  //Vidage du CO
  for ACol:=0 to 5 do
    for ARow:=1 to 7 do
      sgCO.Cells[ACol,ARow]:='';
  //Vidage des résultats
  for ACol:=0 to 10 do
    for ARow:=1 to MAX_RESULTS-1 do
      FrmResults.sgResults.Cells[ACol,ARow]:='';
end;

procedure TFrmMain.CaptureRga();
begin
  //Init vars
  SetLength(FResultsPile,MAX_RESULTS);
  SetLength(FVolsPile,2);
  sCurrentRefresh:=sRefresh;
  //On refresh & affiche une première fois
  bFirstTime:=true;
  RefreshPage();
end;

procedure TFrmMain.RefreshPage();
var
  dataout:TMemoryStream;
  postdata:string;
  i:byte;
  cookies:string;
begin
  globalcookies.Clear();
  //Login
  pagedata:='';
  postdata:='user=gremy1&password=ymer21AM';
  dataout:=TMemoryStream.Create();
  dataout.Write(postdata[1],length(postdata));
  dataout.Seek(0,0);
  httpcli.URL:='http://www.cotations.com/index.asp';
  httpcli.OnStateChange:=OnFinishLogin;
  httpcli.SendStream:=dataout;
  httpcli.postASync();
end;

procedure TFrmMain.OnFinishLogin(sender:TObject);
var
  i:integer;
begin
  if HttpCli.state=httpReady then begin
    PageData:='';
    HttpCli.Cookie:='';
    //Chargement de la page
    HttpCli.OnStateChange:=OnFinishPage;
    for i:=0 to GlobalCookies.Count-1 do
      HttpCli.Cookie:=HttpCli.Cookie+' '+gauche(' ',globalcookies[i]);
    HttpCli.URL:='http://www.cotations.com/resultat_requete_cours_tempsreel.asp?VALEUR=13000';
    HttpCli.GetASync();
  end;
end;

procedure TFrmMain.OnFinishPage(sender:TObject);
begin
  if httpcli.state=httpready then begin
    if bFirstTime then begin
      TimerMain.Interval:=1000;
      TimerMain.OnTimer:=TimerProc;
      TimerMain.Enabled:=true;
      FrmParamsDlg.DeactivateCtrls();
    end;
    affiche(bFirstTime);
    timerMain.Enabled:=true;
  end;
end;

procedure TFrmMain.Affiche(FirstTime:Boolean);
var
  i:byte;
  sSection:String;
  HaNbTot,HaQteTot,VtNbTot,VtQteTot:integer;
begin
  tbRGA.Text:=GetParsedValue(PageData,'<TD ALIGN=LEFT VALIGN=TOP BGCOLOR="#CCCCCC"><FONT FACE="Arial,Helvetica" size=2>'+#13#10+'<B>','</B>',1);
  tbTitre.Text:=GetParsedValue(PageData,'<TD ALIGN=LEFT VALIGN=TOP  NOWRAP BGCOLOR="#CCCCCC"><FONT FACE="Arial,Helvetica" size=2>'+#13#10+'<B>','</B>',1);
  tbVarVeille.Text:=GetParsedValue(PageData,'<TD ALIGN=CENTER VALIGN=TOP BGCOLOR="#CCCCCC"><FONT FACE="Arial,Helvetica" size=2>'#13#10,#13#10'</TD>',1);
  if pos('-',tbVarVeille.Text)<>0 then
    tbVarVeille.Font.color:=clRed
  else
    tbVarVeille.font.color:=clGreen;
  tbFirst.Text:=GetParsedValue(PageData,'<TD ALIGN=CENTER VALIGN=TOP BGCOLOR="#CCCCCC"><FONT FACE="Arial,Helvetica" size=2>'#13#10,#13#10'</TD>',4);
  tbLast.text:=GetParsedValue(PageData,'<TD ALIGN=CENTER VALIGN=TOP BGCOLOR="#CCCCCC"><FONT FACE="Arial,Helvetica" size=2>'#13#10,#13#10'</TD>',1);
  try
    tbOpenVar.Text:=formatfloat('##.##',( ( (strtofloatdef(tbLast.text,0)-strtofloatdef(tbFirst.Text,0))/strtofloatdef(tbFirst.text,0))*100));
    if pos('-',tbOpenVar.text)<>0 then
      tbOpenVar.Font.Color:=clRed
    else
      tbOpenVar.Font.Color:=clGreen;
  except
    tbOpenVar.Text:='0.00 %';
  end;
  tbLow.text:=GetParsedValue(PageData,'<TD ALIGN=CENTER VALIGN=TOP BGCOLOR="#CCCCCC"><FONT FACE="Arial,Helvetica" size=2>'#13#10,#13#10'</TD>',6);
  tbHigh.text:=GetParsedValue(PageData,'<TD ALIGN=CENTER VALIGN=TOP BGCOLOR="#CCCCCC"><FONT FACE="Arial,Helvetica" size=2>'#13#10,#13#10'</TD>',5);
  {tbCac.Text:=GetParsedValue(WebB.OleObject.Document.Body.innerHTML,'<TD vAlign=top align=middle bgColor=#cccccc><FONT face=Arial,Helvetica size=2>',' </FONT>',10);
  tbVarVeilleCac.text:=GetParsedValue(WebB.OleObject.Document.Body.innerHTML,'<TD vAlign=top align=middle bgColor=#cccccc><FONT face=Arial,Helvetica size=2>',' </FONT>',11);
  if pos('-',tbVarVeilleCac.text)<>0 then
    tbVarVeilleCac.font.color:=clRed
  else
    tbVarVeilleCac.font.color:=clGreen;
  //Volumes T0 et T-1 Note : FVolsPile[0] = T0 et FVolsPile[1] = T-1
  FVolsPile[1]:=FVolsPile[0];
  FVolsPile[0]:=strtointdef(Gauche('k',GetParsedValue(WebB.oleobject.document.body.innerHTML,'<TD vAlign=top align=middle bgColor=#cccccc><FONT face=Arial,Helvetica size=2>',' </FONT>',3)),0);
  lbVolsDiff.Clear();
  lbVolsDiff.items.Add('T0 : '+inttostr(FVolsPile[0]));
  lbVolsDiff.items.add('T-1 : '+inttostr(FVolsPile[1]));
  tbVolsDiffResult.Text:=inttostr(FVolsPile[0]-FVolsPile[1]);
  //Carnet d'Ordres
  sSection:=GetSection(webB.oleobject.document.body.innerhtml,'<!-- Carnet d''ordres -->','<!-- FIN Carnet d''ordres -->');
  HaNbTot:=0;
  HaQteTot:=0;
  VtNbTot:=0;
  VtQteTot:=0;
  for i:=0 to 4 do begin
    sgCO.Cells[0,i+1]:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',7+i*7);
    sgCO.Cells[1,i+1]:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',8+i*7);
    sgCO.Cells[2,i+1]:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',9+i*7);
    HaNbTot:=HaNbTot+strtointdef(GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',7+i*7),0);
    HaQteTot:=HaQteTot+strtointdef(GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',8+i*7),0);
    sgCO.Cells[3,i+1]:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',11+i*7);
    sgCO.Cells[4,i+1]:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',12+i*7);
    sgCO.Cells[5,i+1]:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',13+i*7);
    VtNbTot:=VtNbTot+strtointdef(GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',13+i*7),0);
    VtQteTot:=VtQteTot+strtointdef(GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',12+i*7),0);
  end;
  //Ligne de résultats Carnet D'Ordres
  sgCO.Cells[0,7]:=inttostr(HaNbTot);
  sgCO.Cells[1,7]:=inttostr(HaQteTot);
  try
    sgCO.Cells[2,7]:=formatfloat('#',HaQteTot/HaNbTot);
    sgCO.Cells[3,7]:=formatfloat('#',VtQteTot/VtNbTot);
  except
    on EInvalidOp do;
  end;
  sgCO.Cells[4,7]:=inttostr(VtQteTot);
  sgCO.Cells[5,7]:=inttostr(VtNbTot);
  if bSaveCO then
    RegisterCO();
  //Swap des items de la pile
  if FirstTime = false then begin
    for i:=Length(FResultsPile)-1 downto 1 do
      FResultsPile[i]:=FResultsPile[i-1];
    //Remplissage de l'élément 0 de la pile : nouvel élément
    FResultsPile[0].Hour:=formatdatetime('HH:MM:SS',time());
    FResultsPile[0].nb:=VtNbTot-HaNbTot;
    FResultsPile[0].qte:=VtQteTot-HaQteTot;
    FResultsPile[0].px:=GetParsedValue(WebB.oleobject.document.body.innerHTML,'<TD vAlign=top align=middle bgColor=#cccccc><FONT face=Arial,Helvetica size=2>',' </FONT>',1);
    try
      FResultsPile[0].RatioHA:=HaQteTot / HaNbTot;
      FResultsPile[0].RatioVT:=VtQteTot / VtNbTot;
      FResultsPile[0].Ratio:=FResultsPile[0].RatioHA-FResultsPile[0].RatioVT;
    except
      on EInvalidOp do;
    end;
    FResultsPile[0].Vol:=FVolsPile[0]-FVolsPile[1];
    //Distribution entre volp et volm suivant 3 facteurs : ratio, qté, nb
    FResultsPile[0].volp:=FResultsPile[1].volp;
    FResultsPile[0].volm:=FResultsPile[1].volm;
    {Conditionnel Qté}
    {if FResultsPile[0].qte>=0 then
      FResultsPile[0].volp:=FResultsPile[0].volp+FResultsPile[0].vol / 4
    else if FResultsPile[0].qte<0 then
      FResultsPile[0].volm:=FResultsPile[0].volm+FResultsPile[0].vol / 4;
    {Conditionnel nb}
    {if FResultsPile[0].nb>=0 then
      FResultsPile[0].volp:=FResultsPile[0].volp+FResultsPile[0].vol / 4
    else if FResultsPile[0].nb<0 then
      FResultsPile[0].volm:=FResultsPile[0].volm+FResultsPile[0].vol / 4;
    {Conditionnel Ratio}
    {if FResultsPile[0].Ratio>=0 then
      FResultsPile[0].volp:=FResultsPile[0].volp+FResultsPile[0].vol / 2
    else if FResultsPile[0].Ratio<0 then
      FResultsPile[0].volm:=FResultsPile[0].volm+FResultsPile[0].vol / 2;

    FResultsPile[0].sensvol:=FResultsPile[0].volp-FResultsPile[0].volm;
    //Affichage des résultats contenus dans la pile résultats
    with FrmResults.sgResults do
      for i:=0 to MAX_RESULTS-1 do begin
        Cells[0,i+1]:=FResultsPile[i].Hour;
        Cells[1,i+1]:=inttostr(FResultsPile[i].qte);
        Cells[2,i+1]:=inttostr(FResultsPile[i].nb);
        Cells[3,i+1]:=FResultsPile[i].px;
        Cells[4,i+1]:=formatfloat('#',FResultsPile[i].RatioHA);
        Cells[5,i+1]:=FormatFloat('#',FResultsPile[i].Ratio);
        Cells[6,i+1]:=formatfloat('#',FResultsPile[i].RatioVT);
        Cells[7,i+1]:=formatfloat('0.00',FResultsPile[i].Volm);
        Cells[8,i+1]:=formatfloat('0.00',FResultsPile[i].sensvol);
        Cells[9,i+1]:=formatfloat('0.00',FResultsPile[i].volp);
        Cells[10,i+1]:=inttostr(FResultsPile[i].vol);
      end;
    if bSaveResults then
      RegisterResults();
  end;}
  bFirstTime:=false;
end;

procedure TFrmMain.RegisterCO();
var
  F:TextFile;
  buf:string;
  Col,Row:byte;
begin
  AssignFile(F,FCOFilename);
  buf:='';
  try
    if FileExists(FCoFilename) then
      Append(F)
    else
      Rewrite(F);
    //Les achats
    for Row := 1 to 7 do
      for Col := 0 to 2 do
        if (Row<>6) then
          buf:=buf+FormatPt(sgCO.Cells[Col,Row])+',';
    Write(F,buf);
    buf:='';
    for Row:=1 to 7 do
      for Col:=3 to 5 do
        if (Row<>6) then
          buf:=buf+FormatPt(sgCO.Cells[Col,Row])+',';
    WriteLn(F,buf);
  finally
    closefile(f);
  end;
end;

procedure TFrmMain.RegisterResults();
var
  Text:TStringList;
  buf:string;
  ofStruct:_OFSTRUCT;
  fileHwnd:HFILE;
begin
  Text:=TStringList.Create();
  try
    if not fileExists(FRSFilename) then begin
      fileHWND:=OpenFile(PChar(FRSFilename),ofStruct,OF_CREATE);
      closeHandle(fileHWND);
    end;
    Text.LoadFromFile(FRSFilename);
    buf:=FResultsPile[0].Hour+','+inttostr(FResultsPile[0].qte)+','+inttostr(FResultsPile[0].nb)+','+
      FResultsPile[0].px+','+formatfloat('#',FResultsPile[0].RatioHA)+','+formatfloat('#',FResultsPile[0].Ratio)+','+
      formatfloat('#',FResultsPile[0].RatioVT)+','+formatfloat('#.##',FResultsPile[0].volm)+','+
      formatfloat('#.##',FResultsPile[0].sensvol)+','+formatfloat('#.##',FResultsPile[0].volp)+','+
      inttostr(FResultsPile[0].vol);
    Text.Insert(0,buf);
    Text.SaveToFile(FRSFilename);
  finally
    Text.Free();
  end;
end;


{procedure TFrmMain.OnCompleteRGAFirst(Sender: TObject);
begin
  //Afficher la page RGA de la premiere fois et activer le raffraichissement
  if pos('Valeur ou code inconnu.',WebB.OleObject.Document.Body.InnerHtml)<>0 then begin
    MessageBox(0,PChar('Valeur ou code inconnu.'),PChar('Erreur...'),MB_ICONWARNING);
    FrmParamsDlg.mStop.Click();
    exit;
  end;
  WebB.OnDocumentComplete:=nil;
  Affiche(True);
  TimerMain.OnTimer:=TimerProc;
  TimerMain.interval:=1000;
  TimerMain.Enabled:=true;
  FrmParamsDlg.DeactivateCtrls();
end;}

procedure TFrmMain.TimerProc(sender:TObject);
begin


  //Verifier si on a atteint le taux de raffraichissement demande
  //et si oui raffraichir la page
  if sCurrentRefresh = 1 then begin
    TimerMain.enabled:=false;
    //Afficher le contenu de la page
    RefreshPage();
    sCurrentRefresh:=sRefresh;
  end;

  dec(sCurrentRefresh);

  //Afficher dans combien de temps on a un refresh
  lblRefresh.Caption:=inttostr(sCurrentRefresh);


end;

//--Memoire--

procedure TFrmMain.FormCreate(Sender: TObject);
var
  Ini:TIniFile;
begin
  lblRefresh.Caption:='';
  //Rubriques du CO
  sgCO.Cells[0,0]:='NB';
  sgCO.Cells[1,0]:='QTE';
  sgCO.cells[2,0]:='PX';
  sgCO.Cells[3,0]:='PX';
  sgCO.Cells[4,0]:='QTE';
  sgCO.Cells[5,0]:='NB';
  //On retrouve la position de la fenêtre dans le fichier INI
  Ini:=TIniFile.Create(extractfilepath(application.Exename)+'init.ini');
  try
    with ini do begin
      //Position & largeur de la fenêtre principale
      top:=ReadInteger('FrmMain','Top',108);
      left:=ReadInteger('FrmMain','Left',191);
      height:=ReadInteger('FrmMain','height',264);
      width:=ReadInteger('FrmMain','width',264);
      //Options du captureur
      BatchStart:=ReadBool('Misc','BatchStart',false);
      if BatchStart then begin
        sRGA:=readstring('Misc','StartRGA','13000');
        sRefresh:=readinteger('Misc','StartRefresh',30);
      end;
      //Options de sauvegarde du captureur
      bSaveCO:=ReadBool('SaveParams','SaveCO',false);
      bSaveResults:=ReadBool('SaveParams','SaveResults',false);
      if bSaveCO then
        FCOFilename:=readstring('SaveParams','COFilename','c:\monco.csv');
      if bSaveResults then
        FRSFilename:=readstring('SaveParams','RSFilename','c:\mesresults.csv');
    end;
  finally
    ini.Free();
  end;
  tbFirst.Alignment:=taRightJustify;
  tbHigh.Alignment:=taRightJustify;
  tbLow.Alignment:=taRightJustify;
  tbLast.Alignment:=taRightJustify;
  tbVarVeilleCac.Alignment:=taRightJustify;
  tbCac.Alignment:=taRightJustify;
  tbVarVeille.Alignment:=taRightJustify;
  tbVolsDiffResult.Alignment:=taCenter;
  tbOpenVar.Alignment:=taCenter;
  tbRGA.Alignment:=taCenter;
  tbTitre.alignment:=taCenter;
  //Ver info
  Application.title:=Ver_Info;
  self.caption:=Ver_Info;
  //Cookies system
  GlobalCookies:=TStringList.Create();
end;


procedure TFrmMain.FormDestroy(Sender: TObject);
var
  Ini:tinifile;
begin
  ini:=TIniFile.create(extractfilepath(application.Exename)+'init.ini');
  try
    with ini do begin
      //Position & largeur de la fenêtre principale
      WriteInteger('FrmMain','top',top);
      WriteInteger('FrmMain','left',left);
      WriteInteger('FrmMain','height',height);
      Writeinteger('FrmMain','width',width);
      //Options du captureur
      WriteBool('Misc','BatchStart',ReadBool('Misc','BatchStart',false));
      WriteString('Misc','StartRGA',ReadString('Misc','StartRGA','13000'));
      WriteInteger('Misc','StartRefresh',ReadInteger('Misc','StartRefresh',30));
      //Options de sauvegarde du captureur
      WriteBool('SaveParams','SaveCO',ReadBool('SaveParams','SaveCO',false));
      WriteBool('SaveParams','SaveResults',ReadBool('SaveParams','SaveResults',false));
      WriteString('SaveParams','COFilename',readstring('SaveParams','COFilename','c:\monco.csv'));
      WriteString('SaveParams','RSFilename',readstring('SaveParams','RSFilename','c:\mesresults.csv'));
    end;
  finally
    ini.free();
  end;
  //Cookies system
  GlobalCookies.Free();
end;

//-- Commands from popupMenu --

procedure TFrmMain.mResultsClick(Sender: TObject);
begin
  if FrmResults.Visible then
    FrmResults.hide()
  else
    FrmResults.show();
end;

procedure TFrmMain.mCloseClick(Sender: TObject);
begin
  Close();
end;

procedure TFrmMain.mParamsClick(Sender: TObject);
begin
  if FrmParamsDlg.Visible then
    FrmParamsDlg.Hide()
  else
    FrmParamsDlg.Show();
end;

//-- Evenements --
procedure TFrmMain.sgCODrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  Format:integer;
begin

  sgCO.Canvas.FillRect(Rect);
  //Formattage des rubriques du CO
  if ARow = 0 then begin
    Format:=DT_CENTER;
    sgCO.Canvas.Font.style:=[fsbold];
  end else begin
    if (ACol = 0) or (ACol = 2) or (ACol = 3) or (ACol = 5) then
      Format:=DT_CENTER
    else
      Format:=DT_RIGHT;
  end;

  DrawText(sgCO.Canvas.handle,PChar(sgCO.cells[ACol,ARow]),-1,Rect,Format);
end;

procedure TFrmMain.HttpCliCookie(Sender: TObject; const Data: String;var Accept: Boolean);
begin
  GlobalCookies.Add(data);
end;

procedure TFrmMain.HttpCliDocData(Sender: TObject; Buffer: Pointer;
  Len: Integer);
begin
  PageData:=PageData+PString(@Buffer)^;
end;

end.
