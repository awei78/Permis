{******
  单 元：CtrlsEx
  作 者：刘景威
  日 期：2007-6-15
  说 明：改写TPanel、TColorBox、TGroupBox，加入些新特性
  更 新：
******}

unit CtrlsEx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StdCtrls, jpeg, ExtCtrls, Consts, ShockwaveFlashObjects_TLB;

type
  //TPanel，加入其Enabled控制其中控件之Enabled属性
  TPanel = class(TCustomPanel)
  private
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
  public
    property DockManager;
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderWidth;
    property BorderStyle;
    property Caption;
    property Color;
    property Constraints;
    property Ctl3D;
    property UseDockManager default True;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FullRepaint;
    property Font;
    property Locked;
    property ParentBiDiMode;
    property ParentBackground;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

  //作用等同TPanel
  TGroupBox = class(TCustomGroupBox)
  private
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Color;
    property Constraints;
    property Ctl3D;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBackground default True;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDockDrop;
    property OnDockOver;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

  //去除颜色名
  TColorBox = class(TCustomColorBox)
  protected
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
  published
    property AutoComplete;
    property AutoDropDown;
    property DefaultColorColor;
    property NoneColorColor;
    property Selected;
    property Style;

    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BiDiMode;
    property Color;
    property Constraints;
    property Ctl3D;
    property DropDownCount;
    property Enabled;
    property Font;
    property ItemHeight;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnCloseUp;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnSelect;
    property OnStartDock;
    property OnStartDrag;
  end;

  //加入对Flash的支持
  TImage = class(TGraphicControl)
  private
    FImage: string;
    FPicture: TPicture;
    FOnProgress: TProgressEvent;
    FStretch: Boolean;
    FCenter: Boolean;
    FIncrementalDisplay: Boolean;
    FTransparent: Boolean;
    FDrawing: Boolean;
    FProportional: Boolean;
    //Flash控件
    FFlash: TShockwaveFlash;
    function GetCanvas: TCanvas;
    //检测是否非标准的jpeg文件
    function CheckJpegImage(const AImage: string): Boolean;
    procedure PictureChanged(Sender: TObject);
    procedure SetCenter(Value: Boolean);
    procedure SetPicture(Value: TPicture);
    procedure SetStretch(Value: Boolean);
    procedure SetTransparent(Value: Boolean);
    procedure SetProportional(Value: Boolean);
    procedure SetImage(const Value: string);
    //屏蔽Flash右键
    procedure OnMessage(var Msg: TMsg; var Handled: Boolean);
  protected
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    function DestRect: TRect;
    function DoPaletteChange: Boolean;
    function GetPalette: HPALETTE; override;
    procedure Paint; override;
    procedure Progress(Sender: TObject; Stage: TProgressStage;
      PercentDone: Byte; RedrawNow: Boolean; const R: TRect; const Msg: string); dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Canvas: TCanvas read GetCanvas;
  published
    property Image: string read FImage write SetImage;
    property Align;
    property Anchors;
    property AutoSize;
    property Center: Boolean read FCenter write SetCenter default False;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property IncrementalDisplay: Boolean read FIncrementalDisplay write FIncrementalDisplay default False;
    property ParentShowHint;
    property Picture: TPicture read FPicture write SetPicture;
    property PopupMenu;
    property Proportional: Boolean read FProportional write SetProportional default false;
    property ShowHint;
    property Stretch: Boolean read FStretch write SetStretch default False;
    property Transparent: Boolean read FTransparent write SetTransparent default False;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnProgress: TProgressEvent read FOnProgress write FOnProgress;
    property OnStartDock;
    property OnStartDrag;
  end;

  //解决退格键对中文的不支持
  TComboBox = class(TCustomComboBox)
  private
    function IsNTSystem: Boolean;
  protected
    procedure KeyPress(var Key: Char); override;
  published
    property AutoComplete default True;
    property AutoDropDown default False;
    property AutoCloseUp default False;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property Style; {Must be published before Items}
    property Anchors;
    property BiDiMode;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DropDownCount;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ItemHeight;
    property ItemIndex default -1;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnCloseUp;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnSelect;
    property OnStartDock;
    property OnStartDrag;
    property Items; { Must be published after OnMeasureItem }
  end;

