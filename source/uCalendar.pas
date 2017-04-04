unit uCalendar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzPanel, RzButton, ExtCtrls, ActnList, ImgList, Grids, DBGrids,
  ComCtrls, StdCtrls, DBCtrls, Mask, DB, ADODB, CtrlsEx, OleCtrls, SHDocVw;

type
  TfrmCalendar = class(TForm)
    wbCal: TWebBrowser;
    procedure FormCreate(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
  private
    { Private declarations }
    //使模式窗点可闪标题栏
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
  public
    { Public declarations }
  end;

var
  frmCalendar: TfrmCalendar;

function ShowCalendar(): Boolean;

implementation

uses uData, uGlobal;

{$R *.dfm}

function ShowCalendar(): Boolean;
begin
  Result := True;

  if not Assigned(frmCalendar) then frmCalendar := TfrmCalendar.Create(Application.MainForm);
  if frmCalendar.WindowState = wsMinimized then
    frmCalendar.WindowState := wsNormal;
  frmCalendar.Show();
end;

procedure TfrmCalendar.WMSetCursor(var Msg: TWMSetCursor);
begin
  if (SmallInt(Msg.HitTest) = HTERROR) and (Msg.MouseMsg = WM_LBUTTONDOWN) then
    DefaultHandler(Msg)
  else inherited;
end;

procedure TfrmCalendar.FormCreate(Sender: TObject);
begin
  SetWindowLong(Handle, GWL_HWNDPARENT, HWND_DESKTOP);

  wbCal.Navigate(App.Path + 'calendar.html');
end;

procedure TfrmCalendar.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  if Msg.CharCode = VK_ESCAPE then Close();
end;

end.
