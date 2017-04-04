
{******************************************}
{                                          }
{             FastReport v2.53             }
{        Intermediate Export Matrix        }
{         Copyright (c) 1998-2004          }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit frIEMatrix;

{$I fr.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, graphics, fr_Class, fr_utils, frProgr;

type
  TfrIEMObject = class;
  TfrIEMObjectList = class;
  TfrIEMStyle = class;

  TfrIEMatrix = class(TObject)
  private
    FIEMObjectList: TList;
    FIEMStyleList:  TList;
    FXPos: TList;
    FYPos: TList;
    FPageBreaks: TList;
    FWidth:     Integer;
    FHeight:    Integer;
    FMaxWidth:  Extended;
    FMaxHeight: Extended;
    FMatrix:    array of integer;
    FDeltaY: Extended;
    FShowProgress: Boolean;
    FMaxCellHeight: Extended;
    FMaxCellWidth: Extended;
    FInaccuracy: Extended;
    FProgress: TfrProgress;
    FRotatedImage: Boolean;
    FPlainRich: Boolean;
    FRichText: Boolean;
    FFillArea: Boolean;
    FOptFrames: Boolean;
    function AddStyleInternal(Style: TfrIEMStyle): integer;
    function AddStyle(Obj: TfrView): integer;
    function AddInternalObject(Obj: TfrIEMObject; x, y, dx, dy: integer): integer;
    function IsMemo(Obj: TfrView): boolean;
    procedure SetCell(x, y: integer; Value: integer);
    procedure FillArea(x, y, dx, dy: integer; Value: integer);
    procedure ReplaceArea(ObjIndex:integer; x, y, dx, dy: integer; Value: integer);
    procedure FindRectArea(x, y: integer; var dx, dy: integer);
    procedure CutObject(ObjIndex: Integer; x, y, dx, dy: integer);
    procedure CloneFrames(Obj1, Obj2: Integer);
    procedure AddPos(List: TList; Value: Extended);
    procedure OrderPosArray(List: TList; Vert: boolean);
    procedure OrderByCells;
    procedure Render;
    procedure Analyse;
    procedure AddPageBreak(Value: Extended);
    procedure OptimizeFrames;
  public
    constructor Create;
    destructor Destroy; override;
    function GetCell(x, y: integer): integer;
    function GetObjectById(ObjIndex: integer): TfrIEMObject;
    function GetStyleById(StyleIndex: integer): TfrIEMStyle;
    function GetXPosById(PosIndex: integer): Extended;
    function GetYPosById(PosIndex: integer): Extended;
    function GetObject(x, y: integer): TfrIEMObject;
    function GetStyle(x, y: integer): TfrIEMStyle;
    function GetCellXPos(x: integer): Extended;
    function GetCellYPos(y: integer): Extended;
    function GetPageBreak(Page: integer): Extended;
    function GetStylesCount: Integer;
    function GetPagesCount: Integer;
    function GetObjectsCount: Integer;
    procedure Clear;
    procedure AddObject(Obj: TfrView);
    procedure Prepare;
    procedure GetObjectPos(ObjIndex: integer; var x, y, dx, dy: integer);
    procedure EndPage;
  published
    property Width: Integer read FWidth;
    property Height: Integer read FHeight;
    property MaxWidth: Extended read FMaxWidth;
    property MaxHeight: Extended read FMaxHeight;
    property ShowProgress: Boolean read FShowProgress write FShowProgress;
    property MaxCellHeight: Extended read FMaxCellHeight write FMaxCellHeight;
    property MaxCellWidth: Extended read FMaxCellWidth write FMaxCellWidth;
    property PagesCount: Integer read GetPagesCount;
    property StylesCount: Integer read GetStylesCount;
    property ObjectsCount: Integer read GetObjectsCount;
    property Inaccuracy: Extended read FInaccuracy write FInaccuracy;
    property RotatedAsImage: boolean read FRotatedImage write FRotatedImage;
    property RichText: boolean read FRichText write FRichText;
    property PlainRich: boolean read FPlainRich write FPlainRich;
    property AreaFill: boolean read FFillArea write FFillArea;
    property FramesOptimization: boolean read FOptFrames write FOptFrames;
  end;

  TfrIEMObject = class(TObject)
  private
    FMemo: TStrings;
    FURL: String;
    FStyleIndex: Integer;
    FStyle: TfrIEMStyle;
    FIsText: Boolean;
    FIsRichText: Boolean;
    FLeft: Extended;
    FTop: Extended;
    FWidth: Extended;
    FHeight: Extended;
    FImage: TBitmap;
    FParent: TfrIEMObject;
    FCounter: Integer;
    procedure SetMemo(const Value: TStrings);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Memo: TStrings read FMemo write SetMemo;
    property URL: String read FURL write FURL;
    property StyleIndex: Integer read FStyleIndex write FStyleIndex;
    property IsText: Boolean read FIsText write FIsText;
    property IsRichText: Boolean read FIsRichText write FIsRichText;
    property Left: Extended read FLeft write FLeft;
    property Top: Extended read FTop write FTop;
    property Width: Extended read FWidth write FWidth;
    property Height: Extended read FHeight write FHeight;
    property Image: TBitmap read FImage write FImage;
    property Parent: TfrIEMObject read FParent write FParent;
    property Style: TfrIEMStyle read FStyle write FStyle;
    property Counter: Integer read FCounter write FCounter;
  end;

  TfrIEMObjectList = class(TObject)
  public
    Obj: TfrIEMObject;
    x, y, dx, dy : Integer;
    Exist: Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

  TfrIEMPos = class(TObject)
  public
    Value: Extended;
  end;

  TfrIEMStyle = class(TObject)
  public
    Font:       TFont;
    Align:      Integer;
    FrameTyp:   Integer;
    FrameWidth: Single;
    FrameColor: TColor;
    FrameStyle: Integer;
    Color:      TColor;
    Rotation:   Integer;
    BrushStyle: TBrushStyle;
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Style: TfrIEMStyle);
  end;

