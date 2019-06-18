unit uLeft;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBase, uDlgBase, uGlobal, StdCtrls, Buttons, ExtCtrls, ComCtrls, ADODB,
  DB, Grids, DBGridEh, RzPanel, Mask, RzEdit, RzBtnEdt;

type
  TfrmLeft = class(TfrmDlgBase)
    Label3: TLabel;
    lblReger: TLabel;
    dpLeft: TDateTimePicker;
    edtReger: TEdit;
    gbOld: TGroupBox;
    gbNew: TGroupBox;
    lblDept: TLabel;
    edtDept: TEdit;
    lblDuty: TLabel;
    edtDuty: TEdit;
    lblKind: TLabel;
    edtKind: TEdit;
    edtTech: TEdit;
    lblTech: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    cbReason: TComboBox;
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
    //�������
    function CheckData: Boolean; override;
  public
    { Public declarations }
  end;

var
  frmLeft: TfrmLeft;

function ShowLeft(const AActOper: TActOper; AAQInqu: TADOQuery = nil; ATVInqu: TTreeView = nil): Boolean;

implementation

uses uData;

{$R *.dfm}

var
  aqStaff: TADOQuery;

function ShowLeft(const AActOper: TActOper; AAQInqu: TADOQuery; ATVInqu: TTreeView): Boolean;
begin
  with TfrmLeft.Create(Application.MainForm) do
  begin
    HelpHtml := 'left.html';
    imgHelp.Visible := False;
    FActOper := AActOper;
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

{ TfrmLeft }

procedure TfrmLeft.InitData;
  procedure DealCaption(ALabel: TLabel; AValue: string);
  begin
    if ALabel.Caption <> AValue + '��' then
    begin
      ALabel.Caption := AValue + '��';
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
  //�Զ���Caption...
  with App do
  begin
    DealCaption(lblReger, ViewSet.RegerStr);
    DealCaption(lblDept, ViewSet.DeptStr);
    DealCaption(lblDuty, ViewSet.DutyStr);
    DealCaption(lblKind, ViewSet.TypeStr);
    DealCaption(lblTech, ViewSet.TechnicStr);
  end;
  //ԭ��
  FillKind(cbReason, ktReason);

  dpLeft.Date := Date();
  edtReger.Text := App.UserID;

  //��ɫ...
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TEdit then
      TEdit(Components[i]).Color := VIEW_COLOR;
  edtStaNo.Enabled := (FAQInqu <> nil) and (FActOper = aoAdd);
  if not edtStaNo.Enabled then edtStaNo.Color := VIEW_COLOR;
end;

procedure TfrmLeft.LoadData;
var
  sSql: string;
begin
  //���������...������ֻ�����
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

      Caption := 'Ա����ְ - ��� - ' + edtStaName.Text;
    end
  end
  //��ѯ�������
  else
  begin
    //���
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
          end;
        end;

        Caption := 'Ա����ְ - ��� - ' + edtStaName.Text;
      end;
    end
    //�༭
    else
    begin
      with FAQInqu do
      begin
        edtStaNo.Text   := FieldByName('staffNo').AsString;
        edtStaName.Text := FieldByName('staffName').AsString;
        dpLeft.Date     := FieldByName('leftDate').AsDateTime;
        edtDept.Text    := FieldByName('oldDept').AsString;
        edtDuty.Text    := FieldByName('oldDuty').AsString;
        edtKind.Text    := FieldByName('oldKind').AsString;
        edtTech.Text    := FieldByName('oldTech').AsString;
        //ԭ����
        cbReason.Text := FieldByName('leftReason').AsString;
        meoDes.Text := FieldByName('des').AsString;

        Caption := 'Ա����ְ - �޸� - ' + edtStaName.Text;
      end;
    end;
  end;
end;

function TfrmLeft.CheckData: Boolean;
begin
  if cbReason.Text = '' then
  begin
    Result := False;
    MessageBox(Handle, '��ѡԱ������ְԭ��', '��ʾ',  MB_ICONWARNING + MB_OK);
    cbReason.SetFocus;
    Exit;
  end;

  Result := inherited CheckData();
end;

procedure TfrmLeft.SaveData;
var
  sSql: string;
  BookMark: TBookMark;
begin
  //���������
  if FAQInqu = nil then
  begin
    if FActOper = aoAdd then
    begin
      sSql := 'INSERT INTO [left](staffNo, staffName, staffPY, leftDate, reger, oldDept, oldDuty, oldKind, oldTech, leftReason, des) ' +
              'VALUES(' + QuotedStr(edtStaNo.Text) + ', ' + QuotedStr(edtStaName.Text) + ', ' + QuotedStr(GetPYStr(edtStaName.Text)) + ', ' + QuotedStr(DateToStr(dpLeft.Date)) + ', ' + QuotedStr(edtReger.Text) +
              ', ' + QuotedStr(edtDept.Text) + ', ' + QuotedStr(edtDuty.Text) + ', ' + QuotedStr(edtKind.Text) + ', ' + QuotedStr(edtTech.Text) +
              ', ' + QuotedStr(cbReason.Text) + ', ' + QuotedStr(meoDes.Text) + ')';
      dmPer.ExecSQL(sSql);
    end;
  end
  //��ѯ�������
  else
  begin
    with FAQInqu do
    begin
      if FActOper = aoAdd then
      begin
        FieldByName('staffNo').AsString   := edtStaNo.Text;
        FieldByName('staffName').AsString := edtStaName.Text;
        FieldByName('staffPY').AsString   := aq_staff.FieldByName('staffPY').AsString;
        FieldByName('sex').AsString       := aq_staff.FieldByName('sex').AsString;
        FieldByName('reger').AsString     := edtReger.Text;

        FieldByName('oldDept').AsString   := edtDept.Text;
        FieldByName('oldDuty').AsString   := edtDuty.Text;
        FieldByName('oldKind').AsString   := edtKind.Text;
        FieldByName('oldTech').AsString   := edtTech.Text;
        FieldByName('isBacked').AsBoolean := False;
      end;

      FieldByName('leftDate').AsString    := DateToStr(dpLeft.Date);
      FieldByName('leftReason').AsString  := cbreason.Text;
      FieldByName('des').AsString         := meoDes.Text;
      Post;
      UpdateBatch();
    end;
  end;

  //����Ա����Ϣ��...������Ч�ʲ�Щ������ʹ���������ݼ����ƶ�
  aqStaff := dmPer.aqStaff;
  //����Ա����Ϣ��
  if FAQInqu <> nil then
  begin
    BookMark := aqStaff.GetBookmark;
    if not aqStaff.Locate('staffNo;workState', VarArrayOf([edtStaNo.Text, 0]), []) then
      aqStaff.Locate('staffNo;workState', VarArrayOf([edtStaNo.Text, 2]), []);
  end
  else BookMark := nil;
  aqStaff.Edit;
  if FActOper <> aoEdit then aqStaff.FieldByName('workState').AsInteger := 1;
  aqStaff.FieldByName('leftDate').AsString := DateToStr(dpLeft.Date);
  aqStaff.Post;
  aqStaff.UpdateBatch();
  if (FAQInqu <> nil) and aqStaff.BookmarkValid(BookMark) then
  begin
    aqStaff.GotoBookmark(BookMark);
    aqStaff.FreeBookmark(BookMark); 
  end;

  Log.Write(App.UserID + '��Ա��[' + edtStaName.Text + ']������ְ����');
end;

procedure TfrmLeft.dg_staffDblClick(Sender: TObject);
begin
  inherited;
  LoadData();
  cbReason.SetFocus; 
end;

end.
