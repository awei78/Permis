{******
  �� Ԫ��uGlobal.pas
  �� �ߣ�������
  �� �ڣ�2008-5-15
  ˵ �������õĳ���������
  �� �£�
******}

unit uGlobal;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, ComCtrls, Graphics, ExtCtrls,
  StdCtrls, Dialogs, Variants, Registry, ShellAPI, DB, ADODB, Grids, DBGrids, DBGridEh,
  jpeg, ActiveX, ComObj, DateUtils, FR_PTabl, FR_View, Printers, ExtDlgs, ShlObj,
  uData, uApp, uLog;

const
  APP_CAPTION      = 'CR���µ�������ϵͳ';
  AW_HOMEPAGE      = 'http://www.cr-soft.net';
  MAX_RECORD       = 25;
  VIEW_COLOR       = $00EFE7E7;
  HH_DISPLAY_TOPIC = $0000;
  ADMIN_TYPE:      array[0..2] of string = ('ϵͳ����Ա', '����Ա', '����û�');
  DLL_NAME         = 'AWData.dll';
  DATA_NAME        = 'pdata.mdb';   

  //��������ʾ����01��ʾ��Ӧ�����ػ�����ʾ
  //                1   5    10   15   20   25   30   35   40
  //FIELD_SET      = '01111001000010001000011110000000000001000000';  //44λ
  WM_STAFFCHANGE = WM_USER + 201;  //��������������ݸı�
  WM_INQUSTAFF   = WM_USER + 202;  //���������Ѵ��崫Ա���Ž��в�ѯ
  WM_DEPTCHANGE  = WM_USER + 203;  //���Žṹ�ı�
  WM_KINDCHANGE  = WM_USER + 204;  //���ṹ�ı�
  WM_FIELDCHANGE = WM_USER + 205;  //DBGrid�������Ƿ�ɼ��ı�
  WM_DATACOMPRESSED = WM_USER + 206;  //������ѹ��
  WM_DATARESTORE    = WM_USER + 207;  //�����ѻָ�

type
  //������ͣ�
  TLeaveType = (ltLeave, ltUnLeave, ltEdit);
  //�ڵ����ͣ��ޡ����š�ְ�񡢹��֡�ְ�ơ��Ա����塢������������ò���Ļ��̶ȡ�רҵ
  TNodeType = (ntNone, ntDept, ntDuty, ntType, ntTechnic, ntSex, ntFolk, ntMarriage,
    ntPolity, ntCulture, ntSpecial);
  //������Ϣ����
  TKindType = (ktDuty, ktType, ktTechnic, ktFolk, ktMarriage, ktPolity, ktCulture,
    ktSpecial, ktReason, ktBank, ktState, ktContType);
  //��������
  TActOper = (aoView, aoAdd, aoEdit, aoDulAdd);
  //ͼ������
  TChartType = (ctPie, ctBar, ctLine);
  //�춯��ѯ����
  TInquType = (itMove, itLeft, itBack);
  //����ͳ������
  TStatType = (stNew, stLeft, stBack, stMove);

var
  App: TApp;
  Log: TLog;

//�Ƿ���������
function GetCanAdd(AHandle: THandle): Boolean;
//����ͼƬ
function DealImage(const AImgFile: string; AMaxWidth: Integer = 640;
  AMaxHeight: Integer = 480): Boolean;
//��ñ������߶�
function GetCaptionHeight: Integer;
//��ȡ�ؼ����ڴ����Handle
function GetFormHandle(ACtrl: TWinControl): THandle;
//��ʾͼƬ
procedure ShowPhoto(AOwner: TComponent; const AStaName, AImgFile: string);
//�������ݼ�
procedure FilterData(ADataSet: TADOQuery; const AFilter: string);
//������ݵ���ΪExcel�ĵ�������Ҫ��װMicrosoft Excel
procedure DataToExcel(AGrid: TCustomControl; const AFileName: string);
//�����ͻ�ȡ���ֶ���
function GetFieldNameByKindType(const AKindType: TKindType): string;
//���ֶ�����ȡ������
function GetKindTypeByFieldName(const AFieldName: string): TKindType;
//ָ���ڵ��Ƿ�����ĳһ����ID
function GetNodeKind(ANode: TTreeNode): Integer;
//��ȡָ��NodeType��Ӧ��staffs��fieldNameֵ
function GetNodeField(const ANodeType: TNodeType): string; overload;
//ָ���ڵ��Ƿ�����ĳһ���͵Ľڵ�
function GetNodeType(ANode: TTreeNode): TNodeType;
//��ȡ���������ַ���
function GetDeptStr(ADeptNode: TTreeNode): string;
//�Ƿ��Žڵ�
function IsDeptNode(ANode: TTreeNode): Boolean;
//���������ڵ�
procedure DrawDept(ANode: TTreeNode; const GetDeptList: Boolean = True);
//����������ڵ�
procedure DrawKind(ANode: TTreeNode; AKindType: TKindType = ktDuty);
//DBGirdEh�п�����Ӧ
procedure AutoFitWidth(ADBGrid: TDBGridEh);
//DBGridEh��ͷ�������
procedure DBGridEhTitleBtnClick(Sender: TObject; ACol: Integer; Column: TColumnEh);
//��ӡDBGridGh
procedure PrintDBGridEh(ADBGridEh: TDBGridEh; const ATitle: string = '');
//��䲿��ComboBox
procedure FillDept(AComboBox: TCustomComboBox);
//������ComboBox
procedure FillKind(AComboBox: TCustomComboBox; AKindType: TKindType);
//�ַ����Ƿ�Ϊ����
function IsNumeric(const AValue: string): Boolean;
//��ȡ�ļ���С
function GetFileSize(const AFileName: string): Double;
//��ȡƴ������ĸ...��dll���ó���������Ϊ�䴦����ַ���PY_TABLE��Ӱ����¼��λ
function GetPYStr(const ACnStr: string): string;
//ϵͳ�Ƿ���Excel
function ExcelInstalled(AHandle: THandle): Boolean;
//ѡ��Ŀ¼
function SelectDirectory(Handle: HWND; const Caption, DefaultDir: string;
  out Directory: string): Boolean;
