{******************************************}
{                                          }
{             FastReport v2.53             }
{         Excel OLE export filter          }
{        Copyright(c) 1998-2004 by         }
{             FastReports Inc.             }
{                                          }
{******************************************}

unit frOLEExl;

interface

{$I fr.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, extctrls, Clipbrd, Printers, ComObj, FR_Class, frIEMatrix, frProgr
{$IFDEF Delphi6}
, Variants
{$ENDIF},
  FR_Progr, FR_Ctrls;


type
  TfrOLEExcelSet = class(TForm)
    OK: TButton;
    Cancel: TButton;
    Panel1: TPanel;
    GroupCellProp: TGroupBox;
    CB_Merged: TCheckBox;
    CB_Borders: TCheckBox;
    CB_WrapWords: TCheckBox;
    CB_HQ: TCheckBox;
    CB_PageBreaks: TCheckBox;
    Better: TButton;
    Faster: TButton;
    CB_Pictures: TCheckBox;
    GroupPageRange: TGroupBox;
    Pages: TLabel;
    Descr: TLabel;
    E_Range: TEdit;
    GroupPageSettings: TGroupBox;
    LeftM: TLabel;
    TopM: TLabel;
    ScX: TLabel;
    Label2: TLabel;
    ScY: TLabel;
    Label9: TLabel;
    E_LMargin: TEdit;
    E_TMargin: TEdit;
    E_ScaleX: TEdit;
    E_ScaleY: TEdit;
    CB_OpenExcel: TCheckBox;
    procedure BetterClick(Sender: TObject);
    procedure FasterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure Localize;
  end;

  TFrExcel = class;

