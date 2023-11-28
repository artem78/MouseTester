unit JournalFrm;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TJournalForm }

  TJournalForm = class(TForm)
    Memo1: TMemo;
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
  Memo1.Append(Format('[%s]   %s', [FormatDateTime('hh:nn:ss.zzz', now), S]));
  //Memo1.ScrollBy(0, 99999);
  SendMessage(Memo1.Handle, EM_LINESCROLL, 0,Memo1.Lines.Count);
end;

end.

