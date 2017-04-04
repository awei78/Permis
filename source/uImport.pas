unit uImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBase, StdCtrls, Buttons, ExtCtrls, DBGridEh, Mask, RzEdit, ExcelXP,
  RzBtnEdt, Grids, ComCtrls, RzGrids, ComObj, DB, ADODB;

type
  TfrmImport = class(TfrmBase)
    Label1: TLabel;
    bePath: TRzButtonEdit;
    Label2: TLabel;
    sgField: TRzStringGrid;
    cbField: TComboBox;
    lbSheet: TListBox;
    Label3: TLabel;
    cbNoSameStaNo: TCheckBox;
    pnlShow: TPanel;
    lblDis: TLabel;
    pbDis: TProgressBar;
    procedure bePathButtonClick(Sender: TObject);
    procedure bePathChange(Sender: TObject);
    procedure sgFieldClick(Sender: TObject);
    procedure sgFieldTopLeftChanged(Sender: TObject);
    procedure lbSheetClick(Sender: TObject);
    procedure cbFieldChange(Sender: TObject);
  private
    { Private declarations }
    FDBGrid: TDBGridEh;
    FLastIndex: Integer;
    procedure ClearData;
    procedure LoadExcel(AFileName: string);
    procedure LoadSheet(ASheet: OleVariant);
    function GetFieldNameByCaption(const ACaption: string): string;
    function GetSqlStr: string;
    procedure UpdateDept;
    procedure UpdateDict;
    //function GetSheetRecordCount(const ASheetName: string): Integer;
  protected
    //���ݲ�������...
    procedure InitData; override;
    procedure SaveData; override;
    //�������
    function CheckData: Boolean; override;
  public
    { Public declarations }
  end;

var
  frmImport: TfrmImport;

function ShowImport(ADBGrid: TDBGridEh): Boolean;

implementation

uses uGlobal, uData, uLunar;

{$R *.dfm}

function ShowImport(ADBGrid: TDBGridEh): Boolean;
begin
  with TfrmImport.Create(Application.MainForm) do
  begin
    HelpHtml := 'import.html';
    FDBGrid := ADBGrid;
    try
      InitData();
      Result := ShowModal() = mrOk;
    finally
      Free;
    end;
  end;
end;

procedure TfrmImport.InitData;
var
  i: Integer;
begin
  sgField.RowCount := FDBGrid.Columns.Count;
  sgField.ColWidths[0] := 25;
  sgField.ColWidths[1] := 120;
  sgField.ColWidths[2] := 120;
  sgField.Cells[1, 0] := 'Ŀ���ֶ�';
  sgField.Cells[2, 0] := 'Excel��';
  cbField.Visible := False;
  cbField.Width := 120;

  //��Ϣ��ʾ���
  pnlShow.Visible := False;
  pnlShow.Left := (Width - pnlShow.Width) div 2;
  pnlShow.Top := (Height - pnlShow.Height) div 2 - 6;

  for i := 1 to FDBGrid.Columns.Count - 1 do
  begin
    sgField.Cells[0, i] := IntToStr(i);
    sgField.Cells[1, i] := FDBGrid.Columns[i].Title.Caption;
  end;

  cbNoSameStaNo.Checked := App.NoImpSameStaNo;
end;

procedure TfrmImport.ClearData;
begin
  cbField.Visible := False;
  //���ComboBox
  cbField.Items.Clear;

  sgField.Cols[2].Clear;
  sgField.Cells[2, 0] := 'Excel��';
end;

procedure TfrmImport.LoadExcel(AFileName: string);
var
  v, sheet: OleVariant;
  i: Integer;
begin
  if not ExcelInstalled(Handle) then Exit;

  FLastIndex := -1;
  v := CreateOleObject('Excel.Application');
  try
    v.WorkBooks.Open(AFileName);
    if v.Worksheets.Count = 0 then
    begin
      MessageBox(Handle, PAnsiChar('��ѡ���Excelû�л�Ĺ�����Excel���ݲ��ܱ�����'), '��ʾ', MB_OK + MB_ICONWARNING);
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

procedure TfrmImport.LoadSheet(ASheet: OleVariant);
var
  i, j: Integer;
