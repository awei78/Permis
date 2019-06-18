unit uLeave;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBase, uDlgBase, uGlobal, StdCtrls, ComCtrls, RzEdit, DB, ADODB,
  Grids, DBGridEh, ExtCtrls, RzPanel, Mask, RzBtnEdt, Buttons, Math, DateUtils;

type
  TfrmLeave = class(TfrmDlgBase)
    lblDate: TLabel;
    lblReger: TLabel;
    dpLeave: TDateTimePicker;
    edtReger: TEdit;
    Label5: TLabel;
    edtDay: TRzNumericEdit;
    udDay: TUpDown;
    Label6: TLabel;
    meoReason: TMemo;
    Label7: TLabel;
    meoDes: TMemo;
    lblUnDate: TLabel;
    dpUnDate: TDateTimePicker;
    btnPrint: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure dpLeaveChange(Sender: TObject);
    procedure edtDayChange(Sender: TObject);
    procedure udDayChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure btnPrintClick(Sender: TObject);
    procedure dg_staffDblClick(Sender: TObject);
  private
    { Private declarations }
    FLeaveType: TLeaveType;
    FAQInqu: TADOQuery;
    FTVInqu: TTreeView;
  protected
    procedure InitData; override;
    procedure LoadData; override;
    procedure SaveData; override;
    //检查数据
    function CheckData: Boolean; override;
  public
    { Public declarations }
  end;

var
  frmLeave: TfrmLeave;

function ShowLeave(const ALeaveType: TLeaveType; AAQInqu: TADOQuery = nil; ATVInqu: TTreeView = nil): Boolean;

implementation

uses uData;

{$R *.dfm}

var
  aqStaff: TADOQuery;

function ShowLeave(const ALeaveType: TLeaveType; AAQInqu: TADOQuery; ATVInqu: TTreeView): Boolean;
begin
  with TfrmLeave.Create(Application.MainForm) do
  begin
    HelpHtml := 'leave.html';
    imgHelp.Visible := False;
    FLeaveType := ALeaveType;
    FAQInqu := AAQInqu;
    FTVInqu := ATVInqu;
    try
      InitData();
      LoadData();
      Result := ShowModal() = mrOk;
      if not Result and (FAQInqu <> nil) then FAQInqu.CancelBatch();
    finally
      Free;
    end;
  end;
end;

{ TfrmLeave }

procedure TfrmLeave.InitData;
var
  i: Integer;
begin
  if FTVInqu <> nil then
    with FTVInqu do
    begin
      if (Selected.Level >= 2) and IsDeptNode(Selected) then
        FFilter := 'deptName LIKE ' + QuotedStr(GetDeptStr(Selected) + '%')
      else FFilter := '';
    end;
  FSqlStr := 'SELECT id, staffNo, staffName, staffPY, sex, deptName FROM [staffs] WHERE workState = 0';
  inherited;

  aqStaff := dmPer.aqStaff;
  if lblReger.Caption <> App.ViewSet.RegerStr + '：' then
  begin
    lblReger.Caption := App.ViewSet.RegerStr + '：';
    lblReger.Left := lblReger.FocusControl.Left - lblReger.Width - 3;
  end;

  //数据集赋值
  if FAQInqu <> nil then
  begin
    if FLeaveType = ltLeave then
      FAQInqu.Append()
    else FAQInqu.Edit;
  end;

  edtStaNo.Enabled := (FAQInqu <> nil) and (FLeaveType = ltLeave);
  dpLeave.Enabled := FLeaveType <> ltUnLeave;
  meoReason.Enabled := dpLeave.Enabled;
  dpUnDate.Enabled := FLeaveType <> ltLeave;

  //颜色...
  for i := 0 to ComponentCount - 1 do
  begin
    if (Components[i] is TWinControl) and not TWinControl(Components[i]).Enabled then
    begin
      if Components[i] is TEdit then TEdit(Components[i]).Color := VIEW_COLOR;
      if Components[i] is TMemo then TMemo(Components[i]).Color := VIEW_COLOR;
      if Components[i] is TDateTimePicker then TDateTimePicker(Components[i]).Color := VIEW_COLOR;
    end;
  end;
end;

