unit Main;

interface

uses
  Windows, Messages, SysUtils, variants, Classes,
  Controls, Forms, Menus, StdCtrls, ExtCtrls,ComObj, ComCtrls, OleCtrls,
  SHDocVw,inifiles;

type
  TParameters = record
    iTicksLimit,iDelayLimit,iRGACode:integer;
    bCloseAtEnd,bAutoSave,bIntraday,bAutoStart,bVolume,bDernier:boolean;
    sSaveFilename:string;
    //intraday params
    iEndHour,iEndMin,iEndSec:byte;
    iStartHour,iStartMin,iStartSec:byte;
  end;

  TCnxState = (csLogin,csRGALoaded,csProcessing);
  TFrmMain = class(TForm)
    MainMenu: TMainMenu;
    mFile: TMenuItem;
    mNewCO: TMenuItem;
    N1: TMenuItem;
    mQuit: TMenuItem;
    mAbout: TMenuItem;
    lbLog: TListBox;
    TimerDelay: TTimer;
    StatusBar1: TStatusBar;
    Splitter1: TSplitter;
    WebB: TWebBrowser;
    mTools: TMenuItem;
    mInfo: TMenuItem;
    mSecondsAjout: TMenuItem;
    mStop: TMenuItem;
    mPause: TMenuItem;
    procedure mNewCOClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mQuitClick(Sender: TObject);
    procedure WebBDocumentComplete(Sender: TObject;const pDisp: IDispatch; var URL: OleVariant);
    procedure DelayTimer(Sender: TObject);
    procedure mStopClick(Sender: TObject);
    procedure mPauseClick(Sender: TObject);
    procedure mAboutClick(Sender: TObject);

    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    //Parameters
    Params:TParameters;
    //Program vars
    iDelay,iLinePtr,iTicksCount:integer;
    CnxState:TCnxState;
    //App object
    OleApp:Variant;
    //Utils
    procedure AddToXls();
    procedure HeaderToXls();
    procedure StopCapture();
    procedure ClearCounter();
  end;

var
  FrmMain: TFrmMain;

const
  Version_Info = 'CO MechaniC v3.0c4';


implementation

{$R *.dfm}

uses FonctionChaines, AboutBox, WaitingTime;



//----------------------------------------UTILS---------------------------------------------------

//Procedure to generate a POST request with IE ActiveX (Start URL with parameters generates a POST method request)
procedure Navigator(stURL, stPostData: String; var wbWebBrowser: TWebBrowser);
var
  vWebAddr, vPostData, vFlags, vFrame, vHeaders: OleVariant;
  iLoop: Integer;
begin
  if Length(stPostData)> 0 then begin
    vHeaders:= 'Content-Type: application/x-www-form-urlencoded'+ #10#13#0;
    vPostData:= VarArrayCreate([0, Length(stPostData)], varByte);
    for iLoop := 0 to Length(stPostData)- 1 do
      vPostData[iLoop]:= Ord(stPostData[iLoop+ 1]);
    vPostData[Length(stPostData)]:= 0;
    TVarData(vPostData).vType:=varArray;
  end;
  vWebAddr:= stURL;
  wbWebBrowser.Navigate2(vWebAddr, vFlags, vFrame, vPostData, vHeaders);
end;


//Function that returns the parsed value through the help of the tags
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

function FormatPt(sIn:string):string;
begin
  if (pos(',',sIn)<>0) and (UpperCase(sIn)<>'ATP') and (UpperCase(sIn)<>'APM') and (UpperCase(sIn)<>'OUV') then
    result:=gauche(',',sIn)+'.'+droite(',',sIn)
  else
    result:=sIn;
end;


procedure TFrmMain.HeaderToXLS();
begin
  OleApp.Range['B1'].Value:=#32+Gauche('</B>',Droite('<B>',Droite('<B>'+inttostr(params.iRGACode)+'</B>',WebB.OleObject.document.body.innerHTML)));
  OleApp.Range['H1'].Value:=inttostr(params.iRGACode);
  OleApp.Range['L1'].Value:=datetostr(now());
end;

procedure TFrmMain.ClearCounter();
begin
  OleApp.range['A1'].Value:='';
end;

