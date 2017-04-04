unit uDiary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzPanel, RzButton, ExtCtrls, ActnList, ImgList, Grids, DBGridEh,
  ComCtrls, StdCtrls, DBCtrls, Mask, DB, ADODB, DBCtrlsEh, DBGrids, GridsEh;

type
  TfrmDiary = class(TForm)
    tbDiary: TRzToolbar;
    btnAdd: TRzToolButton;
    btnEdit: TRzToolButton;
    btnDel: TRzToolButton;
    Spacer2: TRzSpacer;
    btnCancel: TRzToolButton;
    btnSave: TRzToolButton;
    Spacer3: TRzSpacer;
    btnExit: TRzToolButton;
    alDiray: TActionList;
    actAdd: TAction;
    actEdit: TAction;
    actDel: TAction;
    actSave: TAction;
    actCancel: TAction;
    actExit: TAction;
    sbDiary: TStatusBar;
    edtTopic: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    meoContent: TDBMemo;
    dgDiary: TDBGridEh;
    Label4: TLabel;
    deDate: TDBDateTimeEditEh;
    cbWeather: TDBComboBox;
    dsDiary: TDataSource;
    aqDiary: TADOQuery;
    aqDiaryid: TAutoIncField;
    aqDiarytopic: TWideStringField;
    aqDiaryweather: TWideStringField;
    aqDiarycontent: TMemoField;
    edtSrh: TEdit;
    Label5: TLabel;
    RzSpacer1: TRzSpacer;
    aqDiarydiaryDate: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure dsDiaryDataChange(Sender: TObject; Field: TField);
    procedure edtSrhChange(Sender: TObject);
    procedure aqDiaryFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    FBookMark: TBookMark;
    procedure InitData;
    procedure FillList;
    procedure SetControls(AViewState: Boolean = True);
    //ʹģʽ�������������
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
  public
    { Public declarations }
  end;

var
  frmDiary: TfrmDiary;

function ShowDiary(): Boolean;

implementation

uses uData, uGlobal;

{$R *.dfm}

function ShowDiary(): Boolean;
begin
  Result := True;

  if not Assigned(frmDiary) then frmDiary := TfrmDiary.Create(Application.MainForm);
  if frmDiary.WindowState = wsMinimized then
    frmDiary.WindowState := wsNormal;

  frmDiary.InitData();
  frmDiary.Show();
end;

procedure TfrmDiary.WMSetCursor(var Msg: TWMSetCursor);
begin
  if (SmallInt(Msg.HitTest) = HTERROR) and (Msg.MouseMsg = WM_LBUTTONDOWN) then
    DefaultHandler(Msg)
  else inherited;
end;

procedure TfrmDiary.InitData;
begin
  dmPer.OpenQuery(aqDiary, 'SELECT * FROM [diary] ORDER BY diaryDate DESC');
  FillList();
end;

