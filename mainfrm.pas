unit MainFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus, Types;

type

  { TMainForm }

  TMainForm = class(TForm)
    InstructionsLabel: TLabel;
    AboutMenuItem: TMenuItem;
    TestAreaLabel: TLabel;
    MainMenu: TMainMenu;
    MainMenuItem: TMenuItem;
    JournalMenuItem: TMenuItem;
    procedure AboutMenuItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TestAreaLabelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TestAreaLabelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TestAreaLabelMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure TestAreaLabelMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure JournalMenuItemClick(Sender: TObject);
  private
    ScrollCounter: Integer;
    procedure HideInstructions;
  public

  end;

var
  MainForm: TMainForm;

implementation

uses JournalFrm, AboutFrm;

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

procedure TMainForm.AboutMenuItemClick(Sender: TObject);
var
  AboutForm: TAboutForm;
begin
  AboutForm := TAboutForm.Create(Self);
  AboutForm.ShowModal;
  AboutForm.Free;
end;

procedure TMainForm.TestAreaLabelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  HideInstructions;

  Color:=clGray;

  JournalForm.AddString(TestAreaLabel.Caption + ' released');
end;

procedure TMainForm.TestAreaLabelMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  HideInstructions;

  Color:=clSkyBlue;

  if ScrollCounter > 0 then
    ScrollCounter:=0;
  Dec(ScrollCounter);

  TestAreaLabel.Caption:=Format('Scroll Down %d', [Abs(ScrollCounter)]);

  JournalForm.AddString('Scroll Down');

  Handled:=True;
end;

procedure TMainForm.TestAreaLabelMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  HideInstructions;

  Color:=clSkyBlue;

  if ScrollCounter < 0 then
    ScrollCounter:=0;
  Inc(ScrollCounter);

  TestAreaLabel.Caption:=Format('Scroll Up %d', [Abs(ScrollCounter)]);

  JournalForm.AddString('Scroll Up');

  Handled:=True;
end;

procedure TMainForm.JournalMenuItemClick(Sender: TObject);
begin
  if JournalMenuItem.Checked then
    JournalForm.show
  else
    JournalForm.hide;
end;

procedure TMainForm.HideInstructions;
begin
  InstructionsLabel.Hide;
end;

end.