implementation

{ TPanel }

procedure TPanel.CMEnabledChanged(var Message: TMessage);
var
  i: Integer;
begin
  inherited;

  for i := 0 to ControlCount - 1 do
    Controls[i].Enabled := Enabled and Controls[i].Enabled;
end;

{ TGroupBox }

procedure TGroupBox.CMEnabledChanged(var Message: TMessage);
var
  i: Integer;
begin
  inherited;

  for i := 0 to ControlCount - 1 do
    Controls[i].Enabled := Enabled and Controls[i].Enabled;
end;

{ TColorBox }

procedure TColorBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);

  function ColorToBorderColor(AColor: TColor): TColor;
  type
    TColorQuad = record
      Red,
      Green,
      Blue,
      Alpha: Byte;
    end;
  begin
    if (TColorQuad(AColor).Red > 192) or
       (TColorQuad(AColor).Green > 192) or
       (TColorQuad(AColor).Blue > 192) then
      Result := clBlack
    else if odSelected in State then
      Result := clWhite
    else Result := AColor;
  end;

var
  LRect: TRect;
begin
  with Canvas do
  begin
    FillRect(Rect);

    LRect := Rect;
    InflateRect(LRect, -1, -1);
    Brush.Color := Colors[Index];
    if Brush.Color = clDefault then
      Brush.Color := DefaultColorColor
    else if Brush.Color = clNone then
      Brush.Color := NoneColorColor;

    FillRect(LRect);
    Brush.Color := ColorToBorderColor(ColorToRGB(Brush.Color));
    FrameRect(LRect);
  end;
end;

{ TImage }

constructor TImage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FPicture := TPicture.Create;
  FPicture.OnChange := PictureChanged;
  FPicture.OnProgress := Progress;
  Height := 105;
  Width := 105;

  Application.OnMessage := OnMessage;
end;

destructor TImage.Destroy;
begin
  Application.OnMessage := nil;
  FPicture.Free;
  inherited Destroy;
end;

function TImage.GetPalette: HPALETTE;
begin
  Result := 0;
  if FPicture.Graphic <> nil then
    Result := FPicture.Graphic.Palette;
end;

function TImage.DestRect: TRect;
var
  w, h, cw, ch: Integer;
  xyaspect: Double;
begin
  w := Picture.Width;
  h := Picture.Height;
  cw := ClientWidth;
  ch := ClientHeight;
  if Stretch or (Proportional and ((w > cw) or (h > ch))) then
  begin
  	if Proportional and (w > 0) and (h > 0) then
   	begin
      xyaspect := w / h;
      if w > h then
      begin
        w := cw;
        h := Trunc(cw / xyaspect);
        if h > ch then  // woops, too big
        begin
          h := ch;
          w := Trunc(ch * xyaspect);
        end;
      end
      else
      begin
        h := ch;
        w := Trunc(ch * xyaspect);
        if w > cw then  // woops, too big
        begin
          w := cw;
          h := Trunc(cw / xyaspect);
        end;
      end;
    end
    else
    begin
      w := cw;
      h := ch;
    end;
  end;

  with Result do
  begin
    Left := 0;
    Top := 0;
    Right := w;
    Bottom := h;
  end;

  if Center then
	OffsetRect(Result, (cw - w) div 2, (ch - h) div 2);
end;

procedure TImage.Paint;
var
  Save: Boolean;
begin
  if csDesigning in ComponentState then
  with inherited Canvas do
  begin
    Pen.Style := psDash;
    Brush.Style := bsClear;
    Rectangle(0, 0, Width, Height);
  end;
  Save := FDrawing;
  FDrawing := True;
  try
  with inherited Canvas do
    StretchDraw(DestRect, Picture.Graphic);
  finally
  FDrawing := Save;
  end;
end;

function TImage.DoPaletteChange: Boolean;
var
  ParentForm: TCustomForm;
  Tmp: TGraphic;
