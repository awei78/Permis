{******
  单 元：uImportC.pas
  作 者：刘景威
  日 期：2009-3-16
  说 明：从Excel中导入员工合同单元
  更 新：
******}

unit uImportC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBase, StdCtrls, Buttons, ExtCtrls, DBGridEh, Mask, RzEdit, ExcelXP,
  RzBtnEdt, Grids, ComCtrls, RzGrids, ComObj, DB, ADODB;

type
  TfrmImportC = class(TfrmBase)
    Label1: TLabel;
    bePath: TRzButtonEdit;
    Label2: TLabel;
    sgField: TRzStringGrid;
    cbField: TComboBox;
    lbSheet: TListBox;
    Label3: TLabel;
    cbNoSameContNo: TCheckBox;
    procedure bePathButtonClick(Sender: TObject);
    procedure bePathChange(Sender: TObject);
    procedure sgFieldClick(Sender: TObject);
    procedure lbSheetClick(Sender: TObject);
    procedure cbFieldChange(Sender: TObject);
  private
    { Private declarations }
    FLastIndex: Integer;
    FSL: TStrings;
    procedure ClearData;
    procedure LoadExcel(AFileName: string);
    procedure LoadSheet(ASheet: OleVariant);
    function GetSqlStr: string;
    procedure UpdateContractType;
    //function GetSheetRecordCount(const ASheetName: string): Integer;
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
  frmImportC: TfrmImportC;

function ShowImportC(): Boolean;

implementation

uses uGlobal, uData;

{$R *.dfm}

function ShowImportC(): Boolean;
begin
  with TfrmImportC.Create(Application.MainForm) do
  begin
    HelpHtml := 'cont_import.html';
    try
      FSL := TStringList.Create;
      InitData();
      Result := ShowModal() = mrOk;
    finally
      FSL.Free;
      Free;
    end;
  end;
end;

procedure TfrmImportC.InitData;
var
  i: Integer;
begin
  sgField.RowCount := 16;
  sgField.ColWidths[0] := 25;
  sgField.ColWidths[1] := 120;
  sgField.ColWidths[2] := 120;
  sgField.Cells[1, 0] := '目标字段';
  sgField.Cells[2, 0] := 'Excel列';
  cbField.Visible := False;
  cbField.Width := 120;

  FSL := TStringList.Create;

  //初始化数据列
  with FSL do
  begin
    Append('工号=staffNo');
    Append('姓名=staffName');
    Append('性别=sex');
    Append('部门=deptName');
    Append('合同编号=contNo');
    Append('合同名称=contName');
    Append('合同类型=contType');
    Append('合同属性=contProp');
    Append('签订日期=recDate');
    Append('合同期=contMonth');
    Append('生效日期=startDate');
    Append('终止日期=endDate');
    Append('合同状态=contState');
    Append('合同文件=contFile');
    Append('合同备注=des');
  end;
  for i := 0 to FSL.Count - 1 do
  begin
    sgField.Cells[0, i + 1] := IntToStr(i + 1);
    sgField.Cells[1, i + 1] := FSL.Names[i]
  end;

  cbNoSameContNo.Checked := App.NoImpSameContNo;
end;

procedure TfrmImportC.ClearData;
begin
  cbField.Visible := False;
  //填充ComboBox
  cbField.Items.Clear;

  sgField.Cols[2].Clear;
  sgField.Cells[2, 0] := 'Excel列';
end;

procedure TfrmImportC.LoadExcel(AFileName: string);
var
  v, sheet: OleVariant;
  i: Integer;
begin
  if not ExcelInstalled(Handle) then Exit;

  Application.ProcessMessages;
  FLastIndex := -1;
  v := CreateOleObject('Excel.Application');
  try
    v.WorkBooks.Open(AFileName);
    if v.Worksheets.Count = 0 then
    begin
      MessageBox(Handle, PAnsiChar('您选择的Excel没有活动的工作表，Excel数据不能被导入'), '提示', MB_OK + MB_ICONWARNING);
      Exit;
    end;

    lbSheet.Items.Clear;
    for i := 1 to v.Worksheets.Count do
    begin
      sheet := v.WorkSheets[i];
      lbSheet.Items.Append(sheet.Name);
    end;
    lbSheet.ItemIndex := 0;
    lbSheet.OnClick(lbSheet);
  finally
    v.ActiveWorkBook.Saved := True;
    v.WorkBooks.Close;
    v.Quit;
    v := Unassigned;
  end;
end;

procedure TfrmImportC.LoadSheet(ASheet: OleVariant);
var
  i, j: Integer;
