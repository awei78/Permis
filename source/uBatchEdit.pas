unit uBatchEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBase, ComCtrls, StdCtrls, Buttons, CtrlsEx, ExtCtrls, DB, ADODB,
  DBGridEh;

type
  TfrmBatchEdit = class(TfrmBase)
    img: TImage;
    Label3: TLabel;
    Label1: TLabel;
    rbCur: TRadioButton;
    rbAll: TRadioButton;
    Label2: TLabel;
    cbFields: TComboBox;
    Label5: TLabel;
    edtValue: TEdit;
    cbValue: TComboBox;
    dpValue: TDateTimePicker;
    procedure btnOkClick(Sender: TObject);
    procedure cbFieldsChange(Sender: TObject);
  private
    { Private declarations }
    FDBGrid: TDBGridEh;
    FWhr: string;
  protected
    procedure InitData; override;
    procedure SaveData; override;
    function CheckData: Boolean; override;
  public
    { Public declarations }
  end;

var
  frmBatchEdit: TfrmBatchEdit;

function ShowBatchEdit(ADBGrid: TDBGridEh; AWhr: string = ''): Boolean;

implementation

uses uData, uGlobal;

{$R *.dfm}

function ShowBatchEdit(ADBGrid: TDBGridEh; AWhr: string): Boolean;
begin
  if not Assigned(frmBatchEdit) then
  begin
    frmBatchEdit := TfrmBatchEdit.Create(Application.MainForm);
    with frmBatchEdit do
    begin
      FDBGrid := ADBGrid;
      HelpHtml := 'batchedit.html';
      FDBGrid := ADBGrid;
      InitData();
    end;
  end;

  with frmBatchEdit do
  begin
    FWhr := AWhr;
    //显示
    Result := ShowModal() = mrOk;
  end;
end;

{ TfrmBatchEdit }

procedure TfrmBatchEdit.InitData;
var
  i: Integer;
begin
  cbValue.Visible := False;
  cbValue.Top := edtValue.Top;
  dpValue.Visible := False;
  dpValue.Top := edtValue.Top;

  cbFields.Items.Clear;
  for i := 1 to FDBGrid.Columns.Count - 1 do
    if Pos(FDBGrid.Columns[i].Field.FieldName, 'age') = 0 then
      cbFields.Items.AddObject(FDBGrid.Columns[i].Title.Caption, TObject(i));

  if cbFields.Items.Count <> 0 then cbFields.ItemIndex := 0;
end;

function TfrmBatchEdit.CheckData: Boolean;
begin
  Result := inherited CheckData();
end;

procedure TfrmBatchEdit.SaveData;
var
  FieldIndex: Integer;
  sSql, sFieldName, sValue: string;
  BookMark: TBookMark;
begin
  FieldIndex := Integer(cbFields.Items.Objects[cbFields.ItemIndex]);
  sFieldName := FDBGrid.Columns[FieldIndex].FieldName;
  if edtValue.Visible then
    sValue := QuotedStr(edtValue.Text)
  else if cbValue.Visible then
  begin
    if sFieldName = 'workState' then
      sValue := IntToStr(cbValue.ItemIndex)
    else sValue := QuotedStr(cbValue.Text);
  end
  else sValue := '#' + DateToStr(dpValue.Date) + '#';
  sSql := 'UPDATE [staffs] SET ' + sFieldName + '=' + sValue;
  if rbCur.Checked then sSql := sSql + ' WHERE ' + FWhr;
  //更新数据
  dmPer.ExecSQL(sSql);
  //重计算数据
  BookMark := TADOQuery(FDBGrid.DataSource.DataSet).GetBookmark;
  TADOQuery(FDBGrid.DataSource.DataSet).Requery();
  if TADOQuery(FDBGrid.DataSource.DataSet).BookmarkValid(BookMark) then
  begin
    TADOQuery(FDBGrid.DataSource.DataSet).GotoBookmark(BookMark);
    TADOQuery(FDBGrid.DataSource.DataSet).FreeBookmark(BookMark); 
  end;

  Log.Write(App.UserID + '进行员工字段批量修改。字段：' + cbFields.Text + '，值：' + sValue);
end;

procedure TfrmBatchEdit.btnOkClick(Sender: TObject);
begin
  if CheckData() then SaveData();
end;

procedure TfrmBatchEdit.cbFieldsChange(Sender: TObject);
var
  FieldIndex: Integer;
  sFieldName, sMaxValue: string;
begin
  FieldIndex := Integer(cbFields.Items.Objects[cbFields.ItemIndex]);
  sFieldName := FDBGrid.Columns[FieldIndex].FieldName;
  cbValue.Visible := Pos(sFieldName, 'sex,folk,marriage,politics,culture,special,deptName,duty,workKind,technic,workState,bankName') <> 0;
  dpValue.Visible := FDBGrid.Columns[FieldIndex].Field.DataType = ftDateTime;
  edtValue.Visible := not (cbValue.Visible or dpValue.Visible);

  if cbValue.Visible then
  begin
    cbValue.Style := csDropDown;
    cbValue.Clear;
    if sFieldName = 'deptName' then
      FillDept(cbValue)
    else if sFieldName = 'sex' then
    begin
      cbValue.Items.Append('男');
      cbValue.Items.Append('女');
    end
    else if sFieldName = 'workState' then
    begin
      cbValue.Style := csDropDownList;
      cbValue.Items.Append('在职');
      cbValue.Items.Append('离职');
      cbValue.Items.Append('请假');
    end
    else FillKind(cbValue, GetKindTypeByFieldName(sFieldName));

    if sFieldName <> 'workState' then
    begin
      //置最多使用的为默认值
      //sMaxValue := dmPer.GetFieldValue('SELECT TOP 1 ' + sFieldName + ' FROM [staffs] GROUP BY ' + sFieldName + ' HAVING Count(id)=(SELECT Max(vCount) FROM (SELECT Count(id) AS vCount, ' + sFieldName + ' FROM [staffs] GROUP BY ' + sFieldName + '))', sFieldName);
      //两种方法都可以得到想要的结果
      if cbValue.Items.Count <> 0 then
      begin
        sMaxValue := dmPer.GetFieldValue('SELECT TOP 1 ' + sFieldName + ' FROM (SELECT Count(id) AS vCount, ' + sFieldName + ' FROM [staffs] WHERE NOT ' + sFieldName + ' IS NULL GROUP BY ' + sFieldName + ') ORDER BY vCount DESC, ' + sFieldName, sFieldName);
        cbValue.ItemIndex := cbValue.Items.IndexOf(sMaxValue);
      end;
    end
    else cbValue.ItemIndex := 0;
  end;
end;

end.
