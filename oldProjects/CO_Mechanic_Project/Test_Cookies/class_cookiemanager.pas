unit class_cookiemanager;

interface

uses SysUtils,windows;

type
  TCookieManager = class
    private
      FWorkFile:string;
    public
      constructor Create(WorkFile:string);
      function GetCookies():string;
      procedure AddCookie(Data:string);
    end;


implementation

uses FonctionChaines;

constructor TCookieManager.Create(workFile:string);
begin
  FWorkFile:=workFile;
end;

function TCOokieManager.GetCookies():string;
var
  F:TextFile;
  buf:string;
begin
  result:='';
  AssignFile(F,FWorkFile);
  Reset(F);
  while not EOF(F) do begin
    ReadLn(F,buf);
    result:=gauche(';',buf)+';'+result;
  end;
  closefile(f);
end;

procedure TCookieManager.AddCookie(data:string);
var
  F:TextFile;
begin
  assignfile(F,FWorkFile);
  if fileexists(FWorkFile) then
    append(F)
  else
    rewrite(F);
  writeLn(f,data);
  closefile(F);
end;

end.
