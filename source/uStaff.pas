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
    //获取最大员工号
    function GetMaxStaffNo: string;
    //数据检测
    function CheckData: Boolean;
    //存诸处理后的数据
    procedure SetExtraData;
    //获取身份证籍贯
    function GetIdCardArea(const AIdCardNo: string): string;
    //使模式窗点可闪标题栏
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    //截获最大化、最小化消息
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    //设定最大化区域
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
  //打开从数据集
  dmPer.OpenQuery(aqAP, 'SELECT * FROM [ap] WHERE staffId=:id');
  dmPer.OpenQuery(aqTrain, 'SELECT * FROM [train] WHERE staffId=:id');
  dmPer.OpenQuery(aqMove, 'SELECT * FROM [move] WHERE staffId=:id');
                                                                         
  //管理员角色...
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
  //部门...
  FillDept(cbDept);
  //民族
  FillKind(cbFolk, ktFolk);
  //婚姻状况
  FillKind(cbMarriage, ktMarriage);
  //政治面貌
  FillKind(cbPolitics, ktPolity);
  //学历
  FillKind(cbCulture, ktCulture);
  //专业
  FillKind(cbSpecial, ktSpecial);
  //职务
  FillKind(cbDuty, ktDuty);
  //工种
  FillKind(cbType, ktType);
  //职称
  FillKind(cbTechnic, ktTechnic);
  //发卡银行
  FillKind(cbBank, ktBank);
  //登记人
  edtReger.Text := App.UserID;
end;

procedure TfrmStaff.InitCaptions;
var
  i, Index: Integer;
  lbl: TLabel;
begin
  //此标识为处理[任职状态]而设
  Index := 1;
  with App.GridSet do
    for i := 1 to FieldLabels.Count - 1 do
    begin
      if i = 25 then Continue;

      lbl := TLabel(FindComponent('Label' + IntToStr(Index)));
      if (lbl <> nil) and (lbl.Caption <> FieldLabels[i] + '：') then
      begin
        lbl.Caption := FieldLabels[i] + '：';
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
  //act使动状态...
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
  //控件使动状态...
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

  //特别处理项
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

  //此处调用SetNavState，须在GotoBookmark之前
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
    Caption := '员工信息 - ' + aqStaff.FieldByName('staffName').AsString
  else Caption := '员工信息 - 添加';

  //临时照片路径
  if (aqStaff.State = dsEdit) and FileExists(App.TmpPhotoPath + aqStaff.FieldByName('photoStr').AsString) then
    imgPhoto.Image := App.TmpPhotoPath + aqStaff.FieldByName('photoStr').AsString
  else imgPhoto.Image := App.Path + 'photos\' + aqStaff.FieldByName('photoStr').AsString;
end;

function TfrmStaff.GetMaxStaffNo: string;
var
  sMaxNo, sNewNo: string;
begin
  //ADO不支持Replace函数，用Right及Len替代实现
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

  //添加&编辑
  staffNo := edtNo.Text;

  if Trim(edtNo.Text) = '' then
  begin
    MessageBox(Handle, '请输入您要添加员工的工号！', '提示',  MB_ICONINFORMATION + MB_OK);
    edtNo.SetFocus;
    Exit;
  end;

  //检查是否重复
  if FActOper <> aoEdit then
    sSql := 'SELECT id FROM [staffs] WHERE workState <> 1 AND staffNo=' + QuotedStr(edtNo.Text)
  else sSql := 'SELECT id FROM [staffs] WHERE workState <> 1 AND staffNo=' + QuotedStr(edtNo.Text) + ' AND id <> ' + aqStaff.FieldByName('id').AsString;
  if VarToStr(dmPer.GetFieldValue(sSql, 'id')) <> '' then
  begin
    MessageBox(Handle, PAnsiChar('此工号[' + staffNo + ']对应的在职员工已存在，请重新输入！'), '提示',  MB_ICONWARNING + MB_OK);
    edtNo.SetFocus;
    Exit;
  end;

  if Trim(edtName.Text) = '' then
  begin
    MessageBox(Handle, '请输入您要添加员工的姓名！', '提示',  MB_ICONINFORMATION + MB_OK);
    edtName.SetFocus;
    Exit;
  end;
  if Trim(cbDept.Text) = '' then
  begin
    MessageBox(Handle, PAnsiChar('请输入您要添加员工的' + App.ViewSet.DeptStr + '！'), '提示',  MB_ICONINFORMATION + MB_OK);
    cbDept.SetFocus;
    Exit;
  end;

  Result := True;
end;

procedure TfrmStaff.SetExtraData;
var
  sOriImg, sPhoto: string;
begin
  //名字拼音
  aqStaff.FieldByName('staffPY').AsString := GetPYStr(edtName.Text);
  RecCount(aqStaff.RecordCount);
  //照片...此处其实有bug的：在可以连续编辑的情况下，假如最后不save，则内容不变，照片却变了
  sPhoto := App.Path + 'photos\' + aqStaff.FieldByName('photoStr').AsString;
  if imgPhoto.Image = '' then
    aqStaff.FieldByName('photoStr').AsString := ''
  else if sPhoto <> imgPhoto.Image then
  begin
    //处理图片
    if not SameText(ExtractFileExt(imgPhoto.Image), '.gif') and DealImage(imgPhoto.Image) then
      sOriImg := App.TmpJpg
    else sOriImg := imgPhoto.Image;

    //暂存于临时照片目录中，以解决连续编辑问题
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

  //设定最大区域
  FCaptionHeight := GetCaptionHeight();
