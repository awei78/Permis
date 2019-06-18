unit uMove;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBase, uDlgBase, uGlobal, StdCtrls, Buttons, ExtCtrls, ComCtrls, ADODB,
  DB, Grids, DBGridEh, RzPanel, DBCtrls, Mask, RzEdit, RzDBEdit, RzDBBnEd,
  RzBtnEdt;

type
  TfrmMove = class(TfrmDlgBase)
    Label3: TLabel;
    lblReger: TLabel;
    dpMove: TDateTimePicker;
    edtReger: TEdit;
    gbOld: TGroupBox;
    gbNew: TGroupBox;
    gbDes: TGroupBox;
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
    meoDes: TMemo;
    procedure dg_staffDblClick(Sender: TObject);
  private
    { Private declarations }
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
  frmMove: TfrmMove;

function ShowMove(const AActOper: TActOper; AAQInqu: TADOQuery = nil; ATVInqu: TTreeView = nil): Boolean;

implementation

uses uData;

{$R *.dfm}

var
  aqStaff: TADOQuery;

function ShowMove(const AActOper: TActOper; AAQInqu: TADOQuery; ATVInqu: TTreeView): Boolean;
begin
  with TfrmMove.Create(Application.MainForm) do
  begin
    HelpHtml := 'move.html';
    imgHelp.Visible := False;
    FActOper := AActOper;
    FAQInqu := AAQInqu;
    FTVInqu := ATVInqu;
    try
      InitData();
      LoadData();
      Result := ShowModal() = mrOk;
      if not Result and (FAQInqu <> nil) then FAQInqu.CancelBatch();
      if Result then dmPer.DealMoveRecord();
    finally
      Free;
    end;
  end;
end;

{ TfrmMove }

procedure TfrmMove.InitData;
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
  if FTVInqu <> nil then
    with FTVInqu do
    begin
      if Selected.Level >= 2 then
        FFilter := 'deptName LIKE ' + QuotedStr(GetDeptStr(Selected) + '%')
      else FFilter := '';
    end;
  inherited InitData();

  aqStaff := dmPer.aqStaff;
  if FAQInqu <> nil then
  begin
    if FActOper = aoAdd then
      FAQInqu.Append()
    else FAQInqu.Edit;
  end;  
  //自定义Caption...
  with App do
  begin
    DealCaption(lblReger, ViewSet.RegerStr);
    DealCaption(lblDepto, ViewSet.DeptStr);
    DealCaption(lblDeptn, ViewSet.DeptStr);
    DealCaption(lblDutyo, ViewSet.DutyStr);
    DealCaption(lblDutyn, ViewSet.DutyStr);
    DealCaption(lblKindo, ViewSet.TypeStr);
    DealCaption(lblKindn, ViewSet.TypeStr);
    DealCaption(lblTecho, ViewSet.TechnicStr);
    DealCaption(lblTechn, ViewSet.TechnicStr);
  end;
  //部门
  FillDept(cbDept);
  //职务
  FillKind(cbDuty, ktDuty);
  cbDuty.ItemIndex := -1;
  //工种
  FillKind(cbKind, ktType);
  cbKind.ItemIndex := -1;
  //职称
  FillKind(cbTech, ktTechnic);
  cbTech.ItemIndex := -1;
  dpMove.Date := Date();
  edtReger.Text := App.UserID;

  //颜色...
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TEdit then
      TEdit(Components[i]).Color := VIEW_COLOR;
  edtStaNo.Enabled := (FAQInqu <> nil) and (FActOper = aoAdd);
  if not edtStaNo.Enabled then edtStaNo.Color := VIEW_COLOR;
end;

procedure TfrmMove.LoadData;
var
  sSql: string;
begin
  //主界面操作...主界面只能添加
  if FAQInqu = nil then
  begin
    if FActOper = aoAdd then
    begin
      edtStaNo.Text   := aqStaff.FieldByName('staffNo').AsString;
      edtStaName.Text := aqStaff.FieldByName('staffName').AsString;
      edtReger.Text   := App.UserID;
      edtDept.Text    := aqStaff.FieldByName('deptName').AsString;
      edtDuty.Text    := aqStaff.FieldByName('duty').AsString;
      edtKind.Text    := aqStaff.FieldByName('workKind').AsString;
      edtTech.Text    := aqStaff.FieldByName('technic').AsString;

      cbDept.ItemIndex := cbDept.Items.IndexOf(edtDept.Text);
      Caption := '员工调动 - 添加 - ' + edtStaName.Text;
    end;
  end
  //查询界面操作
  else
  begin
    //添加
    if FActOper = aoAdd then
    begin
      edtReger.Text := App.UserID;
      if edtStaNo.Text <> '' then
      begin
        with dmPer do
        begin
          sSql := 'SELECT id, staffNo, staffName, deptName, staffPY, duty, workKind, technic FROM [staffs] ' +
                  'WHERE id=' + aq_staff.FieldByName('id').AsString + ' AND workState <> 1';
          OpenQuery(aqTemp, sSql);
          if not aqTemp.Eof then
          begin
            edtDept.Text := aqTemp.FieldByName('deptName').AsString;
            edtDuty.Text := aqTemp.FieldByName('duty').AsString;
            edtKind.Text := aqTemp.FieldByName('workKind').AsString;
            edtTech.Text := aqTemp.FieldByName('technic').AsString;
            cbDept.Text  := edtDept.Text;
          end;
        end;
        Caption := '员工调动 - 添加 - ' + edtStaName.Text;
      end;
    end
    //编辑
    else
    begin
      with FAQInqu do
      begin
        edtStaNo.Text := FieldByName('staffNo').AsString;
        edtStaName.Text := FieldByName('staffName').AsString;
        dpMove.Date := FieldByName('moveDate').AsDateTime;
        edtDept.Text := FieldByName('oldDept').AsString;
        edtDuty.Text := FieldByName('oldDuty').AsString;
        edtKind.Text := FieldByName('oldKind').AsString;
        edtTech.Text := FieldByName('oldTech').AsString;
        //部门列
        cbDept.Text := FieldByName('newDept').AsString;
        cbDuty.Text := FieldByName('newDuty').AsString;
        cbKind.Text := FieldByName('newKind').AsString;
        cbTech.Text := FieldByName('newTech').AsString;

        Caption := '员工调动 - 修改 - ' + edtStaName.Text;
      end;
    end;
  end;