procedure TfrmDiary.FillList;
begin
  //�������
  cbWeather.Clear;
  with dmPer do
  begin
    OpenQuery(aqTemp, 'SELECT weather FROM [diary] WHERE weather <> '''' GROUP BY weather ORDER BY Count(weather) DESC, weather');
    while not aqTemp.Eof do
    begin
      cbWeather.Items.Append(aqTemp.FieldByName('weather').AsString);
      aqTemp.Next;
    end;
  end;
end;

procedure TfrmDiary.SetControls(AViewState: Boolean);
var
  clr: TColor;
begin
  actAdd.Enabled := AViewState;
  actEdit.Enabled := AViewState and (aqDiary.RecordCount <> 0);
  actDel.Enabled := AViewState and (aqDiary.RecordCount <> 0);

  actSave.Enabled := not AViewState;
  actCancel.Enabled := not AViewState;

  if AViewState then
    clr := VIEW_COLOR
  else clr := clWindow;
  edtTopic.Color := clr;
  deDate.Color := clr;
  cbWeather.Color := clr;
  meoContent.Color := clr;

  //���ÿɱ༭״̬
  dgDiary.Enabled := AViewState;
  edtTopic.ReadOnly := AViewState;
  deDate.ReadOnly := AViewState;
  cbWeather.ReadOnly := AViewState;
  meoContent.ReadOnly := AViewState;
  edtSrh.ReadOnly := not AViewState;

  if AViewState then
  begin
    edtSrh.OnChange(edtSrh);
    if aqDiary.BookmarkValid(FBookMark) then
    begin
      aqDiary.GotoBookmark(FBookMark);
      aqDiary.FreeBookmark(FBookMark);
      FBookMark := nil;
    end
    else aqDiary.First;
    dgDiary.SetFocus;
  end
  else edtTopic.SetFocus;                                    
end;

procedure TfrmDiary.FormCreate(Sender: TObject);
begin
  SetWindowLong(Handle, GWL_HWNDPARENT, HWND_DESKTOP);
end;

procedure TfrmDiary.FormShow(Sender: TObject);
begin
  SetControls();
end;

procedure TfrmDiary.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if actCancel.Enabled then actCancel.Execute;
end;

procedure TfrmDiary.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  if Msg.CharCode = VK_ESCAPE then
  begin
    if actCancel.Enabled then
      actCancel.Execute
    else actExit.Execute;
  end;
end;

procedure TfrmDiary.actAddExecute(Sender: TObject);
begin
  SetControls(False);
  aqDiary.Append();
  deDate.Value := Date();
  cbWeather.ItemIndex := 0;
  aqDiary.FieldByName('weather').AsString := cbWeather.Text;
end;

procedure TfrmDiary.actEditExecute(Sender: TObject);
begin
  SetControls(False);
  FBookMark := aqDiary.GetBookmark;
  aqDiary.Edit();
end;

procedure TfrmDiary.actDelExecute(Sender: TObject);
begin
  if MessageBox(Handle, 'ȷ��Ҫɾ��ѡ���ļ�¼ô��', '��ʾ', MB_ICONQUESTION + MB_YESNO) = IDYES then
  begin
    //��dgMultiSelect�£���Ϊ0
    if dgDiary.SelectedRows.Count = 0 then
      aqDiary.Delete()
    else dgDiary.SelectedRows.Delete;

    aqDiary.UpdateBatch();
  end;
  SetControls();
end;

procedure TfrmDiary.actSaveExecute(Sender: TObject);
  function DiaryExists(ADate: string): Boolean;
  var
    aqDate: TADOQuery;
  begin
    aqDate := TADOQuery.Create(Self);
    try
      aqDate.Clone(aqDiary, ltReadOnly);
      Result := aqDate.Locate('diaryDate', ADate, []) and (aqDiary.State = dsInsert);
    finally
      aqDate.Free;
    end;
  end;

var
  sDate: string;
begin
  if Trim(edtTopic.Text) = '' then
  begin
    MessageBox(Handle, '��������Ҫд���ռǱ��⣡', '��ʾ',  MB_ICONINFORMATION + MB_OK);
    edtTopic.SetFocus;
    Exit;
  end;

  sDate := deDate.Text;
  if not DiaryExists(sDate) then
  begin
    aqDiary.UpdateBatch();
    FillList();
    aqDiary.Sort := 'diaryDate DESC';
    SetControls();
  end
  else if MessageBox(Handle, '�����������ռ��Ѵ��ڣ���Ҫ�ϲ�������', '��ʾ',  MB_ICONQUESTION + MB_YESNO) = IDYES then
  begin
    dmPer.ExecSQL('UPDATE [diary] SET content=content + ' + QuotedStr(#13#10 + meoContent.Text) + ' WHERE diaryDate=#' + sDate + '#');
    aqDiary.Requery();
    SetControls();
  end
  else deDate.SetFocus;
end;

procedure TfrmDiary.actCancelExecute(Sender: TObject);
begin
  if aqDiary.State in [dsInsert, dsEdit] then
  begin
    aqDiary.CancelBatch();
    SetControls();
  end;
end;

procedure TfrmDiary.actExitExecute(Sender: TObject);
begin
  Close();
end;

procedure TfrmDiary.dsDiaryDataChange(Sender: TObject; Field: TField);
var
  RecNo: Integer;
begin
  if aqDiary.RecordCount <> 0 then
    Caption := '�ռǱ� - ' + aqDiary.FieldByName('topic').AsString
  else Caption := '�ռǱ�';
  if aqDiary.RecNo = -1 then
    RecNo := 0
  else RecNo := aqDiary.RecNo;
    sbDiary.Panels[0].Text := '��¼����' + IntToStr(RecNo) + '/' + IntToStr(aqDiary.RecordCount);

  if dgDiary.Focused then
  begin
    if GetAsyncKeyState(VK_CONTROL) <> 0 then
      dgDiary.Options := dgDiary.Options + [DBGridEh.dgMultiSelect]
    else dgDiary.Options := dgDiary.Options - [DBGridEh.dgMultiSelect];
  end;
end;

procedure TfrmDiary.edtSrhChange(Sender: TObject);
begin
  {��Ϊ�����ֶβ�֧��LIKE���������Բ�����ģ����ѯ����Filter := ...���С�
  �������ADOQuery��OnFilterRecord����������Filter := Trueʱ����
  ����ΪFalseһ�£���Ȼ������ΪTrue�����´���ΪTrueʱ�¼��������ٴδ���
  ��Filter = ''��������RecordCountΪ���˺�ģ����¼�����ԭ����}
  aqDiary.Filtered := False;
  aqDiary.Filtered := Trim(edtSrh.Text) <> '';

  //��RecNo���ж��Ƿ���û�м�¼
  aqDiary.First;
  actEdit.Enabled := aqDiary.RecNo <> -1;
  actDel.Enabled := aqDiary.RecNo <> -1;
end;

procedure TfrmDiary.aqDiaryFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := (Pos(Trim(edtSrh.Text), DataSet.FieldByName('topic').AsString) > 0) or
    (Pos(Trim(edtSrh.Text), FormatDateTime('yy-MM-dd', DataSet.FieldByName('diaryDate').AsDateTime)) > 0);
end;

end.
