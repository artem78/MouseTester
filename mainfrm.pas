unit MainFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus, Types;

type

  { TMainForm }

  TMainForm = class(TForm)
    TestAreaLabel: TLabel;
    MainMenu: TMainMenu;
    MainMenuItem: TMenuItem;
    JournalMenuItem: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure TestAreaLabelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TestAreaLabelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TestAreaLabelMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure TestAreaLabelMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure MainMenuItemClick(Sender: TObject);
    procedure JournalMenuItemClick(Sender: TObject);
  private
    ScrollCounter: Integer;
  public

  end;

var
  MainForm: TMainForm;

implementation

uses JournalFrm;

{$R *.lfm}

{ TMainForm }

procedure TMainForm.TestAreaLabelMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    TestAreaLabel.Caption:='LMB'
  else if Button = mbRight then
    TestAreaLabel.Caption:='RMB'
  else if Button = mbMiddle then
    TestAreaLabel.Caption:='MMB'
  else
    TestAreaLabel.Caption:='???';

  Color:=clYellow;

  ScrollCounter:=0;

  JournalForm.AddString(TestAreaLabel.Caption + ' pressed');
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  ScrollCounter:=0;
end;

procedure TMainForm.TestAreaLabelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Color:=clGray;

  JournalForm.AddString(TestAreaLabel.Caption + ' released');
end;

procedure TMainForm.TestAreaLabelMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Color:=clSkyBlue;

  if ScrollCounter > 0 then
    ScrollCounter:=0;
  Dec(ScrollCounter);

  TestAreaLabel.Caption:=Format('Scroll Down %d', [Abs(ScrollCounter)]);

  JournalForm.AddString('Scroll Down');
end;

procedure TMainForm.TestAreaLabelMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Color:=clSkyBlue;

  if ScrollCounter < 0 then
    ScrollCounter:=0;
  Inc(ScrollCounter);

  TestAreaLabel.Caption:=Format('Scroll Up %d', [Abs(ScrollCounter)]);

  JournalForm.AddString('Scroll Up');
end;

procedure TMainForm.MainMenuItemClick(Sender: TObject);
begin

end;

procedure TMainForm.JournalMenuItemClick(Sender: TObject);
begin
  if JournalMenuItem.Checked then
    JournalForm.show
  else
    JournalForm.hide;
end;

end.