implementation

uses FR_Rich
{$IFDEF RX}
, fr_rxrtf
{$ENDIF};

{ TfrIEMatrix }

const
  MAX_POS_SEARCH_DEPTH = 100;

function TfrIEMatrix.AddInternalObject(Obj: TfrIEMObject; x, y, dx, dy: integer): integer;
var
  FObjItem: TfrIEMObjectList;
begin
  FObjItem := TfrIEMObjectList.Create;
  FObjItem.x := x;
  FObjItem.y := y;
  FObjItem.dx := dx;
  FObjItem.dy := dy;
  FObjItem.Obj := Obj;
  FIEMObjectList.Add(FObjItem);
  Result := FIEMObjectList.Count - 1;
end;

procedure TfrIEMatrix.AddObject(Obj: TfrView);
var
  dx, dy: Extended;
  FObj: TfrIEMObject;
  MemStream: TMemoryStream;
begin
  FObj := TfrIEMObject.Create;
  FObj.StyleIndex := AddStyle(Obj);
  FObj.Style := TfrIEMStyle(FIEMStyleList[FObj.StyleIndex]);
//  FObj.URL :=Obj.URL;
  FObj.Left := Obj.x;
  FObj.Top := FDeltaY + Obj.y;
  FObj.Width := Obj.dx;
  FObj.Height := Obj.dy;
  if IsMemo(Obj) then
  begin
    FObj.Memo := TfrMemoView(Obj).Memo;
    FObj.IsText := True;
    FObj.IsRichText := False;
  end
  else if ((Obj is TfrRichView) and (FRichText))
{$IFDEF RX}
 or ((Obj is TfrrxRichView) and (FRichText))
{$ENDIF}
   then
  begin
    FObj.IsText := True;
    FObj.IsRichText := True;
    if FPlainRich then
      TfrRichView(Obj).RichEdit.PlainText :=  True
    else
      TfrRichView(Obj).RichEdit.PlainText :=  False;
    MemStream := TMemoryStream.Create;
    TfrRichView(Obj).RichEdit.Lines.SaveToStream(MemStream);
    MemStream.Seek(0, soFromBeginning);
    FObj.Memo.LoadFromStream(MemStream);
    MemStream.Free;
  end else
  begin
    FObj.IsText := False;
    FObj.IsRichText := False;
    dx := Obj.dx;
    dy := Obj.dy;
    if Round(dx) = 0 then
      dx := 1;
    if dx < 0 then
    begin
      dx := -dx;
      FObj.Left := FObj.Left - dx;
    end;
    if Round(dy) = 0 then
      dy := 1;
    if dy < 0 then
    begin
      dy := -dy;
      FObj.Top := FObj.Top - dy;
    end;
    FObj.Width := dx;
    FObj.Height := dy;
    FObj.Image := TBitmap.Create;
    FObj.Image.Height := Round(dy) + 1;
    FObj.Image.Width := Round(dx) + 1;
    Obj.x := 0;
    Obj.y := 0;
    TfrView(Obj).Draw(FObj.Image.Canvas);
    Obj.x := Round(FObj.Left);
    Obj.y := Round(FObj.Top - FDeltaY);
  end;
  if FObj.Top + FObj.Height > FMaxHeight then
    FMaxHeight := FObj.Top + FObj.Height;
  if FObj.Left + FObj.Width > FMaxWidth then
    FMaxWidth := FObj.Left + FObj.Width;
  AddPos(FXPos, FObj.Left);
  AddPos(FXPos, FObj.Left + FObj.Width);
  AddPos(FYPos, FObj.Top);
  AddPos(FYPos, FObj.Top + FObj.Height);
  AddInternalObject(FObj, 0, 0, 1, 1);