//���ע�����Ƿ���ȷ
function CheckRegCode(const AKey, ACode: string): Boolean; export; stdcall;
//ȡӢ������ĸ
function RecCount(const ARecordCount: Integer = 0): PAnsiChar; export; stdcall;
//���ð����ļ�
function HtmlHelp(hwd: THandle; pszFile: string; uCommand, dwData: Integer): Integer; stdcall;

implementation

uses DataExp;

function CheckRegCode; stdcall; external DLL_NAME name 'Autumn';
function RecCount; stdcall; external DLL_NAME name 'Wind';
function HtmlHelp; stdcall; external 'HHCtrl.ocx' name 'HtmlHelpA';

//...
function GetCanAdd(AHandle: THandle): Boolean;
begin
  Result := True;

  if App.RegType <> rtNone then
  begin
    with dmPer do
    begin
      OpenQuery(aqTemp, 'SELECT Count(id) AS recCount FROM [staffs]');
      if aqTemp.FieldByName('recCount').AsInteger >= MAX_RECORD then
      begin
        MessageBox(AHandle, PAnsiChar('δע���ֻ�����' + IntToStr(MAX_RECORD) + '����Ϣ�����Ѳ��������'), '��ʾ', MB_OK + MB_ICONINFORMATION);
        Result := False;
      end;
    end;
  end;
end;

function DealImage(const AImgFile: string; AMaxWidth, AMaxHeight: Integer): Boolean;
var
  pic: TPicture;
  bmp: TBitmap;
  jpg: TJPEGImage;
  fScale: Single;
  iWidth, iHeight: Integer;
begin
  Result := False;
  if not FileExists(AImgFile) then Exit;

  pic := TPicture.Create;
  bmp := TBitmap.Create;
  jpg := TJPEGImage.Create;
  Screen.Cursor := crHourGlass;
  try
    try
      pic.LoadFromFile(AImgFile);
      if (pic.Width > AMaxWidth) or (pic.Height > AMaxHeight) then
      begin
        fScale := AMaxHeight / AMaxWidth;

        if (pic.Height / pic.Width) > fScale then
        begin
          iWidth := Round(pic.Width * AMaxHeight / pic.Height);
          iHeight := AMaxHeight;
        end
        else
        begin
          iWidth := AMaxWidth;
          iHeight := Round(pic.Height * AMaxWidth / pic.Width);
        end;
      end
      else
      begin
        iWidth := pic.Width;
        iHeight := pic.Height;
      end;
      bmp.PixelFormat := pf24bit;
      bmp.Width := iWidth;
      bmp.Height := iHeight;
      bmp.Canvas.StretchDraw(Rect(0, 0, iWidth, iHeight), pic.Graphic);

      jpg.Assign(bmp);
      jpg.SaveToFile(App.TmpJpg);
      Result := True;
    except
      Result := False;
    end;
  finally
    pic.Free;
    bmp.Free;
    jpg.Free;
    Screen.Cursor := crDefault;
  end;
end;

function GetCaptionHeight: Integer;
begin
  Result := GetSystemMetrics(SM_CYCAPTION);
end;

function GetFormHandle(ACtrl: TWinControl): THandle;
var
  w: TWinControl;
begin
  w := ACtrl.Parent;
  while not (w is TForm) do
    w := w.Parent;
  Result := w.Handle;
end;

procedure ShowPhoto(AOwner: TComponent; const AStaName, AImgFile: string);
var
  Form: TForm;
  Panel: TPanel;
  Image: TImage;
  FrameWidth: Integer;
begin
  if not FileExists(AImgFile) then Exit;

  Form := TForm.Create(AOwner);
  try
    Form.Name := 'frmPhoto';
    Form.Caption := '��Ƭ - ' + AStaName;
    Form.BorderStyle := bsDialog;
    Form.Position := poOwnerFormCenter;

    //Ϊ��Ӧ����˳�
    with TButton.Create(Form) do
    begin
      Parent := Form;
      ModalResult := mrCancel;
      Cancel := True;
    end;

    //Ϊ��ס��ť���趨
    Panel := TPanel.Create(Form);
    Panel.Parent := Form;
    Panel.BevelOuter := bvLowered;
    Panel.AutoSize := True;
    Image := TImage.Create(Form);
    with Image do
    begin
      Parent := Panel;
      AutoSize := True;
      Center := True;
      Proportional := True;
      Picture.LoadFromFile(AImgFile);
    end;

    FrameWidth := Form.Width - Form.ClientWidth;
    Form.Width := Image.Width + FrameWidth;
    Form.Height := Image.Height + FrameWidth + GetCaptionHeight();
    if (Form.ClientWidth > 720) or (Form.ClientHeight > 540) then
    begin
      if Form.ClientWidth > 720 then Form.ClientWidth := 720;
      if Form.ClientHeight > 540 then Form.ClientHeight := 540;
      Image.AutoSize := False;
      Image.Stretch := True;
      if Image.Width > Form.ClientWidth then Image.Width := Form.ClientWidth;
      if Image.Height > Form.ClientHeight then Image.Height := Form.ClientHeight;
    end;
    Form.ShowModal();
  finally
    Form.Free;
  end;
