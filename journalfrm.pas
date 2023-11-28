unit JournalFrm;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TJournalForm }

  TJournalForm = class(TForm)
    JournalMemo: TMemo;
    procedure FormCreate(Sender: TObject);
  private

  public
    procedure AddString(S: string);
  end;

var
  JournalForm: TJournalForm;

implementation

uses LCLIntf, JwaWinUser;
{$R *.lfm}

{ TJournalForm }

procedure TJournalForm.FormCreate(Sender: TObject);
var
  m: TMonitor;
begin
  m:=Screen.MonitorFromWindow(self.Handle);
  Left:=m.Width-BoundsRect.Width-30;
  Top:=m.Height-BoundsRect.Height-80;
end;

procedure TJournalForm.AddString(S: string);
begin
  BringToFront;
  JournalMemo.Append(Format('[%s]   %s', [FormatDateTime('hh:nn:ss.zzz', now), S]));
  //JournalMemo.ScrollBy(0, 99999);
  SendMessage(JournalMemo.Handle, EM_LINESCROLL, 0,JournalMemo.Lines.Count);
end;

end.