end;

procedure TfrIEMatrix.AddPageBreak(Value: Extended);
var
  Pos: TfrIEMPos;
begin
  Pos := TfrIEMPos.Create;
  Pos.Value := Value;
  FPageBreaks.Add(Pos);
end;

procedure TfrIEMatrix.AddPos(List: TList; Value: Extended);
var
  Pos: TfrIEMPos;
  i, cnt: integer;
  Exist: Boolean;
begin
  Exist := False;
  if List.Count > MAX_POS_SEARCH_DEPTH then
    cnt := List.Count - MAX_POS_SEARCH_DEPTH
  else
    cnt := 0;
  for i := List.Count - 1 downto cnt do
    if TfrIEMPos(List[i]).Value = Value then
    begin
      Exist := True;
      break;
    end;
  if not Exist then
  begin
    Pos := TfrIEMPos.Create;
    Pos.Value := Value;
    List.Add(Pos);
  end;
end;

function TfrIEMatrix.AddStyle(Obj: TfrView): integer;
var
  Style: TfrIEMStyle;
begin
  Style := TfrIEMStyle.Create;
  if IsMemo(Obj) then
  begin
    Style.Font.Assign(TfrMemoView(Obj).Font);
    Style.Align := TfrMemoView(Obj).Alignment;
    Style.FrameTyp := TfrMemoView(Obj).FrameTyp;
    Style.FrameWidth := TfrMemoView(Obj).FrameWidth;
    Style.FrameColor := TfrMemoView(Obj).FrameColor;
    Style.FrameStyle := TfrMemoView(Obj).FrameStyle;
//    Style.Rotation := TfrMemoView(Obj).Rotation;
    Style.Color := TfrMemoView(Obj).FillColor;
    Style.Font.Assign(TfrMemoView(Obj).Font);
  end else
  begin
    Style.FrameTyp := 0;
    Style.Color := Obj.FillColor;
    Style.Font.Name := 'Arial';
    Style.Font.Color := clBlack;
    Style.Font.Size := 10;
  end;
  Result := AddStyleInternal(Style);
end;

function TfrIEMatrix.AddStyleInternal(Style: TfrIEMStyle): integer;
var
  i: integer;
  Style2: TfrIEMStyle;
begin
  Result := -1;
  for i := 0 to FIEMStyleList.Count - 1 do
  begin
    Style2 := TfrIEMStyle(FIEMStyleList[i]);
    if (Style.Font.Color = Style2.Font.Color) and
       (Style.Font.Name = Style2.Font.Name) and
       (Style.Font.Size = Style2.Font.Size) and
       (Style.Font.Style = Style2.Font.Style) and
       (Style.Align = Style2.Align) and
       (Style.FrameTyp = Style2.FrameTyp) and
       (Style.FrameWidth = Style2.FrameWidth) and
       (Style.FrameColor = Style2.FrameColor) and
       (Style.FrameStyle = Style2.FrameStyle) and
       (Style.Rotation = Style2.Rotation) and
       (Style.Color = Style2.Color) then
    begin
      Result := i;
      break;
    end;
  end;
  if Result = -1 then
  begin
    FIEMStyleList.Add(Style);
    Result := FIEMStyleList.Count - 1;
  end else
    Style.Free;
