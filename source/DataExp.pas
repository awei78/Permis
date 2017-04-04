{******
  �� Ԫ��DataExp.pas
  �� �ߣ�������
  �� �ڣ�2008-11-16
  ˵ ����DBGrid��DBGridEh���ݵ���ΪExcel�ļ���ֱ��д������
  �� �£���ֱд��ΪExcel 2.1��ʽ��office 2010�����ϰ治�ܴ򿪣����ΪExcel�������ɷ���
******}

unit DataExp;

interface

uses
  Windows, Classes, SysUtils, Variants, ComObj, IdGlobal, DB, ADODB, DBGrids, DBGridEh;

var
  CXlsBof: array[0..5] of Word = ($809, 8, 0, $10, 0, 0);
  CXlsEof: array[0..1] of Word = ($0A, 00);
  CXlsLabel: array[0..5] of Word = ($204, 0, 0, 0, 0, 0);
  CXlsNumber: array[0..4] of Word = ($203, 14, 0, 0, 0);
  CXlsRk: array[0..4] of Word = ($27E, 10, 0, 0, 0);
  CXlsBlank: array[0..4] of Word = ($201, 6, 0, 0, $17);
  CXlsFont: array[0..9] of Byte = ($31, 2, 0, 0, 0, 0, 0, 0, 0, 0);

type
  TDataToExcel = class(TObject)
  private
    FCol: word;
    FRow: word;
    //��Ҫ����������...Ϊȥ��VisibleΪFalse������
    FExpColCount: Word;
    FDataSet: TCustomADODataSet;
    FDBGrid: TDBGrid;
    FDBGridEh: TDBGridEh;
    FBookMark: TBookmark;
    FStream: TStream;
    procedure IncColRow;
    procedure WritePrefix;
    procedure WriteSuffix;
    procedure WriteTitle;
    procedure WriteBlankCell;
    procedure WriteFloatCell(const AValue: Double);
    procedure WriteIntegerCell(const AValue: Integer);
    procedure WriteStringCell(const AValue: string);
    procedure WriteDataCell;
    procedure WriteDBGridData;
    procedure WriteDBGridEhData;

    function NeedExcelAppExport: Boolean;
    function SaveToStream(Stream: TStream): Boolean;
  public
    function SaveToFile(const FileName: string): Boolean;

    constructor Create(ADBGrid: TDBGrid); overload;
    constructor Create(ADBGridEh: TDBGridEh); overload;
 end;

implementation

{ TDataToExcel }

constructor TDataToExcel.Create(ADBGrid: TDBGrid);
var
  i: Integer;
begin
  FDBGrid := ADBGrid;
  FDataSet := TCustomADODataSet(FDBGrid.DataSource.DataSet);

  FExpColCount := 0;
  for i := 0 to FDBGrid.Columns.Count - 1 do
  begin
    if not FDBGrid.Columns[i].Visible then Continue;
    Inc(FExpColCount);
  end;
end;

constructor TDataToExcel.Create(ADBGridEh: TDBGridEh);
var
  i: Integer;
begin
  FDBGridEh := ADBGridEh;
  FDataSet := TCustomADODataSet(FDBGridEh.DataSource.DataSet);

  FExpColCount := 0;
  for i := 0 to FDBGridEh.Columns.Count - 1 do
  begin
    if not FDBGridEh.Columns[i].Visible then Continue;
    Inc(FExpColCount);
  end;
end;

function TDataToExcel.SaveToStream(Stream: TStream): Boolean;
begin
  FCol := 0;
  FRow := 0;
  FStream := Stream;
  try
    WriteDataCell();
    Result := True;
  except
    raise;
  end;
end;

function TDataToExcel.SaveToFile(const FileName: string): Boolean;
var
  FileStream: TFileStream;
begin
  if FileExists(FileName) then DeleteFile(FileName);

  FileStream := TFileStream.Create(FileName, fmCreate);
  try
    Result := SaveToStream(FileStream);
  finally
    FileStream.Free;
  end;
end;

