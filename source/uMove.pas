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
    //�������
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
    DealCaption(lblDepto, ViewSet.DeptStr);
    DealCaption(lblDeptn, ViewSet.DeptStr);
    DealCaption(lblDutyo, ViewSet.DutyStr);
    DealCaption(lblDutyn, ViewSet.DutyStr);
    DealCaption(lblKindo, ViewSet.TypeStr);
    DealCaption(lblKindn, ViewSet.TypeStr);
    DealCaption(lblTecho, ViewSet.TechnicStr);
    DealCaption(lblTechn, ViewSet.TechnicStr);
  end;
  //����
  FillDept(cbDept);
  //ְ��
  FillKind(cbDuty, ktDuty);
  cbDuty.ItemIndex := -1;
  //����
  FillKind(cbKind, ktType);
  cbKind.ItemIndex := -1;
  //ְ��
  FillKind(cbTech, ktTechnic);
  cbTech.ItemIndex := -1;
  dpMove.Date := Date();
  edtReger.Text := App.UserID;

  //��ɫ...
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

      cbDept.ItemIndex := cbDept.Items.IndexOf(edtDept.Text);
      Caption := 'Ա������ - ��� - ' + edtStaName.Text;
    end;
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
            cbDept.Text  := edtDept.Text;
          end;
        end;
        Caption := 'Ա������ - ��� - ' + edtStaName.Text;
      end;
    end
    //�༭
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
        //������
        cbDept.Text := FieldByName('newDept').AsString;
        cbDuty.Text := FieldByName('newDuty').AsString;
        cbKind.Text := FieldByName('newKind').AsString;
        cbTech.Text := FieldByName('newTech').AsString;

        Caption := 'Ա������ - �޸� - ' + edtStaName.Text;
      end;
    end;
  end;
end;

function TfrmMove.CheckData: Boolean;
begin
  if edtStaNo.Text = '' then
  begin
    Result := False;
    MessageBox(Handle, PAnsiChar('��������Ҫ������Ա����'), '��ʾ',  MB_ICONWARNING + MB_OK);
    edtStaNo.SetFocus;
    Exit;
  end;

  if edtStaNo.Focused then edtStaNo.OnExit(edtStaNo);
  if cbDept.Text = '' then
  begin
    Result := False;
    MessageBox(Handle, PAnsiChar('��ѡ��������' + App.ViewSet.DeptStr + '��'), '��ʾ',  MB_ICONWARNING + MB_OK);
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
  //���������
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

  //����Ա����Ϣ��...
  if FAQInqu <> nil then
  begin
    BookMark := aqStaff.GetBookmark;
    if not aqStaff.Locate('staffNo;workState', VarArrayOf([edtStaNo.Text, 0]), []) then
      aqStaff.Locate('staffNo;workState', VarArrayOf([edtStaNo.Text, 2]), []);
  end
  else BookMark := nil;
  
  //���Ժ���ȡ��ֵ�����Ѹı䣬����ȡ
  sId := aqStaff.FieldByName('id').AsString;
  aqStaff.Edit;
  aqStaff.FieldByName('deptName').AsString := cbDept.Text;
  aqStaff.FieldByName('duty').AsString := cbDuty.Text;
  aqStaff.FieldByName('workKind').AsString := cbKind.Text;
  aqStaff.FieldByName('technic').AsString := cbTech.Text;
  aqStaff.Post;
  aqStaff.UpdateBatch(arCurrent);
  //����Щ�û������ָ��¾�Ȼ�������ã�����SQL����һ��
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

  Log.Write(App.UserID + '��Ա��[' + edtStaName.Text + ']���е�������');
end;

procedure TfrmMove.dg_staffDblClick(Sender: TObject);
begin
  inherited;
  LoadData();
  cbDept.SetFocus;
end;

end.