end;

function TfrmMove.CheckData: Boolean;
begin
  if edtStaNo.Text = '' then
  begin
    Result := False;
    MessageBox(Handle, PAnsiChar('您输入您要调动的员工。'), '提示',  MB_ICONWARNING + MB_OK);
    edtStaNo.SetFocus;
    Exit;
  end;

  if edtStaNo.Focused then edtStaNo.OnExit(edtStaNo);
  if cbDept.Text = '' then
  begin
    Result := False;
    MessageBox(Handle, PAnsiChar('请选择调动后的' + App.ViewSet.DeptStr + '。'), '提示',  MB_ICONWARNING + MB_OK);
    cbDept.SetFocus;
    Exit;
  end;

  Result := inherited CheckData();
end;

procedure TfrmMove.SaveData;
var
  sSql: string;
  sId: string;
  BookMark: TBookMark;
begin
  //存入调动表
  if FAQInqu = nil then
  begin
    if FActOper = aoAdd then
    begin
      sSql := 'INSERT INTO [move](staffId, staffNo, staffName, staffPY, sex, moveDate, reger, oldDept, oldDuty, oldKind, oldTech, ' +
              'newDept, newDuty, newKind, newTech, des) ' +
              'VALUES(' + aqStaff.FieldByName('id').AsString + ', ' + QuotedStr(edtStaNo.Text) + ', ' + QuotedStr(edtStaName.Text) + ', ' + QuotedStr(aqStaff.FieldByName('staffPY').AsString) +
              ', ' + QuotedStr(aqStaff.FieldByName('sex').AsString) + ', ' + QuotedStr(DateToStr(dpMove.Date)) + ', ' + QuotedStr(edtReger.Text) + ', ' + QuotedStr(edtDept.Text) + ', ' + QuotedStr(edtDuty.Text) +
              ', ' + QuotedStr(edtKind.Text) + ', ' + QuotedStr(edtTech.Text) + ', ' + QuotedStr(cbDept.Text) + ', ' + QuotedStr(cbDuty.Text) + ', ' + QuotedStr(cbKind.Text) + ', ' + QuotedStr(cbTech.Text) + ', ' + QuotedStr(meoDes.Text) + ')';
      dmPer.ExecSQL(sSql);
    end;
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
        FieldByName('reger').AsString     := edtReger.Text;

        FieldByName('oldDept').AsString := edtDept.Text;
        FieldByName('oldDuty').AsString := edtDuty.Text;
        FieldByName('oldKind').AsString := edtKind.Text;
        FieldByName('oldTech').AsString := edtTech.Text;
      end;

      FieldByName('moveDate').AsString := DateToStr(dpMove.Date);
      FieldByName('newDept').AsString  := cbDept.Text;
      FieldByName('newDuty').AsString  := cbDuty.Text;
      FieldByName('newKind').AsString  := cbKind.Text;
      FieldByName('newTech').AsString  := cbTech.Text;
      Post;
      UpdateBatch();
    end;
  end;

  //更新员工信息表...
  if FAQInqu <> nil then
  begin
    BookMark := aqStaff.GetBookmark;
    if not aqStaff.Locate('staffNo;workState', VarArrayOf([edtStaNo.Text, 0]), []) then
      aqStaff.Locate('staffNo;workState', VarArrayOf([edtStaNo.Text, 2]), []);
  end
  else BookMark := nil;
  
  //怕以后再取此值，它已改变，胡先取
  sId := aqStaff.FieldByName('id').AsString;
  aqStaff.Edit;
  aqStaff.FieldByName('deptName').AsString := cbDept.Text;
  aqStaff.FieldByName('duty').AsString := cbDuty.Text;
  aqStaff.FieldByName('workKind').AsString := cbKind.Text;
  aqStaff.FieldByName('technic').AsString := cbTech.Text;
  aqStaff.Post;
  aqStaff.UpdateBatch(arCurrent);
  //对有些用户，此种更新居然不起作用，再用SQL操作一次
  sSql := 'UPDATE [staffs] SET deptName=' + QuotedStr(cbDept.Text) + ', ' +
          'duty=' + QuotedStr(cbDuty.Text) + ', ' +
          'workKind=' + QuotedStr(cbKind.Text) + ', ' +
          'technic=' + QuotedStr(cbTech.Text) + ' WHERE id=' + sId;
  dmPer.ExecSQL(sSql);
  if (FAQInqu <> nil) and aqStaff.BookmarkValid(BookMark) then
  begin
    aqStaff.GotoBookmark(BookMark);
    aqStaff.FreeBookmark(BookMark); 
  end;

  Log.Write(App.UserID + '对员工[' + edtStaName.Text + ']进行调动操作');
end;

procedure TfrmMove.dg_staffDblClick(Sender: TObject);
begin
  inherited;
  LoadData();
  cbDept.SetFocus;
end;

end.