procedure TDataToExcel.IncColRow;
begin
  if FCol = FExpColCount - 1 then
  begin
    Inc(FRow);
    FCol := 0;
  end
  else Inc(FCol);
end;

//��δ��װExcel����Excel�汾Ϊ2010���ϣ�����Excel���󵼳�
function TDataToExcel.NeedExcelAppExport: Boolean;
var
  ExcelApp: Variant;
begin
  try
    ExcelApp := CreateOleObject('Excel.Application');
    //office xp: 10, office2003: 11, office2007: 12, office2010: 14, office2013: 15
    Result := StrToFloat(VarToStr(ExcelApp.Version)) >= 14.0;
  except
    Result := False;
  end;
end;

procedure StreamWriteWordArray(Stream: TStream; wr: array of Word);
var
  i: Integer;
begin
  for i := 0 to Length(wr)-1 do
{$IFDEF CIL}
    Stream.Write(wr[i]);
{$ELSE}
    Stream.Write(wr[i], SizeOf(wr[i]));
{$ENDIF}
end;

procedure StreamWriteAnsiString(Stream: TStream; S: AnsiString);
{$IFDEF CIL}
var
  b: TBytes;
{$ENDIF}
begin
{$IFDEF CIL}
    b := BytesOf(AnsiString(S));
    Stream.Write(b, Length(b));
{$ELSE}
    Stream.Write(PAnsiChar(S)^, Length(S));
{$ENDIF}
end;

procedure TDataToExcel.WritePrefix;
begin
  StreamWriteWordArray(FStream, CXlsBof);
end;

procedure TDataToExcel.WriteSuffix;
begin
  StreamWriteWordArray(FStream, CXlsEof);
end;

procedure TDataToExcel.WriteBlankCell;
begin
  CXlsBlank[2] := FRow;
  CXlsBlank[3] := FCol;
  StreamWriteWordArray(FStream, CXlsBlank);
  IncColRow();
end;

procedure TDataToExcel.WriteFloatCell(const AValue: Double);
begin
  CXlsNumber[2] := FRow;
  CXlsNumber[3] := FCol;
  StreamWriteWordArray(FStream, CXlsNumber);
  FStream.WriteBuffer(AValue, 8);
  IncColRow();
end;

procedure TDataToExcel.WriteIntegerCell(const AValue: Integer);
var
  v: Integer;
begin
  CXlsRk[2] := FRow;
  CXlsRk[3] := FCol;
  StreamWriteWordArray(FStream, CXlsRk);
  v := (AValue shl 2) or 2;
  FStream.WriteBuffer(V, 4);
  IncColRow();
end;

procedure TDataToExcel.WriteStringCell(const AValue: string);
var
  Len: Word;
begin
  Len := Length(AValue);
  CXlsLabel[1] := 8 + Len;
  CXlsLabel[2] := FRow;
  CXlsLabel[3] := FCol;
  CXlsLabel[5] := Len;
  StreamWriteWordArray(FStream, CXlsLabel);
  StreamWriteAnsiString(FStream, AnsiString(AValue));
  IncColRow();
end;

procedure TDataToExcel.WriteTitle;
var
  i: Integer;
begin
  if FDBGrid <> nil then
  begin
    for i := 0 to FDBGrid.Columns.Count - 1 do
    begin
      if not FDBGrid.Columns[i].Visible then Continue;
      WriteStringCell(FDBGrid.Columns[i].Title.Caption);
    end;
  end
  else
  begin
    for i := 0 to FDBGridEh.Columns.Count - 1 do
    begin
      if not FDBGridEh.Columns[i].Visible then Continue;
      WriteStringCell(FDBGridEh.Columns[i].Title.Caption);
    end;
  end;
end;

procedure TDataToExcel.WriteDBGridData;
var
  i: Integer;
  Column: TColumn;