end;

procedure FilterData(ADataSet: TADOQuery; const AFilter: string);
begin
  with ADataSet do
  begin
    if not Active or (AFilter = '') then Exit;

    Filtered := False;
    Filter := AFilter;
    Filtered := True;
  end;
end;

procedure DataToExcel(AGrid: TCustomControl; const AFileName: string);
var
  dte: TDataToExcel;
  sd: TSaveDialog;
  sFileName: string;
begin
  sd := TSaveDialog.Create(Application.MainForm);
  try
    sd.Title := '��Ҫ���������';
    sd.Filter := 'Microsoft Excel �ļ�(*.xls)|*.xls';
    sd.FileName := AFileName;
    sd.Options := sd.Options + [ofOverwritePrompt];

    if sd.Execute then
    begin
      if AGrid is TDBGrid then
        dte := TDataToExcel.Create(TDBGrid(AGrid))
      else dte := TDataToExcel.Create(TDBGridEh(AGrid));
      try
        sFileName := sd.FileName;
        if LowerCase(ExtractFileExt(sFileName)) <> '.xls' then ChangeFileExt(sFileName, '.xls');
        try
          dte.SaveToFile(sFileName);
          if MessageBox(GetFormHandle(AGrid), PAnsiChar('�����ѳɹ�������[' + sFileName + ']����Ҫ������'), '��ʾ', MB_YESNO + MB_ICONINFORMATION + MB_DEFBUTTON2) = ID_YES then
            ShellExecute(GetFormHandle(AGrid), 'open', PAnsiChar(sFileName), nil, nil, SW_NORMAL);
        except
          on E: Exception do
          begin
            Log.Write(App.UserID + '���ݵ���ʧ�ܣ���Ϣ��' + E.Message);
            MessageBox(GetFormHandle(AGrid), PAnsiChar('���ݵ���ʧ�ܣ���ϢΪ��' + E.Message), '��ʾ', MB_OK + MB_ICONWARNING);
          end;
        end;
      finally
        dte.Free;
      end;
    end;
  finally
    sd.Free;
  end;
end;

function GetFieldNameByKindType(const AKindType: TKindType): string;
begin
  case AKindType of
    ktDuty:     Result := 'duty';
    ktType:     Result := 'workKind';
    ktTechnic:  Result := 'technic';
    ktFolk:     Result := 'folk';
    ktMarriage: Result := 'marriage';
    ktPolity:   Result := 'politics';
    ktCulture:  Result := 'culture';
    ktSpecial:  Result := 'special';
    ktReason:   Result := 'leftReason';
    ktBank:     Result := 'bankName';
    ktState:    Result := 'workState';
    ktContType: Result := 'contType';
  else
    Result := 'duty';
  end;
end;

function GetKindTypeByFieldName(const AFieldName: string): TKindType;
begin
  if AFieldName = 'duty' then //ְ��
    Result := ktDuty
  else if AFieldName = 'workKind' then //����
    Result := ktType
  else if AFieldName = 'technic' then //ְ��
    Result := ktTechnic
  else if AFieldName = 'folk' then //����
    Result := ktFolk
  else if AFieldName = 'marriage' then //����״��
    Result := ktMarriage
  else if AFieldName = 'politics' then //������ò
    Result := ktPolity
  else if AFieldName = 'culture' then //ѧ��
    Result := ktCulture
  else if AFieldName = 'special' then //רҵ
    Result := ktSpecial
  else if AFieldName = 'bankName' then //��������
    Result := ktBank
  else Result := ktDuty;
end;

function GetNodeKind(ANode: TTreeNode): Integer;
var
  sl: TStrings;
begin
  Result := 0;
  if (ANode = nil) or (ANode.Level = 0) then Exit;

  while ANode.Level <> 1 do
    ANode := ANode.Parent;

  //��û�����ؽ��Ĺ��ܡ�Ϊʵ�ֽ����ʾ���ƣ��Ĺ��˴�����
  //Result := TNodeType(ANode.Index + 1)
  sl := TStringList.Create;
  try
    with sl, App.ViewSet do
    begin
      Append(DutyStr);
      Append(TypeStr);
      Append(TechnicStr);
      Append(FolkStr);
      Append(MarriageStr);
      Append(PolityStr);
      Append(CultureStr);
      Append(SpecialStr);
      Result := IndexOf(ANode.Text);
    end;
  finally
    sl.Free;
  end;
end;

