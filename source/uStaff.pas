unit uStaff;

interface                                                                 

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, RzPanel, RzButton, ImgList, ActnList, StdCtrls,
  Mask, DBCtrls, DBCtrlsEh, Buttons, ComCtrls, DB, ADODB, DateUtils, IdGlobal,
  uGlobal, CtrlsEx, ExtDlgs, PNGImage, GifImage, Grids, DBGridEh, GridsEh;

type
  TfrmStaff = class(TForm)
    tbStaff: TRzToolbar;
    tbAdd: TRzToolButton;
    tbEdit: TRzToolButton;
    tbDel: TRzToolButton;
    Spacer1: TRzSpacer;       
    tbCancel: TRzToolButton;
    tbSave: TRzToolButton;
    Spacer2: TRzSpacer;
    tbExit: TRzToolButton;
    tbPrev: TRzToolButton;
    tbNext: TRzToolButton;
    Spacer0: TRzSpacer;
    ilStaff: TImageList;
    alStaff: TActionList;
    actAdd: TAction;
    actEdit: TAction;
    actDel: TAction;
    actSave: TAction;
    actCancel: TAction;
    actPrint: TAction;
    actPrev: TAction;
    actNext: TAction;
    gbBasic: TGroupBox;
    Label1: TLabel;
    edtNo: TDBEdit;
    Label2: TLabel;
    edtName: TDBEdit;
    edtSchool: TDBEdit;
    Label3: TLabel;
    cbSex: TDBComboBox;
    Label4: TLabel;
    deBirth: TDBDateTimeEditEh;
    Label5: TLabel;
    edtAge: TDBEdit;
    Label6: TLabel;
    cbFolk: TDBComboBox;
    Label7: TLabel;
    cbMarriage: TDBComboBox;
    Label8: TLabel;
    cbPolitics: TDBComboBox;
    Label9: TLabel;
    deInPoliDate: TDBDateTimeEditEh;
    Label10: TLabel;
    edtCardNo: TDBEdit;
    Label11: TLabel;
    deWorkDate: TDBDateTimeEditEh;
    Label12: TLabel;
    deGraDate: TDBDateTimeEditEh;
    cbCulture: TDBComboBox;
    Label13: TLabel;
    cbSpecial: TDBComboBox;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    edtNative: TDBEdit;
    Label17: TLabel;
    edtNaAddr: TDBEdit;
    Label18: TLabel;
    edtFileNo: TDBEdit;
    Label19: TLabel;
    deRegDate: TDBDateTimeEditEh;
    Label20: TLabel;
    gbDept: TGroupBox;
    pnlPhoto: TPanel;
    imgPhoto: TImage;
    Label21: TLabel;
    cbDept: TDBComboBox;
    Label25: TLabel;
    deDeptDate: TDBDateTimeEditEh;
    Label22: TLabel;
    cbDuty: TDBComboBox;
    Label24: TLabel;
    cbTechnic: TDBComboBox;
    Label23: TLabel;
    cbType: TDBComboBox;
    Label29: TLabel;
    edtSalaryNo: TDBEdit;
    Label30: TLabel;
    edtOldNo: TDBEdit;
    Label31: TLabel;
    edtMedNo: TDBEdit;
    gbContact: TGroupBox;
    Label26: TLabel;
    deDWDate: TDBDateTimeEditEh;
    gbOther: TGroupBox;
    Label32: TLabel;
    edtMobile: TDBEdit;
    Label37: TLabel;
    edtPostCode: TDBEdit;
    Label33: TLabel;
    edtTel: TDBEdit;
    Label34: TLabel;
    edtMail: TDBEdit;
    Label35: TLabel;
    edtCityTel: TDBEdit;
    Label36: TLabel;
    edtAddr: TDBEdit;
    Label38: TLabel;
    edtQQCode: TDBEdit;
    pcOther: TPageControl;
    tsSelf: TTabSheet;
    tsFami: TTabSheet;
    tsExper: TTabSheet;
    tsAandP: TTabSheet;
    tsTrain: TTabSheet;
    tsOther: TTabSheet;
    meoSelf: TDBMemo;
    meoFami: TDBMemo;
    meoExper: TDBMemo;
    meoOther: TDBMemo;
    edtReger: TDBEdit;
    Label28: TLabel;
    cbBank: TDBComboBox;
    Label27: TLabel;
    deLeftDate: TDBDateTimeEditEh;
    actDulAdd: TAction;
    tbDulAdd: TRzToolButton;
    Spacer3: TRzSpacer;
    cbKeepEdit: TCheckBox;
    odImg: TOpenPictureDialog;
    actHelp: TAction;
    btnAdd: TBitBtn;
    btnDel: TBitBtn;
    btnCap: TBitBtn;
    dgAP: TDBGridEh;
    dgTrain: TDBGridEh;
    aqAP: TADOQuery;
    aqTrain: TADOQuery;
    dsAP: TDataSource;
    dsTrain: TDataSource;
    tsMove: TTabSheet;
    dgMove: TDBGridEh;
    aqMove: TADOQuery;
    dsMove: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actPrevExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
    procedure actDulAddExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure deBirthExit(Sender: TObject);
    procedure edtCardNoExit(Sender: TObject);
    procedure edtCardNoKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnCapClick(Sender: TObject);
    procedure imgPhotoDblClick(Sender: TObject);
    procedure alStaffExecute(Action: TBasicAction; var Handled: Boolean);
    procedure dgAPTitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
    procedure dgTrainTitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
  private
    { Private declarations }
    FActOper: TActOper;
    FBookMark: TBookMark;
    FChanged: Boolean;
    FCaptionHeight: Integer;
    FDeptStr: string;
    procedure InitData;
    procedure InitCaptions;
    procedure SetActState;
    procedure SetNavState;
    //��ȡ���Ա����
    function GetMaxStaffNo: string;
    //���ݼ��
    function CheckData: Boolean;
    //�����������
    procedure SetExtraData;
    //��ȡ���֤����
    function GetIdCardArea(const AIdCardNo: string): string;
    //ʹģʽ�������������
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    //�ػ���󻯡���С����Ϣ
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    //�趨�������
    procedure WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
  public
    { Public declarations }
  end;