end;

procedure TfrIEMatrix.Analyse;
var
  i, j, k: integer;
  dx, dy: integer;
  obj: TfrIEMObjectList;
begin
  for i := 0 to FHeight - 1 do
    for j := 0 to FWidth - 1 do
    begin
      k := GetCell(j, i);
      if k <> -1 then
      begin
        obj := TfrIEMObjectList(FIEMObjectList[k]);
        if not obj.Exist then
        begin
          FindRectArea(j, i, dx, dy);
          if (obj.x <> j) or (obj.y <> i) or
             (obj.dx <> dx) or (obj.dy <> dy) then
          begin
            if not Obj.Exist then
              CutObject(k, j, i, dx, dy)
          end else
            Obj.Exist := true;
        end;
      end;
    end;
  if FShowProgress then
    FProgress.Tick;
end;

procedure TfrIEMatrix.Clear;
var
  i : Integer;
begin
  for i := 0 to FIEMObjectList.Count - 1 do
    TfrIEMObjectList(FIEMObjectList[i]).Free;
  FIEMObjectList.Clear;
  for i := 0 to FIEMStyleList.Count - 1 do
    TfrIEMStyle(FIEMStyleList[i]).Free;
  FIEMStyleList.Clear;
  for i := 0 to FXPos.Count - 1 do
    TfrIEMPos(FXPos[i]).Free;
  FXPos.Clear;
  for i := 0 to FYPos.Count - 1 do
    TfrIEMPos(FYPos[i]).Free;
  FYPos.Clear;
  for i := 0 to FPageBreaks.Count - 1 do
    TfrIEMPos(FPageBreaks[i]).Free;
  FPageBreaks.Clear;
  SetLength(FMatrix, 0);
  FDeltaY := 0;
end;

procedure TfrIEMatrix.CloneFrames(Obj1, Obj2: Integer);
var
  FOld, FNew: TfrIEMObject;
  FrameTyp: Integer;
  NewStyle: TfrIEMStyle;
begin
  FOld := TfrIEMObjectList(FIEMObjectList[Obj1]).Obj;
  FNew := TfrIEMObjectList(FIEMObjectList[Obj2]).Obj;
  if FOld.IsText and FNew.IsText then
  begin
    FrameTyp := 0;
    if ((frftTop and FOld.Style.FrameTyp) <> 0) and (FOld.Top = FNew.Top) then
      FrameTyp := FrameTyp + frftTop;
    if ((frftLeft and FOld.Style.FrameTyp) <> 0) and (FOld.Left = FNew.Left) then
      FrameTyp := FrameTyp + frftLeft;
    if ((frftBottom and FOld.Style.FrameTyp) <> 0) and
       ((FOld.Top + FOld.Height) = (FNew.Top + FNew.Height)) then
      FrameTyp := FrameTyp + frftBottom;
    if ((frftRight and FOld.Style.FrameTyp) <> 0) and
       ((FOld.Left + FOld.Width) = (FNew.Left + FNew.Width)) then
      FrameTyp := FrameTyp + frftRight;
    if FrameTyp <> FNew.Style.FrameTyp then
    begin
      NewStyle := TfrIEMStyle.Create;
      NewStyle.FrameTyp := FrameTyp;
      NewStyle.FrameWidth := FOld.Style.FrameWidth;
      NewStyle.FrameColor := FOld.Style.FrameColor;
      NewStyle.FrameStyle := FOld.Style.FrameStyle;
      NewStyle.Font.Assign(FOld.Style.Font);
      NewStyle.Align := FOld.Style.Align;
      NewStyle.Color := FOld.Style.Color;
      NewStyle.Rotation := FOld.Style.Rotation;
      NewStyle.BrushStyle := FOld.Style.BrushStyle;
      FNew.StyleIndex := AddStyleInternal(NewStyle);
      FNew.Style := TfrIEMStyle(FIEMStyleList[FNew.StyleIndex]);
    end;
  end;
