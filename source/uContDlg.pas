{
  文件名：uContDlg.pas
  说  明：合同操作窗体
  编写人：刘景威
  日  期：2009-03-15
  更  新：
}

unit uContDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBase, uDlgBase, uGlobal, RzSpnEdt, StdCtrls, RzEdit, RzBtnEdt,
  ComCtrls, DB, ADODB, Grids, DBGridEh, ExtCtrls, RzPanel, DBCtrls, Mask,
  RzDBEdit, RzDBBnEd, Buttons, DateUtils, ShellAPI;

type
  TfrmContDlg = class(TfrmDlgBase)
    lblDate: TLabel;
    deRecDate: TDateTimePicker;
    lblDept: TLabel;
    edtDept: TEdit;
    Label3: TLabel;
    edtContNo: TEdit;
    Label4: TLabel;
    edtContName: TEdit;
    Label5: TLabel;
    cbType: TComboBox;
    Label6: TLabel;
    cbProp: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    deStartDate: TDateTimePicker;
    Label9: TLabel;
    deEndDate: TDateTimePicker;
    lblReger: TLabel;
    edtReger: TEdit;
    Label10: TLabel;
    beContFile: TRzButtonEdit;
    btnOpen: TBitBtn;
    Label11: TLabel;
    meoDes: TMemo;
    seMonth: TRzSpinEdit;
    Label12: TLabel;
    cbState: TComboBox;
    procedure dg_staffDblClick(Sender: TObject);
    procedure seMonthChange(Sender: TObject);
    procedure deStartDateChange(Sender: TObject);
    procedure beContFileButtonClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
  private
    { Private declarations }
    FAQInqu: TADOQuery;
    FTVInqu: TTreeView;
  protected
    procedure InitData; override;
    procedure SaveData; override;
    //检查数据
    function CheckData: Boolean; override;
  public
    { Public declarations }
  end;

var
  frmContDlg: TfrmContDlg;

function ShowContDlg(const AActOper: TActOper; AAQInqu: TADOQuery = nil; ATVInqu: TTreeView = nil): Boolean;

implementation

uses uData;

{$R *.dfm}

function ShowContDlg(const AActOper: TActOper; AAQInqu: TADOQuery; ATVInqu: TTreeView): Boolean;
begin
  with TfrmContDlg.Create(Application.MainForm) do
  begin
    HelpHtml := 'cont_add.html';
    FActOper := AActOper;
    FAQInqu := AAQInqu;
    FTVInqu := ATVInqu;
    imgHelp.Visible := False;
    try
      InitData();
      LoadData();
      Result := ShowModal() = mrOk;
    finally
      Free;
    end;
  end;
end;

{ TfrmLeave }

procedure TfrmContDlg.InitData;
  procedure FillContProp;
  begin
    with dmPer do
    begin
      OpenQuery(aqTemp, 'SELECT contProp FROM [contract] GROUP BY contProp ORDER BY Count(contProp) DESC, contProp');
      if not aqTemp.Eof then cbProp.Clear;
      while not aqTemp.Eof do
      begin
        if aqTemp.FieldByName('contProp').AsString <> '' then
          cbProp.Items.Append(aqTemp.FieldByName('contProp').AsString);
        aqTemp.Next;
      end;
    end;
    if cbProp.Items.Count > 0 then cbProp.ItemIndex := 0;
  end;

  procedure FillData();
  begin
    with FAQInqu do
    begin
      edtStaNo.Text    := FieldByName('staffNo').AsString;
      edtStaName.Text  := FieldByName('staffName').AsString;
      edtDept.Text     := FieldByName('deptName').AsString;
      edtReger.Text    := FieldByName('reger').AsString;
      edtContNo.Text   := FieldByName('contNo').AsString;
      edtContName.Text := FieldByName('contName').AsString;
      cbType.Text      := FieldByName('contType').AsString;
      cbProp.Text      := FieldByName('contProp').AsString;
      deRecDate.Date   := FieldByName('recDate').AsDateTime;
      seMonth.Value    := FieldByName('contMonth').AsInteger;
      deStartDate.Date := FieldByName('startDate').AsDateTime;
      deEndDate.Date   := FieldByName('endDate').AsDateTime;
      beContFile.Text  := FieldByName('contFile').AsString;
      cbState.Text     := FieldByName('contState').AsString;
      meoDes.Text      := FieldByName('des').AsString;
    end;
  end;

