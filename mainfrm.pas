unit MainFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus, Types;

type

  { TForm1 }

  TForm1 = class(TForm)
    Label1: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Label1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label1MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Label1MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
  private
    ScrollCounter: Integer;
  public

  end;

var
  Form1: TForm1;

implementation

uses JournalFrm;

{$R *.lfm}

{ TForm1 }

procedure TForm1.Label1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    Label1.Caption:='LMB'
  else if Button = mbRight then
    Label1.Caption:='RMB'
  else if Button = mbMiddle then
    Label1.Caption:='MMB'
  else
    Label1.Caption:='???';

  Color:=clYellow;

  ScrollCounter:=0;

  JournalForm.AddString(Label1.Caption + ' pressed');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ScrollCounter:=0;
end;

procedure TForm1.Label1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Color:=clGray;

  JournalForm.AddString(Label1.Caption + ' released');
end;

procedure TForm1.Label1MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Color:=clDefault;

  if ScrollCounter > 0 then
    ScrollCounter:=0;
  Dec(ScrollCounter);

  Label1.Caption:=Format('Scroll Down %d', [Abs(ScrollCounter)]);

  JournalForm.AddString('Scroll Down');
end;

procedure TForm1.Label1MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Color:=clDefault;

  if ScrollCounter < 0 then
    ScrollCounter:=0;
  Inc(ScrollCounter);

  Label1.Caption:=Format('Scroll Up %d', [Abs(ScrollCounter)]);

  JournalForm.AddString('Scroll Up');
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  if MenuItem2.Checked then
    JournalForm.show
  else
    JournalForm.hide;
end;

end.

