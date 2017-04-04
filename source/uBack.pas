unit uBack;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBase, StdCtrls, Buttons, ExtCtrls, ComCtrls, DB, ADODB;

type
  TfrmBack = class(TfrmBase)
    Label1: TLabel;
    edtStaNo: TEdit;
    Label2: TLabel;
    edtStaName: TEdit;
    Label3: TLabel;
    lblReger: TLabel;
    dpBack: TDateTimePicker;
    edtReger: TEdit;
    gbOld: TGroupBox;
    gbNew: TGroupBox;
    lblDepto: TLabel;
    edtDept: TEdit;
    lblDutyo: TLabel;
    edtDuty: TEdit;
    lblKindo: TLabel;
    edtKind: TEdit;
    edtTech: TEdit;
    lblTecho: TLabel;
    lblDeptn: TLabel;
    lblDutyn: TLabel;
    lblKindn: TLabel;
    lblTechn: TLabel;
    cbDept: TComboBox;
    cbDuty: TComboBox;
    cbKind: TComboBox;
    cbTech: TComboBox;
    Label13: TLabel;
    edtReason: TEdit;
    Label14: TLabel;
    edtDate: TEdit;
    lblRegero: TLabel;
    edtLReger: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    meoLDes: TMemo;
    meoDes: TMemo;
  private
    { Private declarations }
    FLeftID: string;
    FAQInqu: TADOQuery;
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
  frmBack: TfrmBack;

function ShowBack(AAQInqu: TADOQuery = nil): Boolean;

implementation

uses uGlobal, uData;

{$R *.dfm}

var
  aqStaff: TADOQuery;

function ShowBack(AAQInqu: TADOQuery): Boolean;
begin
  with TfrmBack.Create(Application.MainForm) do
  begin
    HelpHtml := 'back.html';
    imgHelp.Visible := False;
    FAQInqu := AAQInqu;
    try
      InitData();
      LoadData();
      Result := ShowModal() = mrOk;
    finally
      Free;
    end;
  end;
end;

{ TfrmBack }

procedure TfrmBack.InitData;
  procedure DealCaption(ALabel: TLabel; AValue: string);
  begin
    if ALabel.Caption <> AValue + '：' then
    begin
      ALabel.Caption := AValue + '：';
      ALabel.Left := ALabel.FocusControl.Left - ALabel.Width - 3;
    end;
  end;

var
  i: Integer;
begin
  //自定义Caption...
  with App do
  begin
    DealCaption(lblReger, ViewSet.RegerStr);
    DealCaption(lblRegero, ViewSet.RegerStr);
    DealCaption(lblDepto, ViewSet.DeptStr);
    DealCaption(lblDeptn, ViewSet.DeptStr);
    DealCaption(lblDutyo, ViewSet.DutyStr);
    DealCaption(lblDutyn, ViewSet.DutyStr);
    DealCaption(lblKindo, ViewSet.TypeStr);
    DealCaption(lblKindn, ViewSet.TypeStr);
    DealCaption(lblTecho, ViewSet.TechnicStr);
    DealCaption(lblTechn, ViewSet.TechnicStr);
  end;

  aqStaff := dmPer.aqStaff;
  //部门
  FillDept(cbDept);
  //职务
  FillKind(cbDuty, ktDuty);
  //工种
  FillKind(cbKind, ktType);
  //职称
  FillKind(cbTech, ktTechnic);
  dpBack.Date := Date();
  edtReger.Text := App.UserID;

  //颜色...
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TEdit then
      TEdit(Components[i]).Color := VIEW_COLOR;
  meoLDes.Color := VIEW_COLOR;
  aqStaff := dmPer.aqStaff;
end;

procedure TfrmBack.LoadData;
begin
  //主窗体操作
  if FAQInqu = nil then
  begin
    edtStaNo.Text := aqStaff.FieldByName('staffNo').AsString;
    edtStaName.Text := aqStaff.FieldByName('staffName').AsString;
    with dmPer do
    begin
      OpenQuery(aqTemp, 'SELECT TOP 1 * FROM [left] WHERE staffNo=' + QuotedStr(edtStaNo.Text) + ' AND isBacked = False ORDER BY id DESC');
      if not aqTemp.Eof then
      begin
        FLeftID         := aqTemp.FieldByName('id').AsString;
        edtDept.Text    := aqTemp.FieldByName('oldDept').AsString;
        edtDuty.Text    := aqTemp.FieldByName('oldDuty').AsString;
        edtKind.Text    := aqTemp.FieldByName('oldKind').AsString;
        edtTech.Text    := aqTemp.FieldByName('oldTech').AsString;
        edtReason.Text  := aqTemp.FieldByName('leftReason').AsString;
        edtDate.Text    := aqTemp.FieldByName('leftDate').AsString;
        edtLReger.Text   := aqTemp.FieldByName('reger').AsString;
        meoLDes.Text    := aqTemp.FieldByName('des').AsString;
      end;                 
    end;
  end
  else
  begin
    with FAQInqu do
    begin
      edtStaNo.Text   := FieldByName('staffNo').AsString;
      edtStaName.Text := FieldByName('staffName').AsString;
      edtDept.Text    := FieldByName('oldDept').AsString;
      edtDuty.Text    := FieldByName('oldDuty').AsString;
      edtKind.Text    := FieldByName('oldKind').AsString;
      edtTech.Text    := FieldByName('oldTech').AsString;
      edtReason.Text  := FieldByName('leftReason').AsString;
      edtDate.Text    := FieldByName('leftDate').AsString;
      edtLReger.Text   := FieldByName('reger').AsString;
      meoLDes.Text    := FieldByName('des').AsString;
    end;
  end;

  //右侧赋值
  cbDept.Text := edtDept.Text;
  cbDuty.Text := edtDuty.Text;
  cbKind.Text := edtKind.Text;
  cbTech.Text := edtTech.Text;

  Caption := '员工复职 - ' + edtStaName.Text;
