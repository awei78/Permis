unit uInqu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBase, StdCtrls, Buttons, ComCtrls, ExtCtrls, CtrlsEx, DB, DBGridEh;

type
  TfrmInqu = class(TfrmBase)
    gbBasic: TGroupBox;
    Label2: TLabel;
    cbBF: TComboBox;
    Label3: TLabel;
    edtBV: TEdit;
    gbDate: TGroupBox;
    Label1: TLabel;
    Label4: TLabel;
    cbDF: TComboBox;
    cbDC: TComboBox;
    dpStart: TDateTimePicker;
    dpEnd: TDateTimePicker;
    Label5: TLabel;
    rbOr: TRadioButton;
    rbAnd: TRadioButton;
    cbBC: TComboBox;
    btnReset: TButton;
    lblSpace: TLabel;
    cbBV: TComboBox;
    procedure cbBFChange(Sender: TObject);
    procedure cbDFChange(Sender: TObject);
    procedure cbDCChange(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
  private
    { Private declarations }
    FDBGrid: TDBGridEh;
    function GetWhrStr: string;
    function GetFieldNameByCaption(const ACaption: string): string;
  protected
    //数据操作过程...
    procedure InitData; override;
    procedure ResetData; override;
  public
    { Public declarations }
  end;

var
  frmInqu: TfrmInqu;

function ShowInqu(ADBGrid: TDBGridEh; out AWhr: string): Boolean;

implementation

uses uGlobal, uData;

{$R *.dfm}

function ShowInqu(ADBGrid: TDBGridEh; out AWhr: string): Boolean;
begin
  if not Assigned(frmInqu) then
  begin
    frmInqu := TfrmInqu.Create(Application.MainForm);
    with frmInqu do
    begin
      HelpHtml := 'inqu.html';
      FDBGrid := ADBGrid;
      InitData();
    end;
  end;

  //显示
  with frmInqu do
  begin
    Result := ShowModal() = mrOk;
    if Result then
    begin
      AWhr := GetWhrStr();
      Log.Write(App.UserID + '进行员工查询操作：' + AWhr);
    end;
  end;
end;

{ TfrmInqu }

procedure TfrmInqu.InitData;
var
  i: Integer;
begin
  cbBV.Visible := False;
  cbBV.Top := edtBV.Top;
  cbBF.Items.Clear;
  cbDF.Items.Clear;
  cbDF.Items.Append('留空……');
  for i := 1 to FDBGrid.Columns.Count - 1 do
    if FDBGrid.Columns[i].Field.FieldName <> 'workState' then
    begin
      //基本备件字段
      if FDBGrid.Columns[i].Field.DataType <> ftDateTime then
        cbBF.Items.Append(FDBGrid.Columns[i].Title.Caption)
      //时间条件字段
      else cbDF.Items.Append(FDBGrid.Columns[i].Title.Caption);
    end;
  cbBF.ItemIndex := 1;
  cbBC.ItemIndex := 5;
  cbDF.ItemIndex := 0;
  cbDF.OnChange(cbDF);
  cbDC.ItemIndex := 0;
  cbDC.OnChange(cbDC);
  //日期初始值
  dpStart.Date := Date();
  dpEnd.Date := Date();
end;

procedure TfrmInqu.ResetData;
begin
  cbBF.ItemIndex := 1;
  cbBF.OnChange(cbBF);
  cbBC.ItemIndex := 5;
  edtBV.Text := '';
  rbOr.Checked := True;
  cbDF.ItemIndex := 0;
  cbDF.OnChange(cbDF);
  cbDC.ItemIndex := 0;
  cbDC.OnChange(cbDC);
  //日期初始值
  dpStart.Date := Date();
  dpEnd.Date := Date();

  edtBV.SetFocus;
end;

function TfrmInqu.GetWhrStr: string;
  function GetSign(ACbx: TComboBox): string;
  begin
    case ACbx.ItemIndex of
      0: Result := '>';
      1: Result := '>=';
      2: Result := '=';
      3: Result := '<=';
      4: Result := '<';
      5:
      begin
        if ACbx = cbBC then
          Result := 'LIKE'
        else Result := 'BETWEEN #%s# AND #%s#';
      end
    end;
  end;

var
  sFieldName, sValue, sWhr: string;
begin
  //基本条件
  if (edtBV.Visible and (Trim(edtBV.Text) <> '')) or (cbBV.Visible and (Trim(cbBV.Text) <> '')) then
  begin
    sFieldName := GetFieldNameByCaption(cbBF.Text);
    if edtBV.Visible then
      sValue := edtBV.Text
    else sValue := cbBV.Text;
    if sFieldName = 'age' then
    begin
      if cbBC.ItemIndex <> cbBC.Items.Count - 1 then
        sWhr := sFieldName + ' ' + GetSign(cbBC) + ' ' + sValue
      else sWhr := ' (' + sFieldName + ' - ' + sValue + ') <= 2';
    end
    else
    begin
      if cbBC.ItemIndex <> cbBC.Items.Count - 1 then
        sWhr := sFieldName + ' ' + GetSign(cbBC) + ' ''' + sValue + ''''
      else sWhr := sFieldName + ' ' + GetSign(cbBC) + ' ''%' + sValue + '%''';
    end;
  end;
  //逻辑关系
  if cbDF.ItemIndex <> 0 then
  begin
    if sWhr <> '' then
    begin
      if rbOr.Checked then
        sWhr := sWhr + ' OR '
      else sWHr := sWhr + ' AND ';
    end;
    //日期条件
    if sWhr <> '' then
    begin
      if cbDC.ItemIndex <> cbDC.Items.Count - 1 then
         sWhr := sWhr + GetFieldNameByCaption(cbDF.Text) + ' ' + GetSign(cbDC) + ' #' + DateToStr(dpStart.Date) + '#'
      else sWhr := sWhr + GetFieldNameByCaption(cbDF.Text) + ' ' + Format(GetSign(cbDC), [DateToStr(dpStart.Date), DateToStr(dpEnd.Date)]);
    end
    else
    begin
      if cbDC.ItemIndex <> cbDC.Items.Count - 1 then
        sWhr := GetFieldNameByCaption(cbDF.Text) + ' ' + GetSign(cbDC) + ' #' + DateToStr(dpStart.Date) + '#'
      else sWhr := GetFieldNameByCaption(cbDF.Text) + ' ' + Format(GetSign(cbDC), [DateToStr(dpStart.Date), DateToStr(dpEnd.Date)]);
    end;
  end;

  if sWhr = '' then sWhr := '0 = 0';
  Result := sWhr;
end;

function TfrmInqu.GetFieldNameByCaption(const ACaption: string): string;
var
  i: Integer;
begin
  for i := 0 to FDBGrid.Columns.Count - 1 do
    if FDBGrid.Columns[i].Title.Caption = ACaption then
    begin
      Result := FDBGrid.Columns[i].FieldName;
      Break;
    end;
end;

procedure TfrmInqu.cbDFChange(Sender: TObject);
begin
  cbDC.Enabled := cbDF.ItemIndex <> 0;
  dpStart.Enabled := cbDC.Enabled;
  dpEnd.Enabled := cbDc.Enabled;
end;

procedure TfrmInqu.cbBFChange(Sender: TObject);
var
  sFieldName, sMaxValue: string;
begin
  sFieldName := GetFieldNameByCaption(cbBF.Text);
  cbBV.Visible := Pos(sFieldName, 'sex,folk,marriage,politics,culture,special,deptName,duty,workKind,technic,bankName') <> 0;
  edtBV.Visible := not cbBV.Visible;
  if cbBV.Visible then
  begin
    cbBV.Clear;
    if sFieldName = 'deptName' then
      FillDept(cbBV)
    else if sFieldName = 'sex' then
    begin
      cbBV.Items.Append('男');
      cbBV.Items.Append('女');
    end
    else FillKind(cbBV, GetKindTypeByFieldName(sFieldName));

    //置最多使用的为默认值
    //sMaxValue := dmPer.GetFieldValue('SELECT TOP 1 ' + sFieldName + ' FROM [staffs] GROUP BY ' + sFieldName + ' HAVING Count(id)=(SELECT Max(vCount) FROM (SELECT Count(id) AS vCount, ' + sFieldName + ' FROM [staffs] GROUP BY ' + sFieldName + '))', sFieldName);
    //两种方法都可以得到想要的结果
    if cbBV.Items.Count <> 0 then
    begin
      sMaxValue := dmPer.GetFieldValue('SELECT TOP 1 ' + sFieldName + ' FROM (SELECT Count(id) AS vCount, ' + sFieldName + ' FROM [staffs] WHERE NOT ' + sFieldName + ' IS NULL GROUP BY ' + sFieldName + ') ORDER BY vCount DESC, ' + sFieldName, sFieldName);
      cbBV.ItemIndex := cbBV.Items.IndexOf(sMaxValue);
    end;
  end;
end;

procedure TfrmInqu.cbDCChange(Sender: TObject);
begin
  dpEnd.Visible := cbDC.ItemIndex = cbDC.Items.Count - 1;
  lblSpace.Visible := dpEnd.Visible;
  if dpEnd.Visible then
    dpStart.Width := 105
  else dpStart.Width := 219;
end;

procedure TfrmInqu.btnResetClick(Sender: TObject);
begin
  ResetData();
end;

end.