end;

constructor TfrIEMatrix.Create;
begin
  FIEMObjectList := TList.Create;
  FIEMStyleList := TList.Create;
  FXPos := TList.Create;
  FYPos := TList.Create;
  FPageBreaks := TList.Create;
  FMaxWidth := 0;
  FMaxHeight := 0;
  FDeltaY := 0;
  FMaxCellHeight := 0;
  FShowProgress := true;
  FInaccuracy := 0;
  FRotatedImage := false;
  FPlainRich := true;
  FRichText := false;
  FFillArea := false;
  FOptFrames := false;
end;

procedure TfrIEMatrix.CutObject(ObjIndex, x, y, dx, dy: integer);
var
  Obj: TfrIEMObject;
  NewObject: TfrIEMObject;
  NewIndex: Integer;
begin
  Obj := TfrIEMObjectList(FIEMObjectList[ObjIndex]).Obj;
  NewObject := TfrIEMObject.Create;
  NewObject.StyleIndex := Obj.StyleIndex;
  NewObject.Style := Obj.Style;
  NewObject.Left := TfrIEMPos(FXPos[x]).Value;
  NewObject.Top := TfrIEMPos(FYPos[y]).Value;
  NewObject.Width := TfrIEMPos(FXPos[x + dx]).Value - TfrIEMPos(FXPos[x]).Value;
  NewObject.Height := TfrIEMPos(FYPos[y + dy]).Value - TfrIEMPos(FYPos[y]).Value;
  NewObject.Memo := Obj.Memo;
  NewObject.Image := Obj.Image;
  NewObject.IsText := Obj.IsText;
  NewObject.Parent := Obj;
  Obj.Memo.Clear;
  Obj.Image := nil;
  Obj.IsText := True;
  NewIndex := AddInternalObject(NewObject, x, y, dx, dy);
  ReplaceArea(ObjIndex, x, y, dx, dy, NewIndex);
  CloneFrames(ObjIndex, NewIndex);
  TfrIEMObjectList(FIEMObjectList[NewIndex]).Exist := True;
end;

destructor TfrIEMatrix.Destroy;
begin
  Clear;
  FXPos.Free;
  FYPos.Free;
  FIEMObjectList.Free;
  FIEMStyleList.Free;
  FPageBreaks.Free;
  inherited;
end;

procedure TfrIEMatrix.EndPage;
begin
  FDeltaY := FMaxHeight;
  AddPageBreak(FMaxHeight);
end;

procedure TfrIEMatrix.FillArea(x, y, dx, dy, Value: integer);
var
  i, j: integer;
begin
  for i := y to y + dy - 1 do
    for j := x to x + dx - 1 do
      SetCell(j, i, Value);
end;

procedure TfrIEMatrix.FindRectArea(x, y: integer; var dx, dy: integer);
var
  px, py: integer;
  Obj: integer;
begin
  Obj := GetCell(x, y);
  px := x;
  py := y;
  dx := 0;
  while GetCell(px, py) = Obj do
  begin
    while GetCell(px, py) = Obj do
      Inc(px);
    if dx = 0 then
      dx := px - x
    else
      if px - x < dx then
        break;
    Inc(py);
    px := x;
  end;
  dy := py - y;
end;

function TfrIEMatrix.GetCell(x, y: integer): integer;
begin
  if (x < FWidth) and (y < FHeight) and (x >= 0) and (y >= 0) then
    Result := FMatrix[FWidth * y + x]
  else
    Result := -1;
end;

function TfrIEMatrix.GetCellXPos(x: integer): Extended;
begin
  Result := TfrIEMPos(FXPos[x]).Value;
end;

function TfrIEMatrix.GetCellYPos(y: integer): Extended;
begin
  Result := TfrIEMPos(FYPos[y]).Value;
end;

function TfrIEMatrix.GetObject(x, y: integer): TfrIEMObject;
var
  i: integer;
begin
  i := GetCell(x, y);
  if i = -1 then
    Result := nil
  else
    Result := TfrIEMObjectList(FIEMObjectList[i]).Obj;
end;

