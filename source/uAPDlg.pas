unit uAPDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBase, uDlgBase, uGlobal, ComCtrls, StdCtrls, DB, ADODB, Grids, DBGridEh,
  ExtCtrls, RzPanel, Mask, RzEdit, RzBtnEdt, Buttons;

type
  TfrmAPDlg = class(TfrmDlgBase)
    lblDate: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    meoDes: TMemo;
    lblUnDate: TLabel;
    rbA: TRadioButton;
    rbP: TRadioButton;
    edtReason: TEdit;
    Label3: TLabel;
    edtResult: TEdit;
    cbDept: TComboBox;
    dpDate: TDateTimePicker;
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
  frmAPDlg: TfrmAPDlg;

function ShowAPDlg(const AActOper: TActOper; AAQInqu: TADOQuery; ATVInqu: TTreeView): Boolean;

implementation

uses uData;

{$R *.dfm}

function ShowAPDlg(const AActOper: TActOper; AAQInqu: TADOQuery; ATVInqu: TTreeView): Boolean;
begin
  with TfrmAPDlg.Create(Application.MainForm) do
  begin
    //HelpHtml := 'Leave.html';
    imgHelp.Visible := False;
    FActOper := AActOper;
    FAQInqu := AAQInqu;
    FTVInqu := ATVInqu;
    try
      InitData();
      LoadData();
      Result := ShowModal() = mrOk;
      if not Result then FAQInqu.CancelBatch();
    finally
      Free;
    end;
  end;
end;

{ TfrmLeave }

procedure TfrmAPDlg.InitData;
begin
  FillDept(cbDept);
  with FTVInqu do
  begin
    if (Selected.Level >= 2) and IsDeptNode(Selected) then
      FFilter := 'deptName LIKE ' + QuotedStr(GetDeptStr(Selected) + '%')
    else FFilter := '';
  end;
  inherited InitData;
  
  //��ɫ...
  edtStaNo.Enabled := FActOper = aoAdd;
  if not edtStaNo.Enabled then edtStaNo.Color := VIEW_COLOR;
end;

procedure TfrmAPDlg.LoadData;
begin
  //Caption��ֵ
  case FActOper of
    aoAdd:
    begin
      Caption := '���ͼ�¼ - ���';
      dpDate.Date := Date();
      FAQInqu.Append;
    end;
  else
    with FAQInqu do
    begin
      dpDate.Date     := FieldByName('apDate').AsDateTime;
      rbA.Checked     := FieldByName('apType').AsString = '����';
      rbP.Checked     := not rbA.Checked;
      edtStaNo.Text   := FieldByName('staffNo').AsString;
      edtStaName.Text := FieldByName('staffName').AsString;
      edtReason.Text  := FieldByName('reason').AsString;
      edtResult.Text  := FieldByName('result').AsString;
      cbDept.Text     := FieldByName('operDept').AsString;
      meoDes.Text     := FieldByName('des').AsString;
    end;
    FAQInqu.Edit;
    Caption := '���ͼ�¼ - �޸� - ' + edtStaName.Text;
  end;
  edtStaName.Enabled := False;
end;

function TfrmAPDlg.CheckData: Boolean;
begin
  if edtStaNo.Focused then edtStaNo.OnExit(edtStaNo);

  if Trim(edtStaName.Text) = '' then
  begin
    Result := False;
    MessageBox(Handle, PAnsiChar('��������Ҫ����Ա���Ĺ��š�'), '��ʾ',  MB_ICONWARNING + MB_OK);
    edtStaNo.SetFocus;
    Exit;
  end;

  if Trim(edtReason.Text) = '' then
  begin
    Result := False;
    if rbA.Checked then
      MessageBox(Handle, PAnsiChar('������[' + edtStaName.Text + ']��' + rbA.Caption + 'ԭ��'), '��ʾ',  MB_ICONWARNING + MB_OK)
    else MessageBox(Handle, PAnsiChar('������[' + edtStaName.Text + ']��' + rbP.Caption + 'ԭ��'), '��ʾ',  MB_ICONWARNING + MB_OK);
    edtReason.SetFocus;
    Exit;
  end;

  Result := inherited CheckData();
end;

procedure TfrmAPDlg.SaveData;
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
      FieldByName('deptName').AsString  := aq_staff.FieldByName('deptName').AsString;
    end;
    FieldByName('apDate').AsString      := DateToStr(dpDate.Date);
    if rbA.Checked then
      FieldByName('apType').AsString    := '����'
    else FieldByName('apType').AsString := '�ͷ�';
    FieldByName('reason').AsString      := edtReason.Text;
    FieldByName('result').AsString      := edtResult.Text;
    FieldByName('operDept').AsString    := cbDept.Text;
    FieldByName('des').AsString         := meoDes.Text;
    FieldByName('operDate').AsDateTime  := Now();
  end;

  FAQInqu.Post;
  FAQInqu.UpdateBatch();
end;

procedure TfrmAPDlg.dg_staffDblClick(Sender: TObject);
begin
  inherited;
  edtReason.SetFocus;
end;

end.
