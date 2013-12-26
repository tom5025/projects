unit WaitingTime;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmWaitingTime = class(TForm)
    gbWaitingTime: TGroupBox;
    tbWaitingTime: TEdit;
    btOk: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmWaitingTime: TFrmWaitingTime;

implementation

uses Main;

{$R *.dfm}

end.