function TfrIEMatrix.GetObjectById(ObjIndex: integer): TfrIEMObject;
begin
  if ObjIndex < FIEMObjectList.Count then
    Result := TfrIEMObjectList(FIEMObjectList[ObjIndex]).Obj
  else
    Result := nil;
end;

procedure TfrIEMatrix.GetObjectPos(ObjIndex: integer; var x, y, dx,
  dy: integer);
begin
  x := TfrIEMObjectList(FIEMObjectList[ObjIndex]).x;
  y := TfrIEMObjectList(FIEMObjectList[ObjIndex]).y;
  dx := TfrIEMObjectList(FIEMObjectList[ObjIndex]).dx;
  dy := TfrIEMObjectList(FIEMObjectList[ObjIndex]).dy;
end;

function TfrIEMatrix.GetObjectsCount: Integer;
begin
  Result := FIEMObjectList.Count;
end;

function TfrIEMatrix.GetPageBreak(Page: integer): Extended;
begin
  if Page < FPageBreaks.Count then
    Result := TfrIEMPos(FPageBreaks[Page]).Value
  else
    Result := 0;
end;

function TfrIEMatrix.GetPagesCount: Integer;
begin
  Result := FPageBreaks.Count;
end;

function TfrIEMatrix.GetStyle(x, y: integer): TfrIEMStyle;
var
  Obj: TfrIEMObject;
begin
  Obj := GetObject(x, y);
  if Obj <> nil then
    Result := TfrIEMStyle(FIEMStyleList[Obj.StyleIndex])
  else
    Result := nil;
end;

function TfrIEMatrix.GetStyleById(StyleIndex: integer): TfrIEMStyle;
begin
  Result := TfrIEMStyle(FIEMStyleList[StyleIndex]);
end;

function TfrIEMatrix.GetStylesCount: Integer;
begin
  Result := FIEMStyleList.Count;
end;

function TfrIEMatrix.GetXPosById(PosIndex: integer): Extended;
begin
  Result := TfrIEMPos(FXPos[PosIndex]).Value;
end;

function TfrIEMatrix.GetYPosById(PosIndex: integer): Extended;
begin
  Result := TfrIEMPos(FYPos[PosIndex]).Value;
end;

function TfrIEMatrix.IsMemo(Obj: TfrView): boolean;
begin
  Result := (Obj is TfrMemoView);
end;

procedure TfrIEMatrix.OptimizeFrames;
var
  x, y: Integer;
  Obj, PrevObj: TfrIEMObject;
  FrameTyp: Integer;
  Style: TfrIEMStyle;
begin
  for y := 0 to Height - 1 do
    for x := 0 to Width - 1 do
    begin
      Obj := GetObject(x, y);
      if Obj = nil then continue;
      FrameTyp := Obj.Style.FrameTyp;
      if ((frftTop and FrameTyp) <> 0) and (y > 0) then
      begin
        PrevObj := GetObject(x, y - 1);
        if (PrevObj <> nil) and (PrevObj <> Obj) then
          if ((frftBottom and PrevObj.Style.FrameTyp) <> 0) and
            (PrevObj.Style.FrameWidth = Obj.Style.FrameWidth) and
            (PrevObj.Style.FrameColor = Obj.Style.FrameColor) then
            FrameTyp := FrameTyp - frftTop;
      end;
      if ((frftLeft and FrameTyp) <> 0) and (x > 0) then
      begin
        PrevObj := GetObject(x - 1, y);
        if (PrevObj <> nil) and (PrevObj <> Obj) then
          if ((frftRight and PrevObj.Style.FrameTyp) <> 0) and
            (PrevObj.Style.FrameWidth = Obj.Style.FrameWidth) and
            (PrevObj.Style.FrameColor = Obj.Style.FrameColor) then
            FrameTyp := FrameTyp - frftLeft;
      end;
      if FrameTyp <> Obj.Style.FrameTyp then
      begin
        Style := TfrIEMStyle.Create;
        Style.Assign(Obj.Style);
        Style.FrameTyp := FrameTyp;
        Obj.StyleIndex := AddStyleInternal(Style);
        Obj.Style := TfrIEMStyle(FIEMStyleList[Obj.StyleIndex]);
      end;
    end;
end;

procedure TfrIEMatrix.OrderByCells;
var
  i, j, k, dx, dy: integer;
  curx, cury: Extended;
  obj: TfrIEMObject;