begin
  ClearData();
  //填充ComboBox
  cbField.items.Append('');
  for i := 1 to ASheet.Columns.Count do
    if Trim(ASheet.Cells[1, i]) <> '' then
      cbField.Items.Append(ASheet.Cells[1, i])
    else Break;

  //初始化对应字段
  for i := 1 to sgField.RowCount - 1 do
    for j := 0 to cbField.Items.Count - 1 do
      if (Pos(sgField.Cells[1, i], cbField.Items[j]) > 0) or (Pos(cbField.Items[j], sgField.Cells[1, i]) > 0) then
        sgField.Cells[2, i] := cbField.Items[j];
end;

function TfrmImportC.GetSqlStr: string;
var
  i: Integer;
  sTableFields, sSheetFields, sCurTableField, sCurSheetField: string;
begin
  for i := 1 to sgField.RowCount - 1 do
  begin
    if Trim(sgField.Cells[2, i]) = '' then Continue;

    sCurTableField := FSL.Values[sgField.Cells[1, i]];
    sTableFields := sTableFields + ', ' + sCurTableField;

    sCurSheetField := sgField.Cells[2, i];
    sSheetFields := sSheetFields + ', [' + sCurSheetField + ']';
  end;
  sTableFields := Copy(sTableFields, 3, Length(sTableFields) - 2);
  sSheetFields := Copy(sSheetFields, 3, Length(sSheetFields) - 2);

  Result := 'INSERT INTO [contract](' + sTableFields + ') SELECT ' + sSheetFields +
  ' FROM [Excel 8.0; database=' + bePath.Text + '].[' + lbSheet.Items[lbSheet.ItemIndex] + '$] tblXls WHERE [' + sgField.Cells[2, 5] + ']&"" <> ""';
  if cbNoSameContNo.Checked then Result := Result + ' AND NOT EXISTS (SELECT id FROM [contract] WHERE contNo=tblXls.[' + sgField.Cells[2, 5] + '])';
end;

procedure TfrmImportC.UpdateContractType;
var
  sSql, sContType, sTypeID, sSortNo: string;
begin
  //合同属性栏
  if Trim(sgField.Cells[2, 7]) = '' then Exit;

  //此处不能从Excel中取，为的是cbNoSameContNo.Checked判断。因为数据已加入，所以其返回True值
  sSql := 'SELECT DISTINCT contType FROM [contract]';
  with dmPer do
  begin
    OpenQuery(aqTemp, sSql);
    while not aqTemp.Eof do
    begin
      sContType := aqTemp.FieldByName('contType').AsString;
      if sContType <> '' then
      begin
        sTypeID := IntToStr(Ord(ktState));
        sSql := 'SELECT id FROM [dict] WHERE kindName=' + QuotedStr(sContType) + ' AND kindType=' + sTypeID;
        if VarToStr(GetFieldValue(sSql, 'id')) = '' then
        begin
          //取记录数当前序号
          sSortNo := GetFieldValue('SELECT Count(id) AS recCount FROM [dict] WHERE kindType=' + sTypeID, 'recCount');
          //插入记录
          sSql := 'INSERT INTO [dict](kindName, kindType, sortNo) VALUES(' + QuotedStr(sContType) + ', ' + sTypeID + ', ' + sSortNo + ')';
          ExecSQL(sSql);
        end;
      end;

      aqTemp.Next;
    end;
  end;
end;

