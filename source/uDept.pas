{
  �ļ�����uDept.pas
  ˵  �������Ź�����
  ��д�ˣ�������
  ��  �ڣ�2008-05-18
  ��  �£�
}

unit uDept;
                       
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, uBase;

type
  TfrmDept = class(TfrmBase)
    btnUp: TBitBtn;
    btnDown: TBitBtn;
    btnAddSib: TBitBtn;
    btnAddChild: TBitBtn;
    btnEdit: TBitBtn;
    btnDel: TBitBtn;
    lblTips: TLabel;
    tvDept: TTreeView;
    btnLeft: TBitBtn;
    btnRight: TBitBtn;
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnLeftClick(Sender: TObject);
    procedure btnRightClick(Sender: TObject);
    procedure btnAddSibClick(Sender: TObject);
    procedure btnAddChildClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure tvDeptChange(Sender: TObject; Node: TTreeNode);
    procedure tvDeptEdited(Sender: TObject; Node: TTreeNode;
      var S: String);
    procedure tvDeptEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure tvDeptGetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure tvDeptGetSelectedIndex(Sender: TObject; Node: TTreeNode);
    procedure tvDeptKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    //���ԱȽ����Ƿ��Ѹı�
    FOriTreeStr: string;
    procedure SetState;
    function GetTreeStr(ATreeView: TTreeView): string;
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
  frmDept: TfrmDept;

function ShowDept(): Boolean;

implementation

uses uData, uGlobal;

{$R *.dfm}

function ShowDept(): Boolean;
begin
  with TfrmDept.Create(Application.MainForm) do
  begin
    HelpHtml := 'dept.html';
    try
      LoadData();
      SetState();
      Result := ShowModal() = mrOk
    finally
      Free;
    end;
  end;
end;

procedure TfrmDept.SetState;
begin
  btnUp.Enabled := (tvDept.Selected <> nil) and (tvDept.Selected.Level <> 0) and (tvDept.Selected.Index <> 0);
  btnDown.Enabled := (tvDept.Selected <> nil) and (tvDept.Selected.Level <> 0) and (tvDept.Selected.Index <> tvDept.Selected.Parent.Count - 1);
  btnLeft.Enabled := (tvDept.Selected <> nil) and (tvDept.Selected.Parent <> nil) and (tvDept.Selected.Parent.Level <> 0);
  btnRight.Enabled := (tvDept.Selected <> nil) and (tvDept.Selected.getPrevSibling <> nil);

  btnAddSib.Enabled := (tvDept.Selected <> nil) and (tvDept.Selected.Level <> 0);
  btnAddChild.Enabled := tvDept.Selected <> nil;
  btnEdit.Enabled := (tvDept.Selected <> nil) and (tvDept.Selected.Level <> 0);
  btnDel.Enabled := (tvDept.Selected <> nil) and (tvDept.Selected.Level <> 0);
end;

function TfrmDept.GetTreeStr(ATreeView: TTreeView): string;
var
  i: Integer;
begin
  Result := '';
  if ATreeView.Items.Count = 0 then Exit;

  for i := 0 to ATreeView.Items.Count - 1 do
    Result := Result + '|' + IntToStr(ATreeView.Items[i].Level) + ATreeView.Items[i].Text;
  Result := Copy(Result, 2, Length(Result) - 1);
end;

function TfrmDept.GetLatestID: Integer;
begin
  Result := StrToIntDef(VarToStr(dmPer.GetFieldValue('SELECT @@identity AS id FROM [dept]', 'id')), 0);
end;

procedure TfrmDept.LoadData;
var
  Root: TTreeNode;
begin
  //��ʱ��ʵ�ִ˹���
  btnLeft.Visible := False;
  btnRight.Visible := False;
  btnAddSib.Top := 48;
  btnAddChild.Top := 74;
  btnEdit.Top := 100;
  btnDel.Top := 126;
  lblTips.Top := 160;

  //���ܿ�ʼ��
  tvDept.Items.Clear;
  Root := tvDept.Items.AddFirst(nil, App.Company.Name);
  DrawDept(Root, False);

  if tvDept.Items.Count > 1 then
  begin
    tvDept.Items[1].Expand(False);
    tvDept.Items[1].Selected := True;

    FOriTreeStr := GetTreeStr(tvDept);
  end;
end;

procedure TfrmDept.SaveData;
var
  Node: TTreeNode;
  bNeedRequery: Boolean;
  i, parId: Integer;
  sIds, sDept, sSql: string;