var
  frmStaff: TfrmStaff;

function ShowStaff(AActOper: TActOper; const ADeptStr: string = ''): Boolean;

implementation

uses uData, uApp, uVideo, uLunar;

var
  aqStaff: TADOQuery;

{$R *.dfm}

function ShowStaff(AActOper: TActOper; const ADeptStr: string): Boolean;
begin
  with TfrmStaff.Create(Application.MainForm) do
  begin
    FActOper := AActOper;
    FDeptStr := ADeptStr;
    try
      InitData();
      Result := ShowModal() = mrOk;
    finally
      Free;
    end;
  end;
end;

procedure TfrmStaff.WMSetCursor(var Message: TWMSetCursor);
begin
  if (SmallInt(Message.HitTest) = HTERROR) and (Message.MouseMsg = WM_LBUTTONDOWN) then
    DefaultHandler(Message)
  else inherited;
end;

procedure TfrmStaff.WMSize(var Message: TWMSize);
begin
  if not Active then Exit;

  if Message.SizeType = SIZE_MAXIMIZED then
  begin
    Top := FCaptionHeight;
    gbOther.Height := Height - 420;
  end
  else gbOther.Height := 153;
end;

procedure TfrmStaff.WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
begin
  inherited;
  with Message.MinMaxInfo^ do
  begin
    ptMaxPosition.X := Left;
    ptMaxPosition.Y := FCaptionHeight;
    ptMaxSize.X := Width;
    ptMaxSize.Y := Screen.Height - FCaptionHeight;
  end;
  Message.Result := 0;
end;