procedure TfrmLeave.LoadData;
begin
  if FLeaveType = ltLeave then
  begin
    if FAQInqu = nil then
    begin
      edtStaNo.Text := aqStaff.FieldByName('staffNo').AsString;
      edtStaName.Text := aqStaff.FieldByName('staffName').AsString;
    end;
    dpLeave.Date := Date();
    edtDay.OnChange(edtDay);
    edtReger.Text := App.UserID;

    if edtStaName.Text <> '' then Caption := '员工请假 - ' + edtStaName.Text;
    btnOk.Caption := '请假(&S)';
  end
  //销假、编辑
  else
  begin
    with dmPer do
    begin
      //查询窗体，销假或者编辑
      if FAQInqu <> nil
        then aqTemp := FAQInqu
      else OpenQuery(aqTemp, 'SELECT TOP 1 * FROM [leave] WHERE staffNo=' + QuotedStr(aqStaff.FieldByName('staffNo').AsString) + ' AND isLeave=True ORDER BY id DESC');
      if not aqTemp.Eof then
      begin
        edtStaNo.Text   := aqTemp.FieldByName('staffNo').AsString;
        edtStaName.Text := aqTemp.FieldByName('staffName').AsString;
        dpLeave.Date    := aqTemp.FieldByName('leaveDate').AsDateTime;
        edtDay.Value    := aqTemp.FieldByName('leaveDay').AsFloat;
        udDay.Position  := Floor(edtDay.Value);
        meoReason.Text  := aqTemp.FieldByName('leaveReason').AsString;
        meoDes.Text     := aqTemp.FieldByName('des').AsString;
        dpUnDate.Date   := aqTemp.FieldByName('unLeaveDate').AsDateTime;
        edtReger.Text   := aqTemp.FieldByName('reger').AsString;

        if FLeaveType = ltUnLeave then
        begin
          Caption := '员工销假 - ' + edtStaName.Text;
          btnOk.Caption := '销假(&S)';
        end
        else
        begin
          Caption := '请假信息修改 - ' + edtStaName.Text;
          btnOk.Caption := '确定(&S)';
        end;
      end;
    end;
  end;
end;

function TfrmLeave.CheckData: Boolean;
begin
  if Trim(edtDay.Text) = '0' then
  begin
    Result := False;
    MessageBox(Handle, PAnsiChar('请设置[' + edtStaName.Text + ']要请假的天数。'), '提示',  MB_ICONWARNING + MB_OK);
    edtDay.SetFocus;
    Exit;
  end;

  if Trim(meoReason.Text) = '' then
  begin
    Result := False;
    MessageBox(Handle, PAnsiChar('请输入[' + edtStaName.Text + ']的请假原因。'), '提示',  MB_ICONWARNING + MB_OK);
    meoReason.SetFocus;
    Exit;
  end;

  Result := inherited CheckData();
end;

procedure TfrmLeave.SaveData;
var
  sSql: string;
  BookMark: TBookMark;
begin
  //请假
  if FLeaveType = ltLeave then
  begin
    //主界面操作
    if FAQInqu = nil then
    begin
      sSql := 'INSERT INTO [leave](staffId, staffNo, staffName, staffPY, sex, deptName, leaveDate, leaveDay, leaveReason, des, unLeaveDate, reger) ' +
              'VALUES(' + aqStaff.FieldByName('id').AsString + ', ' + QuotedStr(edtStaNo.Text) + ', ' + QuotedStr(edtStaName.Text) +
              ', ' + QuotedStr(GetPYStr(edtStaName.Text)) + ', ' + QuotedStr(aqStaff.FieldByName('sex').AsString) +
              ', ' + QuotedStr(aqStaff.FieldByName('deptName').AsString) + ', #' + DateToStr(dpLeave.Date) + '#, ' + edtDay.Text +
              ', ' + QuotedStr(meoReason.Text) +  ', ' + QuotedStr(meoDes.Text) + ', #' + DateToStr(dpUnDate.Date) + '#, ' + QuotedStr(edtReger.Text) + ')';
      dmPer.ExecSQL(sSql);
      dmPer.OpenLeave();
      //更新主界面
      aqStaff.Edit;
      aqStaff.FieldByName('workState').AsInteger := 2;
      aqStaff.Post;
      aqStaff.UpdateBatch();
    end
    else
    begin
      with FAQInqu do
      begin
        FieldByName('staffId').AsString     := aq_staff.FieldByName('id').AsString;
        FieldByName('staffNo').AsString     := edtStaNo.Text;
        FieldByName('staffName').AsString   := edtStaName.Text;
        FieldByName('staffPY').AsString     := aq_staff.FieldByName('staffPY').AsString;
        FieldByName('sex').AsString         := aq_staff.FieldByName('sex').AsString;
        FieldByName('deptName').AsString    := aq_staff.FieldByName('deptName').AsString;
        FieldByName('leaveDate').AsString   := DateToStr(dpLeave.Date);
        FieldByName('leaveDay').AsFloat     := edtDay.Value;
        FieldByName('leaveReason').AsString := meoReason.Text;
        FieldByName('des').AsString         := meoDes.Text;
        FieldByName('unLeaveDate').AsString := DateToStr(dpUnDate.Date);
        FieldByName('reger').AsString       := App.UserID;
        FieldByName('isLeave').AsBoolean    := True;

        Post;
        UpdateBatch();
      end;
      //更新主界面
      BookMark := aqStaff.GetBookmark;
      if aqStaff.Locate('id', aq_staff.FieldByName('id').Value, []) then
      begin
        aqStaff.Edit;
        aqStaff.FieldByName('workState').AsInteger := 2;
        aqStaff.Post;
        aqStaff.UpdateBatch();
      end;
      if aqStaff.BookmarkValid(BookMark) then
      begin
        aqStaff.GotoBookmark(BookMark);
        aqStaff.FreeBookmark(BookMark); 
      end;
    end;

    Log.Write(App.UserID + '对员工[' + edtStaName.Text + ']进行请假操作');
  end
  //销假&编缉
  else
  begin
    //销假
    if FLeaveType = ltUnLeave then
    begin
      if FAQInqu = nil then
      begin
        sSql := 'UPDATE [leave] SET leaveDay=' + edtDay.Text + ', leaveReason=' + QuotedStr(meoReason.Text) + ', des=' + QuotedStr(meoDes.Text) +
                ', unLeaveDate=#' + DateToStr(dpUnDate.Date) + '#, isLeave=False WHERE id=' + aq_staff.FieldByName('staffId').AsString;
        dmPer.ExecSQL(sSql);
        dmPer.OpenLeave();
        aqStaff.Edit;
        aqStaff.FieldByName('workState').AsInteger := 0;
        aqStaff.Post;
        aqStaff.UpdateBatch();
      end
      else
      begin
        with FAQInqu do
        begin
          FieldByName('leaveDay').AsFloat     := edtDay.Value;
          FieldByName('des').AsString         := meoDes.Text;
          FieldByName('unLeaveDate').AsString := DateToStr(dpUnDate.Date);
          FieldByName('isLeave').AsBoolean    := False;

          Post;
          UpdateBatch();
        end;
        //更新主界面
        BookMark := aqStaff.GetBookmark;
        if aqStaff.Locate('staffNo', edtStaNo.Text, []) then
        begin
          aqStaff.Edit;
          aqStaff.FieldByName('workState').AsInteger := 0;
          aqStaff.Post;
          aqStaff.UpdateBatch();
        end;
        if aqStaff.BookmarkValid(BookMark) then
        begin
          aqStaff.GotoBookmark(BookMark);
          aqStaff.FreeBookmark(BookMark);
        end;
      end;

      Log.Write(App.UserID + '对员工[' + edtStaName.Text + ']进行销假操作');
    end
    //编辑
    else
    begin
      with FAQInqu do
      begin
        FieldByName('leaveDate').AsString   := DateToStr(dpLeave.Date);
        FieldByName('leaveDay').AsFloat     := edtDay.Value;
        FieldByName('leaveReason').AsString := meoReason.Text;
        FieldByName('des').AsString         := meoDes.Text;
        FieldByName('unLeaveDate').AsString := DateToStr(dpUnDate.Date);
        FieldByName('reger').AsString       := App.UserID;

        Post;
        UpdateBatch();
      end;
    end;
  end;
