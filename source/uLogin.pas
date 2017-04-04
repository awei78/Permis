unit uLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ADODB, uBase, ExtCtrls, CtrlsEx;

type
  TfrmLogin = class(TfrmBase)
    lblOld: TLabel;
    lblNew: TLabel;
    cbId: TComboBox;
    edtPwd: TEdit;
    img: TImage;
    Label3: TLabel;
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure InitData; override;
  public
    { Public declarations }
  end;

function ShowLogin(): Boolean;

var
  frmLogin: TfrmLogin;

implementation

uses uGlobal, uData, uApp, DateUtils;

{$R *.dfm}

function ShowLogin(): Boolean;
begin
  with TfrmLogin.Create(Application.MainForm) do
  begin
    HelpHtml := 'login.html';
    imgHelp.Visible := False;
    //重登录情况
    if Assigned(Application.MainForm) and Application.MainForm.Visible then
      Application.MainForm.Hide
    else SetWindowLong(Application.Handle, GWL_EXSTYLE, GetWindowLong(Application.Handle, GWL_EXSTYLE) or not WS_EX_APPWINDOW);
    //显示于任务栏上
    SetWindowLong(Handle, GWL_HWNDPARENT, HWND_DESKTOP);

    try
      InitData();
      Result := ShowModal() = mrOk;
      if Result then
      begin
        if Assigned(Application.MainForm) and not Application.MainForm.Visible then
          Application.MainForm.Show
      end
      else if Application.Active then Application.Terminate;
    finally
      Free;
    end;
  end;
end;

procedure TfrmLogin.InitData;
begin
  with dmPer do
  begin
    dmPer.OpenQuery(aqTemp, 'SELECT uid FROM [admin] ORDER BY lgTime DESC, uid');
    while not aqTemp.Eof do
    begin
      cbId.Items.Append(aqTemp.FieldByName('uid').AsString);
      aqTemp.Next;
    end;
    if cbId.Items.Count <> 0 then cbId.ItemIndex := 0;
  end;
end;

procedure TfrmLogin.btnOkClick(Sender: TObject);
var
  aqLogin: TADOQuery;
  sSql: string;
begin
  if Trim(cbId.Text) = '' then
  begin
    MessageBox(Handle, '请输入管理员帐号登录！', '提示',  MB_ICONINFORMATION + MB_OK);
    cbId.SetFocus;
    Exit;
  end;

  aqLogin := TADOQuery.Create(Self);
  try
    if edtPwd.Text = '' then
      sSql := 'SELECT * FROM [admin] WHERE uid=' + QuotedStr(cbId.Text) + ' AND (pwd=' + QuotedStr(edtPwd.Text) + ' OR pwd IS NULL)'
    else sSql := 'SELECT * FROM [admin] WHERE uid=' + QuotedStr(cbId.Text) + ' AND pwd=' + QuotedStr(edtPwd.Text);
    dmPer.OpenQuery(aqLogin, sSql);
    if aqLogin.RecordCount = 0 then
    begin
      MessageBox(Handle, '您输入的帐号或密码有误，请重新输入', '提示',  MB_ICONWARNING + MB_OK);
      cbId.SetFocus;
    end
    else if not aqLogin.FieldByName('inUse').AsBoolean then
    begin
      MessageBox(Handle, '您输入的帐号已被管理员禁用，请用其它帐号输入', '提示',  MB_ICONWARNING + MB_OK);
      cbId.SetFocus;
    end
    else
    begin
      //最后登录时间
      aqLogin.Edit;
      aqLogin.FieldByName('lgTime').AsDateTime := Now();
      aqLogin.Post;
      aqLogin.UpdateBatch();

      App.UserID := cbId.Text;
      App.UserPwd := edtPwd.Text;
      App.AdminType := TAdminType(aqLogin.FieldByName('type').AsInteger);
      Log.Write(ADMIN_TYPE[Ord(App.AdminType)] + '[' + App.UserID + ']登录系统');

      ModalResult := mrOk;
    end;
  finally
    aqLogin.Free;
  end;
end;

end.
