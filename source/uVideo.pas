unit uVideo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBase, StdCtrls, Buttons, ExtCtrls, CtrlsEx, RzPanel, jpeg, MMSystem;

type
  TfrmVideo = class(TfrmBase)
    pnlVideo: TPanel;
    pnlLeft: TRzPanel;
    pnlRight: TRzPanel;
    btnCap: TBitBtn;
    pnlPhoto: TPanel;
    img: TImage;
    btnSet: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCapClick(Sender: TObject);
    procedure btnSetClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
    FParHandle: THandle;
    FStaffID: string;
    FCamera: Boolean;
    function DealImage(const AImgFile: string): Boolean;
    procedure SaveImage;
    function CaptureVideoAsBmp(const ABmpFile: string): Boolean;
  protected
    //数据操作过程...
    procedure InitData; override;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
  end;

var
  frmVideo: TfrmVideo;

function capCreateCaptureWindow(
  lpszWindowName: PChar;
  dwStyle: DWord;
  x, y: Integer;
  nWidth, nHeight: Integer;
  hwndParent: THandle;
  nID: Integer): THandle; stdcall;

function ShowVideo(AOwner: TWinControl; AStaffID: string; const ACamera: Boolean = False): Boolean;

implementation

uses uGlobal;

{$R *.dfm}

const
  WM_CAP_DRIVER_CONNECT    = WM_USER + 10;
  WM_CAP_DRIVER_DISCONNECT = WM_USER + 11;
  //WM_CAP_SAVEDIB           = WM_USER + 25;
  WM_CAP_SET_PREVIEW       = WM_USER + 50;
  WM_CAP_SET_OVERLAY       = WM_USER + 51;
  WM_CAP_SET_PREVIEWRATE   = WM_USER + 52;
  WM_CAP_SET_SCALE         = WM_USER + 53;
  WM_CAP_DLG_VIDEOFORMAT   = WM_USER + 41;
  WM_CAP_DLG_VIDEOSOURCE   = WM_USER + 42;
  PHOTO_WIDTH  = 200;
  PHOTO_HEIGHT = 240;

var
  hWndC: HWND;
  HasVideo: Boolean;

function capCreateCaptureWindow; external 'avicap32.dll' name
  'capCreateCaptureWindowA';

function ShowVideo(AOwner: TWinControl; AStaffID: string; const ACamera: Boolean): Boolean;
begin
  with TfrmVideo.Create(AOwner) do
  begin
    FParHandle := AOwner.Handle;
    FStaffID := AStaffID;
    FCamera := ACamera;
    imgHelp.Visible := False;
    btnSet.Enabled := False;
    btnOk.Enabled := False;
    if ACamera then
    begin
      btnOk.Caption := '保存(&S)';
      btnCancel.Caption := '关闭(&X)';
    end;
    try
      InitData();
      Result := HasVideo and (ShowModal() = mrOk);
    finally
      Free;
    end;
  end;
end;

procedure TfrmVideo.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WndParent := TWinControl(Owner).Handle;
end;

procedure TfrmVideo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if hWndC <> 0 then
  begin
    SendMessage(hWndC, WM_CAP_DRIVER_DISCONNECT, 0, 0);
    SendMessage(hWndC, WM_CLOSE, 0, 0);
    hWndC := 0;
  end;

  Screen.Cursor := crDefault;
end;

