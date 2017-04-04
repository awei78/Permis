{******************************************}
{                                          }
{             FastReport v2.53             }
{          Adv. RTF export filter          }
{        Copyright(c) 1998-2004 by         }
{             FastReports Inc.             }
{                                          }
{******************************************}

unit frRtfExp;

interface

{$I Fr.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, extctrls, Clipbrd, Printers, FR_Class, frIEMatrix, frProgr, ShellAPI
{$IFDEF Delphi6}
, Variants
{$ENDIF},
  FR_Progr, FR_Ctrls;

type
  TfrRtfExpSet = class(TForm)
  OK: TButton;
  Cancel: TButton;
    GroupPageSettings: TGroupBox;
    GroupPageRange: TGroupBox;
    LeftM: TLabel;
    Pages: TLabel;
    E_Range: TEdit;
    Descr: TLabel;
    E_LMargin: TEdit;
    TopM: TLabel;
    E_TMargin: TEdit;
    ScX: TLabel;
    E_ScaleX: TEdit;
    Label2: TLabel;
    ScY: TLabel;
    E_ScaleY: TEdit;
    Label9: TLabel;
    GroupCellProp: TGroupBox;
    CB_PageBreaks: TCheckBox;
    CB_Pictures: TCheckBox;
    procedure FormCreate(Sender: TObject);
 private
    procedure Localize;
end;

TfrRtfAdvExport = class(TfrExportFilter)
  private
    FirstPage: boolean;
    CurrentPage: Integer;
    CntPics: Integer;
    frExportSet: TfrRTFExpSet;
    expPictures, expBorders, expPageBreaks,
      expShowProgress, expOpenAfter: boolean;
    expScaleX, expScaleY, expTopMargin, expLeftMargin: Extended;
    Exp: TStream;
    Progress: TfrProgress;
    Matrix: TfrIEMatrix;
    FontTable, ColorTable, pgList: TStringList;
    DataList: TList;
    procedure WriteExpLn(const str: string);
    procedure ExportPage;
    procedure AfterExport(const FileName: string);
    function ChangeReturns(Str: string): string;
    function TruncReturns(Str: string): string;
    function GetRTFBorders(Style: TfrIEMStyle): string;
    function GetRTFColor(c: Integer): string;
    function GetRTFFontStyle(f: TFontStyles): String;
    function GetRTFFontColor(f: String): String;
    function GetRTFFontName(f: String): String;
    function GetRTFHAlignment(HAlign: Integer) : String;
    function GetRTFVAlignment(VAlign: Integer) : String;
    procedure PrepareExport;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ShowModal: Word; override;
    procedure OnBeginDoc; override;
    procedure OnEndPage; override;
    procedure OnBeginPage; override;
    procedure OnData(x, y: Integer; View: TfrView); override;
  published
    property ExportPictures : Boolean read expPictures write expPictures default True;
    property LeftMargin : Extended read expLeftMargin write expLeftMargin;
    property PageBreaks : Boolean read expPageBreaks write expPageBreaks default True;
    property TopMargin : Extended read expTopMargin write expTopMargin;
end;


implementation

uses FR_Const, FR_Utils
{$IFDEF Delphi6}
, StrUtils
{$ENDIF};

{$R *.dfm}

const
  Xdivider = 15.2;
  Ydivider = 15;
  PageDivider = 5.67;
  FONT_DIVIDER = 16;
  IMAGE_DIVIDER = 25.3;

constructor TfrRtfAdvExport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  frRegisterExportFilter(Self, frLoadStr(frRes + 1870), '*.rtf');
  ShowDialog := True;
  expBorders := True;
  expPageBreaks := True;
  expScaleX := 1.0;
  expScaleY := 1.0;
  expPictures := True;
  expOpenAfter := false;
  expShowProgress := True;
  pgList := TStringList.Create;
end;

destructor TfrRtfAdvExport.Destroy;
begin
  frUnRegisterExportFilter(Self);
  pgList.Free;
  inherited;
end;

function TfrRTFAdvExport.TruncReturns(Str: string): string;
begin
  Str := StringReplace(Str, #1, '', [rfReplaceAll]);
  if Copy(Str, Length(Str) - 1, 2) = #13#10 then
    Delete(Str, Length(Str) - 1, 2);
  Result := Str;
end;

function TfrRTFAdvExport.ChangeReturns(Str: string): string;
begin
  Str := StringReplace(Str, '\', '\\', [rfReplaceAll]);
  Str := StringReplace(Str, '{', '\{', [rfReplaceAll]);
  Str := StringReplace(Str, '}', '\}', [rfReplaceAll]);
  Str := StringReplace(Str, #13#10, '\line'#13#10, [rfReplaceAll]);
  Result := Str;
end;

procedure TfrRTFAdvExport.WriteExpLn(const str: string);
var
  ln : string;
begin
  if Length(str) > 0 then
  begin
    ln := #13#10;
    Exp.Write(str[1], Length(str));
    Exp.Write(ln[1], Length(ln));
  end;
end;

function TfrRTFAdvExport.GetRTFBorders(Style: TfrIEMStyle): string;
var
  brdrw: String;
  brdrc: String;
begin
  Result := '';
  brdrw := '\brdrs\brdrw' + IntToStr(Round(Style.FrameWidth * 20)) + ' ';
  brdrc := '\brdrcf' + GetRTFFontColor(GetRTFColor(Style.FrameColor)) + ' ';
  if (frftTop and Style.FrameTyp) <> 0 then
    Result := Result + '\clbrdrt' + brdrw + brdrc;
  if (frftLeft and Style.FrameTyp) <> 0 then
    Result := Result + '\clbrdrl' + brdrw + brdrc;
  if (frftBottom and Style.FrameTyp) <> 0 then
    Result := Result + '\clbrdrb' + brdrw + brdrc;
  if (frftRight and Style.FrameTyp) <> 0 then
    Result := Result + '\clbrdrr' + brdrw + brdrc;
end;

function TfrRTFAdvExport.GetRTFColor(c: Integer): string;
begin
   Result := '\red' + IntToStr(GetRValue(c)) +
             '\green' + IntToStr(GetGValue(c)) +
             '\blue' + IntToStr(GetBValue(c)) + ';'
end;

function TfrRTFAdvExport.GetRTFFontStyle(f: TFontStyles): String;
begin
  Result := '';
  if f = [fsItalic] then Result := '\i';
  if f = [fsBold] then Result := Result + '\b';
  if f = [fsUnderline] then Result := Result + '\ul';
end;

function TfrRTFAdvExport.GetRTFFontColor(f: String): String;
var
  i: Integer;
begin
  i := ColorTable.IndexOf(f);
  if i <> -1 then
    Result := IntToStr(i + 1)
  else begin
    ColorTable.Add(f);
    Result := IntToStr(ColorTable.Count);
  end;
end;

function TfrRTFAdvExport.GetRTFFontName(f: String): String;
var
  i: Integer;
begin
  i := FontTable.IndexOf(f);
  if i <> -1 then
    Result := IntToStr(i)
  else begin
    FontTable.Add(f);
    Result := IntToStr(FontTable.Count - 1);
  end;
end;

function TfrRTFAdvExport.GetRTFHAlignment(HAlign: Integer) : String;
begin
  Result:='';
  if (HAlign and frtaLeft) <> 0 then Result := Result + '\ql';
  if (HAlign and frtaRight) <> 0 then Result := Result + '\qr';
  if (HAlign and frtaCenter) <> 0 then Result := Result + '\qc';
  if Result = '' then Result := '\ql';
end;

function TfrRTFAdvExport.GetRTFVAlignment(VAlign: Integer) : String;
begin
  Result:='';
  if (VAlign and frtaVertical) <> 0 then Result := Result + '\clvertalt';
  if (VAlign and frtaMiddle) <> 0 then Result := Result + '\clvertalc';
  if (VAlign and frtaDown) <> 0 then Result := Result + '\clvertalb';
  if Result = '' then Result := '\ql';
end;

procedure TfrRTFAdvExport.PrepareExport;
var
  i, j, x, y, n, n1, fx: Integer;
  s, s0, s1, s2: String;
  Obj: TfrIEMObject;
  RepPos: TStringList;
begin
  for y := 0 to Matrix.Height - 1 do
    for x := 0 to Matrix.Width - 1 do
    begin
      i := Matrix.GetCell(x, y);
      if (i <> -1) then
      begin
        Obj := Matrix.GetObjectById(i);
        if Obj.Counter <> -1 then
        begin
          Obj.Counter := -1;
          GetRTFFontColor(GetRTFColor(Obj.Style.Color));
          GetRTFFontColor(GetRTFColor(Obj.Style.FrameColor));
          if Obj.IsRichText then
          begin
            RepPos := TStringList.Create;
            s := Obj.Memo.Text;
            fx := Pos('{\fonttbl', s);
            Delete(s, 1, fx + 8);
            i := 1;
            RepPos.Clear;
            while (i < Length(s)) and (s[i] <> '}') do
            begin
              while (i < Length(s)) and (s[i] <> '{') do
                Inc(i);
              Inc(i);
              j := i;
              while (j < Length(s)) and (s[j] <> '}') do
                Inc(j);
              Inc(j);
              s1 := Copy(s, i , j - i - 2);
              i := j;
              j := Pos(' ', s1);
              s2 := Copy(s1, j + 1, Length(s1) - j + 1);
              s0 := '\f' + GetRTFFontName(s2);
              j := Pos('\f', s1);
              n := j + 1;
              while (s1[n] <> '\') and (s1[n] <> ' ') and (n < Length(s1)) do
                Inc(n);
              s2 := Copy(s1, j, n - j);
              j := Pos('}}', s);
              s1 := Copy(s, j + 2, Length(s) - j - 1);
              j := j + 2;
              n := 1;
              while n > 0 do
              begin
                n := Pos(s2, s1);
                if n > 0 then
                begin
                  if RepPos.IndexOf(IntToStr(n + j - 1)) = -1 then
                  begin
                    RepPos.Add(IntToStr(n + j - 1));
                    Delete(s, n + j - 1, Length(s2));
                    Insert(s0, s, n + j - 1);
                  end;
                  j := j + n + Length(s2) - 1;
                  s1 := Copy(s, j, Length(s) - j + 1);
                end;
              end;
            end;
            fx := Pos('}}', s);
            if fx > 0 then
              Delete(s, 1, fx + 1);
            fx := Pos('{\colortbl', s);
            if fx > 0 then
            begin
              Delete(s, 1, fx + 11);
              i := 1;
              n1 := 1;
              RepPos.Clear;
              while (i < Length(s)) and (s[i] <> '}') do
              begin
                while (i < Length(s)) and (s[i] <> '\') do
                  Inc(i);
                j := i;
                while (j < Length(s)) and (s[j] <> ';') do
                  Inc(j);
                Inc(j);
                s1 := Copy(s, i , j - i);
                i := j;
                s0 := '\cf' + GetRTFFontColor(s1);
                s2 := '\cf' + IntToStr(n1);
                j := Pos(';}', s);
                s1 := Copy(s, j + 2, Length(s) - j - 1);
                j := j + 2;
                n := 1;
                while n > 0 do
                begin
                  n := Pos(s2, s1);
                  if n > 0 then
                  begin
                    if RepPos.IndexOf(IntToStr(n + j - 1)) = -1 then
                    begin
                      RepPos.Add(IntToStr(n + j - 1));
                      Delete(s, n + j - 1, Length(s2));
                      Insert(s0, s, n + j - 1);
                    end;
                    j := j + n + Length(s2) - 1;
                    s1 := Copy(s, j, Length(s) - j + 1);
                  end;
                end;
                Inc(n1);
              end;
              fx := Pos(';}', s);
              if fx > 0 then
                Delete(s, 1, fx + 1);
            end;
            fx := Pos('{\stylesheet', s);
            if fx > 0 then
            begin
              Delete(s, 1, fx + 12);
              fx := Pos('}}', s);
              if fx > 0 then
                Delete(s, 1, fx + 1);
            end;
            s := StringReplace(s, '\pard', '', [rfReplaceAll]);
            Delete(s, Length(s) - 3, 3);
            Obj.Memo.Text := s;
            RepPos.Free;
          end else if Obj.IsText then
          begin
            GetRTFFontColor(GetRTFColor(Obj.Style.Font.Color));
            GetRTFFontName(Obj.Style.Font.Name);
          end;
        end;
      end;
    end;
end;

function TfrRtfAdvExport.ShowModal: Word;
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
  frExportSet := TfrRtfExpSet.Create(nil);
  frExportSet.E_ScaleX.Text := FloatToStr(Int(expScaleX*100));
  frExportSet.E_ScaleY.Text := FloatToStr(Int(expScaleY*100));
  frExportSet.E_TMargin.Text := FloatToStr(expTopMargin);
  frExportSet.E_LMargin.Text := FloatToStr(expLeftMargin);
  frExportSet.CB_Pictures.Checked := expPictures;
  Result := frExportSet.ShowModal;
  PageNumbers := frExportSet.E_Range.Text;
  expScaleX := StrToInt(frExportSet.E_ScaleX.Text) / 100;
  expScaleY := StrToInt(frExportSet.E_ScaleY.Text) / 100;
  expTopMargin := StrToFloat(frExportSet.E_TMargin.Text);
  expLeftMargin := StrToFloat(frExportSet.E_LMargin.Text);
  expPictures := frExportSet.CB_Pictures.Checked;
  frExportSet.Destroy;
 end
 else
   Result := mrOk;
 pgList.Clear;
 ParsePageNumbers;
end;

procedure TfrRtfAdvExport.ExportPage;
var
  i, j, x, y, fx, fy,
  dx, dy, n, n1, pbk: Integer;
  dcol, drow: integer;
  buff, s, s0, s1, s2: String;
  CellsLine: String;
  Obj: TfrIEMObject;
  Graphic: TGraphic;
  Str, CellsStream: TMemoryStream;
  bArr: Array[0..1023] of Byte;
  m: TRect;

begin
  PrepareExport;
  m := CurReport.EMFPages[0].pgMargins;
  if m.Left = 0 then m.Left := 40;
  if m.Right = 0 then m.Right := 40;
  if m.Top = 0 then m.Top := 10;
  if m.Bottom = 0 then m.Bottom := 10;
  WriteExpLn('{\rtf1\ansi');
  s := '{\fonttbl';
  for i := 0 to FontTable.Count - 1 do begin
    s1 := '{\f' + IntToStr(i) + ' ' + FontTable[i] + '}';
    if Length(s + s1) < 255 then
      s := s + s1
    else begin
      WriteExpLn(s);
      s := s1;
    end;
  end;
  s := s + '}';
  WriteExpLn(s);
  s := '{\colortbl;';
  for i := 0 to ColorTable.Count - 1 do begin
    s1 := ColorTable[i];
    if Length(s + s1) < 255 then
      s := s + s1
    else begin
      WriteExpLn(s);
      s := s1;
    end;
  end;
  s := s + '}';
  WriteExpLn(s);
  WriteExpLn('{\info{\title ' + CurReport.ReportName +
             '}{\author FastReport 2.52 http://www.fast-report.com' +
             '}{\creatim\yr2004\mo4\dy20\hr11\min11}}');
  WriteExpLn('\paperw' + IntToStr(Round(CurReport.EMFPages[0].pgWidth * PageDivider)) +
             '\paperh' + IntToStr(Round(CurReport.EMFPages[0].pgHeight * PageDivider)) +
             '\margl' + IntToStr(Round(m.Left * PageDivider)) +
             '\margr' + IntToStr(Round(m.Right * PageDivider)) +
             '\margt' + IntToStr(Round(m.Top * PageDivider)) +
             '\margb' + IntToStr(Round(m.Bottom * PageDivider)));
  if CurReport.EMFPages[0].pgOr = poLandscape then
    WriteExpLn('\lndscpsxn');
  if expShowProgress then
    Progress.Execute(Matrix.Height - 2, 'Please wait ...', true, true);
  pbk := 0;
  for y := 0 to Matrix.Height - 2 do
  begin
    if expShowProgress then
    begin
      Progress.Tick;
      if Progress.Terminated then
        break;
    end;
    if expPageBreaks then
      if Matrix.PagesCount > pbk then
        if Matrix.GetPageBreak(pbk) <= Matrix.GetYPosById(y) then
        begin
          WriteExpLn('{\page\fs1\par}');
          Inc(pbk);
        end;
    drow := Round(expScaleY * (Matrix.GetYPosById(y + 1) - Matrix.GetYPosById(y)) * Ydivider);
    buff := '\trowd \trrh' + IntToStr(drow)+ '\trgaph15';
    CellsStream := TMemoryStream.Create;
    for x := 0 to Matrix.Width - 1 do
    begin
      i := Matrix.GetCell(x, y);
      if (i <> -1) then
      begin
        Obj := Matrix.GetObjectById(i);
        Matrix.GetObjectPos(i, fx, fy, dx, dy);
        if Obj.Counter = -1 then
        begin
          if dy > 1 then
            buff := buff + '\clvmgf';
          if obj.Style.Color <> clNone then
            buff := buff + '\clcbpat' + GetRTFFontColor(GetRTFColor(Obj.Style.Color))
          else
            buff := buff + '\clcbpat' + GetRTFFontColor(GetRTFColor(clWhite));
          buff := buff + GetRTFVAlignment(Obj.Style.Align) + GetRTFBorders(Obj.Style) + '\cltxlrtb';
          dcol := Round(expScaleX * (Obj.Left + Obj.Width) * Xdivider);
          buff := buff + '\cellx' + IntToStr(dcol);
          if Obj.IsText then
          begin
            s := '\f' + GetRTFFontName(Obj.Style.Font.Name);
            if Length(Obj.Memo.Text) > 0 then
              s := s + '\fs' + IntToStr(Obj.Style.Font.Size * 2)
            else begin
              j := drow div FONT_DIVIDER;
              if j > 20 then j := 20;
              s := s + '\fs' + IntToStr(j);
            end;
            s := s + GetRTFFontStyle(Obj.Style.Font.Style);
            s := s + '\cf' + GetRTFFontColor(GetRTFColor(Obj.Style.Font.Color));
            if (Obj.IsRichText) then
              s1 := Obj.Memo.Text
            else
              s1 := ChangeReturns(TruncReturns(Obj.Memo.Text));
            if Trim(s1) <> '' then
              s2 := '\sl' + IntToStr((Obj.Style.Font.Size + 2) * 20)
            else s2 := '';
            CellsLine := GetRTFHAlignment(Obj.Style.Align) + s2 +
              '{' + s + ' ' + s1 + '\cell}';
            CellsStream.Write(CellsLine[1], Length(CellsLine));
          end else if expPictures then
          begin
            Graphic := Obj.Image;
            if not ((Graphic = nil) or Graphic.Empty) then
            begin
              Str := TMemoryStream.Create;
              dx := Round(Obj.Width);
              dy := Round(Obj.Height);
              fx := Graphic.Width;
              fy := Graphic.Height;
              Graphic.SaveToStream(Str);
              Str.Position := 0;
              CellsLine := '{\sl000 {\pict\wmetafile8\picw' + FloatToStr(Round(dx * IMAGE_DIVIDER)) +
                   '\pich' + FloatToStr(Round(dy * IMAGE_DIVIDER)) + ' \picbmp\picbpp4' + #13#10;
              CellsStream.Write(CellsLine[1], Length(CellsLine));
              Str.Read(n, 2);
              Str.Read(n, 4);
              n := n div 2 + 7;
              s0 := IntToHex(n + $24, 8);
              s := '010009000003' + Copy(s0, 7, 2) + Copy(s0, 5, 2) +
                   Copy(s0, 3, 2) + Copy(s0, 1, 2) + '0000';
              s0 := IntToHex(n, 8);
              s1 := Copy(s0, 7, 2) + Copy(s0, 5, 2) + Copy(s0, 3, 2) + Copy(s0, 1, 2);
              s := s + s1 + '0000050000000b0200000000050000000c02';
              s0 := IntToHex(fy, 4);
              s := s + Copy(s0, 3, 2) + Copy(s0, 1, 2);
              s0 := IntToHex(fx, 4);
              s := s + Copy(s0, 3, 2) + Copy(s0, 1, 2) +
                   '05000000090200000000050000000102ffffff000400000007010300' + s1 +
                   '430f2000cc000000';
              s0 := IntToHex(fy, 4);
              s := s + Copy(s0, 3, 2) + Copy(s0, 1, 2);
              s0 := IntToHex(fx, 4);
              s := s + Copy(s0, 3, 2) + Copy(s0, 1, 2) + '00000000';
              s0 := IntToHex(fy, 4);
              s := s + Copy(s0, 3, 2) + Copy(s0, 1, 2);
              s0 := IntToHex(fx, 4);
              s := s + Copy(s0, 3, 2) + Copy(s0, 1, 2) + '00000000';
              CellsLine := s + #13#10;
              CellsStream.Write(CellsLine[1], Length(CellsLine));
              Str.Read(bArr[0], 8);
              n1 := 0; s := '';
              repeat
                n := Str.Read(bArr[0], 1024);
                for j := 0 to n - 1 do
                begin
                  s := s + IntToHex(bArr[j], 2);
                  Inc(n1);
                  if n1 > 63 then
                  begin
                    n1 := 0;
                    CellsLine := s + #13#10;
                    CellsStream.Write(CellsLine[1], Length(CellsLine));
                    s := '';
                  end;
                end;
              until n < 1024;
              Str.Free;
              if n1 <> 0 then
              begin
                CellsLine := s + #13#10;
                CellsStream.Write(CellsLine[1], Length(CellsLine));
              end;
              s := '030000000000}';
              CellsLine := s + '\cell}' + #13#10;
              CellsStream.Write(CellsLine[1], Length(CellsLine));
            end;
          end;
          Obj.Counter := y + 1;
        end else
        begin
          if (dy > 1) and (Obj.Counter <> (y + 1))then
          begin
            buff := buff + '\clvmrg';
            buff := buff + GetRTFBorders(Obj.Style) + '\cltxlrtb';
            dcol := Round(expScaleX * (Obj.Left + Obj.Width) * Xdivider);
            buff := buff + '\cellx' + IntToStr(dcol);
            j := drow div FONT_DIVIDER;
            if j > 20 then j := 20;
            CellsLine := '{\fs' + IntToStr(j) + ' \cell}';
            CellsStream.Write(CellsLine[1], Length(CellsLine));
            Obj.Counter := y + 1;
          end;
        end
      end;
    end;
    buff := buff + '\pard \intbl';
    WriteExpLn(buff);
    Exp.CopyFrom(CellsStream, 0);
    WriteExpLn('\pard {\row}');
    CellsStream.Free;
  end;
  WriteExpLn('}');
end;

procedure TfrRtfAdvExport.OnBeginDoc;
begin
  Matrix := TfrIEMatrix.Create;
  Matrix.ShowProgress := false;
  Matrix.Inaccuracy := 0.5;
  Matrix.RotatedAsImage := True;
  Matrix.RichText := True;
  Matrix.PlainRich := False;
  Matrix.AreaFill := True;
  OnAfterExport := AfterExport;
  FontTable := TStringList.Create;
  ColorTable := TStringList.Create;
  DataList := TList.Create;
  CurrentPage := 0;
  FirstPage := true;
  CntPics := 0;
end;

procedure TfrRtfAdvExport.OnBeginPage;
begin
  Inc(CurrentPage);
end;

procedure TfrRtfAdvExport.OnData(x, y: Integer; View: TfrView);
var
  ind : integer;

begin
  ind := 0;
  if (pgList.Find(IntToStr(CurrentPage),ind)) or (pgList.Count = 0) then
    if View is TfrView then
      if (View is TfrMemoView) or
         (expPictures and (not (View is TfrMemoView))) then
        Matrix.AddObject(TfrView(View));
end;

procedure TfrRtfAdvExport.OnEndPage;
var
  ind: integer;
begin
  ind := 0;
  if (pgList.Find(IntToStr(CurrentPage),ind)) or (pgList.Count = 0) then
    Matrix.EndPage;
end;

procedure TfrRtfAdvExport.AfterExport(const FileName: string);
begin
  Matrix.Prepare;
  if expShowProgress then
    Progress := TfrProgress.Create(Self);
  Exp := TFileStream.Create(FileName, fmCreate);
  ExportPage;
  Exp.Free;
  Matrix.Clear;
  Matrix.Free;
  FontTable.Free;
  ColorTable.Free;
  DataList.Free;
  if expShowProgress then
    Progress.Free;
  if expOpenAfter then
    ShellExecute(GetDesktopWindow, 'open', PChar(FileName), nil, nil, SW_SHOW);
end;

procedure TfrRtfExpSet.Localize;
begin
  Ok.Caption := frLoadStr(SOk);
  Cancel.Caption := frLoadStr(SCancel);
  GroupPageRange.Caption := frLoadStr(frRes + 44);
  Pages.Caption := frLoadStr(frRes + 47);
  Descr.Caption := frLoadStr(frRes + 48);
  Caption := frLoadStr(frRes + 1871);
  GroupPageSettings.Caption := frLoadStr(frRes + 1845);
  Topm.Caption := frLoadStr(frRes + 1846);
  Leftm.Caption := frLoadStr(frRes + 1847);
  ScX.Caption := frLoadStr(frRes + 1848);
  ScY.Caption := frLoadStr(frRes + 1849);
  GroupCellProp.Caption := frLoadStr(frRes + 1850);
  CB_PageBreaks.Caption := frLoadStr(frRes + 1860);
  CB_Pictures.Caption := frLoadStr(frRes + 1863);
end;

procedure TfrRtfExpSet.FormCreate(Sender: TObject);
begin
   Localize;
end;

end.
