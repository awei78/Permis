{
  �ļ�����uDept.pas
  ˵  ����������Ϣ������
  ��д�ˣ�������
  ��  �ڣ�2008-05-18
  ��  �£�
}

unit uDict;
                       
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, uBase, DB, ADODB;

type
  TfrmDict = class(TfrmBase)
    btnAdd: TBitBtn;
    btnEdit: TBitBtn;
    btnDel: TBitBtn;
    lblTips: TLabel;
    tvDict: TTreeView;
    btnUp: TBitBtn;
    btnDown: TBitBtn;
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure tvDictChange(Sender: TObject; Node: TTreeNode);
    procedure tvDictEdited(Sender: TObject; Node: TTreeNode;
      var S: String);
    procedure tvDictEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure tvDictGetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure tvDictGetSelectedIndex(Sender: TObject; Node: TTreeNode);
    procedure tvDictDblClick(Sender: TObject);
    procedure tvDictKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    //���ԱȽ����Ƿ��Ѹı�
    FOriTreeStr: string;
    FChgTreeStr: string;
    procedure SetState;
    function GetTreeStr(ATreeView: TTreeView): string;
    function GetChgStr(ATreeView: TTreeView): string;
    //��ȡ���һ��ID
    function GetLatestID: Integer;
  protected
    //���ݲ�������
    procedure LoadData; override;
    procedure SaveData; override;
    //�������
    function CheckData: Boolean; override;
  public
    { Public declarations }
  end;

var
  frmDict: TfrmDict;

function ShowDict(): Boolean;

implementation

uses uData, uGlobal;

{$R *.dfm}

function ShowDict(): Boolean;
begin
  with TfrmDict.Create(Application.MainForm) do
  begin
    HelpHtml := 'dict.html';
    try
      //������
      LoadData();
      SetState();
      Result := ShowModal() = mrOk
    finally
      Free;
    end;
  end;
end;

procedure TfrmDict.SetState;
begin
  btnUp.Enabled := (tvDict.Selected <> nil) and (tvDict.Selected.Level = 2) and (tvDict.Selected.Index <> 0);
  btnDown.Enabled := (tvDict.Selected <> nil) and (tvDict.Selected.Level = 2) and (tvDict.Selected.Index <> tvDict.Selected.Parent.Count - 1);

  btnAdd.Enabled := (tvDict.Selected <> nil) and (tvDict.Selected.Level <> 0);
  btnEdit.Enabled := (tvDict.Selected <> nil) and (tvDict.Selected.Level = 2);
  btnDel.Enabled := (tvDict.Selected <> nil) and (tvDict.Selected.Level = 2);
end;

function TfrmDict.GetTreeStr(ATreeView: TTreeView): string;
var
  i: Integer;
begin
  Result := '';
  if ATreeView.Items.Count = 0 then Exit;

  for i := 0 to ATreeView.Items.Count - 1 do
    Result := Result + '|' + ATreeView.Items[i].Text;
  Result := Copy(Result, 2, Length(Result) - 1);
end;

function TfrmDict.GetChgStr(ATreeView: TTreeView): string;
var
  i: Integer;
begin
  Result := '';
  if ATreeView.Items.Count = 0 then Exit;

  for i := 0 to ATreeView.Items.Count - 1 do
  begin
    if ATreeView.Items[i].Index = 8 then Exit;

    Result := Result + '|' + ATreeView.Items[i].Text;
  end;
  Result := Copy(Result, 2, Length(Result) - 1);
end;

function TfrmDict.GetLatestID: Integer;
begin
  Result := StrToIntDef(VarToStr(dmPer.GetFieldValue('SELECT @@identity AS id FROM [dict]', 'id')), 0);
end;

procedure TfrmDict.LoadData;
var
  i: Integer;
  Root: TTreeNode;
begin
  Root := tvDict.Items.GetFirstNode;
  Root.Text := App.Company.Name;
  //���ڵ�...
  Root.DeleteChildren;
  with tvDict.Items, App.ViewSet do
  begin
    AddChildObject(Root, DutyStr, PInteger(Ord(ktDuty)));
    AddChildObject(Root, TypeStr, PInteger(Ord(ktType)));
    AddChildObject(Root, TechnicStr, PInteger(Ord(ktTechnic)));
    AddChildObject(Root, FolkStr, PInteger(Ord(ktFolk)));
    AddChildObject(Root, MarriageStr, PInteger(Ord(ktMarriage)));
    AddChildObject(Root, PolityStr, PInteger(Ord(ktPolity)));
    AddChildObject(Root, CultureStr, PInteger(Ord(ktCulture)));
    AddChildObject(Root, SpecialStr, PInteger(Ord(ktSpecial)));
    AddChildObject(Root, '��ְԭ��', PInteger(Ord(ktReason)));
    AddChildObject(Root, BankStr, PInteger(Ord(ktBank)));
    AddChildObject(Root, '��ͬ����', PInteger(Ord(ktContType)));
  end;
  //���ÿ��...
  for i := 0 to Root.Count - 1 do
    DrawKind(Root.Item[i], TKindType(Root.Item[i].Index));

  //Root.getFirstChild.Expand(False);
  Root.getFirstChild.Selected := True;

  FOriTreeStr := GetTreeStr(tvDict);
  FChgTreeStr := GetChgStr(tvDict);