end;

procedure TfrmLeave.FormShow(Sender: TObject);
begin
  inherited;
  if FLeaveType = ltUnLeave then meoDes.SetFocus;
end;

procedure TfrmLeave.dpLeaveChange(Sender: TObject);
begin
  edtDay.OnChange(edtDay);
end;

procedure TfrmLeave.edtDayChange(Sender: TObject);
begin
  dpUnDate.Date := IncDay(dpLeave.Date, Floor(edtDay.Value));
end;

procedure TfrmLeave.udDayChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
var
  sDecimal: string;
begin
  if not (NewValue in [udDay.Min..udDay.Max]) then Exit;

  if Pos('.', edtDay.Text) <> 0 then
    try
      sDecimal := Copy(edtDay.Text, Pos('.', edtDay.Text), Length(edtDay.Text) - Pos('.', edtDay.Text) + 1);
      if NewValue + StrToFloat(sDecimal) > udDay.Max then Exit;
    except
      Exit;
    end;

  if Pos('.', edtDay.Text) = 0 then
    edtDay.Text := IntToStr(NewValue)
  else edtDay.Text := IntToStr(NewValue) + Copy(edtDay.Text, Pos('.', edtDay.Text), Length(edtDay.Text) - Pos('.', edtDay.Text) + 1);
end;

procedure TfrmLeave.btnPrintClick(Sender: TObject);
var
  sSql: string;
  isLeave: Boolean;
begin
  if not CheckData() then Exit;

  if FAQInqu = nil then
    isLeave := True
  else isLeave := FAQInqu.FieldByName('isLeave').AsBoolean;

  sSql := Format('SELECT ''%s'' AS staffNo, ''%s'' AS staffName, ''%s'' AS leaveDate, ''%s'' AS leaveDay, ' +
    '''%s'' AS unLeaveDate, ''%s'' AS reger, ''%s'' AS leaveReason, %s AS isLeave, ''%s'' AS des', [edtStaNo.Text,
    edtStaName.Text, DateToStr(dpLeave.Date), edtDay.Text, DateToStr(dpUnDate.Date),
    edtReger.Text, meoReason.Text, BoolToStr(isLeave, True), meoDes.Text]);
  dmPer.PrintLeave(sSql);
end;

procedure TfrmLeave.dg_staffDblClick(Sender: TObject);
begin
  inherited;
  LoadData();
  edtDay.SetFocus;
end;

end.