end;

function TfrmBack.CheckData: Boolean;
begin
  if cbDept.Text = '' then
  begin
    Result := False;
    MessageBox(Handle, PAnsiChar('请选择复职后的' + App.ViewSet.DeptStr + '。'), '提示',  MB_ICONWARNING + MB_OK);
    cbDept.SetFocus;
    Exit;
  end;

  Result := inherited CheckData();
end;

procedure TfrmBack.SaveData;
var
  sSql, sSex: string;
  BookMark: TBookMark;
begin
  if FAQInqu = nil then
    sSex := aqStaff.FieldByName('sex').AsString
  else sSex := FAQInqu.FieldByName('sex').AsString;
  //存入复职表
  sSql := 'INSERT INTO [back](staffNo, staffName, staffPY, sex, backDate, reger, leftDept, leftDuty, leftKind, leftTech, leftReason, leftDate, leftReger, leftDes, ' +
          'backDept, backDuty, backKind, backTech, backDes) ' +
          'VALUES(' + QuotedStr(edtStaNo.Text) + ', ' + QuotedStr(edtStaName.Text) + ', ' + QuotedStr(GetPYStr(edtStaName.Text)) + ', ' + QuotedStr(sSex) + ', ' + QuotedStr(DateToStr(dpBack.Date)) +
          ', ' + QuotedStr(edtReger.Text) + ', ' + QuotedStr(edtDept.Text) + ', ' + QuotedStr(edtDuty.Text) + ', ' + QuotedStr(edtKind.Text) + ', ' + QuotedStr(edtTech.Text) +
          ', ' + QuotedStr(edtReason.Text) + ', ' + QuotedStr(edtDate.Text) + ', ' + QuotedStr(edtLReger.Text) + ', ' + QuotedStr(meoLDes.Text) +
          ', ' + QuotedStr(cbDept.Text) + ', ' + QuotedStr(cbDuty.Text) + ', ' + QuotedStr(cbKind.Text) + ', ' + QuotedStr(cbTech.Text) + ', ' + QuotedStr(meoDes.Text) + ')';
  dmPer.ExecSQL(sSql);
  //更新离职表
  if FAQInqu = nil then
  begin
    if FLeftID <> '' then dmPer.ExecSQL('UPDATE [left] SET isBacked=True WHERE id=' + FLeftID);
  end
  else
  begin
    FAQInqu.Edit;
    FAQInqu.FieldByName('isBacked').AsBoolean := True;
    FAQInqu.Post;
    FAQInqu.UpdateBatch();
  end;
  //更新员工信息表
  if FAQInqu <> nil then
  begin
    BookMark := aqStaff.GetBookmark;
    if not aqStaff.Locate('staffNo;workState', VarArrayOf([edtStaNo.Text, 0]), []) then
      aqStaff.Locate('staffNo;workState', VarArrayOf([edtStaNo.Text, 2]), []);
  end
  else BookMark := nil;
  aqStaff.Edit;
  aqStaff.FieldByName('deptName').AsString   := cbDept.Text;
  aqStaff.FieldByName('duty').AsString       := cbDuty.Text;
  aqStaff.FieldByName('workKind').AsString   := cbKind.Text;
  aqStaff.FieldByName('technic').AsString    := cbTech.Text;
  aqStaff.FieldByName('workState').AsInteger := 0;
  aqStaff.FieldByName('leftDate').AsString   := '';
  aqStaff.Post;
  aqStaff.UpdateBatch();
  if (FAQInqu <> nil) and aqStaff.BookmarkValid(BookMark) then
  begin
    aqStaff.GotoBookmark(BookMark);
    aqStaff.FreeBookmark(BookMark); 
  end;

  Log.Write(App.UserID + '对员工[' + edtStaName.Text + ']进行复职操作');
end;

end.
