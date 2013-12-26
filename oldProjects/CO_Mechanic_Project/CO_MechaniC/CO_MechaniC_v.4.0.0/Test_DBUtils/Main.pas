unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses DBUtils;

procedure TForm1.Button1Click(Sender: TObject);
var
  Item:TDateData;
begin
  DataEngine:=TCDB_DataEngine.Create('c:\datatest.cdb');
  Item.szDate:='10/10/10';
  Item.dwCaptureCount:=2;
    setlength(Item.lpCaptures,1);
    Item.lpCaptures[0].dwRGA:=13000;
    item.lpCaptures[0].szTitre:='SAINT GOBAIN A';
    item.lpCaptures[0].dwMinutesCount:=1;
      setlength(item.lpCaptures[0].lpMinutes,1);
      item.lpCaptures[0].lpMinutes[0].szHour:='10:14';
      item.lpCaptures[0].lpMinutes[0].dwHAPx5:=554;
  DataEngine.AddItem(item);
  DataEngine.SaveToFile();
  DataEngine.LoadFromFile();

end;

end.
