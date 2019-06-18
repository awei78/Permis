unit uTrainDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBase, uDlgBase, uGlobal, ComCtrls, StdCtrls, DBCtrls, DB,
  ADODB, Grids, DBGridEh, ExtCtrls, RzPanel, Mask, RzEdit, RzBtnEdt, Buttons;

type
  TfrmTrainDlg = class(TfrmDlgBase)
    lblDate: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    meoDes: TMemo;
    lblUnDate: TLabel;
    Label3: TLabel;
    cbTrainer: TComboBox;
    dpDate: TDateTimePicker;
    cbName: TComboBox;
    meoContent: TMemo;
    cbSite: TComboBox;
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
  frmTrainDlg: TfrmTrainDlg;

function ShowTrainDlg(const AActOper: TActOper; AAQInqu: TADOQuery; ATVInqu: TTreeView): Boolean;

implementation

uses uData;

{$R *.dfm}

function ShowTrainDlg(const AActOper: TActOper; AAQInqu: TADOQuery; ATVInqu: TTreeView): Boolean;
begin
  with TfrmTrainDlg.Create(Application.MainForm) do
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

procedure TfrmTrainDlg.InitData;
  procedure FillTrainName;
  begin
    with dmPer do
    begin
      OpenQuery(aqTemp, 'SELECT trName FROM [train] GROUP BY trName ORDER BY Count(trName) DESC, trName');
      cbName.Clear;
      while not aqTemp.Eof do
      begin
        if aqTemp.FieldByName('trName').AsString <> '' then
          cbName.Items.Append(aqTemp.FieldByName('trName').AsString);
        aqTemp.Next;
      end;
    end;
  end;

  procedure FillTrainSite;
  begin
    with dmPer do
    begin
      OpenQuery(aqTemp, 'SELECT trSite FROM [train] GROUP BY trSite ORDER BY Count(trSite) DESC, trSite');
      cbSite.Clear;
      while not aqTemp.Eof do
      begin
        if aqTemp.FieldByName('trSite').AsString <> '' then
          cbSite.Items.Append(aqTemp.FieldByName('trSite').AsString);
        aqTemp.Next;
      end;
    end;
  end;

  procedure FillTrainer;
  begin
    with dmPer do
    begin
      OpenQuery(aqTemp, 'SELECT trainer FROM [train] GROUP BY trainer ORDER BY Count(trainer) DESC, trainer');
      cbTrainer.Clear;
      while not aqTemp.Eof do
      begin
        if aqTemp.FieldByName('trainer').AsString <> '' then
          cbTrainer.Items.Append(aqTemp.FieldByName('trainer').AsString);
        aqTemp.Next;
      end;
    end;
  end;

begin
  FillTrainName();
  FillTrainSite();
  FillTrainer();
  with FTVInqu do
  begin
    if (Selected.Level >= 2) and IsDeptNode(Selected) then
      FFilter := 'deptName LIKE ' + QuotedStr(GetDeptStr(Selected) + '%')
    else FFilter := '';
  end;
  inherited InitData;

  //颜色...
  edtStaNo.Enabled := FActOper = aoAdd;
  if not edtStaNo.Enabled then edtStaNo.Color := VIEW_COLOR;
end;

procedure TfrmTrainDlg.LoadData;
begin
  //Caption赋值
  case FActOper of
    aoAdd:
    begin
      Caption := '培训记录 - 添加';
      dpDate.Date := Date();
      FAQInqu.Append;
    end;
  else
    with FAQInqu do
    begin
      cbName.Text     := FieldByName('trName').AsString;
      dpDate.Date     := FieldByName('trDate').AsDateTime;
      edtStaNo.Text   := FieldByName('staffNo').AsString;
      edtStaName.Text := FieldByName('staffName').AsString;
      cbSite.Text     := FieldByName('trSite').AsString;
      cbTrainer.Text  := FieldByName('trainer').AsString;
      meoContent.Text := FieldByName('content').AsString;
      meoDes.Text     := FieldByName('des').AsString;
    end;
    FAQInqu.Edit;
    Caption := '培训记录 - 修改 - ' + edtStaName.Text;
  end;
end;

function TfrmTrainDlg.CheckData: Boolean;
begin
  if edtStaNo.Focused then edtStaNo.OnExit(edtStaNo);

  if Trim(cbName.Text) = '' then
  begin
    Result := False;
    MessageBox(Handle, PAnsiChar('请输入您要添加的培训名称。'), '提示',  MB_ICONWARNING + MB_OK);
    cbName.SetFocus;
    Exit;
  end;

  if Trim(edtStaName.Text) = '' then
  begin
    Result := False;
    MessageBox(Handle, PAnsiChar('请输入您要操作员工的工号。'), '提示',  MB_ICONWARNING + MB_OK);
    edtStaNo.SetFocus;
    Exit;
  end;

  Result := inherited CheckData();
end;

procedure TfrmTrainDlg.SaveData;
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
    FieldByName('trName').AsString     := cbName.Text;
    FieldByName('trDate').AsString     := DateToStr(dpDate.Date);
    FieldByName('trSite').AsString     := cbSite.Text;
    FieldByName('trainer').AsString    := cbTrainer.Text;
    FieldByName('content').AsString    := meoContent.Text;
    FieldByName('des').AsString        := meoDes.Text;
    FieldByName('operDate').AsDateTime := Now();
  end;

  FAQInqu.Post;
  FAQInqu.UpdateBatch();
end;

procedure TfrmTrainDlg.dg_staffDblClick(Sender: TObject);
begin
  inherited;
  cbSite.SetFocus;
end;

end.