begin
  if FTVInqu <> nil then
    with FTVInqu do
    begin
      if IsDeptNode(Selected) and (Selected.Level > 1) then
        FFilter := 'deptName LIKE ' + QuotedStr(GetDeptStr(Selected) + '%')
      else FFilter := '';
    end;

  FillKind(cbType, ktState);
  FillContProp();
  lblDept.Caption := App.ViewSet.DeptStr + '：';
  lblDept.Left := edtDept.Left - lblDept.Width - 3;
  edtReger.Text := App.UserID;    
  inherited InitData;

  //Caption赋值
  case FActOper of
    aoAdd:
    begin
      Caption := '合同管理 - 添加';
      deRecDate.Date := Date();
      deStartDate.DateTime := Date();
      seMonth.OnChange(seMonth);
      //一些初值...
      if (FTVInqu <> nil) and (FTVInqu.Selected <> nil) and (FTVInqu.Selected.Level = 2) then
      begin
        if FTVInqu.Selected.Parent.Text = '合同类型' then cbType.Text := FTVInqu.Selected.Text;
        if FTVInqu.Selected.Parent.Text = '合同属性' then cbProp.Text := FTVInqu.Selected.Text;
        if FTVInqu.Selected.Parent.Text = '合同状态' then cbState.Text := FTVInqu.Selected.Text;
      end;

      if FAQInqu <> nil then FAQInqu.Append;
    end;
  else
    FillData();
    Caption := '合同管理 - 修改 - ' + edtStaName.Text;
    if FAQInqu <> nil then FAQInqu.Edit;
  end;

  edtStaNo.Enabled := FActOper = aoAdd;
  edtDept.Enabled := False;
  edtReger.Enabled := False;
  //颜色...
  if not edtStaNo.Enabled then edtStaNo.Color := VIEW_COLOR;
  edtDept.Color := VIEW_COLOR;
  edtReger.Color := VIEW_COLOR;
end;

function TfrmContDlg.CheckData: Boolean;
var
  sSql: string;
begin
  if edtStaNo.Focused then edtStaNo.OnExit(edtStaNo);

  Result := False;
  if Trim(edtStaName.Text) = '' then
  begin
    MessageBox(Handle, PAnsiChar('请输入您要操作员工的工号。'), '提示',  MB_ICONWARNING + MB_OK);
    edtStaNo.SetFocus;
    Exit;
  end;

  if Trim(edtContNo.Text) = '' then
  begin
    MessageBox(Handle, PAnsiChar('请输入合同编号。'), '提示',  MB_ICONWARNING + MB_OK);
    edtContNo.SetFocus;
    Exit;
  end;

  if Trim(edtContName.Text) = '' then
  begin
    MessageBox(Handle, PAnsiChar('请输入合同名称。'), '提示',  MB_ICONWARNING + MB_OK);
    edtContName.SetFocus;
    Exit;
  end;

  if FActOper <> aoEdit then
    sSql := 'SELECT id FROM [contract] WHERE contNo=' + QuotedStr(edtContNo.Text)
  else sSql := 'SELECT id FROM [contract] WHERE contNo=' + QuotedStr(edtContNo.Text) + ' AND id <> ' + FAQInqu.FieldByName('id').AsString;
  if VarToStr(dmPer.GetFieldValue(sSql, 'id')) <> '' then
  begin
    MessageBox(Handle, PAnsiChar('此合同编号[' + edtContNo.Text + ']已存在，请重新输入！'), '提示',  MB_ICONWARNING + MB_OK);
    edtContNo.SetFocus;
    Exit;
  end;

  Result := inherited CheckData();
end;

procedure TfrmContDlg.SaveData;
var
  sSql: string;
