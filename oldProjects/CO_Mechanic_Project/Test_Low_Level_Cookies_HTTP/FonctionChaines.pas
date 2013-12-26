unit FonctionChaines;

interface


function droite(substr: string; s: string): string;
function DroiteDroite(substr: string; s: string): string;
function gauche(substr: string; s: string): string;
function GaucheDuDernier(substr: string; s: string): string;
function NbSousChaine(substr: string; s: string): integer;
function NDroite(substr: string; s: string;n:integer): string;
function GaucheNDroite(substr: string; s: string;n:integer): string;

implementation

function droite(substr: string; s: string): string;
begin
  if pos(substr,s)=0 then result:='' else
    result:=copy(s, pos(substr, s)+length(substr), length(s)-pos(substr, s)+length(substr));
end;

function droiteDroite(substr: string; s: string): string;
{============================================================================}
{ fonction qui renvoie la sous chaine de caractère situè à droite de la sous }
{ chaine substr située la plus à droite                                      }
{ ex: si substr = '\' et S= 'truc\tr\essai.exe droiteDroite renvoie essai.exe}
{============================================================================}
begin
  Repeat
    S:=droite(substr,s);
  until pos(substr,s)=0;
  result:=S;
end;

function gauche(substr: string; s: string): string;
{============================================================================}
{ fonction qui renvoie la sous chaine de caractère situè à gauche de la sous }
{ chaine substr                                                              }
{ ex: si substr = '\' et S= 'truc\tr\essai.exe' gauche renvoie truc           }
{============================================================================}
begin
  result:=copy(s, 1, pos(substr, s)-1);
end;

function GaucheDuDernier(substr: string; s: string): string;
{============================================================================}
{ fonction qui renvoie la sous chaine de caractère situèe à gauche de la     }
{dernière sous chaine substr                                                 }
{ ex: si substr = '\' et S= 'truc\tr\essai.exe' gauche renvoie truc\tr       }
{============================================================================}
var
 s1:string;
 i:integer;
begin
  s1:='';
  for i:=1 to NbSousChaine(substr, s)-1 do
  begin
    s1:=s1+gauche(substr,s)+substr;
    s:=droite(substr,s);
  end;
  s1:=s1+gauche(substr,s);
  result:=s1;
end;

function NbSousChaine(substr: string; s: string): integer;
{==================================================================================}
{ renvoie le nombre de fois que la sous chaine substr est présente dans la chaine S}
{==================================================================================}
var
  push:string;
begin
  result:=0;
  push:=s;
  while pos(substr,s)<>0 do
  begin
    S:=droite(substr,s);
    inc(result);
  end;
  s:=push;
end;

function NDroite(substr: string; s: string;n:integer): string;
{==============================================================================}
{ renvoie ce qui est à droite de la n ieme sous chaine substr de la chaine S   }
{==============================================================================}
var i:integer;
begin
  for i:=1 to n do
  begin
    S:=droite(substr,s);
  end;
  result:=S;
end;

function GaucheNDroite(substr: string; s: string;n:integer): string;
{==============================================================================}
{ renvoie ce qui est à gauche de la droite de la n ieme sous chaine substr     }
{ de la chaine S                                                               }
{ ex : GaucheNDroite('/','c:machin\truc\essai.exe',1) renvoie 'truc'           }
{ Permet d'extraire un à un les éléments d'une chaine séparés par un séparateur}
{==============================================================================}
var i:integer;
begin
  S:=S+substr;
  for i:=1 to n do
  begin
    S:=copy(s, pos(substr, s)+length(substr), length(s)-pos(substr, s)+length(substr));
  end;
  result:=copy(s, 1, pos(substr, s)-1);
end;


end.


 