begin
  Result := False;
  Tmp := Picture.Graphic;
  if Visible and (not (csLoading in ComponentState)) and (Tmp <> nil) and
  (Tmp.PaletteModified) then
  begin
    if (Tmp.Palette = 0) then
      Tmp.PaletteModified := False
    else
    begin
      ParentForm := GetParentForm(Self);
      if Assigned(ParentForm) and ParentForm.Active and Parentform.HandleAllocated then
      begin
      if FDrawing then
        ParentForm.Perform(wm_QueryNewPalette, 0, 0)
      else
        PostMessage(ParentForm.Handle, wm_QueryNewPalette, 0, 0);
      Result := True;
      Tmp.PaletteModified := False;
      end;
    end;
  end;
end;

procedure TImage.Progress(Sender: TObject; Stage: TProgressStage;
  PercentDone: Byte; RedrawNow: Boolean; const R: TRect; const Msg: string);
begin
  if FIncrementalDisplay and RedrawNow then
  begin
  if DoPaletteChange then Update
  else Paint;
  end;
  if Assigned(FOnProgress) then FOnProgress(Sender, Stage, PercentDone, RedrawNow, R, Msg);
end;

function TImage.GetCanvas: TCanvas;
var
  Bitmap: TBitmap;
begin
  if Picture.Graphic = nil then
  begin
  Bitmap := TBitmap.Create;
  try
    Bitmap.Width := Width;
    Bitmap.Height := Height;
    Picture.Graphic := Bitmap;
  finally
    Bitmap.Free;
  end;
  end;
  if Picture.Graphic is TBitmap then
  Result := TBitmap(Picture.Graphic).Canvas
  else
  raise EInvalidOperation.Create(SImageCanvasNeedsBitmap);
end;

function TImage.CheckJpegImage(const AImage: string): Boolean;
var
  pic: TPicture;
  bmp: TBitmap;
begin
  Result := True;
  if Pos(LowerCase(ExtractFileExt(AImage)), '.jpg.jpeg') = 0 then Exit;

  pic := TPicture.Create;
  bmp := TBitmap.Create;
  try
    try
      pic.LoadFromFile(AImage);
      bmp.Assign(pic.Graphic);
    except
      Result := False;
    end;
  finally
    pic.Free;
    bmp.Free;
  end;
end;

procedure TImage.SetCenter(Value: Boolean);
begin
  if FCenter <> Value then
  begin
    FCenter := Value;
    PictureChanged(Self);
  end;
end;

procedure TImage.SetPicture(Value: TPicture);
begin
  FPicture.Assign(Value);
end;

procedure TImage.SetStretch(Value: Boolean);
begin
  if Value <> FStretch then
  begin
    FStretch := Value;
    PictureChanged(Self);
  end;
end;

procedure TImage.SetTransparent(Value: Boolean);
begin
  if Value <> FTransparent then
  begin
    FTransparent := Value;
    PictureChanged(Self);
  end;
end;

procedure TImage.SetProportional(Value: Boolean);
begin
  if FProportional <> Value then
  begin
    FProportional := Value;
    PictureChanged(Self);
  end;
end;

procedure TImage.SetImage(const Value: string);
var
  sExt: string;
begin
  if not FileExists(Value) or not CheckJpegImage(Value) then
  begin
    if not FileExists(Value) then
    begin
      FImage := '';
      FPicture.Graphic := nil;
      if Assigned(FFlash) then FreeAndNil(FFlash);
    end
    else MessageBox(TWinControl(Owner).Handle, '您所选择的是非法的jpeg文件', '提示', MB_OK + MB_ICONWARNING);

    Exit;
  end;

  FImage := Value;
  sExt := LowerCase(ExtractFileExt(Value));
  //加载图片
  if sExt <> '.swf' then
  begin
    if Assigned(FFlash) then FreeAndNil(FFlash);
    FPicture.LoadFromFile(Value);
  end
  //加载Flash
  else
  begin
    FPicture.Graphic := nil;
    if Assigned(FFlash) then FreeAndNil(FFlash);
    FFlash := TShockwaveFlash.Create(Owner);
    FFlash.Left := Left;
    FFlash.Top := Top;
    FFlash.Width := Width;
    FFlash.Height := Height;
    //须写此处位置才能更新
    FFlash.Parent := Parent;
    FFlash.Movie := Value;
    FFlash.Update;
  end;
