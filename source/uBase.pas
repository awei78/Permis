{******
  单 元：uBase
  作 者：刘景威
  日 期：2008-07-15
  说 明：模式窗体基类
  更 新：
******}

unit uBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmBase = class(TForm)
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    bvl: TBevel;
    imgHelp: TImage;
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure imgHelpClick(Sender: TObject);
  private
    { Private declarations }
    //提示框窗体可闪标题栏
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
  protected
    //数据操作过程...
    procedure InitData; virtual;
    procedure LoadData; virtual;
    procedure SaveData; virtual;
    procedure ResetData; virtual;
    //检查数据
    function CheckData: Boolean; virtual;  
  public
    { Public declarations }
    HelpHtml: string;
  end;

var
  frmBase: TfrmBase;

implementation

uses uGlobal;

{$R *.dfm}

{ TfrmBase }

procedure TfrmBase.WMSetCursor(var Msg: TWMSetCursor);
begin
  if (SmallInt(Msg.HitTest) = HTERROR) and (Msg.MouseMsg = WM_LBUTTONDOWN) then
    DefaultHandler(Msg)
  else inherited;
end;

procedure TfrmBase.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  case Msg.CharCode of
    VK_F1: imgHelp.OnClick(imgHelp);
    VK_ESCAPE:
      if fsModal in FormState then ModalResult := mrCancel;
  end;
end;

procedure TfrmBase.InitData;
begin
  //
end;

procedure TfrmBase.LoadData;
begin
  //
end;

procedure TfrmBase.SaveData;
begin
  //
end;

procedure TfrmBase.ResetData;
begin
  //
end;

function TfrmBase.CheckData: Boolean;
begin
  Result := True;
end;

procedure TfrmBase.btnOKClick(Sender: TObject);
begin
  if CheckData() then
  begin
    SaveData();
    ModalResult := mrOk;
  end;
end;

procedure TfrmBase.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmBase.imgHelpClick(Sender: TObject);
begin
  if HelpHtml <> '' then HtmlHelp(Application.Handle, App.Path + 'help.chm::/' + HelpHtml, HH_DISPLAY_TOPIC, 0);
end;

end.
