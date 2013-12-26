unit ParamsDlg;

interface

uses
  IniFiles,Windows,Class_FormMove,SysUtils,
  Classes,Controls, Forms, StdCtrls,
  Menus, ExtCtrls;

type
  TFrmParamsDlg = class(TForm)
    lblCode: TLabel;
    lblRefresh: TLabel;
    tbRGACode: TEdit;
    btGO: TButton;
    tbRefreshRate: TEdit;
    pmParams: TPopupMenu;
    mFermer: TMenuItem;
    pnCaption: TPanel;
    N1: TMenuItem;
    mStop: TMenuItem;
    mPause: TMenuItem;
    btPause: TButton;
    btStop: TButton;
    procedure mFermerClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btGOClick(Sender: TObject);
    procedure mStopClick(Sender: TObject);
    procedure mPauseClick(Sender: TObject);
    procedure btPauseClick(Sender: TObject);
    procedure btStopClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MoveForm:TMoveForm;
    procedure DeactivateCtrls();
    procedure ActivateCtrls();
  end;

var
  FrmParamsDlg: TFrmParamsDlg;

implementation

uses Main;

{$R *.dfm}

//-- interface utils --

procedure TFrmParamsDlg.DeactivateCtrls();
begin
  tbRefreshRate.enabled:=false;
  tbRGAcode.enabled:=false;
  btPause.Enabled:=true;
  btStop.Enabled:=true;
  btGO.Enabled:=false;
  mPause.Enabled:=true;
  mStop.Enabled:=true;
  btPause.Caption:='Pause';
end;

procedure TFrmParamsDlg.ActivateCtrls();
begin
  tbRefreshRate.clear();
  tbRgaCode.clear();
  tbRefreshRate.enabled:=true;
  tbRGAcode.enabled:=true;
  mPause.Enabled:=false;
  mStop.Enabled:=false;
  btPause.Enabled:=false;
  btStop.Enabled:=false;
  btGO.Enabled:=true;
  btPause.Caption:='Pause';
end;


//-- Memoire --

procedure TFrmParamsDlg.FormCreate(Sender: TObject);
var
  ini:TInifile;
begin
  MoveForm:=TMoveForm.create(pnCaption,self);
  ini:=TIniFile.Create(extractfilepath(application.Exename)+'init.ini');
  try
    top:=ini.readinteger('FrmParams','top',107);
    left:=ini.readinteger('FrmParams','left',460);
  finally
    ini.free();
  end;
end;

procedure TFrmParamsDlg.FormDestroy(Sender: TObject);
var
  ini:tinifile;
begin
  MoveForm.destroy();
  ini:=TIniFile.Create(extractfilepath(application.Exename)+'init.ini');
  try
    ini.writeinteger('FrmParams','top',top);
    ini.writeinteger('FrmParams','left',left);
  finally
    ini.free();
  end;
end;
//-- commands --

procedure TFrmParamsDlg.mFermerClick(Sender: TObject);
begin
  close();
end;

procedure TFrmParamsDlg.mStopClick(Sender: TObject);
begin
  FrmMain.StopCapture();
  ActivateCtrls();
end;

procedure TFrmParamsDlg.mPauseClick(Sender: TObject);
begin
  if FrmMain.TimerMain.enabled then
    FrmMain.PauseCapture()
  else
    FrmMain.ResumeCapture();
end;

procedure TFrmParamsDlg.btGOClick(Sender: TObject);
var
  bExit:Boolean;
begin
  bExit:=false;
  with FrmMain.StartParams do begin
    sRGA:=tbRGACode.text;
    iRefreshRate:=strtointdef(tbRefreshRate.Text,-1);
    //Verify if RGA Code is right
    if (strtointdef(sRGA,-1)=-1) or (strtointdef(sRGA,-1)<0) or (strtointdef(sRGA,-1)>99999) then begin
      MessageBox(0,PChar('Le code RGA doit être compris entre 0 et 99999 et ne doit pas être négatif.'),Pchar('Erreur...'),MB_ICONWARNING);
      bExit:=true;
      ActivateCtrls();
    end;
    if (iRefreshRate<1) or (iRefreshRate = -1) then begin
      MessageBox(0,Pchar('Le taux de raffraichissement entré n''est pas valide. Il doit etre compris entre 1 et 255^4.'),Pchar('Erreur...'),MB_ICONWARNING);
      bExit:=true;
      ActivateCtrls();
    end;
    if bExit then exit;
    FrmMain.CaptureRga();
    //btGo.Enabled:=false;
  end;
end;

//-- Events --

procedure TFrmParamsDlg.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  FrmMain.mParams.checked:=false;
end;

procedure TFrmParamsDlg.btPauseClick(Sender: TObject);
begin
  if FrmMain.TimerMain.Enabled then begin
    FrmMain.PauseCapture();
    btPause.Caption:='Resume';
  end else  begin
    FrmMain.ResumeCapture();
    btPause.Caption:='Pause';
  end;
end;

procedure TFrmParamsDlg.btStopClick(Sender: TObject);
begin
  mStop.Click();
end;

end.
