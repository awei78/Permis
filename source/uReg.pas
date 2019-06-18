unit uReg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ShellAPI, uBase;

type
  TfrmReg = class(TfrmBase)
    Label1: TLabel;
    Label2: TLabel;
    edtMail: TEdit;
    edtCode: TEdit;
    Label3: TLabel;
    imgReg: TImage;
  private
    { Private declarations }
  protected
    procedure SaveData; override;
    //检查数据
    function CheckData: Boolean; override;
  public
    { Public declarations }
  end;

var
  frmReg: TfrmReg;

function ShowReg(): Boolean;

implementation

uses uGlobal, uMain;

{$R *.dfm}

function ShowReg(): Boolean;
begin
  with TfrmReg.Create(Application.MainForm) do
  begin
    imgHelp.Visible := False;
    try
      Result := ShowModal() = mrOk;
    finally
      Free;
    end;
  end;
end;

{ TfrmReg }

function TfrmReg.CheckData: Boolean;
begin
  Result := False;
  if (Pos('@', edtMail.Text) < 2) or (Pos('.', edtMail.Text) < 4) then
  begin
    MessageBox(Handle, '邮件地址不正确，请重新输入', '提示', MB_OK + MB_ICONINFORMATION);
    edtMail.SetFocus;
    Exit;
  end;
  if Trim(edtCode.Text) = '' then
  begin
    MessageBox(Handle, '请输入注册码', '提示', MB_OK + MB_ICONINFORMATION);
    edtMail.SetFocus;
    Exit;
  end;
  if not CheckRegCode(Trim(edtMail.Text), Trim(edtCode.Text)) then
  begin
    MessageBox(Handle, '您输入的邮件与注册码不正确，请重新输入', '提示', MB_OK + MB_ICONWARNING);
    edtMail.SetFocus;
    Exit;
  end
  else
  begin
    frmMain.actReg.Visible := False;
    frmMain.Caption := StringReplace(frmMain.Caption, '(未注册版)', '', []);
    Result := inherited CheckData;

    MessageBox(Handle, '注册成功，感谢您使用CR软件', '提示', MB_OK + MB_ICONINFORMATION);
    ShellExecute(Handle, 'open', PAnsiChar('http://www.cr-soft.net/reg.asp?act=reg&pid=1&mail='
      + edtMail.Text + '&code=' + edtCode.Text + '&ver=' + App.Version), nil, nil, SW_NORMAL);

    Log.Write(App.UserID + '注册了' + App.Caption + ' v' + App.Version);
  end;
end;

procedure TfrmReg.SaveData;
begin
  App.RegMail := edtMail.Text;
  App.RegCode := edtCode.Text;
end;

end.