function GetNodeField(const ANodeType: TNodeType): string;
begin
  case ANodeType of
    ntDuty:     Result := 'duty';
    ntType:     Result := 'workKind';
    ntTechnic:  Result := 'technic';
    ntSex:      Result := 'sex';
    ntFolk:     Result := 'folk';
    ntMarriage: Result := 'marriage';
    ntPolity:   Result := 'politics';
    ntCulture:  Result := 'culture';
    ntSpecial:  Result := 'special';
  else
    Result := 'deptName';
  end;
end;

function GetNodeType(ANode: TTreeNode): TNodeType;
begin
  Result := ntNone;
  if (ANode = nil) or (ANode.Level = 0) then Exit;

  while ANode.Level <> 1 do
    ANode := ANode.Parent;

  Result := TNodeType(Integer(ANode.Data) + 1);
end;

function GetDeptStr(ADeptNode: TTreeNode): string;
var
  pNode: TTreeNode;
begin
  Result := '';
  if ADeptNode = nil then Exit;

  Result := ADeptNode.Text;
  pNode := ADeptNode.Parent;
  while (pNode <> nil) and (pNode <> ADeptNode) and (pNode.Level > 0) and (pNode.Text <> App.ViewSet.DeptStr) do
  begin
    Result := pNode.Text + '/' + Result;
    pNode := pNode.Parent;
  end;
end;

function IsDeptNode(ANode: TTreeNode): Boolean;
begin
  Result := False;
  if (ANode = nil) or (ANode.Level = 0) then Exit;

  while ANode.Level >= 1 do
  begin
    if ANode.Text = App.ViewSet.DeptStr then
    begin
      Result := True;
      Exit;
    end;
    ANode := ANode.Parent;
  end;
end;

procedure DrawDept(ANode: TTreeNode; const GetDeptList: Boolean);
var
  tvDept: TTreeView;

  procedure RecurTree(AParNode: TTreeNode; ID: string);
  var
    aqDeptc: TADOQuery;
    i: Integer;
    pNode: TTreeNode;
    pId: string;
  begin
    aqDeptc := TADOQuery.Create(nil);
    try
      dmPer.OpenQuery(aqDeptc, 'SELECT id, deptName FROM [dept] WHERE parId=' + ID + ' ORDER BY sortNo');
      if aqDeptc.Eof then Exit;

      for i := 0 to aqDeptc.RecordCount - 1 do
      begin
        pId := aqDeptc.FieldByName('id').AsString;
        pNode := tvDept.Items.AddChildObject(AParNode, aqDeptc.FieldByName('deptName').AsString, PInteger(aqDeptc.FieldByName('id').AsInteger));
        RecurTree(pNode, pId);
        aqDeptc.Next;
      end;
    finally
      aqDeptc.Free;
    end;
  end;

  function GetFullStr(ADeptNode: TTreeNode): string;
  var
    pNode: TTreeNode;
  begin
    Result := '';
    if ADeptNode = nil then Exit;

    Result := ADeptNode.Text;
    pNode := ADeptNode.Parent;
    while (pNode <> nil) and (pNode <> ANode) do
    begin
      Result := pNode.Text + '/' + Result;
      pNode := pNode.Parent;
    end;
  end;

var
  pNode, Node: TTreeNode;
  i: Integer;
  pId: string;
begin
  if ANode = nil then Exit;

  //��ָ���ڵ��»����Žṹ��
  tvDept := TTreeView(ANode.TreeView);
  tvDept.Items.BeginUpdate;
  try
    ANode.DeleteChildren;
    if ANode.Parent <> nil then ANode.Parent.Text := App.Company.Name;

    with dmPer do
    begin
      //��������ӣ�ֻ���ش򿪲��ܶ���
      OpenDept();
      FilterData(aqDept, 'parId = 0');
      if aqDept.Eof then Exit;

      for i := 0 to aqDept.RecordCount - 1 do
      begin
        pId := aqDept.FieldByName('id').AsString;
        pNode := tvDept.Items.AddChildObject(ANode, aqDept.FieldByName('deptName').AsString, PInteger(aqDept.FieldByName('id').AsInteger));
        RecurTree(pNode, pId);
        aqDept.Next;
      end;
    end;
  finally
    //���䲻ִ�У���������ʾ
    tvDept.Items.EndUpdate;
  end;

  //���ɲ���ID�����ƶ�Ӧ�б�deptName
  if GetDeptList then
  begin
    App.DeptList.Clear;
    for i := 0 to tvDept.Items.Count - 1 do
    begin
      Node := tvDept.Items[i];
      if GetNodeType(Node) <> ntDept then Continue;

      if Assigned(Node.Data) then
        App.DeptList.Append(GetFullStr(Node));
    end;
  end;
end;

procedure DrawKind(ANode: TTreeNode; AKindType: TKindType = ktDuty);
var
  tvDict: TTreeView;
  i: Integer;
begin
  if ANode = nil then Exit;

  //��ָ���ڵ��»�����ṹ��
  tvDict := TTreeView(ANode.TreeView);
  ANode.DeleteChildren;

  with dmPer do
  begin
    OpenDict();
    FilterData(aqDict, 'kindType = ' + IntToStr(Ord(AKindType)));
    if aqDict.Eof then Exit;

    for i := 0 to aqDict.RecordCount - 1 do
    begin
      tvDict.Items.AddChildObject(ANode, aqDict.FieldByName('kindName').AsString, PInteger(aqDict.FieldByName('id').AsInteger));
      aqDict.Next;
    end;
  end;