procedure TfrmStaff.InitData;
begin
  //�򿪴����ݼ�
  dmPer.OpenQuery(aqAP, 'SELECT * FROM [ap] WHERE staffId=:id');
  dmPer.OpenQuery(aqTrain, 'SELECT * FROM [train] WHERE staffId=:id');
  dmPer.OpenQuery(aqMove, 'SELECT * FROM [move] WHERE staffId=:id');
                                                                         
  //����Ա��ɫ...
  actAdd.Visible := App.AdminType <> atViewer;
  actEdit.Visible := actAdd.Visible;
  actDel.Visible := actAdd.Visible;
  actDulAdd.Visible := actAdd.Visible;
  Spacer1.Visible := actAdd.Visible;
  actSave.Visible := actAdd.Visible;
  actCancel.Visible := actAdd.Visible;
  Spacer2.Visible := actAdd.Visible;
  Spacer3.Visible := actAdd.Visible;
  cbKeepEdit.Visible := actAdd.Visible;

  cbKeepEdit.Checked := App.KeepEdit;
  aqStaff := dmPer.aqStaff;
  SetNavState();

  InitCaptions();
  //����...
  FillDept(cbDept);
  //����
  FillKind(cbFolk, ktFolk);
  //����״��
  FillKind(cbMarriage, ktMarriage);
  //������ò
  FillKind(cbPolitics, ktPolity);
  //ѧ��
  FillKind(cbCulture, ktCulture);
  //רҵ
  FillKind(cbSpecial, ktSpecial);
  //ְ��
  FillKind(cbDuty, ktDuty);
  //����
  FillKind(cbType, ktType);
  //ְ��
  FillKind(cbTechnic, ktTechnic);
  //��������
  FillKind(cbBank, ktBank);
  //�Ǽ���
  edtReger.Text := App.UserID;
end;

procedure TfrmStaff.InitCaptions;
var
  i, Index: Integer;
  lbl: TLabel;
begin
  //�˱�ʶΪ����[��ְ״̬]����
  Index := 1;
  with App.GridSet do
    for i := 1 to FieldLabels.Count - 1 do
    begin
      if i = 25 then Continue;

      lbl := TLabel(FindComponent('Label' + IntToStr(Index)));
      if (lbl <> nil) and (lbl.Caption <> FieldLabels[i] + '��') then
      begin
        lbl.Caption := FieldLabels[i] + '��';
        lbl.Left := lbl.FocusControl.Left - lbl.Width - 3;
      end;
      Inc(Index);
    end;
end;

procedure TfrmStaff.SetActState;
var
  i: Integer;
  clr: TColor;
  CurCmt: TComponent;
begin
  //actʹ��״̬...
  actAdd.Enabled := FActOper = aoView;
  actEdit.Enabled := actAdd.Enabled;
  actDel.Enabled := actAdd.Enabled and (aqStaff.RecordCount <> 0);
  actDulAdd.Enabled := actAdd.Enabled;

  actSave.Enabled := not actAdd.Enabled;
  actCancel.Enabled := actSave.Enabled;
  actPrint.Enabled := actEdit.Enabled;
  cbKeepEdit.Enabled := actAdd.Enabled;

  if FActOper = aoView then
    clr := VIEW_COLOR
  else clr := clWindow;
  //�ؼ�ʹ��״̬...
  for i := 0 to ComponentCount - 1 do
  begin
    CurCmt := Components[i];

    if CurCmt is TDBEdit then
    begin
      TDBEdit(CurCmt).ReadOnly := FActOper = aoView;
      TDBEdit(CurCmt).Color := clr;
    end
    else if CurCmt is TDBComboBox then
    begin
      TDBComboBox(CurCmt).ReadOnly := FActOper = aoView;
      TDBComboBox(CurCmt).Color := clr;
    end
    else if CurCmt is TDBDateTimeEditEh then
    begin
      TDBDateTimeEditEh(CurCmt).ReadOnly := FActOper = aoView;
      TDBDateTimeEditEh(CurCmt).Color := clr;
    end
    else if CurCmt is TDBMemo then
    begin
      TDBMemo(CurCmt).ReadOnly := FActOper = aoView;
      TDBMemo(CurCmt).Color := clr;
    end;
  end;

  //�ر�����
  edtNo.SetFocus;
  if FActOper in [aoAdd, aoDulAdd] then
    imgPhoto.Picture := nil
  else
  begin
    if FActOper <> aoView then edtName.SetFocus;
    edtNo.Color := VIEW_COLOR;
  end;
  edtAge.ReadOnly := True;
  edtAge.Color := VIEW_COLOR;
  edtReger.Color := VIEW_COLOR;
  deLeftDate.ReadOnly := True;
  deLeftDate.Color := VIEW_COLOR;
  btnAdd.Enabled := FActOper <> aoView;
  btnDel.Enabled := btnAdd.Enabled and (imgPhoto.Image <> '');
  btnCap.Enabled := btnAdd.Enabled;

  //�˴�����SetNavState������GotoBookmark֮ǰ
  if (FActOper = aoView) or (cbKeepEdit.Checked and (aqStaff.State = dsEdit)) then
    SetNavState()
  else
  begin
    actPrev.Enabled := False;
    actNext.Enabled := False;
  end;
