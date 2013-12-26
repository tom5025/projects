unit Cotations_SDK;

interface

uses Winsock,windows,sysutils,FonctionChaines,forms;


function _Login(closeonerror:boolean):string;
function _Refresh(closeonerror:boolean;rga:string;InCookies:string;var OutCookies:string):string;

implementation

const
  crlf=#13#10;
//----Tools-------
function LookupHostAddr(const hn: string): string;
var
  h: PHostEnt;
begin
  Result := '';
  if hn <> '' then
  begin
    if hn[1] in ['0'..'9'] then
    begin
      if inet_addr(pchar(hn)) <> INADDR_NONE then
        Result := hn;
    end
    else
    begin
      h := gethostbyname(pchar(hn));
      if h <> nil then
        with h^ do
        Result := format('%d.%d.%d.%d', [ord(h_addr^[0]), ord(h_addr^[1]),
      		  ord(h_addr^[2]), ord(h_addr^[3])]);
    end;
  end
  else Result := '0.0.0.0';
end;




//-----Functions-------

{
 But : Raffra�chir la page du code RGA sp�cifi�
 R�sultat : contenu de la page
 Param�tres :
   - RGA : code RGA concern�
   - InCookies : Cookies obtenu lors du login ou du raffraichissement de la page
   - OutCookies: Nouveaux cookies obtenus lors du raffraichissement de la page
}

function _Refresh(closeonerror:boolean;rga:string;InCookies:string;var OutCookies:string):string;
var
  WSAData:TWsaData;
  uSocket:u_int;
  Host:TSockAddrIn;
  DataOut,DataIn:string;
  Buffer:array [0..4095] of char;
  ret:integer;
begin
  //Start WSA dll
  if WSAStartup(MAKEWORD(2,2),WSAData)<>0 then begin
    MessageBox(0,PChar('Error on WSAStartup()'),Pchar('Error.'),0);
    WSACleanup();
    if closeOnError then postquitmessage(0);
    exit;
  end;
  //Create socket
  uSocket:=Socket(AF_INET,SOCK_STREAM,0);
  if uSocket=INVALID_SOCKET then begin
    MessageBox(0,pchar('Error on Socket()'),PChar('Error.'),0);
    closesocket(uSocket);
    WSACleanup();
    if closeOnError then postquitmessage(0);
    exit;
  end;
  //DNS lookup
  Host.sin_family:=AF_INET;
  Host.sin_addr.S_addr:=inet_addr(PChar(LookupHostAddr('www.cotations.com')));
  Host.sin_port:=htons(80);
  //Connect to the IP received by the DNS lookup
  if Connect(uSocket,Host,sizeof(Host))=SOCKET_ERROR then begin
    MessageBox(0,pchar('Error on connect()'),PChar('Error.'),0);
    closesocket(uSocket);
    WSACleanup();
    if closeOnError then postquitmessage(0);
    exit;
  end;

  //Build Refresh request with cookies
  DataIn:='';
  DataOut:='GET /resultat_requete_cours_tempsreel.asp?VALEUR=13000 HTTP/1.1'+crlf+
         'Accept: text/html'+crlf+
         'User-Agent: Mozilla/3.0 (compatible)'+crlf+
         'Host: www.cotations.com'+crlf+
         'Connection: close'+crlf+'Cookie: '+InCookies+crlf+crlf;

  //Send request
  ret:=send(uSocket,DataOut[1],length(DataOut),0);
  if (ret=SOCKET_ERROR) or (ret<>length(DataOut)) then begin
    MessageBox(0,pchar('Error on send()'),PChar('Error.'),0);
    closesocket(uSocket);
    WSACleanup();
    if closeOnError then postquitmessage(0);
    exit;
  end;

  //Receive request result
  ret:=1;
  ioctlsocket(uSocket,FIONBIO,ret);
  repeat
    zeroMemory(@buffer,sizeof(buffer));
    ret:=recv(uSocket,Buffer,sizeof(buffer),0);
    if (ret<>0) and (ret<>SOCKET_ERROR) then
      datain:=datain+buffer;
    application.ProcessMessages();
  until ret=0;

  OutCookies:='';
  //Parse for new cookies
  for ret:=1 to NbSousChaine('Set-Cookie:',DataIn) do
    OutCookies:=OutCookies+Gauche(';',NDroite('Set-Cookie: ',datain,ret))+'; ';
  //Return the received result
  result:=datain;

  //Free the socket
  closesocket(uSocket);
  wsacleanup();