end;

procedure AutoFitWidth(ADBGrid: TDBGridEh);
const
  CHAR_WIDTH = 54;                        //0
  ARR_COL_WIDTH: array[0..43] of Integer = (32, 65, 55, 36, 74, 36, 60, 60, 60, 72, //����֯����
                                            125, 76, 50, 100, 100, 72, 125, 125, 72, 72, //�Ǽ�����
                                            60, 125, 60, 60, 60, 60, 72, 72, 72, 72, //����
                                            120, 120, 120, 90, 90, 120, 90, 200, 60, 72, //QQ��
                                            64, 64, 64, 64);
var
  i, iColCount: Integer;
  arrWidth: array of Integer;
  aqData: TADOQuery;
  Canvas: TCanvas;
  ColFieldName, sValue: string;
  BookMark: TBookMark;
begin
  //��dgStaff�������Զ���Ӧ����ԭ���п�
  if not Assigned(Application.MainForm) then Exit;
  //������Ա���������
  if not App.GridSet.AutoFitStaffGrid and (ADBGrid.Parent.Name = 'tsData') and (ADBGrid.Name = 'dgStaff') then
  begin
    for i := 0 to ADBGrid.Columns.Count - 1 do
      ADBGrid.Columns[i].Width := ARR_COL_WIDTH[i];
    Exit;
  end;
  //�ӿ�����˴�
  if not Assigned(ADBGrid.DataSource) or not Assigned(ADBGrid.DataSource.DataSet)
    or not ADBGrid.DataSource.DataSet.Active then Exit;

  aqData := TADOQuery(ADBGrid.DataSource.DataSet);
  iColCount := ADBGrid.Columns.Count;
  SetLength(arrWidth, iColCount);
  Canvas := Application.MainForm.Canvas;

  //����Caption֮���
  for i := 0 to iColCount - 1 do
  begin
    if not ADBGrid.Columns[i].Visible then Continue;
    arrWidth[i] := Canvas.TextWidth(ADBGrid.Columns[i].Title.Caption);
  end;

  Screen.Cursor := crHourGlass;
  aqData.DisableControls;
  try
    BookMark := aqData.GetBookmark;
    aqData.First;
    while not aqData.Eof do
    begin
      for i := 0 to iColCount - 1 do
      begin
        if not ADBGrid.Columns[i].Visible then Continue;
        ColFieldName := ADBGrid.Columns[i].FieldName;
        sValue := aqData.FieldByName(ColFieldName).Text;
        //�������С��λ��������
        if IsNumeric(sValue) and (Pos('.', sValue) <> 0) then sValue := FormatFloat('0.##', StrToFloat(sValue));
        if arrWidth[i] < Canvas.TextWidth(sValue) then
          arrWidth[i] := Canvas.TextWidth(sValue);
      end;

      aqData.Next;
    end;
    if aqData.BookmarkValid(BookMark) then
    begin
      aqData.GotoBookmark(BookMark);
      aqData.FreeBookmark(BookMark);
    end
    else aqData.First;
  finally
    aqData.EnableControls;
    Screen.Cursor := crDefault;
  end;

  //��Ӧ��
  //if aqData.RecordCount > 0 then
    for i := 0 to iColCount - 1 do
    begin
      if not ADBGrid.Columns[i].Visible then Continue;
      if ((ADBGrid.Columns[i].FieldName = 'staffNo')and (ADBGrid.DataSource.DataSet.FindField('sex') <> nil)) or (ADBGrid.Columns[i].Field.FieldKind = fkLookup) then
        ADBGrid.Columns[i].Width := arrWidth[i] + 32
      else ADBGrid.Columns[i].Width := arrWidth[i] + 12;
    end;
end;

procedure DBGridEhTitleBtnClick(Sender: TObject; ACol: Integer; Column: TColumnEh);
var
  sSortStr: string;
begin
  if not Column.Field.DataSet.Active then Exit;
  if (Column.FieldName = '') or (Column.Field.FieldKind = fkCalculated) then Exit;

  with Column do
  begin
    case Title.SortMarker of
      smNoneEh:
      begin
        Title.SortMarker := smDownEh;
        sSortStr := StringReplace(Column.FieldName, '_l', '', []) + ' DESC';
      end;
      smDownEh:
      begin
       Title.SortMarker := smUpEh;
       sSortStr := StringReplace(Column.FieldName, '_l', '', []) + ' ASC';
      end;
      smUpEh:
      begin
        Title.SortMarker := smNoneEh;
        if Column.Field.DataSet.Fields.FindField('staffNo') <> nil then
          sSortStr := 'staffNo ASC'
        else if Column.Field.DataSet.Fields.FindField('id') <> nil then
          sSortStr := 'id ASC'
        else if Column.Field.DataSet.Fields.FindField('yearMonth') <> nil then
          sSortStr := 'yearMonth ASC';
      end;
    end;
  end;

  TCustomADODataSet(Column.Field.DataSet).Sort := sSortStr;
end;

procedure PrintDBGridEh(ADBGridEh: TDBGridEh; const ATitle: string);
var
  BookMark: TBookMark;
  dg: TDBGrid;
  i, iWidth: Integer;
  w: TWinControl;
  frpg: TfrPrintGrid;