begin
  //主界面启动合同添加窗体，用SQL语句操作
  if FAQInqu = nil then
  begin
    sSql := 'INSERT INTO [contract](staffId, staffNo, staffName, staffPY, sex, deptName, reger, contNo, contName, contType, ' +
            'contProp, recDate, contMonth, startDate, endDate, contFile, contState, des) ' +
            'VALUES(' + aq_staff.FieldByName('id').AsString + ', ' + QuotedStr(edtStaNo.Text) + ', ' + QuotedStr(edtStaName.Text) + ', ' + QuotedStr(aq_staff.FieldByName('staffPY').AsString) +
            ', ' + QuotedStr(aq_staff.FieldByName('sex').AsString) + ', ' + QuotedStr(edtDept.Text) + ', ' + QuotedStr(edtReger.Text) +
            ', ' + QuotedStr(edtContNo.Text) + ', ' + QuotedStr(edtContName.Text) + ', ' + QuotedStr(cbType.Text) + ', ' + QuotedStr(cbProp.Text) +
            ', #' + DateToStr(deRecDate.Date) + '#, ' + seMonth.Text + ', #' + DateToStr(deStartDate.Date) + '#, #' + DateToStr(deEndDate.Date) +
            '#, ' + QuotedStr(beContFile.Text) + ', ' + QuotedStr(cbState.Text) + ', ' + QuotedStr(meoDes.Text)  + ')';
    dmPer.ExecSQL(sSql);
  end
  else
  begin
    with FAQInqu do
    begin
      if FActOper = aoAdd then
      begin
        FieldByName('staffId').AsString   := aq_staff.FieldByName('id').AsString;
        FieldByName('staffNo').AsString   := edtStaNo.Text;
        FieldByName('staffName').AsString := edtStaName.Text;
        FieldByName('staffPY').AsString   := aq_staff.FieldByName('staffPY').AsString;
        FieldByName('sex').AsString       := aq_staff.FieldByName('sex').AsString;
        FieldByName('deptName').AsString  := edtDept.Text;
        FieldByName('reger').AsString     := edtReger.Text;
      end;

      FieldByName('contNo').AsString     := edtContNo.Text;
      FieldByName('contName').AsString   := edtContName.Text;
      FieldByName('contType').AsString   := cbType.Text;
      FieldByName('contProp').AsString   := cbProp.Text;
      FieldByName('recDate').AsString    := DateToStr(deRecDate.Date);
      FieldByName('contMonth').AsInteger := Round(seMonth.Value);
      FieldByName('startDate').AsString  := DateToStr(deStartDate.Date);
      FieldByName('endDate').AsString    := DateToStr(deEndDate.Date);
      FieldByName('contFile').AsString   := beContFile.Text;
      FieldByName('contState').AsString  := cbState.Text;
      FieldByName('des').AsString        := meoDes.Text;
      FieldByName('operDate').AsDateTime := Date();

      Post();
      UpdateBatch();
    end;
  end;
end;

procedure TfrmContDlg.dg_staffDblClick(Sender: TObject);
begin
  inherited;
  if aq_staff.Locate('staffNo', edtStaNo.Text, []) then
    edtDept.Text := aq_staff.FieldByName('deptName').AsString;
  edtContNo.SetFocus;
end;

procedure TfrmContDlg.deStartDateChange(Sender: TObject);
begin
  seMonth.OnChange(seMonth);
end;

procedure TfrmContDlg.seMonthChange(Sender: TObject);
begin
  deEndDate.Date := IncDay(IncMonth(deStartDate.Date, Round(seMonth.Value)), -1);
end;

procedure TfrmContDlg.beContFileButtonClick(Sender: TObject);
var
  od: TOpenDialog;
begin
  od := TOpenDialog.Create(Self);
  try
    od.Options := od.Options + [ofFileMustExist];
    if od.Execute then beContFile.Text := od.FileName;
  finally
    od.Free;
  end;
end;

procedure TfrmContDlg.btnOpenClick(Sender: TObject);
begin
  if FileExists(beContFile.Text) then ShellExecute(Handle, 'open', PAnsiChar(beContFile.Text), '', '', SW_NORMAL);
end;

end.
