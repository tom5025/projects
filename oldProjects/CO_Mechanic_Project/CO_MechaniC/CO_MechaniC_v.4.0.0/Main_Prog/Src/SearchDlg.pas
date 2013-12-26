unit SearchDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmSearch = class(TForm)
    tbDate: TEdit;
    lblDate: TLabel;
    btSearch: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSearch: TFrmSearch;

implementation

{$R *.dfm}

uses dbutils, ConsultDlg, MainDlg;

end.