begin
  OrderPosArray(FXPos, false);
  OrderPosArray(FYPos, true);
  for i := 0 to FIEMObjectList.Count - 1 do
  begin
    dx := 0; dy := 0;
    obj := TfrIEMObjectList(FIEMObjectList[i]).Obj;
    for j := 0 to FXPos.Count - 1 do
      if TfrIEMPos(FXPos[j]).Value >= Obj.Left then
      begin
        TfrIEMObjectList(FIEMObjectList[i]).x := j;
        curx := Obj.Left;
        k := j;
        while (Obj.Left + Obj.Width > curx) and (k < FXPos.Count - 1) do
        begin
          Inc(k);
          curx := TfrIEMPos(FXPos[k]).Value;
          Inc(dx);
        end;
        TfrIEMObjectList(FIEMObjectList[i]).dx := dx;
        break;
      end;
    for j := 0 to FYPos.Count - 1 do
      if TfrIEMPos(FYPos[j]).Value >= Obj.Top then
      begin
        TfrIEMObjectList(FIEMObjectList[i]).y := j;
        cury := Obj.Top;
        k := j;
        while (Obj.Top + Obj.Height > cury) and (k < FYPos.Count - 1) do
        begin
          Inc(k);
          cury := TfrIEMPos(FYPos[k]).Value;
          Inc(dy);
        end;
        TfrIEMObjectList(FIEMObjectList[i]).dy := dy;
        break;
      end;
  end;
  if FShowProgress then
    FProgress.Tick;
end;

function SortPosCompare(Item1, Item2: Pointer): Integer;
begin
  if TfrIEMPos(Item1).Value < TfrIEMPos(Item2).Value then
    Result := -1
  else if TfrIEMPos(Item1).Value > TfrIEMPos(Item2).Value then
    Result := 1
  else
    Result := 0;
end;

procedure TfrIEMatrix.OrderPosArray(List: TList; Vert: boolean);
var
  i, j, Cnt: integer;
  pos1, pos2: Extended;
  Reorder: Boolean;
begin
  List.Sort(SortPosCompare);
  if FShowProgress then
    FProgress.Tick;
  i := 0;
  while i <= List.Count - 2 do
  begin
    pos1 := TfrIEMPos(List[i]).Value;
    pos2 := TfrIEMPos(List[i + 1]).Value;
    if pos2 - pos1 <= FInaccuracy then
    begin
      TfrIEMPos(List[i]).Free;
      List.Delete(i);
    end else Inc(i);
  end;
  if FShowProgress then
    FProgress.Tick;
  Reorder := False;
  if Vert and (FMaxCellHeight > 0) then
    for i := 0 to List.Count - 2 do
    begin
      pos1 := TfrIEMPos(List[i]).Value;
      pos2 := TfrIEMPos(List[i + 1]).Value;
      if pos2 - pos1 > FMaxCellHeight then
      begin
        Cnt := Round(Int((pos2 - pos1) / FMaxCellHeight));
        for j := 1 to Cnt do
          AddPos(List, pos1 + FMaxCellHeight * j);
        Reorder := True;
      end;
    end;
  if FShowProgress then
    FProgress.Tick;
  if (not Vert) and (FMaxCellWidth > 0) then
    for i := 0 to List.Count - 2 do
    begin
      pos1 := TfrIEMPos(List[i]).Value;
      pos2 := TfrIEMPos(List[i + 1]).Value;
      if pos2 - pos1 > FMaxCellWidth then
      begin
        Cnt := Round(Int((pos2 - pos1) / FMaxCellWidth));
        for j := 1 to Cnt do
          AddPos(List, pos1 + FMaxCellWidth * j);
        Reorder := True;
      end;
    end;
  if Reorder then
    List.Sort(SortPosCompare);
  if FShowProgress then
    FProgress.Tick;
end;

procedure TfrIEMatrix.Prepare;
var
  Style: TfrIEMStyle;
  FObj: TfrIEMObject;
  FObjItem: TfrIEMObjectList;