{function TfrmImport.GetSheetRecordCount(const ASheetName: string): Integer;
var
  ac: TADOConnection;
  aq: TADOQuery;
begin
  ac := TADOConnection.Create(Self);
  aq := TADOQuery.Create(Self);

  try
    ac.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Persist Security Info=False;Data Source=' + bePath.Text + ';Mode=Read;Extended Properties="Excel 8.0;"';
    ac.LoginPrompt := False;
    ac.Open();
    aq.Connection := ac;
    aq.SQL.Text := 'SELECT * FROM [' + lbSheet.Items[lbSheet.ItemIndex] + '$] WHERE [' + sgField.Cells[2, 1] + ']<>''''';
    aq.Open;

    Result := aq.RecordCount;
    ac.Close;
    aq.Close;
  finally
    ac.Free;
    aq.Free;
  end;
end;}

function TfrmImportC.CheckData: Boolean;
  var
  v: OleVariant;
begin
  Result := False;
  if not ExcelInstalled(Handle) then Exit;

  if not FileExists(bePath.Text) or (lbSheet.Count = 0) then
  begin
    MessageBox(Handle, PAnsiChar('请选择您要导入的有效的Excel文件。'), '提示', MB_OK + MB_ICONINFORMATION);
    bePath.OnButtonClick(bePath);
    Exit;
  end;

  if Trim(sgField.Cols[2].Text) = 'Excel列' then
  begin
    MessageBox(Handle, PAnsiChar('请选择Excel中与数据字段对应列！'), '提示', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;

  if Trim(sgField.Cells[2, 1]) = '' then
  begin
    MessageBox(Handle, PAnsiChar('请选择Excel中与工号字段对应的列！'), '提示', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;

  //重存一次Excel文件，以解决Stream写的Excel不标准问题
  v := CreateOleObject('Excel.Application');
  v.Workbooks.Open(bePath.Text);
  try
    FileSetReadOnly(bePath.Text, False);
    v.ActiveWorkbook.Save;
  finally
    v.Quit;
    v := Unassigned;
  end;

  Result := inherited CheckData();
end;

procedure TfrmImportC.SaveData;
var
  sSql: string;
  RecCount: Integer;
begin
  sSql := GetSqlStr();
  try
    RecCount := dmPer.ExecSQL(sSql);
    if RecCount > 0 then
    begin
      //同步拼音
      sSql := 'UPDATE [contract] a, [staffs] b SET a.staffID = b.id, a.staffPY = b.staffPY, a.sex = b.sex, a.reger= ''' + App.UserID + ''' ' +
              'WHERE a.staffNo = b.staffNO and a.staffName = b.staffName';
      dmPer.ExecSQL(sSql);

      //取出合同属性，并写入字典数据中
      UpdateContractType();
      MessageBox(Handle, PAnsiChar('您选择的Excel数据已成功导入到合同数据表中。合同条数：' + IntToStr(RecCount)), '提示', MB_OK + MB_ICONINFORMATION);
    end
    else MessageBox(Handle, PAnsiChar('没有找到符合条件的数据。'), '提示', MB_OK + MB_ICONINFORMATION);

    ModalResult := mrOk;
    App.NoImpSameContNo := cbNoSameContNo.Checked;
    Log.Write(App.UserID + '导入合同Excel文档：[' + bePath.Text + '-> ' + lbSheet.Items[lbSheet.ItemIndex] + ']');
  except
    on E: Exception do
    begin
      Log.Write(App.UserID + 'Excel数据导入失败，信息：' + E.Message);
      MessageBox(Handle, PAnsiChar('Excel数据导入失败！信息为：' + E.Message), '提示', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TfrmImportC.bePathButtonClick(Sender: TObject);
var
  od: TOpenDialog;
begin
  od := TOpenDialog.Create(Self);
  try
    od.Title := '您要导入哪个Excel文件？';
    od.Filter := 'Microsoft Excel 文件 (*.xls)|*.xls';
    od.Options := od.Options + [ofFileMustExist];
    if od.Execute then bePath.Text := od.FileName;
  finally
    od.Free;
  end;
end;

procedure TfrmImportC.bePathChange(Sender: TObject);
begin
  if FileExists(bePath.Text) and (ExtractFileExt(bePath.Text) = '.xls') then
    LoadExcel(bePath.Text)
  else
  begin
    ClearData();
    lbSheet.Items.Clear;
  end;
end;

procedure TfrmImportC.sgFieldClick(Sender: TObject);
begin
  cbField.Visible := sgField.Col = 2;
  if cbField.Visible then
  begin
    cbField.Left := sgField.Left + sgField.CellRect(sgField.Col, sgField.Row).Left + 2;
    cbField.Top := sgField.Top + sgField.CellRect(sgField.Col, sgField.Row).Top + 1;
    cbField.ItemIndex := cbField.Items.IndexOf(sgField.Cells[sgField.Col, sgField.Row]);
  end;
end;

procedure TfrmImportC.lbSheetClick(Sender: TObject);
var
  v, sheet: OleVariant;
  i: Integer;
begin
  if lbSheet.ItemIndex = FLastIndex then Exit;

  v := CreateOleObject('Excel.Application');
  try
    v.WorkBooks.Open(bePath.Text);
    for i := 1 to v.Worksheets.Count do
    begin
      sheet := v.WorkSheets[i];
      if sheet.Name = lbSheet.Items[lbSheet.ItemIndex] then
      begin
        LoadSheet(sheet);
        FLastIndex := lbSheet.ItemIndex;
        Break;
      end;
    end;
  finally
    v.ActiveWorkBook.Saved := True;
    v.WorkBooks.Close;
    v.Quit;
    v := Unassigned;
  end;
end;

procedure TfrmImportC.cbFieldChange(Sender: TObject);
begin
  sgField.Cells[sgField.Col, sgField.Row] := cbField.Text;
end;

end.
