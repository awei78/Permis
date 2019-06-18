unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, XPMan, ExtCtrls, Buttons;

type
  TfrmMain = class(TForm)
    bvl: TBevel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    imgReg: TImage;
    edtMail: TEdit;
    edtCode: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses IniFiles, md5;

const QUIZ_REG_SEED = '呦呦鹿鸣，食野之苹；我有嘉宾，鼓瑟吹笙';

var
  ini: TIniFile;

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'reg.ini');
  if ini.ValueExists('RegCode', 'mail') then edtMail.Text := ini.ReadString('RegCode', 'mail', 'quiz@awindsoft.net');
  if ini.ValueExists('RegCode', 'code') then edtCode.Text := ini.ReadString('RegCode', 'code', '');
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Trim(edtMail.Text) <> '' then ini.WriteString('RegCode', 'mail', edtMail.Text);
  if Trim(edtCode.Text) <> '' then ini.WriteString('RegCode', 'code', edtCode.Text);
  ini.Free;
end;

procedure TfrmMain.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  if Msg.CharCode = VK_ESCAPE then
  begin
    Handled := True;
    btnCancelClick(btnCancel);
  end;
end;

procedure TfrmMain.btnOKClick(Sender: TObject);
  function GetMidCode(const s: string): string;
  var
    sMid: string;
    i: Integer;
  begin
    sMid := UpperCase(MD5Print(MD5String(s)));
    for i := 1 to Length(sMid) do
      if i Mod 8 = 0 then Result := Result + sMid[i];
  end;

var
  s, sCode: string;
  i: Integer;
begin
  if (Pos('@', edtMail.Text) < 2) or (Pos('.', edtMail.Text) < 4) then
  begin
    MessageBox(Handle, '邮件地址不正确，请重新输入', '提示', MB_OK + MB_ICONINFORMATION);
    edtMail.SetFocus;
    Exit;
  end;

  s := UpperCase(MD5Print(MD5String('780927+' + Trim(edtMail.Text) + '+790621')));
  for i := 1 to Length(s) do
    if not Odd(i) then sCode := sCode + s[i];

  sCode := Copy(sCode, 1, 8) + GetMidCode(QUIZ_REG_SEED + Trim(edtMail.Text) + QUIZ_REG_SEED) + Copy(sCode, 9, 8);
  edtCode.Text := sCode;
end;

procedure TfrmMain.btnCancelClick(Sender: TObject);
begin
  Close;
end;

end.
