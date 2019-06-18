unit uAbout;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, RzBckgnd;

type
  TfrmAbout = class(TForm)
    pnlAbout: TPanel;
    imgIcon: TImage;
    lblPro: TLabel;
    lblVer: TLabel;
    lblRight: TLabel;
    btnOk: TButton;
    lblInfo: TLabel;
    rsTop: TRzSeparator;
    rsBottom: TRzSeparator;
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

function ShowAbout(): Boolean;

implementation

uses uGlobal, uApp;

{$R *.dfm}

function ShowAbout(): Boolean;
begin
  with TfrmAbout.Create(Application.MainForm) do
  begin
    try
      imgIcon.Picture.Icon := Application.Icon;
      lblPro.Caption := lblPro.Caption + ' ' + App.Caption;
      lblVer.Caption := lblVer.Caption + ' ' + App.Version;
      if App.RegType = rtNone then
      begin
        lblInfo.Left := 16;
        lblInfo.Font.Color := clGreen;
        lblInfo.Caption := 'Èí¼þÒÑ×¢²á¸ø£º' + App.RegMail;
      end
      else
      begin
        lblInfo.Left := 72;
        lblInfo.Font.Color := clMaroon;
        lblInfo.Caption := 'Î´×¢²á°æ±¾';
      end;

      Result := ShowModal() = mrOk;
    finally
      Free;
    end;
  end;
end;

procedure TfrmAbout.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  if (Msg.CharCode = VK_ESCAPE) and (fsModal in FormState) then ModalResult := mrCancel;
end;

end.
 