begin
  //д����
  if DBGrids.dgTitles in FDBGrid.Options then WriteTitle();

  FDataSet.DisableControls;
  try
    FBookMark := FDataSet.GetBookmark;
    FDataSet.First;
    while not FDataSet.Eof do
    begin
      for i := 0 to FDBGrid.Columns.Count - 1 do
      begin
        Column := FDBGrid.Columns[i];
        if not Column.Visible then Continue;

        if Column.Field.IsNull then
          WriteBlankCell()
        else
        begin
          case Column.Field.DataType of
            ftSmallint, ftInteger, ftWord, ftAutoInc, ftBytes:
            begin
              if IsNumeric(Column.Field.Text) then
                WriteIntegerCell(Column.Field.AsInteger)
              //�ر���OnGetText��OnSetTextֵ
              else WriteStringCell(Column.Field.Text);
            end;
            ftFloat, ftCurrency, ftBCD:
              WriteFloatCell(Column.Field.AsFloat);
          else
            WriteStringCell(Column.Field.Text);
          end;
        end;
      end;
      FDataSet.Next;
    end;

    WriteSuffix;
    if FDataSet.BookmarkValid(FBookMark) then
    begin
      FDataSet.GotoBookmark(FBookMark);
      FDataSet.FreeBookmark(FBookMark);
    end;
  finally
    FDataSet.EnableControls;
  end;
end;

procedure TDataToExcel.WriteDBGridEhData;
var
  i: Integer;
  v: Variant;
  Column: TColumnEh;
begin
  //д����
  if dgTitles in FDBGridEh.Options then WriteTitle();

  FDataSet.DisableControls;
  FBookMark := FDataSet.GetBookmark;
  FDataSet.First;
  while not FDataSet.Eof do
  begin
    for i := 0 to FDBGridEh.Columns.Count - 1 do
    begin
      Column := FDBGridEh.Columns[i];
      if not Column.Visible then Continue;

      if Column.Field.IsNull then
        WriteBlankCell()
      else
      begin
        case Column.Field.DataType of
          ftSmallint, ftInteger, ftWord, ftAutoInc, ftBytes:
          begin
            if IsNumeric(Column.Field.Text) then
              WriteIntegerCell(Column.Field.AsInteger)
            //�ر���OnGetText��OnSetTextֵ
            else WriteStringCell(Column.Field.Text);
          end;
          ftFloat, ftCurrency, ftBCD:
            WriteFloatCell(Column.Field.AsFloat);
        else
          WriteStringCell(Column.DisplayText);
        end;
      end;
    end;
    FDataSet.Next;
  end;
  //дFooter����...��Թ��̣�ֻдһ�е�
  if FDBGridEh.FooterRowCount <> 0 then
  begin
    for i := 0 to FDBGridEh.Columns.Count - 1 do
    begin
      Column := FDBGridEh.Columns[i];
      if not Column.Visible then Continue;

      with Column.Footer do
      begin
        if (ValueType in [fvtSum, fvtAvg, fvtCount]) and (DisplayFormat <> '') then
          v := FormatFloat(DisplayFormat, SumValue)
        else v := SumValue;
        if VarIsNull(v) then v := '';
        WriteStringCell(v);
      end;
    end;
  end;

  if FDataSet.BookmarkValid(FBookMark) then
  begin
    FDataSet.GotoBookmark(FBookMark);
    FDataSet.FreeBookmark(FBookMark);
  end;
  FDataSet.EnableControls;
end;

procedure TDataToExcel.WriteDataCell;
var
  sFontName: string;
  Len: Byte;
begin
  //�ļ���ʼ
  WritePrefix();

  //�������壺����+10�ţ���д��WritePrefix()֮��
  sFontName := '����';
  Len := Length(sFontName);
  CXlsFont[2] := Len + 7;
  CXlsFont[4] := 10 * 20 mod 256;
  CXlsFont[5] := 10 * 20 div 256;
  FStream.WriteBuffer(CXlsFont, SizeOf(CXlsFont));
  FStream.WriteBuffer(Len, SizeOf(Len));
  FStream.WriteBuffer(Pointer(sFontName)^, Len);
  //�ļ�����
  if FDBGrid <> nil then
    WriteDBGridData()
  else WriteDBGridEhData();
  //�ļ�����
  WriteSuffix();
end;

end.