begin
  ClearData();
  //���ComboBox
  cbField.items.Append('');
  for i := 1 to ASheet.Columns.Count do
    if Trim(ASheet.Cells[1, i]) <> '' then
      cbField.Items.Append(ASheet.Cells[1, i])
    else Break;

  //��ʼ����Ӧ�ֶ�
  for i := 1 to sgField.RowCount - 1 do
    for j := 0 to cbField.Items.Count - 1 do
      if (Pos(sgField.Cells[1, i], cbField.Items[j]) > 0) or (Pos(cbField.Items[j], sgField.Cells[1, i]) > 0) then
        sgField.Cells[2, i] := cbField.Items[j];
end;

function TfrmImport.GetFieldNameByCaption(const ACaption: string): string;
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

function TfrmImport.GetSqlStr: string;
var
  i: Integer;
  sTableFields, sSheetFields, sCurTableField, sCurSheetField: string;
begin
  for i := 1 to sgField.RowCount - 1 do
  begin
    if Trim(sgField.Cells[2, i]) = '' then Continue;

    sCurTableField := GetFieldNameByCaption(sgField.Cells[1, i]);
    sTableFields := sTableFields + ', ' + sCurTableField;

    sCurSheetField := sgField.Cells[2, i];
    if sCurTableField = 'workState' then
      sSheetFields := sSheetFields + ', iif(' + sCurSheetField + '="��ְ", 1, iif(' + sCurSheetField + '="���", 2, 0)) AS [' + sCurSheetField + ']'
    else sSheetFields := sSheetFields + ', [' + sgField.Cells[2, i] + ']';
  end;
  sTableFields := Copy(sTableFields, 3, Length(sTableFields) - 2);
  sSheetFields := Copy(sSheetFields, 3, Length(sSheetFields) - 2);

  Result := 'INSERT INTO [staffs](' + sTableFields + ') SELECT ' + sSheetFields +
  ' FROM [Excel 8.0; database=' + bePath.Text + '].[' + lbSheet.Items[lbSheet.ItemIndex] + '$] tblXls WHERE [' + sgField.Cells[2, 1] + ']&"" <> ""';
  if cbNoSameStaNo.Checked then Result := Result + ' AND NOT EXISTS (SELECT id FROM [staffs] WHERE staffNo=tblXls.[' + sgField.Cells[2, 1] + '])';
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

procedure TfrmImport.UpdateDept;
  procedure DoUpdateDept(const ADeptStr: string);
  var
    sl: TStrings;
    i: Integer;
    sDeptName, sSql, sParId, sSortNo: string;
  begin
    sl := TStringList.Create;
    try
      sl.Delimiter := '/';
      sl.DelimitedText := ADeptStr;
      for i := 0 to sl.Count - 1 do
      begin
        sDeptName := sl[i];
        if Trim(sDeptName) = '' then Exit;

        sSql := 'SELECT id FROM [dept] WHERE deptName=' + QuotedStr(sDeptName);
        if VarToStr(dmPer.GetFieldValue(sSql, 'id')) = '' then
        begin
          //���ڵ�
          if i = 0 then
            sParId := '0'
          else sParId := dmPer.GetFieldValue('SELECT id FROM [dept] WHERE deptName=' + QuotedStr(sl[i - 1]), 'id');
          if sParId = '' then sParId := '0';

          //ȡ��ǰ���������
          sSortNo := dmPer.GetFieldValue('SELECT Count(id) AS recCount FROM [dept] WHERE parId=' + sParId, 'recCount');
          sSql := 'INSERT INTO [dept](deptName, parId, sortNo) VALUES(' + QuotedStr(sDeptName) + ', ' + sParId + ', ' + sSortNo + ')';
          dmPer.ExecSQL(sSql);
        end;
      end;
    finally
      sl.Free;
    end;
  end;

var
  i: Integer;
  HasDept: Boolean;
  sSql, sDeptStr: string;
