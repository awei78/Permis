unit uNeedPwd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ADODB, ExtCtrls, uBase;

type
  TfrmNeedPwd = class(TfrmBase)
    lblOld: TLabel;
    edtPwd: TEdit;
    img: TImage;
    Label3: TLabel;
  private
    { Private declarations }
  protected
    //数据操作过程
    function CheckData: Boolean; override;
  public
    { Public declarations }
  end;

var
  frmNeedPwd: TfrmNeedPwd;

function ShowNeedPwd(): Boolean;

implementation

uses uGlobal, uData;

{$R *.dfm}

function ShowNeedPwd(): Boolean;
begin
  Result := App.UserPwd = '';
  if Result then Exit;

  with TfrmNeedPwd.Create(Application.MainForm) do
  begin
    imgHelp.Visible := False;
    try
      Result := ShowModal() = mrOk;
    finally
      Free;
    end;
  end;
end;

function TfrmNeedPwd.CheckData: Boolean;
begin
  Result := False;
  if edtPwd.Text <> App.UserPWD then
  begin
    MessageBox(Handle, '您的输入的密码不正确，请再次输入！', '提示',  MB_ICONINFORMATION + MB_OK);
    edtPwd.SetFocus;
    Exit;
  end;

  Result := inherited CheckData();
end;

end.
