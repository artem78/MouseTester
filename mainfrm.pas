unit MainFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  ActnList, Types, DateUtils;

type

  { TMainForm }

  TMainForm = class(TForm)
    ToggleJournalVisibilityAction: TAction;
    ActionList: TActionList;
    InstructionsLabel: TLabel;
    AboutMenuItem: TMenuItem;
    TestAreaLabel: TLabel;
    MainMenu: TMainMenu;
    MainMenuItem: TMenuItem;
    JournalMenuItem: TMenuItem;
    procedure AboutMenuItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TestAreaLabelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TestAreaLabelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TestAreaLabelMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure TestAreaLabelMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure ToggleJournalVisibilityActionExecute(Sender: TObject);
    procedure ToggleJournalVisibilityActionUpdate(Sender: TObject);
  private
    ScrollCounter: Integer;
    LastButtonPressedTime: TDateTime;

    procedure HideInstructions;
    procedure UpdateLastButtonPressedTime;
    class function ButtonToStr(ABtn: TMouseButton): String; static;
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
  HideInstructions;

  TestAreaLabel.Caption := ButtonToStr(Button);

  Color:=clYellow;

  ScrollCounter:=0;

  JournalForm.AddString(TestAreaLabel.Caption + ' pressed');

  UpdateLastButtonPressedTime;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  ScrollCounter:=0;
  LastButtonPressedTime:=0;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  if InstructionsLabel.IsVisible then
    InstructionsLabel.AdjustFontForOptimalFill;
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

  TestAreaLabel.Caption := ButtonToStr(Button);

  Color:=clGray;

  JournalForm.AddString(TestAreaLabel.Caption + ' released');

  UpdateLastButtonPressedTime;
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

procedure TMainForm.ToggleJournalVisibilityActionExecute(Sender: TObject);
begin
  if {JournalMenuItem.Checked} not JournalForm.IsVisible then
    JournalForm.show
  else
    JournalForm.hide;
end;

procedure TMainForm.ToggleJournalVisibilityActionUpdate(Sender: TObject);
begin
  ToggleJournalVisibilityAction.Checked := JournalForm.IsVisible;
end;

procedure TMainForm.HideInstructions;
begin
  InstructionsLabel.Hide;
end;

procedure TMainForm.UpdateLastButtonPressedTime;
const
  ErrMsg = 'Possible false double click detected!';
var
  ButtonPressedTime: TDateTime;
begin
  ButtonPressedTime := Now;

  if MilliSecondsBetween(ButtonPressedTime, LastButtonPressedTime) <= 50 then
  begin
    JournalForm.AddString(ErrMsg);
    MessageDlg(ErrMsg, mtWarning, [mbOK], 0);
  end;
  LastButtonPressedTime := ButtonPressedTime;
end;

class function TMainForm.ButtonToStr(ABtn: TMouseButton): String;
begin
  case ABtn of
    mbLeft:   Exit('Left Button');
    mbMiddle: Exit('Middle Button');
    mbRight:  Exit('Right Button');
  else
    Exit('Unknown Button');
  end;
end;

end.

