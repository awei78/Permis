unit uDataInit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBase, StdCtrls, Buttons, ExtCtrls, ComCtrls, Mask, RzEdit,
  RzBtnEdt, RzPrgres, CheckLst;

type
  TfrmDataInit = class(TfrmBase)
    Label3: TLabel;
    pb: TProgressBar;
    imgInit: TImage;
    btnReset: TButton;
    cbSelAll: TCheckBox;
    cbInit: TCheckListBox;
    Label1: TLabel;
    procedure btnResetClick(Sender: TObject);
    procedure cbSelAllClick(Sender: TObject);
    procedure cbInitClickCheck(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure DoInitOper;
  protected
    procedure InitData; override;
    procedure SaveData; override;
    procedure ResetData; override;
    //�������
    function CheckData: Boolean; override;
  public
    { Public declarations }
  end;

var
  frmDataInit: TfrmDataInit;

function ShowDataInit(): Boolean;

implementation

uses uGlobal, uData;

{$R *.dfm}

function ShowDataInit(): Boolean;
begin
  with TfrmDataInit.Create(Application.MainForm) do
  begin
    HelpHtml := 'datainit.html';
    try
      InitData();
      Result := ShowModal() = mrOk;
    finally
      Free;
    end;
  end;
end;

procedure TfrmDataInit.DoInitOper;
  procedure UpdateProgress;
  begin
    pb.Position := pb.Position + 1;
    pb.Update;
    Application.ProcessMessages;
  end;

var
  i: Integer;
begin
  pb.Max := 0;
  for i := 0 to cbInit.Count - 1 do
    if cbInit.Checked[i] then pb.Max := pb.Max + 1;

  //�������Ա
  if cbInit.Checked[0] then
  begin
    UpdateProgress();
    dmPer.ExecSQL('DELETE FROM [admin]');
    dmPer.ExecSQL('INSERT INTO [admin](uid, pwd) VALUES(''admin'', '''')');
  end;
  //���������Ϣ
  if cbInit.Checked[1] then
  begin
    UpdateProgress();
    dmPer.ExecSQL('DELETE FROM [dept]');
    App.DeptList.Clear;
  end;
  //���������Ϣ
  if cbInit.Checked[2] then
  begin
    UpdateProgress();
    dmPer.ExecSQL('DELETE FROM [dict]');
  end;
  //���Ա����Ϣ
  if cbInit.Checked[3] then
  begin
    UpdateProgress();
    dmPer.ExecSQL('DELETE FROM [staffs]');
  end;
  //������ͼ�¼
  if cbInit.Checked[4] then
  begin
    UpdateProgress();
    dmPer.ExecSQL('DELETE FROM [ap]');
  end;
  //�����ѵ��¼
  if cbInit.Checked[5] then
  begin
    UpdateProgress();
    dmPer.ExecSQL('DELETE FROM [train]');
  end;
  //�����ټ�¼
  if cbInit.Checked[6] then
  begin
    UpdateProgress();
    dmPer.ExecSQL('DELETE FROM [leave]');
    dmPer.ExecSQL('UPDATE [staffs] SET workState = 0 WHERE workState = 2');
    dmPer.aqStaff.Requery();
  end;
  //���������¼
  if cbInit.Checked[7] then
  begin
    UpdateProgress();
    dmPer.ExecSQL('DELETE FROM [move]');
  end;
  //�����ְ��¼
  if cbInit.Checked[8] then
  begin
    UpdateProgress();
    dmPer.ExecSQL('DELETE FROM [left]');
  end;
  //�����ְ��¼
  if cbInit.Checked[9] then
  begin
    UpdateProgress();
    dmPer.ExecSQL('DELETE FROM [back]');
  end;
  //�����ͬ��¼
  if cbInit.Checked[10] then
  begin
    UpdateProgress();
    dmPer.ExecSQL('DELETE FROM [contract]');
  end;
  //����ռ���Ϣ
  if cbInit.Checked[11] then
  begin
    UpdateProgress();
    dmPer.ExecSQL('DELETE FROM [diary]');
    PostMessage(FindWindow('TfrmDiary', nil), WM_CLOSE, 0, 0);
  end;
  //���ͨѶ¼
  if cbInit.Checked[12] then
  begin
    UpdateProgress();
    dmPer.ExecSQL('DELETE FROM [addrlist]');
    PostMessage(FindWindow('TfrmAddr', nil), WM_CLOSE, 0, 0);
  end;
end;

function TfrmDataInit.CheckData: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to cbInit.Count - 1 do
    Result := Result or cbInit.Checked[i];

  if not Result then
  begin
    MessageBox(Handle, PAnsiChar('��ѡ����Ҫ��������ݱ�'), '��ʾ', MB_OK + MB_ICONWARNING);
    btnReset.OnClick(btnReset);
    Exit;
  end;

  Result := inherited CheckData() and (MessageBox(Handle, '���ݳ�ʼ���������ѡ������ݣ���ȷ��Ҫ��ʼ����', '��ʾ',  MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON2) = IDYES);
end;

procedure TfrmDataInit.InitData;
begin
  with cbInit, App.InitSet do
  begin
    Checked[0] := InitAdmin;
    Checked[1] := InitDept;
    Checked[2] := InitKind;
    Checked[3] := InitStaffs;
    Checked[4] := InitAP;
    Checked[5] := InitTrain;
    Checked[6] := InitLeave;
    Checked[7] := InitMove;
    Checked[8] := InitLeft;
    Checked[9] := InitBack;
    Checked[10] := InitCont;
    Checked[11] := InitDiary;
    Checked[12] := InitAddr;
  end;
  cbInit.OnClickCheck(cbInit);
end;

procedure TfrmDataInit.SaveData;
var
  i: Integer;
  sLog: string;
begin
  Screen.Cursor := crHourGlass;
  try
    DoInitOper();
  finally
    Screen.Cursor := crDefault;
  end;

  if cbInit.Checked[1] or cbInit.Checked[2] or cbInit.Checked[3] then
    PostMessage(Application.MainForm.Handle, WM_DATARESTORE, 0, 0);

  //MessageBox(Handle, PAnsiChar('��ѡ�����������ա�'), '��ʾ', MB_OK + MB_ICONINFORMATION);
  for i := 0 to cbInit.Items.Count - 1 do
    if cbInit.Checked[i] then sLog := sLog + ', ' + cbInit.Items[i];
  sLog := Copy(sLog, 3, Length(sLog) - 2);
  Log.Write(App.UserID + '���г�ʼ��' + sLog + '����');
end;

procedure TfrmDataInit.ResetData;
var
  i: Integer;
begin
  for i := 0 to cbInit.Count - 1 do
    cbInit.Checked[i] := (i >= 3) and (i <= 10);
end;

procedure TfrmDataInit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  with cbInit, App.InitSet do
  begin
    InitAdmin := Checked[0];
    InitDept := Checked[1];
    InitKind := Checked[2] ;
    InitStaffs := Checked[3];
    InitAP := Checked[4];
    InitTrain := Checked[5];
    InitLeave := Checked[6];
    InitMove := Checked[7];
    InitLeft := Checked[8];
    InitBack := Checked[9];
    InitCont := Checked[10];
    InitDiary := Checked[11];
    InitAddr := Checked[12];
  end;
end;

procedure TfrmDataInit.btnResetClick(Sender: TObject);
begin
  ResetData();
end;

procedure TfrmDataInit.cbSelAllClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to cbInit.Count - 1 do
    cbInit.Checked[i] := cbSelAll.Checked;
end;

procedure TfrmDataInit.cbInitClickCheck(Sender: TObject);
var
  i: Integer;
  AllChecked: Boolean;
begin
  AllChecked := True;
  for i := 0 to cbInit.Count - 1 do
    if not cbInit.Checked[i] then
    begin
      AllChecked := False;
      Break;
    end;

  //���ж�
  if AllChecked and not cbSelAll.Checked then
  begin
    cbSelAll.OnClick := nil;
    cbSelAll.Checked := True;
    cbSelAll.OnClick := cbSelAllClick;
  end;
  if cbSelAll.Checked and not AllChecked then
  begin
    cbSelAll.OnClick := nil;
    cbSelAll.Checked := False;
    cbSelAll.OnClick := cbSelAllClick;
  end;
end;

end.