begin
  if FShowProgress then
  begin
    FProgress := TfrProgress.Create(nil);
    FProgress.Execute(11, 'Prepare export', false, true);
  end;
  if FFillArea then
  begin
    Style := TfrIEMStyle.Create;
    Style.FrameTyp := 0;
    Style.Color := clWhite;
    FObj := TfrIEMObject.Create;
    FObj.StyleIndex := AddStyleInternal(Style);
    FObj.Style := Style;
    FObj.Left := 0;
    FObj.Top := 0;
    FObj.Width := MaxWidth;
    FObj.Height := MaxHeight;
    FObj.IsText := True;
    AddPos(FXPos, 0);
    AddPos(FYPos, 0);
    FObjItem := TfrIEMObjectList.Create;
    FObjItem.x := 0;
    FObjItem.y := 0;
    FObjItem.dx := 1;
    FObjItem.dy := 1;
    FObjItem.Obj := FObj;
    FIEMObjectList.Insert(0, FObjItem);
  end;
  OrderByCells;
  FWidth := FXPos.Count;
  FHeight := FYPos.Count;
  Render;
  Analyse;
  if FOptFrames then
    OptimizeFrames;
  if FShowProgress then
    FProgress.Free;
end;

procedure TfrIEMatrix.Render;
var
  i, old: integer;
  obj: TfrIEMObjectList;
  Style: TfrIEMStyle;
begin
  SetLength(FMatrix, FWidth * FHeight);
  FillArea(0, 0, FWidth, FHeight, -1);
  for i := 0 to FIEMObjectList.Count - 1 do
  begin
    obj := TfrIEMObjectList(FIEMObjectList[i]);
    if Obj.Obj.Style.Color = clNone then
    begin
      old := GetCell(obj.x, obj.y);
      if old <> -1 then
      begin
        Style := TfrIEMStyle.Create;
        Style.Assign(Obj.Obj.Style);
        Style.Color := TfrIEMObjectList(FIEMObjectList[Old]).Obj.Style.Color;
        Obj.Obj.StyleIndex := AddStyleInternal(Style);
        Obj.Obj.Style := TfrIEMStyle(FIEMStyleList[Obj.Obj.StyleIndex]);
      end;
    end;
    FillArea(obj.x, obj.y, obj.dx, obj.dy, i);
  end;
  if FShowProgress then
    FProgress.Tick;
end;

procedure TfrIEMatrix.ReplaceArea(ObjIndex, x, y, dx, dy,
  Value: integer);
var
  i, j: integer;
begin
  for i := y to y + dy - 1 do
    for j := x to x + dx - 1 do
      if GetCell(j, i) = ObjIndex then
        SetCell(j, i, Value);
end;

procedure TfrIEMatrix.SetCell(x, y, Value: integer);
begin
  if (x < FWidth) and (y < FHeight) and (x >= 0) and (y >= 0) then
    FMatrix[FWidth * y + x] := Value;
end;

{ TfrIEMObjectList }

constructor TfrIEMObjectList.Create;
begin
  Exist := False;
end;

destructor TfrIEMObjectList.Destroy;
begin
  Obj.Free;
  inherited;
end;

{ TfrIEMStyle }

procedure TfrIEMStyle.Assign(Style: TfrIEMStyle);
begin
  Font.Assign(Style.Font);
  Align := Style.Align;
  FrameTyp := Style.FrameTyp;
  FrameWidth := Style.FrameWidth;
  FrameColor := Style.FrameColor;
  FrameStyle := Style.FrameStyle;
  Color := Style.Color;
  Rotation := Style.Rotation;
  BrushStyle := Style.BrushStyle;
end;

constructor TfrIEMStyle.Create;
begin
  Font := TFont.Create;
end;

destructor TfrIEMStyle.Destroy;
begin
  Font.Free;
  inherited;
end;

{ TfrIEMObject }

constructor TfrIEMObject.Create;
begin
  FMemo := TStringList.Create;
  Left := 0;
  Top := 0;
  Image := nil;
  FParent := nil;
  FCounter := 0;
  FIsText := true;
  FIsRichText := false;
end;

destructor TfrIEMObject.Destroy;
begin
  FMemo.Free;
  if Assigned(FImage) then
    FImage.Free;
  inherited;
end;

procedure TfrIEMObject.SetMemo(const Value: TStrings);
begin
  FMemo.Assign(Value);
end;

end.
