unit uChgPwd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ADODB, ExtCtrls, uBase;

type
  TfrmChgPwd = class(TfrmBase)
    lblOld: TLabel;
    lblNew: TLabel;
    edtOld: TEdit;
    edtNew: TEdit;
    img: TImage;
    Label3: TLabel;
    lblConfirm: TLabel;
    edtConfirm: TEdit;
  private
    { Private declarations }
  protected
    //���ݲ�������
    procedure SaveData; override;
    //�������
    function CheckData: Boolean; override;
  public
    { Public declarations }
  end;

var
  frmChgPwd: TfrmChgPwd;

function ShowChgPwd(): Boolean;

implementation

uses uGlobal, uData;

{$R *.dfm}

function ShowChgPwd(): Boolean;
begin
  with TfrmChgpwd.Create(Application.MainForm) do
  begin
    imgHelp.Visible := False;
    try
      Result := ShowModal() = mrOk;
    finally
      Free;
    end;
  end;
end;

procedure TfrmChgPwd.SaveData;
begin
  dmPer.ExecSQL('UPDATE [admin] SET pwd=' + QuotedStr(edtNew.Text) + ' WHERE uid=' + QuotedStr(App.UserID));
  MessageBox(Handle, '���������ѳɹ����¡�', '��ʾ',  MB_ICONINFORMATION + MB_OK);
  App.UserPwd := edtNew.Text;
  Log.Write(App.UserID + '��������ɹ�');

  ModalResult := mrOk;
end;

{frmChgPwd}

function TfrmChgPwd.CheckData: Boolean;
begin
  Result := False;

  if edtOld.Text <> App.UserPwd then
  begin
    MessageBox(Handle, 'ԭ�������������ȷ��', '��ʾ',  MB_ICONINFORMATION + MB_OK);
    edtOld.SetFocus;
    Exit;
  end;

  if not SameText(edtNew.Text, edtConfirm.Text) then
  begin
    MessageBox(Handle, '�������ȷ�������������벻һ�£�', '��ʾ',  MB_ICONWARNING + MB_OK);
    edtConfirm.SetFocus;
    Exit;
  end;

  Result := inherited CheckData();
end;

end.
