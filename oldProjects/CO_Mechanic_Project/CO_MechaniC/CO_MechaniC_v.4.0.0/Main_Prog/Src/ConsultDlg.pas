unit ConsultDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Menus;

type
  TFrmConsult = class(TForm)
    gbConsult: TGroupBox;
    sbConsult: TStatusBar;
    lsvJours: TListView;
    PopupMenu: TPopupMenu;
    mDeleteSel: TMenuItem;
    N1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddLsvItem(sDate,sCaptureCount:string);
  end;

var
  FrmConsult: TFrmConsult;

implementation

{$R *.dfm}

uses DBUtils;

//utils
procedure TFrmConsult.AddLsvItem(sDate,sCaptureCount:string);
var
  itemtoadd:tlistitem;
begin
  itemtoadd:=lsvJours.Items.add;
  itemtoadd.caption:=sDate;
  itemToAdd.SubItems.Add(sCaptureCount);
end;

procedure TFrmConsult.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

end.
