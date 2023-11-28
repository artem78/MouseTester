unit AboutFrm;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TAboutForm }

  TAboutForm = class(TForm)
    VersionTitleLabel: TLabel;
    HomePageValueLabel: TLabel;
    AuthorValueLabel3: TLabel;
    AuthorValueLabel2: TLabel;
    ProgramNameLabel: TLabel;
    ProgramDescriptionLabel: TLabel;
    VersionValueLabel: TLabel;
    BuildDateTitleLabel: TLabel;
    BuildDateValueLabel: TLabel;
    AuthorTitleLabel: TLabel;
    AuthorValueLabel1: TLabel;
    LicenseTitleLabel: TLabel;
    LicenseValueLabel: TLabel;
    HomePageTitleLabel: TLabel;
    TopPanel: TPanel;
    PropertiesPanel: TPanel;
    AuthorPanel: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure HomePageValueLabelClick(Sender: TObject);
    procedure AuthorValueLabel2Click(Sender: TObject);
  private

  public

  end;

var
  AboutForm: TAboutForm;

implementation

uses LCLIntf, FileInfo, DateUtils;

{$R *.lfm}

{ TAboutForm }

procedure TAboutForm.HomePageValueLabelClick(Sender: TObject);
begin
  OpenURL(TLabel(Sender).Caption + '#Readme');
end;

procedure TAboutForm.FormCreate(Sender: TObject);
var
  FileVerInfo: TFileVersionInfo;
begin
  FileVerInfo := TFileVersionInfo.Create(Nil);
  try
    FileVerInfo.ReadFileInfo;
    with FileVerInfo.VersionStrings do
    begin
      Caption := 'About "' + Values['ProductName'] + '"';
      ProgramNameLabel.Caption := Values['ProductName'];
      ProgramDescriptionLabel.Caption := Values['FileDescription'];
      VersionValueLabel.Caption := Values['FileVersion'];
    end;

    BuildDateValueLabel.Caption := DateToStr(EncodeDateTime({$I %dateYear%}, {$I %dateMonth%}, {$I %dateDay%},
            {$I %timeHour%}, {$I %timeMinute%}, {$I %timeSecond%}, 0));
  finally
    FileVerInfo.Free;
  end;
end;

procedure TAboutForm.AuthorValueLabel2Click(Sender: TObject);
begin
  OpenURL('mailto:' + TLabel(Sender).Caption + '?subject=Mouse%20Tester');
end;

end.