begin
  //��Ϊִ�д�ӡ�����ݻ���������һ��
  ADBGridEh.DataSource.DataSet.DisableControls;
  BookMark := ADBGridEh.DataSource.DataSet.GetBookmark;
  dg := TDBGrid.Create(Application.MainForm);
  frpg := TfrPrintGrid.Create(Application.MainForm);
  try
    dg.DataSource := ADBGridEh.DataSource;
    dg.Columns.Clear;

    iWidth := 0;
    for i := 0 to ADBGridEh.Columns.Count - 1 do
    begin
      if not ADBGridEh.Columns[i].Visible then Continue;

      with dg.Columns.Add do
      begin
        Title.Caption := ADBGridEh.Columns[i].Title.Caption;
        FieldName := ADBGridEh.Columns[i].FieldName;
        Alignment := ADBGridEh.Columns[i].Alignment;
        Field.Alignment := ALignment;
        Width := ADBGridEh.Columns[i].Width + 2;
        iWidth := iWidth + ADBGridEh.Columns[i].Width;
      end;
    end;

    with frpg do
    begin
      Title.Text := ATitle;
      AutoWidth := ADBGridEh.Name = 'dgStaff';
      DBGrid := dg;
      Header.Font.Size := 9;
      Header.Font.Color := clWindowText;
      Header.Color := $00D5D5D5;
      Header.Font.Style := [];
      Body.Font.Size := 9;
      if iWidth > 706 then Orientation := poLandscape;
      PreviewButtons := [pbZoom, pbPrint, pbFind, pbExit];
    end;
    if App.ParamSet.DoPrint then
    begin
      w := ADBGridEh.Parent;
      while not (w is TForm) do
        w := w.Parent;
      if Printer.Printers.Count = 0 then
      begin
        MessageBox(w.Handle, '����ϵͳ��û�п��õĴ�ӡ�����밲װ��ӡ����', '��ʾ', MB_OK + MB_ICONINFORMATION);
        Exit;
      end;

      frpg.Report.PrepareReport;
      frpg.Report.PrintPreparedReportDlg;
    end
    else frpg.ShowReport;
    if TCustomADODataSet(ADBGridEh.DataSource.DataSet).BookmarkValid(BookMark) then
    begin
      ADBGridEh.DataSource.DataSet.GotoBookmark(BookMark);
      ADBGridEh.DataSource.DataSet.FreeBookmark(BookMark);
    end;
  finally
    dg.Free;
    frpg.Free;
    ADBGridEh.DataSource.DataSet.EnableControls;
  end;
end;

procedure FillDept(AComboBox: TCustomComboBox);
var
  i: Integer;
begin
  if App.DeptList.Count = 0 then Exit;

  AComboBox.Clear;
  for i := 0 to App.DeptList.Count - 1 do
    AComboBox.Items.Append(App.DeptList[i]);
end;

procedure FillKind(AComboBox: TCustomComboBox; AKindType: TKindType);
var
  aqDict: TADOQuery;
begin
  dmPer.OpenDict();
  aqDict := dmPer.aqDict;

  FilterData(aqDict, 'kindType=' + IntToStr(Ord(AKindType)));
  if not aqDict.Eof then AComboBox.Clear;
  while not aqDict.Eof do
  begin
    AComboBox.Items.Append(aqDict.FieldByName('kindName').AsString);
    aqDict.Next;
  end;
  if AComboBox.Items.Count <> 0 then AComboBox.ItemIndex := 0;
end;

{$HINTS OFF}
function IsNumeric(const AValue: string): Boolean;
var
  Num: Double;
  Code: Integer;
begin
  Val(AValue, Num, Code);
  Result := Code = 0;
end;
{$HINTS ON}

function GetFileSize(const AFileName: string): Double;
var
  sr: TSearchRec;
begin
  if FindFirst(AFileName, faAnyFile, sr) = 0 then
    Result :=  sr.Size / 1024
  else Result := 0;

  FindClose(sr);
end;

