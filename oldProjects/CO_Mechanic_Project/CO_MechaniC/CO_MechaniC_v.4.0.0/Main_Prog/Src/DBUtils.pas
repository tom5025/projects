unit DBUtils;

interface

uses windows,classes,comctrls,sysutils;

type
  TMinuteData = record
    szHour:string[10];

    dwHAPx5:single;
    dwHANb5:DWORD;
    dwHAQte5:DWORD;

    dwHAPx4:single;
    dwHANb4:DWORD;
    dwHAQte4:DWORD;

    dwHAPx3:single;
    dwHANb3:DWORD;
    dwHAQte3:DWORD;

    dwHAPx2:single;
    dwHANb2:DWORD;
    dwHAQte2:DWORD;

    dwHAPx1:single;
    dwHANb1:DWORD;
    dwHAQte1:DWORD;

    dwVTPx1:single;
    dwVTNb1:DWORD;
    dwVTQte1:DWORD;

    dwVTPx2:single;
    dwVTNb2:DWORD;
    dwVTQte2:DWORD;

    dwVTPx3:single;
    dwVTNb3:DWORD;
    dwVTQte3:DWORD;

    dwVTPx4:single;
    dwVTNb4:DWORD;
    dwVTQte4:DWORD;

    dwVTPx5:single;
    dwVTNb5:DWORD;
    dwVTQte5:DWORD;
  end;

  TCaptureData = record
    dwRGA:DWORD;
    szTitre:string[20];
    dwMinutesCount:DWORD;
    lpMinutes:array of TMinuteData;
  end;

  TDateData = record
    szDate:string[10];
    dwCaptureCount:DWORD;
    lpCaptures:array of TCaptureData;
  end;

  PCDB_Array = ^TCDB_Array;
  TCDB_Array = array of TDateData;

  TCDB_DataEngine = class
    private
      FCDB_Data:PCDB_Array;
      FFileName:string;
      function GetItem(index:integer):TDateData;
      procedure SetItem(index:integer;value:TDateData);
    public
      //Mem alloc procs
      constructor Create(const sFilename:string);
      destructor Free();
      //Main procs
      property Items[index:integer]:TDateData read GetItem write SetItem;
      function Count():integer;
      procedure AddItem(value:TDateData);
      //File utils
      procedure SaveToFile();
//      procedure LoadFromFile();
    end;

var
  DataEngine:TCDB_DataEngine;


implementation

//private
function TCDB_DataEngine.GetItem(index:integer):TDateData;
begin
  Result:=FCDB_Data^[index];
end;

procedure TCDB_DataEngine.SetItem(index:integer;value:TDateData);
begin
  FCDB_Data^[index]:=value;
end;

//Mem alloc procs
constructor TCDB_DataEngine.Create(const sFilename:string);
begin
  FFilename:=sFilename;
  new(FCDB_Data);
  setlength(FCDB_Data^,0);
end;

destructor TCDB_DataEngine.Free();
begin
  dispose(FCDB_Data);
end;

//Main functions
function TCDB_DataEngine.Count():integer;
begin
  result:=length(FCDB_Data^);
end;

procedure TCDB_DataEngine.AddItem(value:TDateData);
begin
  setlength(FCDB_Data^,length(FCDB_Data^)+1);
  FCDB_Data^[length(FCDB_Data^)-1]:=value;
end;

//File utils
procedure TCDB_DataEngine.SaveToFile();
var
  iJour,iCapt,iMinute:DWORD;
  fstream:TFileStream;
  //TDateData
  szDate:string[10];
  dwCaptureCount:DWORD;
  //TCaptureData
  dwRGA:DWORD;
  szTitre:string[20];
  dwMinutesCount:DWORD;
  //TMinuteData
  cMinute:TMinuteData;
begin
  fstream:=TFileStream.Create(FFilename,fmOpenWrite or fmCreate);
  try
    with fstream do begin
      //TDateData
      for iJour:=0 to Count-1 do begin
        szDate:=Items[iJour].szDate;
        dwCaptureCount:=items[iJour].dwCaptureCount;
        write(szDate[1],10);
        write(dwCaptureCount,sizeof(DWORD));
        //TCaptureData
        for iCapt:=0 to dwCaptureCount-1 do begin
          dwRGA:=items[iJour].lpCaptures[iCapt].dwRGA;
          szTitre:=items[iJour].lpCaptures[iCapt].szTitre;
          dwMinutesCount:=items[iJour].lpCaptures[iCapt].dwMinutesCount;
          write(dwRGA,sizeof(DWORD));
          write(dwMinutesCount,sizeof(DWORD));
          write(szTitre[1],20);
          //TMinuteData
          for iMinute:=0 to dwMinutesCount-1 do begin
            cMinute:=Items[iJour].lpCaptures[iCapt].lpMinutes[iMinute];
            Write(cMinute,sizeof(TMinuteData));
          end;
        end;
      end;
    end;
  finally
    fStream.Free();
  end;
end;




end.
