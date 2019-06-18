unit uAddr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzPanel, RzButton, ExtCtrls, ActnList, ImgList, Grids, DBGridEh,
  ComCtrls, StdCtrls, DBCtrls, Mask, DB, ADODB, Menus, ShellAPI, ComObj,
  DBGrids, GridsEh;

type
  TfrmAddr = class(TForm)
    tbAddr: TRzToolbar;
    btnAdd: TRzToolButton;
    btnEdit: TRzToolButton;
    btnDel: TRzToolButton;
    Spacer2: TRzSpacer;
    btnCancel: TRzToolButton;
    btnSave: TRzToolButton;
    Spacer3: TRzSpacer;
    btnExit: TRzToolButton;
    alAddr: TActionList;
    actAdd: TAction;
    actEdit: TAction;
    actDel: TAction;
    actSave: TAction;
    actCancel: TAction;
    actExit: TAction;
    sbAddr: TStatusBar;
    edtName: TDBEdit;
    Label1: TLabel;
    dgAddr: TDBGridEh;
    Label4: TLabel;
    dsAddr: TDataSource;
    aqAddr: TADOQuery;
    edtSrh: TEdit;
    Label5: TLabel;
    RzSpacer1: TRzSpacer;
    cbSex: TDBComboBox;
    Label2: TLabel;
    edtMobile: TDBEdit;
    Label3: TLabel;
    edtTel: TDBEdit;
    Label6: TLabel;
    edtQQ: TDBEdit;
    Label7: TLabel;
    edtMail: TDBEdit;
    Label8: TLabel;
    edtAddr: TDBEdit;
    gbOther: TGroupBox;
    meoDes: TDBMemo;
    aqAddrid: TAutoIncField;
    aqAddrsname: TWideStringField;
    aqAddrsex: TWideStringField;
    aqAddrmobile: TWideStringField;
    aqAddrtel: TWideStringField;
    aqAddrqqcode: TWideStringField;
    aqAddrmail: TWideStringField;
    aqAddraddr: TWideStringField;
    aqAddrdesc: TMemoField;
    aqAddrno: TIntegerField;
    aqAddrpystr: TWideStringField;
    actMail: TAction;
    actQQ: TAction;
    pmAddr: TPopupMenu;
    miAdd: TMenuItem;
    miEdit: TMenuItem;
    miDel: TMenuItem;
    Space01: TMenuItem;
    miMail: TMenuItem;
    miQQ: TMenuItem;
    actGet: TAction;
    N1: TMenuItem;
    miGet: TMenuItem;
    actExport: TAction;
    btnExport: TRzToolButton;
    actSta: TAction;
    actAddr: TAction;
    actSame: TMenuItem;
    miSta: TMenuItem;
    miAddr: TMenuItem;
    btnPrint: TRzToolButton;
    actPrint: TAction;
    actClear: TAction;
    N2: TMenuItem;
    Label9: TLabel;
    edtPlace: TDBEdit;
    aqAddrplace: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actExportExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actGetExecute(Sender: TObject);
    procedure actStaExecute(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
    procedure actAddrExecute(Sender: TObject);
    procedure actMailExecute(Sender: TObject);
    procedure actQQExecute(Sender: TObject);
    procedure dsAddrDataChange(Sender: TObject; Field: TField);
    procedure aqAddrCalcFields(DataSet: TDataSet);
    procedure edtSrhChange(Sender: TObject);
    procedure pmAddrPopup(Sender: TObject);
    procedure dgAddrTitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
    procedure dgAddrDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    { Private declarations }
    procedure SetControls(AViewState: Boolean = True);
    //ʹģʽ�������������
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
  public
    { Public declarations }
  end;

var
  frmAddr: TfrmAddr;

function ShowAddr(): Boolean;

implementation

uses uData, uGlobal;

{$R *.dfm}

function ShowAddr(): Boolean;
begin
  Result := True;

  if not Assigned(frmAddr) then frmAddr := TfrmAddr.Create(Application.MainForm);
  if frmAddr.WindowState = wsMinimized then frmAddr.WindowState := wsNormal;

  dmPer.OpenQuery(frmAddr.aqAddr, 'SELECT * FROM [addrlist]');
  frmAddr.Show();
end;

procedure TfrmAddr.WMSetCursor(var Msg: TWMSetCursor);
begin
  if (SmallInt(Msg.HitTest) = HTERROR) and (Msg.MouseMsg = WM_LBUTTONDOWN) then
    DefaultHandler(Msg)
  else inherited;
end;

procedure TfrmAddr.SetControls(AViewState: Boolean);
var
  clr: TColor;
begin
  actAdd.Enabled := AViewState;
  actEdit.Enabled := AViewState and (aqAddr.RecordCount <> 0);
  actDel.Enabled := AViewState and (aqAddr.RecordCount <> 0);

  actSave.Enabled := not AViewState;
  actCancel.Enabled := not AViewState;

  if AViewState then
    clr := VIEW_COLOR
  else clr := clWindow;

  edtName.Color := clr;
  cbSex.Color := clr;
  edtMobile.Color := clr;
  edtTel.Color := clr;
  edtQQ.Color := clr;
  edtMail.Color := clr;
  edtPlace.Color := clr;
  edtAddr.Color := clr;
  meoDes.Color := clr;

  //���ÿɱ༭״̬
  dgAddr.Enabled := AViewState;
  edtName.ReadOnly := AViewState;
  cbSex.ReadOnly := AViewState;
  edtMobile.ReadOnly := AViewState;
  edtTel.ReadOnly := AViewState;
  edtQQ.ReadOnly := AViewState;
  edtMail.ReadOnly := AViewState;
  edtPlace.ReadOnly := AViewState;
  edtAddr.ReadOnly := AViewState;
  meoDes.ReadOnly := AViewState;
  edtSrh.ReadOnly := not AViewState;

  if AViewState then
    dgAddr.SetFocus
  else edtName.SetFocus;
end;

procedure TfrmAddr.FormCreate(Sender: TObject);
begin
  SetWindowLong(Handle, GWL_HWNDPARENT, HWND_DESKTOP);

  sbAddr.Panels[1].Text := '����б�����ԶԼ�¼��������';
end;

procedure TfrmAddr.FormShow(Sender: TObject);
begin
  SetControls();
end;

procedure TfrmAddr.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  if Msg.CharCode = VK_ESCAPE then
  begin
    if actCancel.Enabled then
      actCancel.Execute
    else actExit.Execute;
  end
  else if Msg.CharCode = VK_DELETE then
  begin
    //��ݼ�����...
    if not Active or (ActiveControl is TCustomEdit) then
      actDel.ShortCut := 0
    else actDel.ShortCut := ShortCut(VK_DELETE, []);
  end;
end;

procedure TfrmAddr.actAddExecute(Sender: TObject);
begin
  SetControls(False);
  aqAddr.Append();
  aqAddr.FieldByName('sex').AsString := cbSex.Items[0];
end;

procedure TfrmAddr.actEditExecute(Sender: TObject);
begin
  SetControls(False);
  aqAddr.Edit();
end;

procedure TfrmAddr.actDelExecute(Sender: TObject);
begin
  if MessageBox(Handle, 'ȷ��Ҫɾ��ѡ���ļ�¼ô��', '��ʾ', MB_ICONQUESTION + MB_YESNO) = IDYES then
  begin
    //��dgMultiSelect�£���Ϊ0
    if dgAddr.SelectedRows.Count = 0 then
      aqAddr.Delete()
    else dgAddr.SelectedRows.Delete;

    aqAddr.UpdateBatch();
  end;
  SetControls();
end;

procedure TfrmAddr.actSaveExecute(Sender: TObject);
var
  aqTemp: TADOQuery;
begin
  if Trim(edtName.Text) = '' then
  begin
    MessageBox(Handle, '��������Ҫ��ӵ���ϵ�ˣ�', '��ʾ',  MB_ICONINFORMATION + MB_OK);
    edtName.SetFocus;
    Exit;
  end;

  //�ظ���¼�ж�
  if aqAddr.State = dsInsert then
  begin
    aqTemp := TADOQuery.Create(Self);
    try
      aqTemp.Clone(aqAddr, ltReadOnly);
      if aqTemp.Locate('sname', Trim(edtName.Text), []) then
      begin
        MessageBox(Handle, '��������ϵ���Ѵ��ڣ�', '��ʾ',  MB_ICONINFORMATION + MB_OK);
        edtName.SetFocus;
        Exit;
      end;
    finally
      aqTemp.Free;
    end;
  end;

  aqAddr.FieldByName('pystr').AsString := GetPYStr(edtName.Text);
  aqAddr.UpdateBatch();
  SetControls();
end;

procedure TfrmAddr.actCancelExecute(Sender: TObject);
begin
  if aqAddr.State in [dsInsert, dsEdit] then
  begin
    aqAddr.CancelBatch();
    SetControls();
  end;
end;

procedure TfrmAddr.actExportExecute(Sender: TObject);
var
  DBGrid: TDBGridEh;
  i: Integer;
begin
  DBGrid := TDBGridEh.Create(Self);
  try
    dgAddr.DataSource.DataSet.DisableControls;
    DBGrid.Visible := False;
    DBGrid.Parent := Self;
    DBGrid.DataSource := dgAddr.DataSource;
    DBGrid.Columns.Clear;

    for i := 0 to dgAddr.Columns.Count - 1 do
    begin
      with DBGrid.Columns.Add do
      begin
        Title.Caption := dgAddr.Columns[i].Title.Caption;
        FieldName := dgAddr.Columns[i].FieldName;
      end;
    end;

    DataToExcel(DBGrid, 'Ա��ͨѶ¼.xls');
  finally
    DBGrid.Free;
    dgAddr.DataSource.DataSet.EnableControls;
  end;
end;

procedure TfrmAddr.actPrintExecute(Sender: TObject);
var
  DBGrid: TDBGridEh;
  i: Integer;
begin
  DBGrid := TDBGridEh.Create(Self);
  try
    dgAddr.DataSource.DataSet.DisableControls;
    DBGrid.Visible := False;
    DBGrid.Parent := Self;
    DBGrid.DataSource := dgAddr.DataSource;
    DBGrid.Columns.Clear;

    for i := 0 to dgAddr.Columns.Count - 1 do
    begin
      with DBGrid.Columns.Add do
      begin
        Title.Caption := dgAddr.Columns[i].Title.Caption;
        FieldName := dgAddr.Columns[i].FieldName;
      end;
    end;
    AutoFitWidth(DBGrid);

    PrintDBGridEh(DBGrid, 'Ա��ͨѶ¼');
  finally
    DBGrid.Free;
    dgAddr.DataSource.DataSet.EnableControls;
  end;
end;

procedure TfrmAddr.actExitExecute(Sender: TObject);
begin
  Close();
end;

procedure TfrmAddr.actGetExecute(Sender: TObject);
var
  sMsg, sSql, sCurId: string;
begin
  sMsg := '�˲�������׷��Ա����ϵ������ͨѶ¼�С���Ա����Ϣ��[��ϵ����]������ͨѶ¼�в����ڣ�����뵽ͨѶ¼�������˲�����';
  if MessageBox(Handle, PAnsiChar(sMsg), '��ʾ',  MB_ICONQUESTION + MB_YESNO) = IDYES then
  begin
    sCurId := aqAddr.FieldByName('id').AsString;
    sSql := 'INSERT INTO [addrlist](sname, pystr, sex, mobile, tel, qqcode, mail, addr) ' +
            'SELECT staffName, staffPY, sex, mobile, tel, qqCode, email, nativePlace FROM [staffs] ' +
            'WHERE NOT EXISTS (SELECT id FROM addrlist WHERE sname=staffName)';
    dmPer.ExecSQL(sSql);

    aqAddr.Requery();
    if sCurId <> '' then aqAddr.Locate('id', sCurId, []);
  end;
end;

procedure TfrmAddr.actStaExecute(Sender: TObject);
var
  sMsg, sSql, sCurId: string;
begin
  sMsg := '�˲��������Ա����Ϣ��[��ϵ����]���ָ���ΪԱ����ͨѶ¼��Ӧ����Ϣ�������˲�����';
  if MessageBox(Handle, PAnsiChar(sMsg), '��ʾ',  MB_ICONQUESTION + MB_YESNO) = IDYES then
  begin
    sSql := 'UPDATE [staffs], [addrlist] SET staffs.sex=addrlist.sex, staffs.mobile=addrlist.mobile, ' +
            'staffs.tel=addrlist.tel, staffs.qqCode=addrlist.qqcode, staffs.email=addrlist.mail WHERE staffs.staffName=addrlist.sname';

    sCurId := dmPer.aqStaff.FieldByName('id').AsString;
    dmPer.ExecSQL(sSql);
    dmPer.aqStaff.Requery();
    dmPer.aqStaff.Locate('id', sCurId, []);
  end;
end;

procedure TfrmAddr.actAddrExecute(Sender: TObject);
var
  sMsg, sSql, sCurId: string;
begin
  sMsg := '�˲��������ͨѶ¼����Ϣ����ΪԱ����Ϣ��[��ϵ����]�ж�Ӧ����Ϣ�������˲�����';
  if MessageBox(Handle, PAnsiChar(sMsg), '��ʾ',  MB_ICONQUESTION + MB_YESNO) = IDYES then
  begin
    sSql := 'UPDATE [addrlist], [staffs] SET addrlist.sex=staffs.sex, addrlist.mobile=staffs.mobile, ' +
            'addrlist.tel=staffs.tel, addrlist.qqCode=staffs.qqcode, addrlist.mail=staffs.email WHERE addrlist.sname=staffs.staffName';

    sCurId := aqAddr.FieldByName('id').AsString;
    dmPer.ExecSQL(sSql);
    aqAddr.Requery();
    aqAddr.Locate('id', sCurId, []);
  end;
end;

procedure TfrmAddr.actClearExecute(Sender: TObject);
begin
  if MessageBox(Handle, PAnsiChar('��ȷ��Ҫ���ͨѶ¼������������'), '��ʾ',  MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON2) = IDYES then
  begin
    dmPer.ExecSQL('DELETE FROM [addrlist]');

    aqAddr.Requery();
  end;
end;

procedure TfrmAddr.actMailExecute(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PAnsiChar('mailto:' + aqAddr.FieldByName('mail').AsString), nil, nil, SW_SHOW);
end;

procedure TfrmAddr.actQQExecute(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PAnsiChar('tencent://message/?uin=' + aqAddr.FieldByName('qqCode').AsString + '&Menu=yes'), nil, nil, SW_SHOW);
end;

procedure TfrmAddr.dsAddrDataChange(Sender: TObject; Field: TField);
var
  RecNo: Integer;
begin
  if aqAddr.RecordCount <> 0 then
    Caption := 'ͨѸ¼ - ' + aqAddr.FieldByName('sname').AsString
  else Caption := 'ͨѸ¼';
  if aqAddr.RecNo = -1 then
    RecNo := 0
  else RecNo := aqAddr.RecNo;
  sbAddr.Panels[0].Text := '��¼����' + IntToStr(RecNo) + '/' + IntToStr(aqAddr.RecordCount);

  if dgAddr.Focused then
  begin
    if GetAsyncKeyState(VK_CONTROL) <> 0 then
      dgAddr.Options := dgAddr.Options + [DBGridEh.dgMultiSelect]
    else dgAddr.Options := dgAddr.Options - [DBGridEh.dgMultiSelect];
  end;

  actEdit.Enabled := aqAddr.RecordCount <> 0;
  actDel.Enabled := actEdit.Enabled;
  actExport.Enabled := actEdit.Enabled;
  actPrint.Enabled := actEdit.Enabled;
  actSta.Enabled := actEdit.Enabled;
  actAddr.Enabled := actEdit.Enabled;
  actClear.Enabled := actEdit.Enabled;
end;

procedure TfrmAddr.aqAddrCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('no').AsInteger := Abs(DataSet.RecNo);
end;

procedure TfrmAddr.edtSrhChange(Sender: TObject);
var
  sFilter: string;
begin
  if edtSrh.Text = '' then
    aqAddr.Filtered := False
  else
  begin
    sFilter := 'sname LIKE ' + QuotedStr('%' + edtSrh.Text + '%') + ' OR pystr LIKE ' + QuotedStr('%' + edtSrh.Text + '%') +
               ' OR sex LIKE ' + QuotedStr('%' + edtSrh.Text + '%') + ' OR mobile LIKE ' + QuotedStr('%' + edtSrh.Text + '%') +
               ' OR tel LIKE ' + QuotedStr('%' + edtSrh.Text + '%') + ' OR qqCode LIKE ' + QuotedStr('%' + edtSrh.Text + '%') +
               ' OR mail LIKE ' + QuotedStr('%' + edtSrh.Text + '%') + ' OR addr LIKE ' + QuotedStr('%' + edtSrh.Text + '%');
    FilterData(aqAddr, sFilter);
  end;
end;

procedure TfrmAddr.dgAddrTitleBtnClick(Sender: TObject; ACol: Integer;
  Column: TColumnEh);
begin
  DBGridEhTitleBtnClick(Sender, ACol, Column);
end;

procedure TfrmAddr.pmAddrPopup(Sender: TObject);
begin
  actMail.Enabled := aqAddr.FieldByName('mail').AsString <> '';
  actQQ.Enabled := aqAddr.FieldByName('qqCode').AsString <> '';
end;

procedure TfrmAddr.dgAddrDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
begin
  if aqAddr.RecordCount = 0 then Exit;

  if (Column.FieldName = 'sex') and (Column.Field.AsString = 'Ů') then
    dgAddr.Canvas.Font.Color := clRed;
  dgAddr.DefaultDrawColumnCell(Classes.Rect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom), DataCol, Column, State);
end;

end.