  TfrOLEExcelExport = class(TfrExportFilter)
  private
    CurrentPage: integer;
    FirstPage: boolean;
    Excel: TFrExcel;
    frExportSet: TfrOLEExcelSet;
    pgList: TStringList;
    PicFormat: Word;
    PicData: Cardinal;
    PicPalette: HPALETTE;
    CntPics: integer;
    expMerged, expWrapWords, expFillColor, expBorders, expAlign,
      expPageBreaks, expFontName, expFontSize, expFontStyle,
      expFontColor, expPictures, expOpenAfter, expHQ: boolean;
    expScaleX, expScaleY, expTopMargin, expLeftMargin: Double;
    Matrix: TfrIEMatrix;
    Progress: TfrProgress;
    procedure ExportPage;
    function CleanReturns(Str: string): string;
    procedure AfterExport(const FileName: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ShowModal: Word; override;
    procedure OnBeginDoc; override;
    procedure OnEndPage; override;
    procedure OnBeginPage; override;
    procedure OnData(x, y: Integer; View: TfrView); override;
  published
    property HighQuality : Boolean read expHQ write expHQ default True;
    property CellsAlign : Boolean read expAlign write expAlign default True;
    property CellsBorders : Boolean read expBorders write expBorders default True;
    property CellsFillColor : Boolean read expFillColor write expFillColor default True;
    property CellsFontColor : Boolean read expFontColor write expFontColor default True;
    property CellsFontName : Boolean read expFontName write expFontName default True;
    property CellsFontSize : Boolean read expFontSize write expFontSize default True;
    property CellsFontStyle : Boolean read expFontStyle write expFontStyle default True;
    property CellsMerged : Boolean read expMerged write expMerged default True;
    property CellsWrapWords : Boolean read expWrapWords write expWrapWords default True;
    property ExportPictures : Boolean read expPictures write expPictures default True;
    property LeftMargin : Double read expLeftMargin write expLeftMargin;
    property OpenExcelAfterExport : Boolean read expOpenAfter write expOpenAfter default False;
    property PageBreaks : Boolean read expPageBreaks write expPageBreaks default True;
    property TopMargin : Double read expTopMargin write expTopMargin;
  end;

  TFrExcel = class(TObject)
  private
    IsOpened: Boolean;
    IsVisible: Boolean;
    Excel: Variant;
    WorkBook: Variant;
    WorkSheet: Variant;
    Range : Variant;
  protected
    procedure SetVisible(DoShow: Boolean);
    function GetCell(x, y: Integer): string;
    procedure SetCell(x, y: Integer; const Value: string);
    function Pos2Str(Pos: Integer): string;
    function IntToCoord(X, Y: Integer): string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure OpenExcel;
    procedure SetRange(x, y, dx, dy: integer);
    procedure SetColSize(x: integer; Size: Extended);
    procedure SetRowSize(y: integer; Size: Extended);
    procedure MergeCells;
    procedure SetPageMargin(Left, Right, Top, Bottom: Extended; Orient: integer);
    procedure SetCellFontName(FontName: string);
    procedure SetCellFontSize(FontSize: integer);
    procedure SetCellFontColor(FontColor: Integer);
    procedure SetCellFontStyle(Style: TFontStyles);
    procedure SetCellHAlign(Horiz: Integer);
    procedure SetCellVAlign(Vert: Integer);
    procedure SetCellOrientation(Grad: Integer);
    procedure SetCellFrame(Frame: integer);
    procedure SetCellFrameInsideV;
    procedure SetCellFrameInsideH;
    procedure SetCellFillColor(Color: integer);
    procedure SendArrayValue(Arr: variant);
    property Cell[x, y: Integer]: string read GetCell write SetCell;
    function IsOpen: Boolean;
  published
    property Visible: Boolean read IsVisible write SetVisible;
  end;

implementation

uses FR_Const, FR_Utils;

{$R *.dfm}

const
  Xdivider = 8;
  Ydivider = 1.31;

  XLMaxHeight = 409;
  xlLeft = -4131;
  xlRight = -4152;
  xlTop = -4160;
  xlCenter = -4108 ;
  xlBottom = -4107;
  xlJustify = -4130 ;
  xlThin = 2;
  xlHairline = 1;
  xlNone = -4142;
  xlAutomatic = -4105;
  xlInsideHorizontal = 12 ;
  xlInsideVertical = 11 ;
  xlEdgeBottom = 9 ;
  xlEdgeLeft = 7 ;
  xlEdgeRight = 10 ;
  xlEdgeTop = 8 ;
  xlSolid = 1 ;
  xlLineStyleNone = -4142;
  xlTextWindows = 20 ;
  xlNormal = -4143 ;
  xlNoChange = 1 ;
  xlPageBreakManual = -4135 ;

constructor TfrOLEExcelExport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  frRegisterExportFilter(Self, frLoadStr(frRes + 1840), '*.xls');
  Excel := TfrExcel.Create;
  pgList := TStringList.Create;
  ShowDialog := True;
  expMerged := True;
  expWrapWords := True;
  expBorders := True;
  expPageBreaks := True;
  expPictures := True;
  expScaleX := 1.0;
  expScaleY := 1.0;
  expHQ := True;
end;

destructor TfrOLEExcelExport.Destroy;
begin
  frUnRegisterExportFilter(Self);
  Excel.Free;
  pgList.Free;
  inherited;
end;

function TfrOLEExcelExport.CleanReturns(Str: string): string;
var
  i: integer;
begin
   i := Pos(#13, Str);
   while i > 0 do
   begin
      if i > 0 then Delete(Str, i, 1);
      i := Pos(#13, Str);
   end;
   i := Pos(#1, Str);
   while i > 0 do
   begin
      if i > 0 then Delete(Str, i, 1);
      i := Pos(#1, Str);
   end;
   while Copy(Str, Length(str), 1) = #10 do
      Delete(Str, Length(Str), 1);
   Result := Str;
end;

{$WARNINGS OFF}
procedure TfrOLEExcelExport.ExportPage;
var
  i, fx, fy, x, y, dx, dy : integer;
  dcol, drow: Extended;
  s : string;
  Left, Right, Top, Bottom : Extended;
  Orient, Vert, Horiz: integer;
  obj: TfrIEMObject;
  ExlArray: Variant;
  EStyle: TfrIEMStyle;
  XStyle: Variant;
  Pic: TPicture;
  m: TRect;

  procedure AlignFR2AlignExcel(Align: integer; var AlignH, AlignV: integer);
  begin
    if (Align and frtaRight) <> 0 then
         if (Align and frtaCenter) <> 0 then AlignH := xlJustify
         else AlignH := xlRight
      else if (Align and frtaCenter) <> 0 then AlignH := xlCenter
      else AlignH := xlLeft;
    if (Align and frtaMiddle) <> 0 then AlignV := xlCenter
      else if (Align and frtaDown) <> 0 then AlignV := xlBottom
      else AlignV := xlTop;
  end;

begin
  if CurReport.EMFPages[0].pgor = poLandscape then Orient := 2
    else Orient := 1;
  m := CurReport.EMFPages[0].pgMargins;
  Left := m.Left / 4;
  Right := m.Right / 4;
  Top := m.Top / 4;
  Bottom := m.Bottom / 4;
  Excel.SetPageMargin(Left, Right, Top, Bottom, Orient);
  CurReport.Terminated := false;
  Progress := TfrProgress.Create(self);
  Progress.Execute(Matrix.Height - 1, 'Please wait', true, true);
  for y := 1 to Matrix.Height - 1 do
  begin
     if CurReport.Terminated then break;
     Progress.Tick;
     drow := expScaleY * (Matrix.GetYPosById(y) - Matrix.GetYPosById(y - 1)) / Ydivider;
     Excel.SetRowSize(y, drow);
//     if pgBreakList.Count > i then
//     if (StrToInt(pgBreakList[i]) <= Round(TObjCell(RY[y]).Value)) and expPageBreaks then
//     begin
//       Excel.WorkSheet.Rows[y + 2].PageBreak := xlPageBreakManual;
//       inc(i);
//     end;
  end;
  if not Progress.Terminated then
    Progress.Execute(Matrix.Width - 1, 'Progress columns', true, true);
  for x := 1 to Matrix.Width - 1 do
  begin
     if Progress.Terminated then break;
     Progress.Tick;
     dcol := expScaleX * (Matrix.GetXPosById(x) - Matrix.GetXPosById(x - 1)) / Xdivider;
     Excel.SetColSize(x, dcol);
  end;
  if not Progress.Terminated then
    Progress.Execute(Matrix.StylesCount - 1, 'Progress styles', true, true);
  for x := 0 to Matrix.StylesCount - 1 do
  begin
    if Progress.Terminated then break;
      Progress.Tick;
    EStyle := Matrix.GetStyleById(x);
    s := 'S'+IntToStr(x);
    XStyle := Excel.Excel.ActiveWorkbook.Styles.Add(s);
    XStyle.Font.Bold := fsBold in EStyle.Font.Style;
    XStyle.Font.Italic := fsItalic in EStyle.Font.Style;
    XStyle.Font.Underline := fsUnderline in EStyle.Font.Style;;
    XStyle.Font.Name := EStyle.Font.Name;
    XStyle.Font.Size := EStyle.Font.Size;
    XStyle.Font.Color:= EStyle.Font.Color;
    XStyle.Interior.Color := EStyle.Color;
    AlignFR2AlignExcel(EStyle.Align, Horiz, Vert);
    XStyle.VerticalAlignment := Vert;
    XStyle.HorizontalAlignment := Horiz;
    Application.ProcessMessages;
  end;
  ExlArray := VarArrayCreate([0, Matrix.Height - 1, 0, Matrix.Width - 1], varVariant);
  if not Progress.Terminated then
    Progress.Execute(Matrix.Height, 'Progress objects', true, true);
  for y := 1 to Matrix.Height do
  begin
    if Progress.Terminated then break;
      Progress.Tick;
    for x := 1 to Matrix.Width do
    begin
      i := Matrix.GetCell(x - 1, y - 1);
      if i <> -1 then
      begin
        Obj := Matrix.GetObjectById(i);
        if Obj.Counter = 0 then
        begin
          Obj.Counter := 1;
          Matrix.GetObjectPos(i, fx, fy, dx, dy);
          Excel.SetRange(x, y, dx, dy);
          if Obj.IsText then
          begin
            if expHQ then
              Excel.Range.Style := 'S'+IntToStr(Obj.StyleIndex);
            if expMerged then
              if (dx > 1) or (dy > 1) then
                if (dx > 1) or (dy > 1) then
                begin
                  Excel.SetRange(x, y, dx, dy);
                  Excel.MergeCells;
                end;
            if expBorders then
              Excel.SetCellFrame(obj.Style.FrameTyp);
            s:=CleanReturns(Obj.Memo.Text);
            ExlArray[y-1, x-1] := s;
          end else
          begin
            Inc(CntPics);
            Pic := TPicture.Create;
            Pic.Bitmap.Assign(Obj.Image);
            Pic.SaveToClipboardFormat(PicFormat, PicData, PicPalette);
            Clipboard.SetAsHandle(PicFormat,THandle(PicData));
            Excel.Range.PasteSpecial(EmptyParam, EmptyParam, EmptyParam, EmptyParam);
            Excel.WorkSheet.Pictures[CntPics].Width := Pic.Width / 1.33;
            Excel.WorkSheet.Pictures[CntPics].Height := Pic.Height/ 1.33;
            Pic.Free;
          end;
        end;
      end;
    end;
  end;
  Excel.SetRange(1, 1, Matrix.Width - 1, Matrix.Height - 1);
  Excel.Range.Value := ExlArray;
  if expWrapWords then
    Excel.WorkSheet.Cells.WrapText := true;
  Progress.Free;
end;
{$WARNINGS ON}

function TfrOLEExcelExport.ShowModal: Word;
var
  PageNumbers: string;

  procedure ParsePageNumbers;
  var
    i, j, n1, n2: Integer;
    s: String;
    IsRange: Boolean;
  begin
    s := PageNumbers;
    while Pos(' ', s) <> 0 do
      Delete(s, Pos(' ', s), 1);
    if s = '' then Exit;
    s := s + ',';
    i := 1; j := 1; n1 := 1;
    IsRange := False;
    while i <= Length(s) do
    begin
      if s[i] = ',' then
      begin
        n2 := StrToInt(Copy(s, j, i - j));
        j := i + 1;
        if IsRange then
          while n1 <= n2 do
          begin
            pgList.Add(IntToStr(n1));
            Inc(n1);
          end
        else
          pgList.Add(IntToStr(n2));
        IsRange := False;
      end
      else if s[i] = '-' then
      begin
        IsRange := True;
        n1 := StrToInt(Copy(s, j, i - j));
        j := i + 1;
      end;
      Inc(i);
    end;
    pgList.Sort;
  end;

begin
 if ShowDialog then
 begin
  frExportSet := TfrOLEExcelSet.Create(nil);
  frExportSet.CB_Merged.Checked := expMerged;
  frExportSet.CB_WrapWords.Checked := expWrapWords;
  frExportSet.CB_Borders.Checked := expBorders;
  frExportSet.CB_PageBreaks.Checked := expPageBreaks;
  frExportSet.CB_Pictures.Checked := expPictures;
  frExportSet.CB_OpenExcel.Checked := expOpenAfter;
  frExportSet.CB_HQ.Checked := expHQ;
  frExportSet.E_ScaleX.Text := FloatToStr(Int(expScaleX * 100));
  frExportSet.E_ScaleY.Text := FloatToStr(Int(expScaleY * 100));
  frExportSet.E_TMargin.Text := FloatToStr(expTopMargin);
  frExportSet.E_LMargin.Text := FloatToStr(expLeftMargin);
  Result := frExportSet.ShowModal;
  PageNumbers := frExportSet.E_Range.Text;
  expMerged := frExportSet.CB_Merged.Checked;
  expWrapWords := frExportSet.CB_WrapWords.Checked;
  expBorders := frExportSet.CB_Borders.Checked;
  expPageBreaks := frExportSet.CB_PageBreaks.Checked;
  expPictures := frExportSet.CB_Pictures.Checked;
  expOpenAfter := frExportSet.CB_OpenExcel.Checked;
  expHQ := frExportSet.CB_HQ.Checked;
  expScaleX := StrToInt(frExportSet.E_ScaleX.Text) / 100;
  expScaleY := StrToInt(frExportSet.E_ScaleY.Text) / 100;
  expTopMargin := StrToFloat(frExportSet.E_TMargin.Text);
  expLeftMargin := StrToFloat(frExportSet.E_LMargin.Text);
  frExportSet.Destroy;
 end
 else
   Result := mrOk;
 pgList.Clear;
 ParsePageNumbers;
end;

procedure TfrOLEExcelExport.OnBeginDoc;
begin
  Matrix := TfrIEMatrix.Create;
  Matrix.ShowProgress := true;
  Matrix.MaxCellHeight := XLMaxHeight * Ydivider;
  Matrix.Inaccuracy := 0.5;
  Matrix.RotatedAsImage := True;
  OnAfterExport := AfterExport;
  Excel.OpenExcel;
  CurrentPage := 0;
  FirstPage := true;
  CntPics := 0;
end;

procedure TfrOLEExcelExport.OnBeginPage;
begin
  Inc(CurrentPage);
end;

procedure TfrOLEExcelExport.OnData(x, y: Integer; View: TfrView);
var
  ind: integer;
begin
  ind := 0;
  if (pgList.Find(IntToStr(CurrentPage),ind)) or (pgList.Count = 0) then
    if View is TfrView then
      Matrix.AddObject(View);
end;

procedure TfrOLEExcelExport.OnEndPage;
var
  ind: integer;
begin
  ind := 0;
  if (pgList.Find(IntToStr(CurrentPage),ind)) or (pgList.Count = 0) then
    Matrix.EndPage;
end;

procedure TfrOLEExcelExport.AfterExport(const FileName: string);
begin
  Matrix.Prepare;
  ExportPage;
  Excel.SetRange(1, 1, 1, 1);
  Excel.Range.Select;
  if expOpenAfter then
    Excel.Visible := true;
  try
   DeleteFile(FileName);
{$IFDEF Delphi3}
   Excel.WorkBook.SaveAs(FileName,xlNormal);
{$ELSE}
   Excel.WorkBook.SaveAs(FileName,xlNormal, EmptyParam,
     EmptyParam, EmptyParam, EmptyParam, xlNoChange, EmptyParam, EmptyParam, EmptyParam);
{$ENDIF}
  if not expOpenAfter then
  begin
    Excel.Excel.Quit;
    Excel.Excel := null;
    Excel.Excel := Unassigned;
  end;
  except
  end;
  Matrix.Free;
end;

///////////////////////////////////////////////////////////

constructor TFrExcel.Create;
begin
  inherited Create;
  IsOpened := false;
  IsVisible := false;
end;

destructor TFrExcel.Destroy;
begin
  inherited Destroy;
end;

function TfrExcel.Pos2Str(Pos: Integer): String;
var
  i, j: integer;
begin
    if Pos > 26 then
    begin
      i := Pos mod 26; j := Pos div 26;
      if i = 0 then Result := Chr(64 + j - 1)
        else Result := Chr(64 + j);
      if i = 0 then Result := Result + chr(90)
        else result := Result + Chr(64 + i);
    end
    else Result := Chr(64 + Pos);
end;

procedure TFrExcel.SetVisible(DoShow: Boolean);
begin
  if not IsOpened then exit;
  if DoShow then
  begin
    Excel.Application.Interactive := true;
    Excel.Application.ScreenUpdating := true;
    Excel.Application.DisplayAlerts := true;
    Excel.Visible := True
  end else
    Excel.Visible := false;
end;

function TFrExcel.IntToCoord(X, Y: Integer): string;
begin
  Result := Pos2Str(X) + IntToStr(Y);
end;

function TFrExcel.GetCell(x, y: Integer): string;
begin
  result := WorkSheet.Cells[y, x];
end;

procedure TFrExcel.SetCell(x, y: Integer; const Value: string);
var
  Cell: Variant;
begin
  Cell := WorkSheet.Cells[y, x];
  Cell.Value := Value;
end;

procedure TFrExcel.SetColSize(x: Integer; Size: Extended);
var
  r: variant;
begin
  r := WorkSheet.Columns;
  r.Columns[x].ColumnWidth := Size;
end;

procedure TFrExcel.SetRowSize(y: Integer; Size: Extended);
var
  r: variant;
begin
  r := WorkSheet.Rows;
  if size > 409 then size := 409;
  r.Rows[y].RowHeight := Size;
end;

procedure TFrExcel.MergeCells;
begin
  Range.MergeCells := true;
end;

procedure TFrExcel.OpenExcel;
begin
  try
    Excel := CreateOLEObject('Excel.Application');
    Excel.Application.EnableEvents := false;
    Excel.Application.EnableAutoComplete := false;
    Excel.Application.EnableAnimations := false;
    Excel.Application.ScreenUpdating := false;
    Excel.Application.Interactive := False;
    Excel.Application.DisplayAlerts := False;
    WorkBook := Excel.WorkBooks.Add;
    WorkSheet := WorkBook.WorkSheets[1];
    IsOpened := True;
  except
    IsOpened := false;
  end;
end;

function TFrExcel.IsOpen: Boolean;
begin
  result := IsOpened;
end;

procedure TFrExcel.SetPageMargin(Left, Right, Top, Bottom: Extended; Orient : Integer);
begin
  try
    Excel.ActiveSheet.PageSetup.LeftMargin := Left;
    Excel.ActiveSheet.PageSetup.RightMargin := Right;
    Excel.ActiveSheet.PageSetup.TopMargin := Top;
    Excel.ActiveSheet.PageSetup.BottomMargin := Bottom;
    Worksheet.PageSetup.Orientation := Orient;
  except
  end;
end;

procedure TFrExcel.SetCellFontName(FontName: string);
begin
  if length(FontName) > 0 then
    Range.Cells.Font.Name := FontName;
end;

procedure TFrExcel.SetCellFontSize(FontSize: integer);
begin
  Range.Cells.Font.Size := FontSize;
end;

procedure TFrExcel.SetCellFontColor(FontColor: integer);
begin
  Range.Cells.Font.Color:= FontColor;
end;

procedure TFrExcel.SetCellFontStyle(Style: TFontStyles);
begin
  Range.Cells.Font.Bold := fsBold in Style;
  Range.Cells.Font.Italic := fsItalic in Style;
  Range.Cells.Font.Underline := fsUnderline in Style;;
end;

procedure TFrExcel.SetCellVAlign(Vert: Integer);
begin
  Range.Select;
  Excel.Selection.Rows.VerticalAlignment := Vert;
end;

procedure TFrExcel.SetCellHAlign(Horiz: Integer);
begin
  Range.Select;
  Excel.Selection.Columns.HorizontalAlignment := Horiz;
end;

procedure TFrExcel.SetCellOrientation(Grad: Integer);
begin
  Range.Cells.Orientation := Grad;
end;

procedure TFrExcel.SetRange(x, y, dx, dy: Integer);
begin
 if (dx > 0) and (dy > 0) then
  Range := WorkSheet.Range[IntToCoord(x, y), IntToCoord(x + dx - 1, y + dy - 1)];
end;

procedure TfrExcel.SetCellFrame(Frame: integer);
begin
  if (Frame and frftLeft) <> 0 then
     Range.Cells.Borders.Item[xlEdgeLeft].Linestyle := xlSolid;
  if (Frame and frftRight) <> 0 then
     Range.Cells.Borders.Item[xlEdgeRight].Linestyle := xlSolid;
  if (Frame and frftTop) <> 0 then
     Range.Borders.Item[xlEdgeTop].Linestyle := xlSolid;
  if (Frame and frftBottom) <> 0 then
     Range.Borders.Item[xlEdgeBottom].Linestyle := xlSolid;
end;

procedure TfrExcel.SetCellFrameInsideH;
begin
  Range.Cells.Borders.Item[xlInsideVertical].Linestyle := xlSolid;
end;
procedure TfrExcel.SetCellFrameInsideV;
begin
  Range.Cells.Borders.Item[xlInsideHorizontal].Linestyle := xlSolid;
end;

procedure TfrExcel.SetCellFillColor(Color: integer);
begin
   Range.Interior.Color := Color;
end;

procedure TfrExcel.SendArrayValue(Arr: variant);
begin
   Range.Value:=Arr;
end;

//////////////////////////////////////////////

procedure TfrOLEExcelSet.Localize;
begin
  Ok.Caption := frLoadStr(SOk);
  Cancel.Caption := frLoadStr(SCancel);
  GroupPageRange.Caption := frLoadStr(frRes + 44);
  Pages.Caption := frLoadStr(frRes + 47);
  Descr.Caption := frLoadStr(frRes + 48);
  Caption := frLoadStr(frRes + 1844);
  GroupPageSettings.Caption := frLoadStr(frRes + 1845);
  Topm.Caption := frLoadStr(frRes + 1846);
  Leftm.Caption := frLoadStr(frRes + 1847);
  ScX.Caption := frLoadStr(frRes + 1848);
  ScY.Caption := frLoadStr(frRes + 1849);
  GroupCellProp.Caption := frLoadStr(frRes + 1850);
  CB_Merged.Caption := frLoadStr(frRes + 1851);
  CB_Borders.Caption := frLoadStr(frRes + 1854);
  CB_WrapWords.Caption := frLoadStr(frRes + 1855);
  CB_PageBreaks.Caption := frLoadStr(frRes + 1860);
  Better.Caption := frLoadStr(frRes + 1861);
  Faster.Caption := frLoadStr(frRes + 1862);
  CB_Pictures.Caption := frLoadStr(frRes + 1863);
  CB_OpenExcel.Caption := frLoadStr(frRes + 1864);
  CB_HQ.Caption := frLoadStr(frRes + 2700);
end;

procedure TfrOLEExcelSet.BetterClick(Sender: TObject);
begin
   CB_Merged.Checked := true;
   CB_WrapWords.Checked := true;
   CB_HQ.Checked := true;
   CB_Borders.Checked := true;
   CB_PageBreaks.Checked := true;
   CB_Pictures.Checked := true;
end;

procedure TfrOLEExcelSet.FasterClick(Sender: TObject);
begin
   CB_Merged.Checked := true;
   CB_WrapWords.Checked := true;
   CB_HQ.Checked := false;
   CB_Borders.Checked := false;
   CB_PageBreaks.Checked := true;
   CB_Pictures.Checked := false;
end;

procedure TfrOLEExcelSet.FormCreate(Sender: TObject);
begin
   Localize;
end;

end.