end;

procedure TfrmStaff.SetNavState;
begin
  actPrev.Enabled := aqStaff.RecNo > 1;
  actNext.Enabled := aqStaff.RecNo <= aqStaff.RecordCount - 1;
  actEdit.Enabled := actAdd.Enabled and ((aqStaff.FieldByName('workState').AsInteger <> 1) or App.ParamSet.LeftCanEdit);
  if FActOper in [aoView, aoEdit] then
    Caption := 'Ա����Ϣ - ' + aqStaff.FieldByName('staffName').AsString
  else Caption := 'Ա����Ϣ - ���';

  //��ʱ��Ƭ·��
  if (aqStaff.State = dsEdit) and FileExists(App.TmpPhotoPath + aqStaff.FieldByName('photoStr').AsString) then
    imgPhoto.Image := App.TmpPhotoPath + aqStaff.FieldByName('photoStr').AsString
  else imgPhoto.Image := App.Path + 'photos\' + aqStaff.FieldByName('photoStr').AsString;
end;

function TfrmStaff.GetMaxStaffNo: string;
var
  sMaxNo, sNewNo: string;
begin
  //ADO��֧��Replace��������Right��Len���ʵ��
  sMaxNo := dmPer.GetFieldValue('SELECT Max(Right(staffNo, Len(staffNo) - Len(''' + App.ParamSet.Prefix + '''))) AS maxNo FROM [staffs]', 'maxNo');
  if IsNumeric(sMaxNo) then
  begin
    sNewNo := IntToStr(StrToInt(sMaxNo) + 1);
    if Length(sNewNo) < Length(sMaxNo) then
      sNewNo := StringOfChar('0', Length(sMaxNo) - Length(sNewNo)) + sNewNo;
    Result := App.ParamSet.Prefix + sNewNo;
  end
  else Result := App.ParamSet.Prefix;
end;

function TfrmStaff.CheckData: Boolean;
var
  staffNo, sSql: string;
begin
  Result := False;

  //���&�༭
  staffNo := edtNo.Text;

  if Trim(edtNo.Text) = '' then
  begin
    MessageBox(Handle, '��������Ҫ���Ա���Ĺ��ţ�', '��ʾ',  MB_ICONINFORMATION + MB_OK);
    edtNo.SetFocus;
    Exit;
  end;

  //����Ƿ��ظ�
  if FActOper <> aoEdit then
    sSql := 'SELECT id FROM [staffs] WHERE workState <> 1 AND staffNo=' + QuotedStr(edtNo.Text)
  else sSql := 'SELECT id FROM [staffs] WHERE workState <> 1 AND staffNo=' + QuotedStr(edtNo.Text) + ' AND id <> ' + aqStaff.FieldByName('id').AsString;
  if VarToStr(dmPer.GetFieldValue(sSql, 'id')) <> '' then
  begin
    MessageBox(Handle, PAnsiChar('�˹���[' + staffNo + ']��Ӧ����ְԱ���Ѵ��ڣ����������룡'), '��ʾ',  MB_ICONWARNING + MB_OK);
    edtNo.SetFocus;
    Exit;
  end;

  if Trim(edtName.Text) = '' then
  begin
    MessageBox(Handle, '��������Ҫ���Ա����������', '��ʾ',  MB_ICONINFORMATION + MB_OK);
    edtName.SetFocus;
    Exit;
  end;
  if Trim(cbDept.Text) = '' then
  begin
    MessageBox(Handle, PAnsiChar('��������Ҫ���Ա����' + App.ViewSet.DeptStr + '��'), '��ʾ',  MB_ICONINFORMATION + MB_OK);
    cbDept.SetFocus;
    Exit;
  end;

  Result := True;
end;

procedure TfrmStaff.SetExtraData;
var
  sOriImg, sPhoto: string;
begin
  //����ƴ��
  aqStaff.FieldByName('staffPY').AsString := GetPYStr(edtName.Text);
  RecCount(aqStaff.RecordCount);
  //��Ƭ...�˴���ʵ��bug�ģ��ڿ��������༭������£��������save�������ݲ��䣬��Ƭȴ����
  sPhoto := App.Path + 'photos\' + aqStaff.FieldByName('photoStr').AsString;
  if imgPhoto.Image = '' then
    aqStaff.FieldByName('photoStr').AsString := ''
  else if sPhoto <> imgPhoto.Image then
  begin
    //����ͼƬ
    if not SameText(ExtractFileExt(imgPhoto.Image), '.gif') and DealImage(imgPhoto.Image) then
      sOriImg := App.TmpJpg
    else sOriImg := imgPhoto.Image;

    //�ݴ�����ʱ��ƬĿ¼�У��Խ�������༭����
    sPhoto := App.TmpPhotoPath + edtNo.Text + ExtractFileExt(sOriImg);
    CopyFile(PAnsiChar(sOriImg), PAnsiChar(sPhoto), False);
    aqStaff.FieldByName('photoStr').AsString := edtNo.Text + ExtractFileExt(sPhoto);
  end;
end;

function TfrmStaff.GetIdCardArea(const AIdCardNo: string): string;
var
  aqArea: TADOQuery;
  sAreaNo: string;
begin
  Result := '';
  if Length(AIdCardNo) < 6 then Exit;

  sAreaNo := Copy(AIdCardNo, 1, 6);
  aqArea := TADOQuery.Create(Self);
  try
    dmPer.OpenQuery(aqArea, 'SELECT area FROM [idcard] WHERE code=' + sAreaNo);
    if not aqArea.Eof then Result := aqArea.FieldByName('area').AsString;
  finally
    aqArea.Free;
  end;
end;
                   
procedure TfrmStaff.FormCreate(Sender: TObject);
begin
  pcOther.ActivePageIndex := 0;

  //�趨�������
  FCaptionHeight := GetCaptionHeight();
end;

procedure TfrmStaff.FormShow(Sender: TObject);
begin
  //�������洫��
  case FActOper of
    aoAdd: actAdd.Execute;
    aoEdit: actEdit.Execute;
    aoDulAdd: actDulAdd.Execute;
  else
    //�������䣬Ϊ��ʾComboBox������
    aqStaff.Edit;
    aqStaff.Cancel;
    SetActState();

    Log.Write(App.UserId + '���Ա����[' + edtNo.Text + '(' + edtName.Text + ')]');
  end;

  //����ͼƬ
  imgPhoto.Image := App.Path + 'photos\' + aqStaff.FieldByName('photoStr').AsString;
end;

procedure TfrmStaff.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  case Msg.CharCode of
    VK_ESCAPE:
    begin
      if actCancel.Enabled and actCancel.Visible and not App.ParamSet.EscClose then
        actCancel.Execute
      else
      begin
        if actCancel.Enabled then actCancel.Execute;
        Close();
      end;
    end;
    VK_PRIOR:
      if actPrev.Enabled then actPrev.Execute;
    VK_NEXT:
      if actNext.Enabled then actNext.Execute;
  end;
end;

procedure TfrmStaff.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if actCancel.Enabled then actCancel.Execute;
  App.KeepEdit := cbKeepEdit.Checked;
  if not FChanged then
    ModalResult := mrCancel
  else ModalResult := mrOk;
end;

procedure TfrmStaff.actPrevExecute(Sender: TObject);
begin
  if cbKeepEdit.Checked and (aqStaff.State = dsEdit) then
  begin
    if not CheckData() then Exit;

    SetExtraData();
    aqStaff.Post;
    aqStaff.Prior;
    aqStaff.Edit;
  end
  else aqStaff.Prior;
  FChanged := True;
  SetNavState();
end;

procedure TfrmStaff.actNextExecute(Sender: TObject);
begin
  if cbKeepEdit.Checked and (aqStaff.State = dsEdit) then
  begin
    if not CheckData() then Exit;

    SetExtraData();
    aqStaff.Post;
    aqStaff.Next;
    aqStaff.Edit;
  end
  else aqStaff.Next;
  FChanged := True;
  SetNavState();
end;

procedure TfrmStaff.actAddExecute(Sender: TObject);
begin
  if not GetCanAdd(Handle) then Exit;

  FActOper := aoAdd;
  aqStaff.Append();
  //�Զ����
  if App.ParamSet.AutoCode then aqStaff.FieldByName('staffNo').AsString := GetMaxStaffNo();
  //deBirth.Value := StrToDate('1980-01-01');
  deRegDate.Value := Date();
  deDeptDate.Value := Date();
  //����˸�ֵ...
  aqStaff.FieldByName('sex').AsString := cbSex.Items[0];
  if cbFolk.Items.Count <> 0 then aqStaff.FieldByName('folk').AsString := cbFolk.Items[0];
  if cbMarriage.Items.Count <> 0 then aqStaff.FieldByName('marriage').AsString := cbMarriage.Items[0];
  if cbPolitics.Items.Count <> 0 then aqStaff.FieldByName('politics').AsString := cbPolitics.Items[0];
  aqStaff.FieldByName('reger').AsString := App.UserID;
  //�����ִ�
  aqStaff.FieldByName('deptName').AsString := FDeptStr;
  
  SetActState();
end;

procedure TfrmStaff.actEditExecute(Sender: TObject);
begin
  aqStaff.Edit();

  FActOper := aoEdit;
  SetActState();
end;

procedure TfrmStaff.actDelExecute(Sender: TObject);
var
  sPhoto: string;
begin
  if MessageBox(Handle, '��ȷ��Ҫɾ����ǰ�ļ�¼��', '��ʾ',  MB_ICONQUESTION + MB_YESNO) = IDYES then
  begin
    //ɾ����Ƭ
    sPhoto := App.Path + 'photos\' + aqStaff.FieldByName('photoStr').AsString;
    if FileExists(sPhoto) then DeleteFile(sPhoto);
    Log.Write(App.UserId + 'ɾ����Ա����[' + edtNo.Text + '(' + edtName.Text + ')]');

    //ɾ��
    aqStaff.Delete;
    aqStaff.UpdateBatch();

    PostMessage(Application.MainForm.Handle, WM_STAFFCHANGE, 0, 0);
  end;
end;

procedure TfrmStaff.actDulAddExecute(Sender: TObject);
var
  aqTemp: TADOQuery;
  i: Integer;
begin
  if not GetCanAdd(Handle) then Exit;

  //�˴�������dmPer�е�aqTemp������ΪGetMaxStaffNo�����õ�
  aqTemp := TADOQuery.Create(Self);
  try
    FActOper := aoDulAdd;
    FBookMark := aqStaff.GetBookmark;
    aqTemp.Clone(aqStaff, ltReadOnly);
    aqTemp.Locate('id', aqStaff.FieldByName('id').Value, []);
    aqStaff.Append;
    //�Զ����
    if App.ParamSet.AutoCode then aqStaff.FieldByName('staffNo').AsString := GetMaxStaffNo();

    //��ֵ
    for i := 0 to aqTemp.FieldCount - 1 do
    begin
      if Pos(aqTemp.Fields[i].FieldName, 'id, no, staffNo, staffName, staffPY, photoStr') <> 0 then Continue;
      if not VarIsNull(aqTemp.Fields[i].Value) then
        aqStaff.FieldByName(aqTemp.Fields[i].FieldName).Value := aqTemp.Fields[i].Value;
    end;
    //�����Ϣ����
    aqStaff.FieldByName('workState').AsInteger := 0;
    SetActState();
  finally
    aqTemp.Free;
  end;
end;

procedure TfrmStaff.actSaveExecute(Sender: TObject);
  procedure CopyPhotoFiles;
  var
    sr: TSearchRec;
    f: Integer;
  begin
    f := FindFirst(App.TmpPhotoPath + '*.*', faAnyFile, sr);
    while f = 0 do
    begin
      if FileExists(App.TmpPhotoPath + sr.Name) then
      begin
        DeleteFile(App.Path + 'photos\' + sr.Name);
        MoveFile(PAnsiChar(App.TmpPhotoPath + sr.Name), PAnsiChar(App.Path + 'photos\' + sr.Name));
      end;
      f := FindNext(sr);
    end;
    FindClose(sr);
  end;

var
  staffNo: string;
  KeepAdd, KeepDulAdd: Boolean;
begin
  if not CheckData() then Exit;

  staffNo := edtNo.Text;
  FDeptStr := cbDept.Text;
  //����...
  //�˴�Post��Ҫ�����Է��ֶ����Ƶ�һ�����ŵģ�������Post������DBCtrlsEh�д�����Ŷ�Ӱ�������ݼ�״̬
  SetExtraData();
  //Ӧ�ø��º����Ƭ...����cmd��ʽ����Ϊ�����첽��
  CopyPhotoFiles();
  //������������
  if deBirth.Focused then deBirth.OnExit(deBirth);
  if edtCardNo.Focused then edtCardNo.OnExit(edtCardNo);
  aqStaff.Post;
  aqStaff.UpdateBatch();

  FChanged := True;
  KeepAdd := (FActOper = aoAdd) and cbKeepEdit.Checked;
  KeepDulAdd := (FActOper = aoDulAdd) and cbKeepEdit.Checked;
  if FActOper in [aoAdd, aoDulAdd] then
  begin
    if aqStaff.BookmarkValid(FBookMark) then
    begin
      aqStaff.FreeBookmark(FBookMark);
      FBookMark := nil;
    end;

    Log.Write(App.UserId + '�����Ա����[' + edtNo.Text + '(' + edtName.Text + ')]');
  end
  else Log.Write(App.UserId + '������Ա����[' + edtNo.Text + '(' + edtName.Text + ')]');

  FActOper := aoView;
  SetActState();

  //PostMessage���ı�
  if not KeepAdd and not KeepDulAdd then
    PostMessage(Application.MainForm.Handle, WM_STAFFCHANGE, 0, 0);
  //�������
  if KeepAdd then actAdd.Execute;
  if KeepDulAdd then actDulAdd.Execute;
end;

procedure TfrmStaff.actCancelExecute(Sender: TObject);
begin
  //�����ʱ��Ƭ�ļ�
  case Win32PlatForm of
    VER_PLATFORM_WIN32_WINDOWS:  //win9x����ϵͳ
      WinExec(PAnsiChar('command.exe /k del "' + App.TmpPhotoPath + '*.*" /q'), SW_HIDE);
  else
    WinExec(PAnsiChar('cmd.exe /k del "' + App.TmpPhotoPath + '*.*" /q'), SW_HIDE);
  end;
  aqStaff.CancelBatch();
  
  //�Ը������ȡ����ĸ�λ
  if aqStaff.BookmarkValid(FBookMark)  then
  begin
    aqStaff.GotoBookmark(FBookMark);
    aqStaff.FreeBookmark(FBookMark);
    FBookMark := nil;
  end;
  FActOper := aoView;
  SetActState();
end;

procedure TfrmStaff.actPrintExecute(Sender: TObject);
begin
  dmPer.PrintCurrent();
end;

procedure TfrmStaff.actHelpExecute(Sender: TObject);
var
  HelpHtml: string;
begin
  if FActOper in [aoAdd, aoDulAdd] then
    HelpHtml := 'add.html'
  else HelpHtml := 'edit.html';

  HtmlHelp(Handle, App.Path + 'help.chm::/' + HelpHtml, HH_DISPLAY_TOPIC, 0);
end;

procedure TfrmStaff.deBirthExit(Sender: TObject);
begin
  if not (aqStaff.State in [dsInsert, dsEdit]) then Exit;
  //��������
  if Trim(deBirth.Text) <> '-  -' then
  begin
    aqStaff.FieldByName('age').AsInteger := YearsBetween(Date(), StrToDate(deBirth.Text));
    aqStaff.FieldByName('birthGreg').AsDateTime := ToGreg(deBirth.Value);
  end
  else aqStaff.FieldByName('age').AsVariant := NULL;
end;

procedure TfrmStaff.edtCardNoExit(Sender: TObject);
  function GetBirthFromIdCard(const AIDCard: string): TDate;
  begin
    Result := 0;
    if not (Length(AIDCard) in [15, 18]) then Exit;

    try
      if Length(AIDCard) = 15 then
        Result := StrToDate('19' + Copy(AIDCard, 7, 2) + '-' + Copy(AIdCard, 9, 2) + '-' + Copy(AIDCard, 11, 2))
      else Result := StrToDate(Copy(AIDCard, 7, 4) + '-' + Copy(AIdCard, 11, 2) + '-' + Copy(AIDCard, 13, 2))
    except
      //do nothing
    end;
  end;

  function GetSexFromIdCard(const AIDCard: string): string;
  var
    SexSign: Integer;
  begin
    Result := '��';
    if not (Length(AIDCard) in [15, 18]) then Exit;

    try
      if Length(AIDCard) = 15 then
        SexSign := StrToInt(Copy(AIDCard, 15, 1))
      else SexSign := StrToInt(Copy(AIDCard, 17, 1));
      if not Odd(SexSign) then Result := 'Ů';
    except
      //do nothing;
    end;
  end;

var
  sAddr: string;
begin
  //��������أ�Ҳ������֤�������ڼ��Ա�����ֻ���������
  //liujw��2008-7-18��������������ж�
  if aqStaff.State in [dsInsert, dsEdit] then
  begin
    sAddr := GetIdCardArea(edtCardNo.Text);
    if sAddr <> '' then aqStaff.FieldByName('nativePlace').AsString := sAddr;
    //if FormatDateTime('yyyy-mm-dd', deBirth.Value) = '1980-01-01' then
    if (Trim(deBirth.Text) = '-  -') and (GetBirthFromIdCard(edtCardNo.Text) <> 0) then
    begin
      aqStaff.FieldByName('birth').AsDateTime := GetBirthFromIdCard(edtCardNo.Text);
      deBirth.OnExit(deBirth);
    end;
    if cbSex.ItemIndex = 0 then aqStaff.FieldByName('sex').AsString := GetSexFromIdCard(edtCardNo.Text);
  end;
end;

procedure TfrmStaff.edtCardNoKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', 'X', 'x', #8]) then Key := #0;
end;

procedure TfrmStaff.btnAddClick(Sender: TObject);
begin
  if odImg.Execute then
  begin
    imgPhoto.Image := odImg.FileName;
    btnDel.Enabled := True;
  end;
end;

procedure TfrmStaff.btnDelClick(Sender: TObject);
begin
  imgPhoto.Image := '';
  btnDel.Enabled := False;
end;

procedure TfrmStaff.btnCapClick(Sender: TObject);
var
  StaffID: string;
begin
  StaffID := aqStaff.FieldByName('id').AsString;
  if ShowVideo(Self, StaffID) then
  begin
    imgPhoto.Image := App.TmpPath + StaffID + '.jpg';
    btnDel.Enabled := True;
  end;
end;

procedure TfrmStaff.imgPhotoDblClick(Sender: TObject);
begin
  if btnAdd.Enabled and (imgPhoto.Image = '') then
    btnAdd.OnClick(btnAdd)
  else ShowPhoto(Self, aqStaff.FieldByName('staffName').AsString, imgPhoto.Image);
end;

procedure TfrmStaff.alStaffExecute(Action: TBasicAction;
  var Handled: Boolean);
begin
  Handled := not TAction(Action).Visible;
end;

procedure TfrmStaff.dgAPTitleBtnClick(Sender: TObject; ACol: Integer;
  Column: TColumnEh);
begin
  DBGridEhTitleBtnClick(Sender, ACol, Column);
end;

procedure TfrmStaff.dgTrainTitleBtnClick(Sender: TObject; ACol: Integer;
  Column: TColumnEh);
begin
  DBGridEhTitleBtnClick(Sender, ACol, Column);
end;

end.