begin
  HasDept := False;
  //���Ƿ��ж�Ӧ�Ĳ���������
  for i := 1 to sgField.RowCount - 1 do
  begin
    if Trim(sgField.Cells[2, i]) = '' then Continue;

    if GetFieldNameByCaption(sgField.Cells[1, i]) = 'deptName' then
    begin
      HasDept := True;
      Break;
    end;
  end;
  if not HasDept then Exit;

  sSql := 'SELECT DISTINCT deptName FROM [staffs]';
  //���ݲ�ѯ
  with dmPer do
  begin
    OpenQuery(aqTemp, sSql);
    if not aqTemp.Eof then
    begin
      if not pnlShow.Visible then pnlShow.Show;
      lblDis.Caption := '���ڸ��²�����Ϣ...';
      pbDis.Position := 0;
      pbDis.Max := aqTemp.RecordCount;

      while not aqTemp.Eof do
      begin
        pbDis.Position := pbDis.Position + 1;
        pnlShow.Update;
        sDeptStr := aqTemp.FieldByName('deptName').AsString;
        if sDeptStr <> '' then DoUpdateDept(sDeptStr);
        aqTemp.Next;
      end;
    end;
  end;
end;

procedure TfrmImport.UpdateDict;
  procedure DoUpdateDict(const AFieldName, AFieldCaption: string);
  var
    sFieldName, sSql, sKindName, sKindType, sSortNo: string;
  begin
    sFieldName := GetFieldNameByCaption(AFieldCaption);
    sKindType := IntToStr(Ord(GetKindTypeByFieldName(sFieldName)));

    sSql := 'SELECT DISTINCT ' + sFieldName + ' FROM [staffs]';
    with dmPer do
    begin
      OpenQuery(aqTemp, sSql);
      if not aqTemp.Eof then
      begin
        if not pnlShow.Visible then pnlShow.Show;
        lblDis.Caption := '���ڸ���' + AFieldCaption + '��Ϣ...';
        pbDis.Position := 0;
        pbDis.Max := aqTemp.RecordCount;

        while not aqTemp.Eof do
        begin
          pbDis.Position := pbDis.Position + 1;
          pnlShow.Update;
          sKindName := aqTemp.FieldByName(sFieldName).AsString;
          if sKindName <> '' then
          begin
            sSql := 'SELECT id FROM [dict] WHERE kindName=' + QuotedStr(sKindName) + ' AND kindType=' + sKindType;
            if VarToStr(GetFieldValue(sSql, 'id')) = '' then
            begin
              //ȡ��¼����ǰ���
              sSortNo := GetFieldValue('SELECT Count(id) AS recCount FROM [dict] WHERE kindType=' + sKindType, 'recCount');
              //�����¼
              sSql := 'INSERT INTO [dict](kindName, kindType, sortNo) VALUES(' + QuotedStr(sKindName) + ', ' + sKindType + ', ' + sSortNo + ')';
              ExecSQL(sSql);
            end;
          end;

          aqTemp.Next;
        end;
      end;
    end;
  end;

var
  i: Integer;
  sFieldName: string;
begin
  //���Ƿ��ж�Ӧ�Ĳ���������
  for i := 1 to sgField.RowCount - 1 do
  begin
    if Trim(sgField.Cells[2, i]) = '' then Continue;

    sFieldName := GetFieldNameByCaption(sgField.Cells[1, i]);
    //��Ҫ����
    if Pos('|' + sFieldName + '|', '|duty|workKind|technic|folk|marriage|politics|culture|special|bankName|') <> 0 then
      DoUpdateDict(sFieldName, sgField.Cells[1, i]);
  end;
end;

function TfrmImport.CheckData: Boolean;
  var
  v: OleVariant;
