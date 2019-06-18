unit uExport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBase, StdCtrls, Buttons, ExtCtrls, CheckLst, DBGrids, DBGridEh;

type
  TfrmExport = class(TfrmBase)
    cbSelAll: TCheckBox;
    cbExport: TCheckListBox;
    btnReset: TButton;
    gbExport: TGroupBox;
    rbCur: TRadioButton;
    rbAll: TRadioButton;
    procedure cbSelAllClick(Sender: TObject);
    procedure cbExportClickCheck(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
  private
    { Private declarations }
    FDBGrid: TDBGridEh;
    FWhr: string;
  protected
    //数据操作过程...
    procedure InitData; override;
    procedure SaveData; override;
    //检查数据
    function CheckData: Boolean; override;
  public
    { Public declarations }
  end;

var
  frmExport: TfrmExport;

function ShowExport(ADBGrid: TDBGridEh; AWhr: string): Boolean;

implementation

uses uGlobal, uApp, uData;

{$R *.dfm}

function ShowExport(ADBGrid: TDBGridEh; AWhr: string): Boolean;
begin
  with TfrmExport.Create(Application.MainForm) do
  begin
    HelpHtml := 'export.html';
    FDBGrid := ADBGrid;
    FWhr := AWhr;
    try
      InitData();
      Result := ShowModal() = mrOk;
    finally
      Free;
    end;
  end;
end;

procedure TfrmExport.InitData;
var
  i: Integer;
  sCaption: string;
begin
  cbExport.Columns := 3;
  for i := 1 to FDBGrid.Columns.Count - 1 do
  begin
    sCaption := FDBGrid.Columns[i].Title.Caption;
    cbExport.Items.Append({IntToStr(i + 1) + '.' + }sCaption);
    cbExport.Checked[i - 1] := FDBGrid.Columns[i].Visible;
  end;

  cbExport.OnClickCheck(cbExport);
end;

function TfrmExport.CheckData: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to cbExport.Count - 1 do
    Result := Result or cbExport.Checked[i];

  if not Result then
  begin
    MessageBox(Handle, PAnsiChar('请选择您要导出到Excel文档的数据。'), '提示', MB_OK + MB_ICONWARNING);
    btnReset.OnClick(btnReset);
  end;
end;

procedure TfrmExport.SaveData;
var
  DBGrid: TDBGridEh;
  IsFiltered: Boolean;
  i: Integer;
begin
  //赋数据入一DBGrid表格
  DBGrid := TDBGridEh.Create(Self);
  IsFiltered := False;
  if rbAll.Checked then
  begin
    FDBGrid.DataSource.DataSet.DisableControls;
    IsFiltered := FDBGrid.DataSource.DataSet.Filtered;
    FDBGrid.DataSource.DataSet.Filtered := False;
  end;
  try
    DBGrid.Visible := False;
    DBGrid.Parent := Self;
    DBGrid.DataSource := FDBGrid.DataSource;
    DBGrid.DrawMemoText := True;
    DBGrid.Columns.Clear;

    for i := 0 to cbExport.Count - 1 do
    begin
      if not cbExport.Checked[i] then Continue;

      with DBGrid.Columns.Add do
      begin
        Title.Caption := FDBGrid.Columns[i + 1].Title.Caption;
        FieldName := FDBGrid.Columns[i + 1].FieldName;
      end;
    end;

    DataToExcel(DBGrid, '员工信息.xls');
  finally
    DBGrid.Free;
    if rbAll.Checked then
    begin
      FDBGrid.DataSource.DataSet.EnableControls;
      FDBGrid.DataSource.DataSet.Filtered := IsFiltered;
    end;
  end;
end;

procedure TfrmExport.cbSelAllClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to cbExport.Count - 1 do
    cbExport.Checked[i] := cbSelAll.Checked;
end;

procedure TfrmExport.cbExportClickCheck(Sender: TObject);
var
  i: Integer;
  AllChecked: Boolean;
begin
  AllChecked := True;
  for i := 0 to cbExport.Count - 1 do
    if not cbExport.Checked[i] then
    begin
      AllChecked := False;
      Break;
    end;

  //反判断
  if AllChecked and not cbSelAll.Checked then
  begin
    cbSelAll.OnClick := nil;
    cbSelAll.Checked := True;
    cbSelAll.OnClick := cbSelAllClick;
  end;
  if cbSelAll.Checked and not AllChecked then
  begin
    cbSelAll.OnClick := nil;
    cbSelAll.Checked := False;
    cbSelAll.OnClick := cbSelAllClick;
  end;
end;

procedure TfrmExport.btnResetClick(Sender: TObject);
var
  i: Integer;
begin
  //填充状态
  for i := 2 to FDBGrid.Columns.Count - 1 do
    cbExport.Checked[i - 1] := FDBGrid.Columns[i].Visible;
  rbCur.Checked := True;
end;

end.