end;

procedure TImage.OnMessage(var Msg: TMsg; var Handled: Boolean);
begin
  Handled := Assigned(FFlash) and (Msg.Hwnd = FFlash.Handle) and (Msg.message = WM_RBUTTONDOWN); 
end;

procedure TImage.PictureChanged(Sender: TObject);
var
  G: TGraphic;
  D : TRect;
begin
  if AutoSize and (Picture.Width > 0) and (Picture.Height > 0) then
    SetBounds(Left, Top, Picture.Width, Picture.Height);
  G := Picture.Graphic;
  if G <> nil then
  begin
    if not ((G is TMetaFile) or (G is TIcon)) then G.Transparent := FTransparent;
    D := DestRect;
    if (not G.Transparent) and (D.Left <= 0) and (D.Top <= 0) and
       (D.Right >= Width) and (D.Bottom >= Height) then
      ControlStyle := ControlStyle + [csOpaque]
    else  // picture might not cover entire clientrect
      ControlStyle := ControlStyle - [csOpaque];
    if DoPaletteChange and FDrawing then Update;
  end
  else ControlStyle := ControlStyle - [csOpaque];
  if not FDrawing then Invalidate;
end;

function TImage.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
begin
  Result := True;
  if not (csDesigning in ComponentState) or (Picture.Width > 0) and
    (Picture.Height > 0) then
  begin
    if Align in [alNone, alLeft, alRight] then
      NewWidth := Picture.Width;
    if Align in [alNone, alTop, alBottom] then
      NewHeight := Picture.Height;
  end;
end;

{ TComboBox }

function TComboBox.IsNTSystem: Boolean;
var
  info:OSVERSIONINFO; 
begin 
  info.dwOSVersionInfoSize:=sizeof(info); 
  GetVersionEx(info); 
  Result:=info.dwPlatformId=VER_PLATFORM_WIN32_NT; 
end; 

procedure TComboBox.KeyPress(var Key: Char);
  function HasSelectedText(CB_HWND:HWND; var StartPos, EndPos: DWORD): Boolean; 
  begin 
    SendMessage(CB_HWND, CB_GETEDITSEL, Integer(@StartPos), 
      Integer(@EndPos)); 
    Result := EndPos > StartPos;
  end;

var 
  StartPos, EndPos: DWORD; 
  OldText, SaveText: WideString;  //关键在此，中间字符串要设为宽字符串型 
  LastByte: Integer; 
begin
  if Ord(Key) = VK_BACK then
  begin
    if not IsNTSystem then Exit;    //非NT系统则退出
    if not AutoComplete then exit;

    SaveText := Text;
    if HasSelectedText(Handle, StartPos, EndPos) then 
    begin
      SendMessage(Handle, CB_GETEDITSEL, Integer(@StartPos), Integer(@EndPos));
      Delete(SaveText, StartPos + 1, EndPos - StartPos);
      SendMessage(Handle, CB_SETCURSEL, -1, 0);
      Text := SaveText;
      SendMessage(Handle, CB_SETEDITSEL, 0, MakeLParam(StartPos,StartPos));
      Key := #0;
    end
    else if(Style in [csDropDown, csSimple]) and (Length(SaveText) > 0) then
    begin
      LastByte := StartPos;
      OldText := Copy(SaveText, 1, LastByte - 1);
      SendMessage(Handle, CB_SETCURSEL, -1, 0);
      Text := OldText + Copy(SaveText, EndPos + 1, MaxInt);
      SendMessage(Handle, CB_SETEDITSEL, 0, MakeLParam(LastByte - 1, LastByte - 1));
      Key := #0;
    end;
  end
  else inherited KeyPress(Key);
end;

end.