begin
  Result := False;
  if not ExcelInstalled(Handle) then Exit;

  if not FileExists(bePath.Text) or (lbSheet.Count = 0) then
  begin
    MessageBox(Handle, PAnsiChar('��ѡ����Ҫ�������Ч��Excel�ļ���'), '��ʾ', MB_OK + MB_ICONINFORMATION);
    bePath.OnButtonClick(bePath);
    Exit;
  end;

  if Trim(sgField.Cols[2].Text) = 'Excel��' then
  begin
    MessageBox(Handle, PAnsiChar('��ѡ��Excel���������ֶζ�Ӧ�У�'), '��ʾ', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;

  if Trim(sgField.Cells[2, 1]) = '' then
  begin
    MessageBox(Handle, PAnsiChar('��ѡ��Excel���빤���ֶζ�Ӧ���У�'), '��ʾ', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;

  //�ش�һ��Excel�ļ����Խ��Streamд��Excel����׼����
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

procedure TfrmImport.SaveData;
var
  sSql: string;
  RecCount: Integer;
begin
  sSql := GetSqlStr();
  try
    RecCount := dmPer.ExecSQL(sSql);
    //�з������������ݵ���
    if RecCount > 0 then
    begin
      //MessageBox(Handle, PAnsiChar('��ѡ���Excel�����ѳɹ����뵽���ݿ��С�'), '��ʾ', MB_OK + MB_ICONINFORMATION);
      //����ƴ��
      Screen.Cursor := crHourGlass;
      try
        with dmPer do
        begin
          OpenQuery(aqTemp, 'SELECT id, birth, birthGreg, staffName, staffPY FROM [staffs]');
          if aqTemp.RecordCount > 0 then
          begin
            aqTemp.First;
            while not aqTemp.Eof do
            begin
              Application.ProcessMessages;
              if aqTemp.FieldByName('staffPY').IsNull then
              begin
                aqTemp.Edit;
                if aqTemp.FieldByName('staffPY').AsString = '' then
                  aqTemp.FieldByName('staffPY').AsString := GetPYStr(aqTemp.FieldByName('staffName').AsString);
                if not aqTemp.FieldByName('birth').IsNull then
                  aqTemp.FieldByName('birthGreg').AsDateTime := ToGreg(aqTemp.FieldByName('birth').AsDateTime);
                aqTemp.Post;
              end;

              aqTemp.Next;
            end;
            aqTemp.UpdateBatch();
          end;
        end;
        //�ع�����
        UpdateDept();
        //�ع��ֵ�
        UpdateDict();
        //ˢ������
        PostMessage(Application.MainForm.Handle, WM_DATARESTORE, 0, 0);
      finally
        pnlShow.Hide;
        Screen.Cursor := crDefault;
      end;
    end;

    ModalResult := mrOk;
    App.NoImpSameStaNo := cbNoSameStaNo.Checked;
    Log.Write(App.UserID + '����Excel�ĵ���[' + bePath.Text + '-> ' + lbSheet.Items[lbSheet.ItemIndex] + ']�������¼����' + IntToStr(RecCount));
  except
    on E: Exception do
    begin
      Log.Write(App.UserID + '����Excel�ĵ���[' + bePath.Text + '-> ' + lbSheet.Items[lbSheet.ItemIndex] + ']ʧ�ܣ���Ϣ��' + E.Message);
      MessageBox(Handle, PAnsiChar('Excel���ݵ���ʧ�ܣ���ϢΪ��' + E.Message), '��ʾ', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TfrmImport.bePathButtonClick(Sender: TObject);
var
  od: TOpenDialog;
begin
  od := TOpenDialog.Create(Self);
  try
    od.Title := '��Ҫ�����ĸ�Excel�ļ���';
    od.Filter := 'Microsoft Excel �ļ� (*.xls)|*.xls';
    od.Options := od.Options + [ofFileMustExist];
    if od.Execute then bePath.Text := od.FileName;
  finally
    od.Free;
  end;
end;

procedure TfrmImport.bePathChange(Sender: TObject);
begin
  if FileExists(bePath.Text) and (ExtractFileExt(bePath.Text) = '.xls') then
    LoadExcel(bePath.Text)
  else
  begin
    ClearData();
    lbSheet.Items.Clear;
  end;
end;

procedure TfrmImport.sgFieldClick(Sender: TObject);
begin
  cbField.Visible := sgField.Col = 2;
  if cbField.Visible then
  begin
    cbField.Left := sgField.Left + sgField.CellRect(sgField.Col, sgField.Row).Left + 2;
    cbField.Top := sgField.Top + sgField.CellRect(sgField.Col, sgField.Row).Top + 1;
    cbField.ItemIndex := cbField.Items.IndexOf(sgField.Cells[sgField.Col, sgField.Row]);
  end;
end;

procedure TfrmImport.sgFieldTopLeftChanged(Sender: TObject);
begin
  cbField.Visible := False;
end;

procedure TfrmImport.lbSheetClick(Sender: TObject);
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

procedure TfrmImport.cbFieldChange(Sender: TObject);
begin
  sgField.Cells[sgField.Col, sgField.Row] := cbField.Text;
end;

end.