function GetPYStr(const ACnStr: string): string;
const
  PY_TABLE = 'CJWGNSPGCGNE[Y[BTYYZDXYKYGT[JNNJQMBSGZSCYJSYY[PGKBZGY[YWJKGKLJYWKPJQHY[W[DZLSGMRYPYWWCCKZNKYYGTTNJJNYKKZYTCJNMCYLQLYPYQFQRPZSLWBTGKJFYXJWZLTBNCXJJJJTXDTTSQZYCDXXHGCK[PHFFSS[YBGXLPPBYLL[HLXS[ZM[JHSOJNGHDZQYKLGJHSGQZHXQGKEZZWYSCSCJXYEYXADZPMDSSMZJ' +
    'ZQJYZC[J[WQJBYZPXGZNZCPWHKXHQKMWFBPBYDTJZZKQHYLYGXFPTYJYYZPSZLFCHMQSHGMXXSXJ[[DCSBBQBEFSJYHXWGZKPYLQBGLDLCCTNMAYDDKSSNGYCSGXLYZAYBNPTSDKDYLHGYMYLCXPY[JNDQJWXQXFYYFJLEJPZRXCCQWQQSBNKYMGPLBMJRQCFLNYMYQMSQYRBCJTHZTQFRXQHXMJJCJLXQGJMSHZKBSWYEMYLTXFS' +
    'YDSWLYCJQXSJNQBSCTYHBFTDCYZDJWYGHQFRXWCKQKXEBPTLPXJZSRMEBWHJLBJSLYYSMDXLCLQKXLHXJRZJMFQHXHWYWSBHTRXXGLHQHFNM[YKLDYXZPYLGG[MTCFPAJJZYLJTYANJGBJPLQGDZYQYAXBKYSECJSZNSLYZHSXLZCGHPXZHZNYTDSBCJKDLZAYFMYDLEBBGQYZKXGLDNDNYSKJSHDLYXBCGHXYPKDJMMZNGMMCLGW' +
    'ZSZXZJFZNMLZZTHCSYDBDLLSCDDNLKJYKJSYCJLKWHQASDKNHCSGANHDAASHTCPLCPQYBSDMPJLPZJOQLCDHJJYSPRCHN[NNLHLYYQYHWZPTCZGWWMZFFJQQQQYXACLBHKDJXDGMMYDJXZLLSYGXGKJRYWZWYCLZMSSJZLDBYD[FCXYHLXCHYZJQ[[QAGMNYXPFRKSSBJLYXYSYGLNSCMHZWWMNZJJLXXHCHSY[[TTXRYCYXBYHCS' +
    'MXJSZNPWGPXXTAYBGAJCXLY[DCCWZOCWKCCSBNHCPDYZNFCYYTYCKXKYBSQKKYTQQXFCWCHCYKELZQBSQYJQCCLMTHSYWHMKTLKJLYCXWHEQQHTQH[PQ[QSCFYMNDMGBWHWLGSLLYSDLMLXPTHMJHWLJZYHZJXHTXJLHXRSWLWZJCBXMHZQXSDZPMGFCSGLSXYMJSHXPJXWMYQKSMYPLRTHBXFTPMHYXLCHLHLZYLXGSSSSTCLSLD' +
    'CLRPBHZHXYYFHB[GDMYCNQQWLQHJJ[YWJZYEJJDHPBLQXTQKWHLCHQXAGTLXLJXMSL[HTZKZJECXJCJNMFBY[SFYWYBJZGNYSDZSQYRSLJPCLPWXSDWEJBJCBCNAYTWGMPAPCLYQPCLZXSBNMSGGFNZJJBZSFZYNDXHPLQKZCZWALSBCCJX[YZGWKYPSGXFZFCDKHJGXDLQFSGDSLQWZKXTMHSBGZMJZRGLYJBPMLMSXLZJQQHZYJ' +
    'CZYDJWBMYKLDDPMJEGXYHYLXHLQYQHKYCWCJMYYXNATJHYCCXZPCQLBZWWYTWBQCMLPMYRJCCCXFPZNZZLJPLXXYZTZLGDLDCKLYRZZGQTGJHHGJLJAXFGFJZSLCFDQZLCLGJDJCSNZLLJPJQDCCLCJXMYZFTSXGCGSBRZXJQQCTZHGYQTJQQLZXJYLYLBCYAMCSTYLPDJBYREGKLZYZHLYSZQLZNWCZCLLWJQJJJKDGJZOLBBZPP' +
    'GLGHTGZXYGHZMYCNQSYCYHBHGXKAMTXYXNBSKYZZGJZLQJDFCJXDYGJQJJPMGWGJJJPKQSBGBMMCJSSCLPQPDXCDYYKY[CJDDYYGYWRHJRTGZNYQLDKLJSZZGZQZJGDYKSHPZMTLCPWNJAFYZDJCNMWESCYGLBTZCGMSSLLYXQSXSBSJSBBSGGHFJLYPMZJNLYYWDQSHZXTYYWHMZYHYWDBXBTLMSYYYFSXJC[DXXLHJHF[SXZQHF' +
    'ZMZCZTQCXZXRTTDJHNNYZQQMNQDMMG[YDXMJGDHCDYZBFFALLZTDLTFXMXQZDNGWQDBDCZJDXBZGSQQDDJCMBKZFFXMKDMDSYYSZCMLJDSYNSBRSKMKMPCKLGDBQTFZSWTFGGLYPLLJZHGJ[GYPZLTCSMCNBTJBQFKTHBYZGKPBBYMTDSSXTBNPDKLEYCJNYDDYKZDDHQHSDZSCTARLLTKZLGECLLKJLQJAQNBDKKGHPJTZQKSECS' +
    'HALQFMMGJNLYJBBTMLYZXDCJPLDLPCQDHZYCBZSCZBZMSLJFLKRZJSNFRGJHXPDHYJYBZGDLQCSEZGXLBLGYXTWMABCHECMWYJYZLLJJYHLG[DJLSLYGKDZPZXJYYZLWCXSZFGWYYDLYHCLJSCMBJHBLYZLYCBLYDPDQYSXQZBYTDKYXJY[CNRJMPDJGKLCLJBCTBJDDBBLBLCZQRPPXJCJLZCSHLTOLJNMDDDLNGKAQHQHJGYKHE' +
    'ZNMSHRP[QQJCHGMFPRXHJGDYCHGHLYRZQLCYQJNZSQTKQJYMSZSWLCFQQQXYFGGYPTQWLMCRNFKKFSYYLQBMQAMMMYXCTPSHCPTXXZZSMPHPSHMCLMLDQFYQXSZYYDYJZZHQPDSZGLSTJBCKBXYQZJSGPSXQZQZRQTBDKYXZKHHGFLBCSMDLDGDZDBLZYYCXNNCSYBZBFGLZZXSWMSCCMQNJQSBDQSJTXXMBLTXZCLZSHZCXRQJGJ' +
    'YLXZFJPHYMZQQYDFQJJLZZNZJCDGZYGCTXMZYSCTLKPHTXHTLBJXJLXSCDQXCBBTJFQZFSLTJBTKQBXXJJLJCHCZDBZJDCZJDCPRNPQCJPFCZLCLZXZDMXMPHJSGZGSZZQLYLWTJPFSYASMCJBTZKYCWMYTCSJJLJCQLWZMALBXYFBPNLSFHTGJWEJJXXGLLJSTGSHJQLZFKCGNNNSZFDEQFHBSAQTGYLBXMMYGSZLDYDQMJJRGBJ' +
    'TKGDHGKBLQKBDMBYLXWCXYTTYBKMRTJZXQJBHLMHMJJZMQASLDCYXYQDLQCAFYWYXQHZ';
