unit uAddAdmin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBase, StdCtrls, Buttons, ExtCtrls, ComCtrls, ADODB;

type
  TfrmAddAdmin = class(TfrmBase)
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    edtId: TEdit;
    edtPwd: TEdit;
    cbType: TComboBox;
    Label5: TLabel;
    meoDes: TMemo;
    cbUse: TCheckBox;
    Label6: TLabel;
  private
    { Private declarations }
    FEditMode: Boolean;
    FListView: TListView;
  protected
    //数据操作过程
    procedure LoadData; override;
    procedure SaveData; override;
    //检查数据
    function CheckData: Boolean; override;
  public
    { Public declarations }
  end;

var
  frmAddAdmin: TfrmAddAdmin;

function ShowAddAdmin(AListView: TListView; AEditMode: Boolean = False): Boolean;

implementation

uses uData, uGlobal;

{$R *.dfm}

function ShowAddAdmin(AListView: TListView; AEditMode: Boolean): Boolean;
begin
  with TfrmAddAdmin.Create(Application) do
  begin
    FEditMode := AEditMode;
    FListView := AListView;
    if FEditMode then
      Caption := '编辑管理员'
    else Caption := '添加管理员';

    imgHelp.Visible := False;
    try
      LoadData();
      Result := ShowModal() = mrOk;
    finally
      Free;
    end;
  end;
end;

procedure TfrmAddAdmin.LoadData;
var
  aqAdmin: TADOQuery;
  id: Integer;
begin
  if not FEditMode then Exit;

  aqAdmin := TADOQuery.Create(Self);
  try
    id := Integer(FListView.Selected.Data);
    dmPer.OpenQuery(aqAdmin, 'SELECT * FROM [admin] WHERE id=' + IntToStr(id));
    if aqAdmin.RecordCount <> 0 then
    begin
      edtId.Text := aqAdmin.FieldByName('uid').AsString;
      edtPwd.Text := aqAdmin.FieldByName('pwd').AsString;
      cbType.ItemIndex := aqAdmin.FieldByName('type').AsInteger;
      cbUse.Checked := aqAdmin.FieldByName('inUse').AsBoolean;
      meoDes.Text := aqAdmin.FieldByName('des').AsString;
    end;
  finally
    aqAdmin.Free;
  end;
end;

procedure TfrmAddAdmin.SaveData;
var
  id: Integer;
begin
  if FEditMode then  //编辑
  begin
    id := Integer(FListView.Selected.Data);
    dmPer.ExecSQL('UPDATE [admin] SET uid=' + QuotedStr(Trim(edtId.Text)) + ', pwd=' + QuotedStr(edtPwd.Text) +
      ', type=' + IntToStr(cbType.ItemIndex) + ', inUse=' + BoolToStr(cbUse.Checked, True) + ', des=' + QuotedStr(meoDes.Text) + ' WHERE id=' + IntToStr(id));

    //更新列表信息
    with FListView.Selected do
    begin
      Caption := Trim(edtId.Text);
      SubItems[0] := cbType.Text;
      if cbUse.Checked then
        SubItems[1] := '启用'
      else SubItems[1] := '禁用';
      SubItems[2] := meoDes.Text;
    end;
    Log.Write('更新了' + ADMIN_TYPE[cbType.ItemIndex] + '[' + edtId.Text + ']');
  end
  else  //添加
  begin
    dmPer.ExecSQL('INSERT INTO [admin](uid, pwd, type, inUse, des) VALUES(' + QuotedStr(Trim(edtId.Text)) + ', ' + QuotedStr(edtPwd.Text) +
      ', ' + IntToStr(cbType.ItemIndex) + ', ' + BoolToStr(cbUse.Checked, True) + ', ' + QuotedStr(meoDes.Text) + ')');

    //获取其ID，生成新的列表项
    id := StrToIntDef(VarToStr(dmPer.GetFieldValue('SELECT @@identity AS id FROM [admin]', 'id')), 0);
    with FListView.Items.Add do
    begin
      Caption := Trim(edtId.Text);
      SubItems.Append(cbType.Text);
      if cbUse.Checked then
        SubItems.Append('启用')
      else SubItems.Append('禁用');
      SubItems.Append(meoDes.Text);
      ImageIndex := 8;

      //以Data记录对应试题
      Data := PInteger(id);
    end;

    Log.Write(App.UserID + '添加了' + ADMIN_TYPE[cbType.ItemIndex] + '[' + edtId.Text + ']');
  end;
end;

function TfrmAddAdmin.CheckData: Boolean;
var
  i: Integer;
  ListItem: TListItem;
begin
  Result := False;

  if Trim(edtId.Text) = '' then
  begin
    MessageBox(Handle, '管理员的用户名不能为空，请输入！', '提示',  MB_ICONINFORMATION + MB_OK);
    edtId.SetFocus;
    Exit;
  end;

  //是否已存在
  for i := 0 to FListView.Items.Count - 1 do
  begin
    ListItem := FListView.Items[i];
    if SameText(Trim(edtId.Text), ListItem.Caption) and (not FEditMode or FEditMode and (ListItem <> FListView.Selected)) then
    begin
      MessageBox(Handle, '此管理员帐号已存在，请重新设定', '提示',  MB_ICONWARNING + MB_OK);
      edtId.SetFocus;
      Result := False;
      Exit;
    end;
  end;

  Result := inherited CheckData();
end;

end.