end;


{
 But : Se logguer sur www.cotations.com
 R�sultat : contenu de la page
 Param�tres :
   - R�sultat : Cookies obtenus apr�s login
}

function _Login(CloseOnError:boolean):string;
var
  WSAData:TWSAData;
  uSocket:u_int;
  Host:TSockAddrIn;
  DataOut,DataIn:string;
  Buffer:array [0..4095] of char;
  ret:integer;
begin
  //Start WSA dll
  if WSAStartup(MAKEWORD(2,2),WSAData)<>0 then begin
    MessageBox(0,PChar('Error on WSAStartup()'),Pchar('Error.'),0);
    WSACleanup();
    if closeOnError then postquitmessage(0);
    exit;
  end;

  //Create socket
  uSocket:=Socket(AF_INET,SOCK_STREAM,0);
  if uSocket=INVALID_SOCKET then begin
    MessageBox(0,pchar('Error on Socket()'),PChar('Error.'),0);
    closesocket(uSocket);
    WSACleanup();
    if closeOnError then postquitmessage(0);
    exit;
  end;

  //DNS lookup
  Host.sin_family:=AF_INET;
  Host.sin_addr.S_addr:=inet_addr(PChar(LookupHostAddr('www.cotations.com')));
  Host.sin_port:=htons(80);

  //Connect to the IP received by the DNS lookup
  if Connect(uSocket,Host,sizeof(Host))=SOCKET_ERROR then begin
    MessageBox(0,pchar('Error on connect()'),PChar('Error.'),0);
    closesocket(uSocket);
    WSACleanup();
    if closeOnError then postquitmessage(0);
    exit;
  end;

  //1st Request
  DataIn:='';
  DataOut:='POST /index.asp HTTP/1.1'+crlf+
           'Accept: image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, */*'+crlf+
           'Content-Type: application/x-www-form-urlencoded'+crlf+
           'User-Agent: Mozilla/3.0 (compatible)'+crlf+
           'Host: www.cotations.com'+crlf+
           'Content-Length: 29'+crlf+
           'Connection: close'+crlf+
           'user=gremy1&password=ymer21AM'+crlf+crlf;

  //Send request
  ret:=send(uSocket,DataOut[1],length(DataOut),0);
  if (ret=SOCKET_ERROR) or (ret<>length(DataOut)) then begin
    MessageBox(0,pchar('Error on send()'),PChar('Error.'),0);
    closesocket(uSocket);
    WSACleanup();
    if closeOnError then postquitmessage(0);
    exit;
  end;

  //Receive request result
  ret:=1;
  ioctlsocket(uSocket,FIONBIO,ret);
  repeat
    zeroMemory(@buffer,sizeof(buffer));
    ret:=recv(uSocket,Buffer,sizeof(buffer),0);
    if (ret<>0) and (ret<>SOCKET_ERROR) then
      datain:=datain+buffer;
    application.ProcessMessages();
  until ret=0;

  //Parse cookies in server's response to get them back to him in our next request
  for ret:=1 to NbSousChaine('Set-Cookie:',DataIn) do
    result:=result+Gauche(';',NDroite('Set-Cookie: ',datain,ret))+'; ';

  //Free socket and close WSA dll
  closesocket(uSocket);
  WSACleanup();
end;

end.