begin
  if FOriTreeStr = GetTreeStr(tvDept) then Exit;

  //�������м�¼�����еĸ��£��µļ��룬����ȡ��ID��
  bNeedRequery := False;
  for i := 0 to tvDept.Items.Count - 1 do
  begin
    Node := tvDept.Items[i];
    if Node.Level = 0 then Continue;

    if Node.Level = 1 then
      parId := 0
    else parId := Integer(Node.Parent.Data);
    //����
    if Assigned(Node.Data) then
    begin
      //�ȸ���Ա������
      sDept := dmPer.GetFieldValue('SELECT deptName FROM [dept] WHERE id=' + IntToStr(Integer(Node.Data)), 'deptName');
      if sDept <> Node.Text then
      begin
        if not bNeedRequery then bNeedRequery := True;
        //һ������
        if Node.Level = 1 then
          sSql := 'UPDATE [staffs] SET deptName=''' + Node.Text + ''' + Right(deptName, Len(deptName) - Len(''' + sDept + ''')) ' +
            'WHERE Left(deptName, Len(''' + sDept + '''))=' + QuotedStr(sDept)
        //��ĩ������...Access��֧��Replace��������Left��Right���滻ʵ��
        else
          sSql := 'UPDATE [staffs] SET deptName=Left(deptName, InStr(deptName, ''/' + sDept + ''')) + ''' + Node.Text + ''' + Right(deptName, Len(deptName) - InStr(deptName, ''/' + sDept + ''') - Len(''/' + sDept + ''') + 1) ' +
            'WHERE InStr(deptName, ''/' + sDept + ''') <> 0';
        dmPer.ExecSQL(sSql);

        //�ٸ��²�������
        dmPer.ExecSQL('UPDATE [dept] SET deptName=' + QuotedStr(Node.Text) + ', parId=' + IntToStr(parId) + ', sortNo=' + IntToStr(Node.Index) + ' WHERE id=' + IntToStr(Integer(Node.Data)));
       end;

       sIds := sIds + ', ' + IntToStr(Integer(Node.Data));
    end
    //����
    else
    begin
      dmPer.ExecSQL('INSERT INTO [dept](deptName, parId, sortNo) VALUES(' + QuotedStr(Node.Text) + ', ' + IntToStr(parId) + ', ' + IntToStr(Node.Index) + ')');
      //ͬʱ��д���䲿��ID��Ϊ�����ӽڵ�����
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
    dmPer.ExecSQL('DELETE FROM [dept] WHERE id NOT IN (' + sIds + ')');
  end;

  Log.Write(App.UserId + '�Բ��Žṹ�����Ķ�');
end;

function TfrmDept.CheckData: Boolean;
label
  Exit;
var
  i, j: Integer;
  Node: TTreeNode;
  s: string;
begin
  Result := inherited CheckData();

  //���ͬһ���ڵ���ͬһ����û���ظ��ļ�¼
  for i := 0 to tvDept.Items.Count - 1 do
  begin
    Node := tvDept.Items[i];
    if Node.Parent = nil then Continue;

    for j := Node.Index + 1 to Node.Parent.Count - 1 do
    begin
      if SameText(Trim(Node.Text), Trim(Node.Parent.Item[j].Text)) then
      begin
        Result := False;
        if Node.Level > 1 then
          s := 'ͬһ��' + Node.Parent.Text + '�£���������ͬ��[' + Node.Text + ']'
        else s := '��˾�ṹ�У�ͬ����������ͬ��[' + Node.Text + ']';
        MessageBox(Handle, PAnsiChar(s), '��ʾ', MB_ICONINFORMATION + MB_OK);
        Node.Selected := True;
        tvDept.SetFocus;

        Goto Exit;
      end;
    end;
  end;

Exit:
  ;
end;

procedure TfrmDept.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  case Msg.CharCode of
    VK_DELETE: if btnDel.Enabled and not tvDept.IsEditing then btnDel.OnClick(btnDel);
    VK_ESCAPE: if not tvDept.IsEditing then inherited;
  else
    inherited;
  end;        
end;

procedure TfrmDept.btnUpClick(Sender: TObject);
begin
  if tvDept.Selected.Index <> 0 then
  begin
    tvDept.Selected.MoveTo(tvDept.Selected.getPrevSibling, naInsert);
    SetState();
  end;
end;

procedure TfrmDept.btnDownClick(Sender: TObject);
begin
  if tvDept.Selected.getNextSibling <> nil then
  begin
    tvDept.Selected.getNextSibling.MoveTo(tvDept.Selected, naInsert);
    SetState();
  end;
end;

procedure TfrmDept.btnLeftClick(Sender: TObject);
var
  NextSibling: TTreeNode;
begin
  if (tvDept.Selected.Parent <> nil) and (tvDept.Selected.Parent.Level <> 0) then
  begin
    NextSibling := tvDept.Selected.Parent.getNextSibling;
    tvDept.Selected.MoveTo(tvDept.Selected.Parent, naAdd);
    if NextSibling <> nil then tvDept.Selected.MoveTo(NextSibling, naInsert);
    SetState();
  end;
end;

procedure TfrmDept.btnRightClick(Sender: TObject);
begin
  if tvDept.Selected.getPrevSibling <> nil then
  begin
    tvDept.Selected.MoveTo(tvDept.Selected.getPrevSibling, naAddChild);
    SetState();
  end;
end;

procedure TfrmDept.btnAddSibClick(Sender: TObject);
begin
  if (tvDept.Selected <> nil) and (tvDept.Selected.Level <> 0) and (tvDept.Selected.Text <> '�²���') then
  begin
    with tvDept.Items.Add(tvDept.Selected, '�²���') do
      Selected := True;

    btnEdit.OnClick(btnEdit);
  end
  else if tvDept.Selected.Text = '�²���' then tvDept.Selected.EditText;
end;

procedure TfrmDept.btnAddChildClick(Sender: TObject);
begin
  if tvDept.Selected.HasChildren and (tvDept.Selected.GetLastChild.Text = '�²���') then
  begin
    tvDept.Selected.GetLastChild.EditText;
    Exit;
  end;

  if tvDept.Selected <> nil then
  begin
    with tvDept.Items.AddChild(tvDept.Selected, '�²���') do
      Selected := True;

    btnEdit.OnClick(btnEdit);
  end;
end;

procedure TfrmDept.btnEditClick(Sender: TObject);
begin
  if (tvDept.Selected <> nil) and (tvDept.Selected.Level <> 0) then
  begin
    tvDept.ReadOnly := False;
    tvDept.Selected.EditText;
  end;
end;

procedure TfrmDept.btnDelClick(Sender: TObject);
var
  s: string;
begin
  if tvDept.Selected.HasChildren then
    s := 'ȷ��Ҫɾ������[' + tvDept.Selected.Text + ']��������������'
  else s := 'ȷ��Ҫɾ������[' + tvDept.Selected.Text + ']��';

  if MessageBox(Handle, PAnsiChar(s), '��ʾ', MB_ICONQUESTION + MB_YESNO) = IDYES then
    tvDept.Selected.Delete;
end;

procedure TfrmDept.btnOkClick(Sender: TObject);
begin
  if FOriTreeStr <> GetTreeStr(tvDept) then
    inherited
  else ModalResult := mrCancel;
end;

procedure TfrmDept.btnCancelClick(Sender: TObject);
begin
  if (FOriTreeStr <> GetTreeStr(tvDept)) and (MessageBox(Handle, '���ѶԲ��Žṹ�������£�Ҫ������', '��ʾ', MB_ICONQUESTION + MB_YESNO) = IDYES) then
    btnOk.OnClick(btnOk)
  else inherited;
end;

procedure TfrmDept.tvDeptEdited(Sender: TObject; Node: TTreeNode;
  var S: String);
begin
  tvDept.ReadOnly := True;
end;

procedure TfrmDept.tvDeptEditing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
begin
  AllowEdit := Node.Level <> 0;
end;

procedure TfrmDept.tvDeptGetImageIndex(Sender: TObject; Node: TTreeNode);
begin
  if Node.Level <> 0 then
  begin
    if Node.HasChildren and Node.Expanded then
      Node.ImageIndex := 2
    else Node.ImageIndex := 1;
  end;
end;

procedure TfrmDept.tvDeptGetSelectedIndex(Sender: TObject;
  Node: TTreeNode);
begin
  if Node.Level <> 0 then
  begin
    if Node.HasChildren and Node.Expanded then
      Node.SelectedIndex := 2
    else Node.SelectedIndex := 1;
  end;
end;

procedure TfrmDept.tvDeptChange(Sender: TObject; Node: TTreeNode);
begin
  SetState();
end;

procedure TfrmDept.tvDeptKeyPress(Sender: TObject; var Key: Char);
begin
  if tvDept.IsEditing and (Key in ['/', '=']) then Key := #0;
end;

end.
