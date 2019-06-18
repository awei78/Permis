{******
  单 元：uImportP.pas
  作 者：刘景威
  日 期：2009-3-16
  说 明：批量导入员工照片单元
  更 新：
******}

unit uImportP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBase, ExtCtrls, ComCtrls, StdCtrls, Mask, RzEdit, RzBtnEdt, DB,
  Buttons, CtrlsEx;

type
  TfrmImportP = class(TfrmBase)
    Label3: TLabel;
    pb: TProgressBar;
    imgImport: TImage;
    gbPath: TGroupBox;
    bePath: TRzButtonEdit;
    gbStaff: TGroupBox;
    lvStaff: TListView;
    lblNo: TLabel;
    lblName: TLabel;
    lblSex: TLabel;
    lblDept: TLabel;
    pnlPhoto: TPanel;
    imgPhoto: TImage;
    Label1: TLabel;
    procedure bePathKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bePathEnter(Sender: TObject);
    procedure bePathExit(Sender: TObject);
    procedure bePathButtonClick(Sender: TObject);
    procedure lvStaffCustomDrawSubItem(Sender: TCustomListView;
      Item: TListItem; SubItem: Integer; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure lvStaffSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure imgPhotoDblClick(Sender: TObject);
  private
    { Private declarations }
    procedure LoadPhotos;
  protected
    procedure InitData; override;
    procedure SaveData; override;
    //检查数据
    function CheckData: Boolean; override;
  public
    { Public declarations }
  end;

var
  frmImportP: TfrmImportP;

function ShowImportP(): Boolean;

implementation

uses uGlobal, uData;

{$R *.dfm}

function ShowImportP(): Boolean;
begin
  with TfrmImportP.Create(Application.MainForm) do
  begin
    HelpHtml := 'import_p.html';
    try
      InitData();
      Result := ShowModal() = mrOk;
    finally
      Free;
    end;
  end;
end;

{ TfrmImportP }

procedure TfrmImportP.InitData;
begin
  bePath.Text := App.PhotoPath;
  LoadPhotos();
  pb.Visible := False;
end;

function TfrmImportP.CheckData: Boolean;
begin
  Result := False;
  if not DirectoryExists(bePath.Text) then
  begin
    MessageBox(Handle, PAnsiChar('请选择您要导入的图片目录。'), '提示', MB_OK + MB_ICONINFORMATION);
    bePath.OnButtonClick(bePath);
    Exit;
  end;
  if bePath.Text = App.Path + 'photos\' then
  begin
    MessageBox(Handle, PAnsiChar('此为CR人事档案系统的照片目录，您不能从这里导入员工照片。'), '提示', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;

  Result := inherited CheckData();
end;

procedure TfrmImportP.SaveData;
var
  i: Integer;
  sImgFile: string;
  Item: TListItem;
  BookMark: TBookMark;
begin
  if lvStaff.Items.Count = 0 then Exit;     

  pb.Visible := True;
  for i := 0 to lvStaff.Items.Count - 1 do
  begin
    Item := lvStaff.Items[i];
    sImgFile := Item.SubItems[1];
    if not FileExists(sImgFile) then Continue;

    //gif图片不做处理
    if LowerCase(ExtractFileExt(sImgFile)) = '.gif' then
    begin
      if CopyFile(PAnsiChar(sImgFile), PAnsiChar(App.Path + 'photos\' + Item.Caption + '.gif'), True) then
        dmPer.ExecSQL('UPDATE [staffs] SET photoStr=''' + Item.Caption + '.gif'' WHERE staffNo=''' + Item.Caption + ''' AND staffName=''' + Item.SubItems[0] + '''');
    end
    else
    begin
      if DealImage(sImgFile) and CopyFile(PAnsiChar(App.TmpJpg), PAnsiChar(App.Path + 'photos\' + Item.Caption + '.jpg'), False) then
        dmPer.ExecSQL('UPDATE [staffs] SET photoStr=''' + Item.Caption + '.jpg'' WHERE staffNo=''' + Item.Caption + ''' AND staffName=''' + Item.SubItems[0] + '''');
    end;

    pb.Position := Round((i + 1) * 100 / lvStaff.Items.Count);
    Application.ProcessMessages;
  end;
  //重查询
  with dmPer do
  begin
    BookMark := aqStaff.GetBookmark;
    aqStaff.Requery();
    if aqStaff.BookmarkValid(BookMark) then
    begin
      aqStaff.GotoBookmark(BookMark);
      aqStaff.FreeBookmark(BookMark); 
    end;
  end;

  Log.Write(App.UserID + '批量从[' + bePath.Text + ']照入照片');
  MessageBox(Handle, '您所设定的员工照片已成功加入到数据库中。', '提示', MB_OK + MB_ICONINFORMATION)
end;

procedure TfrmImportP.LoadPhotos;
var
  sPath, sExt, sExts: string;
  Found: Integer;
  sr: TSearchRec;   
begin
  if Trim(bePath.Text) = '' then Exit;

  //先打开数据集以做查对
  with dmPer, lvStaff do
  begin
    OpenQuery(aqTemp, 'SELECT staffNo, staffName, staffPY, sex, deptName FROM [staffs]');
    if aqTEmp.Eof then Exit;

    lvStaff.Items.Clear;
    sPath := bePath.Text;
    if sPath[Length(sPath)] <> '\' then sPath := sPath + '\';
    sExts := '.jpg;.jpeg;.bmp;.png;.gif;.emf;.wmf';
    //遍历对比
    Found := FindFirst(sPath + '*.*', faAnyFile, sr);
    while Found = 0 do
    begin
      if sr.Attr <> faDirectory then
      begin
        sExt := LowerCase(ExtractFileExt(sr.Name));
        if (Pos(sExt, sExts) <> 0) and (aqTemp.Locate('staffNo', ChangeFileExt(sr.Name, ''), []) or aqTemp.Locate('staffName', ChangeFileExt(sr.Name, ''), []) or aqTemp.Locate('staffPY', ChangeFileExt(sr.Name, ''), [])) then
        begin
          with Items.Add do
          begin
            if aqTemp.FieldByName('sex').AsString = '男' then
              StateIndex := 4
            else StateIndex := 5;
            Caption := aqTemp.FieldByName('staffNo').AsString;
            SubItems.Append(aqTemp.FieldByName('staffName').AsString);
            SubItems.Append(sPath + sr.Name);
            SubItems.Append(aqTemp.FieldByName('deptName').AsString);
          end;
        end;
        Application.ProcessMessages;
      end;
      Found := FindNext(sr);
    end;
    FindClose(sr);
    if lvStaff.Items.Count <> 0 then
    begin
      if Self.Visible then lvStaff.SetFocus;
      lvStaff.Items[0].Selected := True;
    end;
  end;

  App.PhotoPath := bePath.Text;
  Caption := '照片批量导入 - 此目录下员工照片数：' + IntToStr(lvStaff.Items.Count);
end;

procedure TfrmImportP.bePathKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and DirectoryExists(bePath.Text) then LoadPhotos();
end;

procedure TfrmImportP.bePathEnter(Sender: TObject);
begin
  btnOk.Default := False;
end;

procedure TfrmImportP.bePathExit(Sender: TObject);
begin
  btnOk.Default := True;
end;

procedure TfrmImportP.bePathButtonClick(Sender: TObject);
var
  sDir: string;
begin
  if SelectDirectory(Handle, '请选择员工照片文件夹', bePath.Text, sDir) then
  begin
    bePath.Text := sDir;
    LoadPhotos();
  end;
end;

procedure TfrmImportP.lvStaffCustomDrawSubItem(Sender: TCustomListView;
  Item: TListItem; SubItem: Integer; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  if SubItem = 1 then
  begin
    if Item.StateIndex = 5 then
      Sender.Canvas.Font.Color := clRed
    else Sender.Canvas.Font.Color := clBlack;
  end
  else Sender.Canvas.Font.Color := clBlack;
end;

procedure TfrmImportP.lvStaffSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Item <> nil then
  begin
    if FileExists(Item.SubItems[1]) and (imgPhoto.Image <> Item.SubItems[1]) then imgPhoto.Image := Item.SubItems[1];
    lblNo.Caption := '工号：' + Item.Caption;
    lblName.Caption := '姓名：' + Item.SubItems[0];
    if Item.StateIndex = 4 then
      lblSex.Caption := '性别：男'
    else lblSex.Caption := '性别：女';
    lblDept.Caption := '部门：' + Item.SubItems[2];
  end;
  if lvStaff.ItemFocused <> nil then lvStaff.ItemFocused.Selected := True;
end;

procedure TfrmImportP.imgPhotoDblClick(Sender: TObject);
begin
  if FileExists(imgPhoto.Image) then ShowPhoto(Self, lvStaff.Selected.SubItems[0], imgPhoto.Image);
end;

end.
