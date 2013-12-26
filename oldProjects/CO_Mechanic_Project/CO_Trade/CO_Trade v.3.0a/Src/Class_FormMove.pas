unit Class_FormMove;


interface

uses windows,Controls,classes,ExtCtrls,Forms;

  type
    TMoveForm = class
    private
      StartCursPos,StartWindowPos:TPoint;
      CanMove:boolean;
      FForm:tfOrm;
    public
      constructor Create(Comp:TPanel;Form:TForm);
      procedure FormMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
      procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
      procedure FormMouseUp(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    end;

implementation

constructor TMoveForm.create(Comp:TPanel;Form:TForm);
begin
  Comp.OnMouseDown:=FormMouseDown;
  Comp.OnMouseMove:=FormMouseMove;
  Comp.OnMouseUp:=FormMouseUp;
  FForm:=Form;
end;

procedure TMoveForm.FormMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
begin
  canmove:=true;
  startwindowpos:=point(FForm.Left,FForm.Top);
  getcursorpos(startcurspos);
end;

procedure TMoveForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  if CanMove then begin
    FForm.left:=StartWindowPos.X + (mouse.CursorPos.X - startcurspos.X);
    FForm.Top:=StartWindowPos.Y + (mouse.CursorPos.Y - startcurspos.Y);
  end;
end;

procedure TMoveForm.FormMouseUp(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
begin
  canMove:=false;
end;


end.