var
  i, H, L, W: Integer;
  sPyStr: string;
begin
  sPYStr := '';
  i := 1;
  while i <= Length(ACnStr) do
  begin
    if Ord(ACnStr[i]) <= $7F then
    begin
      sPYStr := sPYStr + ACnStr[i];
      Inc(i);
      Continue;
    end;

    H := Word(ACnStr[i]);
    L := Word(ACnStr[i + 1]);
    W := (H - 160) * 100 + L - 160;
    if (W > 1600) and (W < 5590) then
    begin
      case W of
        1601..1636: sPYStr := sPYStr + 'A';
        1637..1832: sPYStr := sPYStr + 'B';
        1833..2077: sPYStr := sPYStr + 'C';
        2078..2273: sPYStr := sPYStr + 'D';
        2274..2301: sPYStr := sPYStr + 'E';
        2302..2432: sPYStr := sPYStr + 'F';
        2433..2593: sPYStr := sPYStr + 'G';
        2594..2786: sPYStr := sPYStr + 'H';
        2787..3105: sPYStr := sPYStr + 'J';
        3106..3211: sPYStr := sPYStr + 'K';
        3212..3471: sPYStr := sPYStr + 'L';
        3472..3634: sPYStr := sPYStr + 'M';
        3635..3721: sPYStr := sPYStr + 'N';
        3722..3729: sPYStr := sPYStr + 'O';
        3730..3857: sPYStr := sPYStr + 'P';
        3858..4026: sPYStr := sPYStr + 'Q';
        4027..4085: sPYStr := sPYStr + 'R';
        4086..4389: sPYStr := sPYStr + 'S';
        4390..4557: sPYStr := sPYStr + 'T';
        4558..4683: sPYStr := sPYStr + 'W';
        4684..4924: sPYStr := sPYStr + 'X';
        4925..5248: sPYStr := sPYStr + 'Y';
        5249..5589: sPYStr := sPYStr + 'Z';
      end;
    end
    else
    begin
      W := (H - 160 - 56) * 94 + L - 160;
      if (W >= 1) and (W <= 3008) then sPYStr := sPYStr + PY_TABLE[W];
    end;

    Inc(i, 2);
  end;
  Result := LowerCase(StringReplace(sPYStr, ' ', '', [rfReplaceAll]));
end;

function ExcelInstalled(AHandle: THandle): Boolean;
var
  v: OleVariant;
begin
  Result := False;
  try
    v := CreateOleObject('Excel.Application');
    v.Quit;
    v := Unassigned;
  except
    MessageBox(AHandle, PAnsiChar('û�м�⵽���ļ�����а�װMicrosoft Excel�����ݲ��ܱ�����'), '��ʾ', MB_OK + MB_ICONWARNING);
    Exit;
  end;

  Result := True;
end;

function SelectDirectory(Handle: HWND; const Caption, DefaultDir: string;
  out Directory: string): Boolean;

  function BrowseCallBackProc(Wnd: HWND; uMsg: UINT; lParam, lpData: LPARAM): Integer stdcall;
  begin
    if uMsg = BFFM_INITIALIZED then
      Result := SendMessage(Wnd, BFFM_SETSELECTION, Ord(TRUE), lpData)
    else Result := 1;
  end;

var
  bi: _browseinfoA;
  pid: PItemIDList;
  buf: array[0..MAX_PATH - 1] of Char;
begin
  Directory := DefaultDir;
  FillChar(bi, SizeOf(BROWSEINFO), 0);
  bi.hWndOwner := Handle;
  bi.iImage := 0;
  bi.lParam := 1;
  bi.lpfn := nil;
  bi.lpszTitle := PAnsiChar(Caption);
  bi.ulFlags := BIF_RETURNONLYFSDIRS;
  bi.lpfn := @BrowseCallBackProc;
  bi.lParam := Integer(PAnsiChar(DefaultDir));
  pid := SHBrowseForFolder(bi);
  Result := pid <> nil;
  if Result and SHGetPathFromIDList(pid, buf) then
  begin
    Directory := StrPas(buf);
    if Directory[Length(Directory)] <> '\' then Directory := Directory + '\';
  end;
end;

initialization
  App := TApp.Create;
  Log := TLog.Create;
finalization
  Log.Free;
  App.Free;

end.
