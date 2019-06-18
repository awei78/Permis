unit uAdmin;

interface

uses               
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBase, ComCtrls, StdCtrls, Buttons, ExtCtrls, DB, ADODB;

type
  TfrmAdmin = class(TfrmBase)
    aqAdmin: TADOQuery;
    img: TImage;
    Label3: TLabel;
    lvAdmin: TListView;
    btnAdd: TBitBtn;
    btnEdit: TBitBtn;
    btnDel: TBitBtn;
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure lvAdminClick(Sender: TObject);
    procedure lvAdminCustomDrawSubItem(Sender: TCustomListView;
      Item: TListItem; SubItem: Integer; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure lvAdminDblClick(Sender: TObject);
    procedure lvAdminSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvAdminKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FLastIndex: Integer;
    procedure SetState;
  protected
    //���ݲ�������
    procedure LoadData; override;
  public
    { Public declarations }
  end;

var
  frmAdmin: TfrmAdmin;

function ShowAdmin(): Boolean;

implementation

uses uData, uGlobal, uAddAdmin;

{$R *.dfm}

function ShowAdmin(): Boolean;
begin
  with TfrmAdmin.Create(Application.MainForm) do
  begin
    HelpHtml := 'admin.html';
    FLastIndex := -1;
    try
      LoadData();
      SetState();
      Result := ShowModal() = mrOk;
    finally
      Free;
    end;
  end;
end;

procedure TfrmAdmin.SetState();
begin
  btnEdit.Enabled := lvAdmin.Selected <> nil;
  btnDel.Enabled := lvAdmin.Selected <> nil;
end;

procedure TfrmAdmin.LoadData;
var
  i: Integer;
begin
  dmPer.OpenQuery(aqAdmin, 'SELECT * FROM [admin]');
  if aqAdmin.RecordCount = 0 then Exit;

  //���ListView
  for i := 0 to aqAdmin.RecordCount - 1 do
  begin
    with lvAdmin.Items.Add do
    begin
      Caption := aqAdmin.FieldByName('uid').AsString;
      SubItems.Append(ADMIN_TYPE[aqAdmin.FieldByName('type').asInteger]);
      if aqAdmin.FieldByName('inUse').AsBoolean then
        SubItems.Append('����')
      else SubItems.Append('����');
      SubItems.Append(aqAdmin.FieldByName('des').AsString);
      ImageIndex := 8;

      //��Data��¼��Ӧ����
      Data := PInteger(aqAdmin.FieldByName('id').AsInteger);
    end;
    aqAdmin.Next;
  end;

  lvAdmin.Items[0].Selected := True;
end;

procedure TfrmAdmin.btnAddClick(Sender: TObject);
begin
  if ShowAddAdmin(lvAdmin) and (lvAdmin.Items.Count = 1) then
    lvAdmin.Items[0].Selected := True;
end;

procedure TfrmAdmin.btnEditClick(Sender: TObject);
begin
  if lvAdmin.Selected <> nil then ShowAddAdmin(lvAdmin, True);
end;

procedure TfrmAdmin.btnDelClick(Sender: TObject);
var
  id: Integer;
begin
  id := Integer(lvAdmin.Selected.Data);
  if lvAdmin.Items.Count = 1 then
  begin
    MessageBox(Handle, 'ϵͳ����ֻ��һ������Ա��������ɾ��', '��ʾ',  MB_ICONWARNING + MB_OK);
    dmPer.ExecSQL('UPDATE [admin] SET type=0 WHERE id=' + IntToStr(id));
    lvAdmin.Selected.SubItems[0] := 'ϵͳ����Ա';
  end
  else if (lvAdmin.Selected <> nil) and (MessageBox(Handle, '��ȷ��Ҫɾ����ǰѡ���Ĺ���Ա��', '��ʾ',  MB_ICONQUESTION + MB_YESNO) = IDYES) then
  begin
    dmPer.ExecSQL('DELETE FROM [admin] WHERE id=' + IntToStr(id));

    Log.Write(App.UserID + 'ɾ���˹���Ա' + lvAdmin.Selected.SubItems[0] + '[' + lvAdmin.Selected.Caption + ']');
    lvAdmin.DeleteSelected;
    if lvAdmin.ItemFocused <> nil then
      lvAdmin.ItemFocused.Selected := True
    else lvAdmin.Items[0].Selected := True;
    lvAdmin.SetFocus;

    if lvAdmin.Items.Count = 1 then
    begin
      id := Integer(lvAdmin.Selected.Data);
      dmPer.ExecSQL('UPDATE [admin] SET type=0 WHERE id=' + IntToStr(id));
      lvAdmin.Selected.SubItems[0] := 'ϵͳ����Ա';
    end;
  end;
end;

procedure TfrmAdmin.lvAdminClick(Sender: TObject);
begin
  if (lvAdmin.Selected = nil) and (lvAdmin.Items.Count <> 0) and (FLastIndex <= lvAdmin.Items.Count - 1) and (FLastIndex <> -1) then
  begin
    lvAdmin.ItemIndex := FLastIndex;
    lvAdmin.Selected.Focused := True;
  end;
end;

procedure TfrmAdmin.lvAdminCustomDrawSubItem(Sender: TCustomListView;
  Item: TListItem; SubItem: Integer; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  if SubItem = 2 then
  begin
    if Item.SubItems[1] = '����' then
      Sender.Canvas.Font.Color := clGreen
    else Sender.Canvas.Font.Color := clRed;
  end
  else Sender.Canvas.Font.Color := clBlack;
end;

procedure TfrmAdmin.lvAdminDblClick(Sender: TObject);
begin
  if lvAdmin.Selected = nil then lvAdmin.OnClick(lvAdmin);
  if lvAdmin.Selected <> nil then btnEdit.OnClick(btnEdit);
end;

procedure TfrmAdmin.lvAdminSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  FLastIndex := Item.Index;
  SetState();
end;

procedure TfrmAdmin.lvAdminKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DELETE) and (lvAdmin.Selected <> nil) then btnDel.OnClick(btnDel);
end;

end.