procedure TfrmVideo.InitData;
begin
  try
    hWndC := capCreateCaptureWindow('照像机',
      WS_CHILD or WS_VISIBLE, 0, 0, pnlVideo.Width, pnlVideo.Height,
      pnlVideo.Handle, 0);
    if Boolean(SendMessage(hWndC, WM_CAP_DRIVER_CONNECT, 0, 0)) then
    begin
      HasVideo := True;
      btnSet.Enabled := True;
      SendMessage(hWndC, WM_CAP_SET_PREVIEW, 1, 0);
      SendMessage(hWndC, WM_CAP_SET_OVERLAY, 1, 0);
      SendMessage(hWndC, WM_CAP_SET_PREVIEWRATE, 30, 0);
      SendMessage(hWndC, WM_CAP_SET_SCALE, 1, 0);
    end
    else MessageBox(FParHandle, PAnsiChar('没有检测到与计算机连接的视频设备，照相功能不能使用'), '提示', MB_OK + MB_ICONWARNING);
  except
    on E: Exception do
      MessageBox(FParHandle, PAnsiChar('没有检测到与计算机连接的视频设备，照相功能不能使用。' + #13#10 + '提示信息：' + E.Message), '提示', MB_OK + MB_ICONWARNING);
  end;
end;

function TfrmVideo.CaptureVideoAsBmp(const ABmpFile: string): Boolean;
  procedure PlayCameraSound();
  var
    hDll: Cardinal;
  begin
    hDll := LoadLibrary(PAnsiChar(DLL_NAME));
    try
    if hDll <> 0 then
      PlaySound('capture', hDll, SND_ASYNC or SND_RESOURCE);
    finally
      FreeLibrary(hDll);
    end;
  end;

var
  VideoDC: HDC;
  bmp: TBitmap;
begin
  bmp := TBitmap.Create;
  VideoDC := GetDC(pnlVideo.Handle);

  try
    //播放声音
    PlayCameraSound();
    with bmp do
    begin
      PixelFormat := pf24bit;
      Width := pnlVideo.Width;
      Height := pnlVideo.Height;
    end;

    try
      BitBlt(bmp.Canvas.Handle, 0, 0, bmp.Width, bmp.Height, VideoDC, 0, 0, SRCCOPY);
      bmp.SaveToFile(ABmpFile);
      Result := True;
    except
      Result := False;
    end;
  finally
    ReleaseDC(pnlVideo.Handle, VideoDC);
    bmp.Free;
  end;
end;

function TfrmVideo.DealImage(const AImgFile: string): Boolean;
var
  bmpSrc, bmp: TBitmap;
  jpg: TJPEGImage;
  iWidth, iHeight: Integer;
  rDest: TRect;
begin
  Result := False;
  if not FileExists(AImgFile) then Exit;

  bmpSrc := TBitmap.Create;
  bmp := TBitmap.Create;
  jpg := TJPEGImage.Create;
  try
    bmpSrc.LoadFromFile(AImgFile);
    iWidth := Round(bmpSrc.Height * 111 / 133);
    iHeight := bmpSrc.Height;
    try
      bmp.PixelFormat := pf24bit;
      bmp.Width := iWidth;
      bmp.Height := iHeight;
      rDest := Rect(Round((bmpSrc.Width - iWidth) / 2 + 1), 0, Round((bmpSrc.Width - iWidth) / 2 + iWidth), bmpSrc.Height);
      bmp.Canvas.CopyRect(Rect(0, 0, iWidth, iHeight), bmpSrc.Canvas, rDest);

      jpg.Assign(bmp);
      jpg.SaveToFile(App.TmpPath + FStaffID + '.jpg');
      Result := True;
    except
      Result := False;
    end;
  finally
    bmpSrc.Free;
    bmp.Free;
    jpg.Free;
  end;
end;

procedure TfrmVideo.SaveImage;
var
  sd: TSaveDialog;
  sImg: string;
begin
  sd := TSaveDialog.Create(Self);
  try
    sd.Filter := 'JPEG 文件(*.jpg)|*.jpg';
    sd.Options := sd.Options + [ofOverwritePrompt];
    if sd.Execute then
    begin
      sImg := sd.FileName;
      if Copy(sImg, Length(sImg) - 4, 4) <> '.jpg' then sImg := sImg + '.jpg';
      CopyFile(PAnsiChar(img.Image), PAnsiChar(sImg), False);
    end;
  finally
    sd.Free;
  end;
end;

procedure TfrmVideo.btnCapClick(Sender: TObject);
var
  tmpBmp: string;
begin
  tmpBmp := ChangeFileExt(App.TmpJpg, '.bmp');
  //测试发现，用vfw的发消息存储图片，会造成与预览图不一致的图片，改用屏幕抓图方式实现
  {if Boolean(SendMessage(hWndC, WM_CAP_SAVEDIB, 0, Integer(PAnsiChar(tmpBmp)))) and
    DealImage(tmpBmp) then}
    
  if CaptureVideoAsBmp(tmpBmp) and DealImage(tmpBmp) then
  begin
    img.Image := App.TmpPath + FStaffID + '.jpg';
    btnOk.Enabled := True;
  end;
end;

procedure TfrmVideo.btnSetClick(Sender: TObject);
begin
  if (hWndC <> 0) and Boolean(SendMessage(hWndC, WM_CAP_DLG_VIDEOSOURCE, 0, 0)) then Update;
end;

procedure TfrmVideo.btnOkClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    if not FCamera then
      ModalResult := mrOk
    else SaveImage();
  finally
    Screen.Cursor := crDefault;
  end;
end;

end.