end;

procedure TfrmStaff.FormShow(Sender: TObject);
begin
  //由主界面传入
  case FActOper of
    aoAdd: actAdd.Execute;
    aoEdit: actEdit.Execute;
    aoDulAdd: actDulAdd.Execute;
  else
    //下面两句，为显示ComboBox数据用
    aqStaff.Edit;
    aqStaff.Cancel;
    SetActState();

    Log.Write(App.UserId + '浏览员工：[' + edtNo.Text + '(' + edtName.Text + ')]');
  end;

  //加载图片
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
  //自动编号
  if App.ParamSet.AutoCode then aqStaff.FieldByName('staffNo').AsString := GetMaxStaffNo();
  //deBirth.Value := StrToDate('1980-01-01');
  deRegDate.Value := Date();
  deDeptDate.Value := Date();
  //须如此赋值...
  aqStaff.FieldByName('sex').AsString := cbSex.Items[0];
  if cbFolk.Items.Count <> 0 then aqStaff.FieldByName('folk').AsString := cbFolk.Items[0];
  if cbMarriage.Items.Count <> 0 then aqStaff.FieldByName('marriage').AsString := cbMarriage.Items[0];
  if cbPolitics.Items.Count <> 0 then aqStaff.FieldByName('politics').AsString := cbPolitics.Items[0];
  aqStaff.FieldByName('reger').AsString := App.UserID;
  //部门字串
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
  if MessageBox(Handle, '您确定要删除当前的记录吗？', '提示',  MB_ICONQUESTION + MB_YESNO) = IDYES then
  begin
    //删除照片
    sPhoto := App.Path + 'photos\' + aqStaff.FieldByName('photoStr').AsString;
    if FileExists(sPhoto) then DeleteFile(sPhoto);
    Log.Write(App.UserId + '删除了员工：[' + edtNo.Text + '(' + edtName.Text + ')]');

    //删除
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

  //此处不能用dmPer中的aqTemp，是因为GetMaxStaffNo中有用到
  aqTemp := TADOQuery.Create(Self);
  try
    FActOper := aoDulAdd;
    FBookMark := aqStaff.GetBookmark;
    aqTemp.Clone(aqStaff, ltReadOnly);
    aqTemp.Locate('id', aqStaff.FieldByName('id').Value, []);
    aqStaff.Append;
    //自动编号
    if App.ParamSet.AutoCode then aqStaff.FieldByName('staffNo').AsString := GetMaxStaffNo();

    //赋值
    for i := 0 to aqTemp.FieldCount - 1 do
    begin
      if Pos(aqTemp.Fields[i].FieldName, 'id, no, staffNo, staffName, staffPY, photoStr') <> 0 then Continue;
      if not VarIsNull(aqTemp.Fields[i].Value) then
        aqStaff.FieldByName(aqTemp.Fields[i].FieldName).Value := aqTemp.Fields[i].Value;
    end;
    //请假信息消除
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
  //保存...
  //此处Post需要；测试发现对新移到一个部门的，若不用Post，似是DBCtrlsEh中代码干扰而影响其数据集状态
  SetExtraData();
  //应用更新后的照片...不用cmd方式，因为它的异步性
  CopyPhotoFiles();
  //更新阳历生日
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

    Log.Write(App.UserId + '添加了员工：[' + edtNo.Text + '(' + edtName.Text + ')]');
  end
  else Log.Write(App.UserId + '更新了员工：[' + edtNo.Text + '(' + edtName.Text + ')]');

  FActOper := aoView;
  SetActState();

  //PostMessage句会改变
  if not KeepAdd and not KeepDulAdd then
    PostMessage(Application.MainForm.Handle, WM_STAFFCHANGE, 0, 0);
  //连续添加
  if KeepAdd then actAdd.Execute;
  if KeepDulAdd then actDulAdd.Execute;
end;

procedure TfrmStaff.actCancelExecute(Sender: TObject);
begin
  //清除临时照片文件
  case Win32PlatForm of
    VER_PLATFORM_WIN32_WINDOWS:  //win9x操作系统
      WinExec(PAnsiChar('command.exe /k del "' + App.TmpPhotoPath + '*.*" /q'), SW_HIDE);
  else
    WinExec(PAnsiChar('cmd.exe /k del "' + App.TmpPhotoPath + '*.*" /q'), SW_HIDE);
  end;
  aqStaff.CancelBatch();
  
  //对复制添加取消后的复位
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
  //计算年龄
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
    Result := '男';
    if not (Length(AIDCard) in [15, 18]) then Exit;

    try
      if Length(AIDCard) = 15 then
        SexSign := StrToInt(Copy(AIDCard, 15, 1))
      else SexSign := StrToInt(Copy(AIDCard, 17, 1));
      if not Odd(SexSign) then Result := '女';
    except
      //do nothing;
    end;
  end;

var
  sAddr: string;
begin
  //计算出生地，也可以验证出生日期及性别；这里只计算出生地
  //liujw于2008-7-18加入其它两项的判断
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