end;

procedure TfrmDict.SaveData;
var
  Node: TTreeNode;
  bNeedRequery: Boolean;
  i, parId: Integer;
  KindType: TKindType;
  sIds, sKindName, sFieldName, sSql: string;
begin
  if tvDict.Focused then btnOk.SetFocus;
  if FOriTreeStr = GetTreeStr(tvDict) then Exit;

  //�������м�¼�����еĸ��£��µļ��룬����ȡ��ID��
  bNeedRequery := False;
  for i := 0 to tvDict.Items.Count - 1 do
  begin
    Node := tvDict.Items[i];
    if Node.Level <> 2 then Continue;

    //����
    if Assigned(Node.Data) then  
    begin
      //�ȸ���Ա������
      sKindName := dmPer.GetFieldValue('SELECT kindName FROM [dict] WHERE id=' + IntToStr(Integer(Node.Data)), 'kindName');
      if sKindName <> Node.Text then
      begin
        //����Ա�����ݱ�
        KindType := TKindType(Integer(Node.Parent.Data));
        sFieldName := GetFieldNameByKindType(KindType);
        case KindType of
          ktReason:
            sSql := 'UPDATE [left] SET ' + sFieldName + '=''' + Node.Text + ''' WHERE ' + sFieldName + '=''' + sKindName + '''';
          ktContType:
            sSql := 'UPDATE [contract] SET ' + sFieldName + '=''' + Node.Text + ''' WHERE ' + sFieldName + '=''' + sKindName + '''';
          ktState:
            sSql := '';
        else
          if not bNeedRequery then bNeedRequery := True;
          sSql := 'UPDATE [staffs] SET ' + sFieldName + '=''' + Node.Text + ''' WHERE ' + sFieldName + '=''' + sKindName + '''';
        end;
        dmPer.ExecSQL(sSql);
        dmPer.ExecSQL('UPDATE [dict] SET kindName=' + QuotedStr(Node.Text) + ', sortNo=' + IntToStr(Node.Index) + ' WHERE id=' + IntToStr(Integer(Node.Data)));
      end;

      sIds := sIds + ', ' + IntToStr(Integer(Node.Data));
    end
    //���
    else
    begin
      parId := Node.Parent.Index;
      dmPer.ExecSQL('INSERT INTO [dict](kindName, kindType, sortNo) VALUES(' + QuotedStr(Node.Text) + ', ' + IntToStr(parId) + ', ' + IntToStr(Node.Index) + ')');
      //ͬʱ��д�������IDֵ��Ϊ�����ӽڵ�����
      Node.Data := PInteger(GetLatestID());

      sIds := sIds + ', ' + IntToStr(Integer(Node.Data));
    end;
  end;

  //�����Ҫ��ˢ��Ա�����ݼ�
  if bNeedRequery then dmPer.aqStaff.Requery();
  //�����ݿ���ɾ����ɾ����¼
  if sIds <> '' then
  begin
    sIds := Copy(sIds, 3, Length(sIds));
    dmPer.ExecSQL('DELETE FROM [dict] WHERE id NOT IN (' + sIds + ')');
  end;
end;

function TfrmDict.CheckData: Boolean;
label
  Exit;
var
  i, j: Integer;
  Node: TTreeNode;
begin
  Result := True;

  //���ͬһ���ڵ���ͬһ����û���ظ��ļ�¼
  for i := 0 to tvDict.Items.Count - 1 do
  begin
    Node := tvDict.Items[i];
    if Node.Level <> 2 then Continue;

    for j := Node.Index + 1 to Node.Parent.Count - 1 do
    begin
      if SameText(Trim(Node.Text), Trim(Node.Parent.Item[j].Text)) then
      begin
        Result := False;
        MessageBox(Handle, PAnsiChar('ͬһ��' + Node.Parent.Text + '�£���������ͬ��[' + Node.Text + ']'), '��ʾ', MB_ICONINFORMATION + MB_OK);
        Node.Selected := True;
        tvDict.SetFocus;

        Goto Exit;
      end;
    end;
  end;

Exit:
  ;
end;

procedure TfrmDict.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  case Msg.CharCode of
    VK_DELETE: if btnDel.Enabled and not tvDict.IsEditing then btnDel.OnClick(btnDel);
    VK_ESCAPE: if not tvDict.IsEditing then inherited;
  else
    inherited;
  end;        
end;

procedure TfrmDict.btnUpClick(Sender: TObject);
begin
  if tvDict.Selected.Index <> 0 then
  begin
    tvDict.Selected.MoveTo(tvDict.Selected.getPrevSibling, naInsert);
    SetState();
  end;
end;

procedure TfrmDict.btnDownClick(Sender: TObject);
begin
  if tvDict.Selected.getNextSibling <> nil then
  begin
    tvDict.Selected.getNextSibling.MoveTo(tvDict.Selected, naInsert);
    SetState();
  end;
end;

procedure TfrmDict.btnAddClick(Sender: TObject);
var
  NewNode: TTreeNode;
begin
  if (tvDict.Selected = nil) or (tvDict.Selected.Level = 0) then Exit;
  if (tvDict.Selected.Level = 1) and (tvDict.Selected.HasChildren) and (tvDict.Selected.GetLastChild.Text = '��ֵ') then
  begin
    tvDict.Selected.EditText;
    Exit;
  end;
  if (tvDict.Selected.Level = 2) and (tvDict.Selected.Text = '��ֵ') then
  begin
    tvDict.Selected.EditText;
    Exit;
  end;

  if (tvDict.Selected <> nil) and (tvDict.Selected.Level <> 0) then
  begin
    if tvDict.Selected.Level = 1 then
      NewNode := tvDict.Items.AddChild(tvDict.Selected, '��ֵ')
    else NewNode := tvDict.Items.Add(tvDict.Selected, '��ֵ');
    NewNode.Selected := True;

    btnEdit.OnClick(btnEdit);
  end;
end;

procedure TfrmDict.btnEditClick(Sender: TObject);
begin
  if (tvDict.Selected <> nil) and (tvDict.Selected.Level <> 0) then
    tvDict.Selected.EditText;
end;

procedure TfrmDict.btnDelClick(Sender: TObject);
begin
  if MessageBox(Handle, PAnsiChar('��ȷ��Ҫɾ��' + tvDict.Selected.Parent.Text + '�µ�[' + tvDict.Selected.Text + ']��'), '��ʾ', MB_ICONQUESTION + MB_YESNO) = IDYES then
    tvDict.Selected.Delete;
end;

procedure TfrmDict.btnOkClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    if FOriTreeStr <> GetTreeStr(tvDict) then
    begin
      if CheckData() then
      begin
        SaveData();

        //����ˢ����������Ϣ
        if FChgTreeStr <> GetChgStr(tvDict) then
          SendMessage(Application.MainForm.Handle, WM_KINDCHANGE, 0, 0);
        ModalResult := mrOk;

        Log.Write(App.UserId + '�Է�����Ϣ�����Ķ�');
      end;
    end
    else ModalResult := mrCancel;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmDict.btnCancelClick(Sender: TObject);
begin
  if (FOriTreeStr <> GetTreeStr(tvDict)) and (MessageBox(Handle, '���ѶԷ�����Ϣ�������£�Ҫ������', '��ʾ', MB_ICONQUESTION + MB_YESNO) = IDYES) then
    btnOk.OnClick(btnOk)
  else inherited;
end;

procedure TfrmDict.tvDictEdited(Sender: TObject; Node: TTreeNode;
  var S: String);
begin
  tvDict.ReadOnly := True;
end;

procedure TfrmDict.tvDictEditing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
begin
  //�������ڵ������ɱ༭֮bug
  AllowEdit := Node.Level = 2;
end;

procedure TfrmDict.tvDictGetImageIndex(Sender: TObject; Node: TTreeNode);
begin
  if Node.Level <> 0 then
  begin
    if Node.HasChildren and Node.Expanded then
      Node.ImageIndex := 2
    else Node.ImageIndex := 1;
    if Node.Level = 2 then
    begin
      if Node.Parent.Index <> Node.Parent.Parent.Count - 2 then
        Node.ImageIndex := 3
      else Node.ImageIndex := 9;
    end;
  end;
end;

procedure TfrmDict.tvDictGetSelectedIndex(Sender: TObject;
  Node: TTreeNode);
begin
  if Node.Level <> 0 then
  begin
    if Node.HasChildren and Node.Expanded then
      Node.SelectedIndex := 2
    else Node.SelectedIndex := 1;
    if Node.Level = 2 then
    begin
      if Node.Parent.Index <> Node.Parent.Parent.Count - 2 then
        Node.SelectedIndex := 3
      else Node.SelectedIndex := 9;
    end;
  end;
end;

procedure TfrmDict.tvDictChange(Sender: TObject; Node: TTreeNode);
begin
  SetState();
  tvDict.ReadOnly := Node.Level <> 2;
end;

procedure TfrmDict.tvDictDblClick(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := tvDict.Selected;
  if (Node <> nil) and (Node.Level = 1) and not Node.HasChildren then btnAdd.OnClick(btnAdd);
end;

procedure TfrmDict.tvDictKeyPress(Sender: TObject; var Key: Char);
begin
  if tvDict.IsEditing and (Key in ['=']) then Key := #0;
end;

end.