procedure TFrmMain.AddToXLS();
var
  sLinePtr,sSection:string;
begin
  sLinePtr:=inttostr(iLinePtr);
  sSection:=GetSection(WebB.oleobject.document.body.innerhtml,'<!-- Carnet d''ordres -->','<!-- FIN Carnet d''ordres -->');
  {Heure de capture}
  OleApp.Range['A'+sLinePtr].Value:=FormatDateTime('HH:MM:SS',time());
  {Achats_Crs5 CDB (BCD) }
  OleApp.Range['C'+sLinePtr].Value:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',35);
  OleApp.Range['D'+sLinePtr].value:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',36);
  OleApp.Range['B'+sLinePtr].Value:=FormatPt(GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',37));
  {Achats_Crs4 FGE (EFG)}
  OleApp.Range['F'+sLinePtr].Value:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',28);
  OleApp.Range['G'+sLinePtr].value:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',29);
  OleApp.Range['E'+sLinePtr].Value:=FormatPt(GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',30));
  {Achats_Crs3 IJH (HIJ) }
  OleApp.Range['I'+sLinePtr].Value:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',21);
  OleApp.Range['J'+sLinePtr].value:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',22);
  OleApp.Range['H'+sLinePtr].Value:=FormatPt(GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',23));
  {Achats_Crs2 LMK (KLM) }
  OleApp.Range['L'+sLinePtr].Value:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',14);
  OleApp.Range['M'+sLinePtr].value:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',15);
  OleApp.Range['K'+sLinePtr].Value:=FormatPt(GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',16));
  {Achats_Crs1 OPN (NOP) }
  OleApp.Range['O'+sLinePtr].Value:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',7);
  OleApp.Range['P'+sLinePtr].value:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',8);
  OleApp.Range['N'+sLinePtr].Value:=FormatPt(GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',9));
  {Vente_Crs5 AD AF AE(AD AE AF) }
  OleApp.Range['AD'+sLinePtr].Value:=FormatPt(GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',39));
  OleApp.Range['AF'+sLinePtr].value:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',40);
  OleApp.Range['AE'+sLinePtr].Value:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',41);
  {Vente_Crs4 AA AC AB (AA AB AC)}
  OleApp.Range['AA'+sLinePtr].Value:=FormatPt(GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',32));
  OleApp.Range['AC'+sLinePtr].value:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',33);
  OleApp.Range['AB'+sLinePtr].Value:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',34);
  {Vente_Crs3 X Z Y (X Y Z)}
  OleApp.Range['X'+sLinePtr].Value:=FormatPt(GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',25));
  OleApp.Range['Z'+sLinePtr].value:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',26);
  OleApp.Range['Y'+sLinePtr].Value:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',27);
  {Vente_Crs2 U W V (U V W)}
  OleApp.Range['U'+sLinePtr].Value:=FormatPt(GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',18));
  OleApp.Range['W'+sLinePtr].value:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',19);
  OleApp.Range['V'+sLinePtr].Value:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',20);
  {Vente_Crs1 R T S (R S T)}
  OleApp.Range['R'+sLinePtr].Value:=FormatPt(GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',11));
  OleApp.Range['T'+sLinePtr].value:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',12);
  OleApp.Range['S'+sLinePtr].Value:=GetParsedValue(sSection,'<TD align=middle><FONT face=Arial,Helvetica color=#000000 size=2>',' </FONT>',13);
  {Volume case Q}
  if Params.bVolume then
    OleApp.Range['Q'+sLinePtr].value:=Gauche('k',GetParsedValue(WebB.oleobject.document.body.innerHTML,'<TD vAlign=top align=middle bgColor=#cccccc><FONT face=Arial,Helvetica size=2>',' </FONT>',3));
  if params.bDernier then 
    OleApp.Range['AG'+sLinePtr].value:=FormatPt(GetParsedValue(WebB.oleobject.document.body.innerHTML,'<TD vAlign=top align=middle bgColor=#cccccc><FONT face=Arial,Helvetica size=2>',' </FONT>',1));
  if Params.bAutoSave then
    OleApp.ActiveWorkBook.Save;

  inc(iLinePtr);
end;

procedure TFrmMain.StopCapture();
begin
  ClearCounter();
  TimerDelay.Enabled:=false;
  iDelay:=params.iDelayLimit;
  iLinePtr:=7;
  iTicksCount:=0;
  lbLog.Items.Add('XLS Document''s ready to be saved.');
  lbLog.Selected[lbLog.Items.Count-1]:=true;
  mStop.Enabled:=false;
  mPause.Enabled:=false;
  mPause.Checked:=false;
  mNewCo.Enabled:=true;
  if Params.bAutoSave then OleApp.ActiveWorkBook.Save;
  if params.bCloseAtEnd then close();
end;


//----------------------------------------INIT----------------------------------

procedure TFrmMain.FormCreate(Sender: TObject);
var
  ini:TIniFile;
begin
  //New INI Method
  ini:=TIniFile.Create(extractfilepath(application.exename)+'init.ini');
  try
    //Création du fichier si il n'existe pas
    if not FileExists(extractfilepath(application.exename)+'init.ini') then begin
      {paramètres généraux}
      ini.WriteInteger('Parameters','iDelayLimit',60);
      ini.WriteInteger('Parameters','iTicksLimit',60);
      ini.writeinteger('Parameters','iRGACode',13000);
      ini.WriteBool('parameters','autostart',false);
      ini.writebool('parameters','closeatend',false);
      ini.writebool('parameters','addvol',false);
      ini.WriteBool('parameters','addlast',false);
      {autosave params}
      ini.WriteBool('autosave','enabled',false);
      ini.WriteString('autosave','savefilename',extractfilepath(application.exename)+'out.xls');
      {Intraday params}
      ini.WriteBool('Intraday_trading','enabled',false);
      ini.Writeinteger('intraday_trading','starthour',08);
      ini.writeinteger('intraday_trading','startmin',00);
      ini.writeinteger('intraday_trading','startsec',00);
      ini.WriteInteger('intraday_trading','EndHour',11);
      ini.writeInteger('intraday_trading','EndMin',10);
      ini.writeinteger('intraday_trading','EndSec',00);
    end;
    {Lecture des paramètres généraux}
    Params.iDelayLimit:=ini.readinteger('Parameters','iDelayLimit',60);
    Params.iTicksLimit:=ini.readinteger('parameters','iTicksLimit',60);
    Params.iRGACode:=ini.Readinteger('Parameters','iRGACode',13000);
    Params.bAutoStart:=ini.readbool('parameters','autostart',false);
    Params.bCloseAtEnd:=ini.readbool('parameters','CloseAtEnd',false);
    Params.bVolume:=ini.readbool('parameters','AddVol',false);
    params.bDernier:=ini.ReadBool('parameters','addlast',false);
    {AutoSave Params}
    Params.bAutoSave:=ini.readbool('AutoSave','Enabled',false);
    Params.sSaveFilename:=ini.ReadString('AutoSave','SaveFilename',extractfilepath(application.ExeName)+'Default.xls');
    {Intraday Params}
    Params.bIntraday:=ini.readbool('Intraday_Trading','Enabled',false);
    Params.iStartHour:=ini.ReadInteger('Intraday_Trading','StartHour',08);
    Params.iStartMin:=ini.readinteger('Intraday_Trading','StartMin',00);
    Params.iStartSec:=ini.readinteger('intraday_trading','startsec',00);
    Params.iEndHour:=ini.readinteger('Intraday_Trading','EndHour',17);
    params.iEndMin:=ini.readinteger('Intraday_Trading','EndMin',30);
    params.iEndSec:=ini.readinteger('intraday_trading','endsec',00);
  finally
    ini.Free();
  end;
  //Si autostart
  if (Params.bAutoStart) then
    mNewCO.Click();
  //Version info
  Application.title:=Version_Info;
  Self.caption:=Version_Info+' [Designed for Excel 2000]';
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin

end;

//----------------------------------------WEB_BROWSER EVENTS--------------------


//Proceding the different states of the surf with this procedure
procedure TFrmMain.WebBDocumentComplete(Sender: TObject;const pDisp: IDispatch; var URL: OleVariant);
begin
  if cnxState = csLogin then begin
    WebB.Navigate('http://www.cotations.com/resultat_requete_cours_tempsreel.asp?VALEUR='+inttostr(params.iRGACode));
    lbLog.Items.Add('Loading page -> Title number : '+inttostr(params.iRGACode)+' ...');
    CnxState:=csRGALoaded;
  end else if cnxState = csRGALoaded then begin
    HeaderToXLS();
    lbLog.Items.Add('Header added to XLS document. (Title :'+#32+Gauche('</B>',Droite('<B>',Droite('<B>'+inttostr(params.iRGACode)+'</B>',WebB.OleObject.document.body.innerHTML)))+' / RGA : '+inttostr(params.iRGACode)+').');
    //Set the vars
    iDelay:=params.iDelayLimit; //The timer which counts the seconds
    iLinePtr:=7; //We start adding at the 7th line in the XLS document
    iTicksCount:=0; //Number of ticks past = 0
    lbLog.items.add('Lauching "delayed Timer"... Complete.');
    TimerDelay.Enabled:=true;
    //User infos
    lbLog.Items.add('Page updated. Added : '+timetostr(now())+' to the document.');
    lbLog.Selected[lbLog.Items.Count-1]:=true;
    //Surf on the page of the specified RGA
    WebB.Navigate('http://www.cotations.com/resultat_requete_cours_tempsreel.asp?VALEUR='+inttostr(params.iRGACode));
    CnxState:=csProcessing;
    //Activate the tools buttons
    mStop.Enabled:=true;
    mPause.Enabled:=true;
    mPause.Checked:=false;
  end else if cnxState = csProcessing then begin
    inc(iTicksCount);
    AddToXLS();
  end;
end;


//----------------------------------------TIMER PROC----------------------------

//Delay count timer
procedure TFrmMain.DelayTimer(Sender: TObject);
begin
  //User infos
  mSecondsAjout.Caption:=inttostr(iDelay);
  OleApp.Range['A1'].Value:='['+inttostr(idelay)+']';

  Dec(iDelay);
  if (iDelay=0) then begin
    //Verify ticks limit
    if params.bIntraday then begin
      if (strtoint(FormatDateTime('HH',now()))=params.iEndHour) and (strtoint(FormatDateTime('NN',now()))>=Params.iEndMin) and (strtoint(formatdatetime('SS',now()))>=params.iEndSec) then begin
        stopcapture();
        exit;
      end;
    end else begin
      if iTicksCount=params.iTicksLimit then begin
        StopCapture();
        exit;
      end;
    end;
    inc(iTicksCount);
    iDelay := params.iDelayLimit;
    //User infos
    lbLog.Items.add('Page updated. Added : '+timetostr(now())+' to the document.');
    lbLog.Selected[lbLog.Items.Count-1]:=true;
    //New method for refreshing
    try
      WebB.Refresh2();
    finally
      AddToXls();
    end;
  end;
end;


//----------------------------------------Commands------------------------------

procedure TFrmMain.mNewCOClick(Sender: TObject);
begin
  //Deactivate the button
  mNewCO.Enabled:=false;

  //Open Excel
  OleApp:=CreateOleObject('Excel.Application');
  OleApp.visible:=true;
  //Open the template
  OleApp.WorkBooks.Open(extractFilePath(ParamStr(0))+'COTemplate.xls');
  if Params.bAutoSave then
    OleApp.ActiveWorkBook.SaveAs(Params.sSaveFilename);
  //Login in
  lbLog.Items.Add('Login sur Cotations.com ...');
  CnxState:=csLogin;
  Navigator('http://www.cotations.com/index.asp','User=gremy1&Password=ymer21AM',WebB);


  //All other things are treated in NavigateComplete
end;


procedure TFrmMain.mQuitClick(Sender: TObject);
begin
  //lol here simply close :p
  Close();
end;

procedure TFrmMain.mStopClick(Sender: TObject);
begin
  StopCapture();
end;

procedure TFrmMain.mPauseClick(Sender: TObject);
begin
  if mPause.Checked then TimerDelay.Enabled:=false
  else TimerDelay.enabled:=true;
end;

procedure TFrmMain.mAboutClick(Sender: TObject);
begin
  FrmAbout.show();
end;





end.
