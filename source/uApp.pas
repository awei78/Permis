{
  �ļ�����uApp.pas
  ˵  ����ϵͳ������
  ��д�ˣ�������
  ��  �ڣ�2008-05-16
  ��  �£�
}

unit uApp;

interface

uses
  Windows, SysUtils, Classes, Forms, IniFiles, Registry, Graphics, DateUtils;

const
  APP_CAPTION     = '������µ�������ϵͳ';
  FIELD_VISIBLE   = '0111100100001000100001111000000001000000';  //40λ
  INI_FILE        = 'config.ini';
  PERMIS_KEY_NAME = 'Software\APermis';

type
  TRegType = (rtNone, rtUnReged);
  //��˾��Ϣ
  TCompany = class;
  //������������
  TParamSet = class;

  //ͼ������
  TChartType = (ctPie, ctBar, ctLine);
  //���沼����ʾѡ��
  TViewMode = record
    ShowTree: Boolean;
    ShowPhoto: Boolean;
    ShowTool: Boolean;
  end;
  //������ʾ
  TViewSet = record
    ShowDept: Boolean;
    ShowDuty: Boolean;
    ShowType: Boolean;
    ShowTechnic: Boolean;
    ShowSex: Boolean;
    ShowFolk: Boolean;
    ShowMarriage: Boolean;
    ShowPolity: Boolean;
    ShowCulture: Boolean;
    ShowSpecial: Boolean;
    DeptStr: string;
    DutyStr: string;
    TypeStr: string;
    TechnicStr: string;
    SexStr: string;
    FolkStr: string;
    MarriageStr: string;
    PolityStr: string;
    CultureStr: string;
    SpecialStr: string;
    BankStr: string;
    RegerStr: string;
  end;
  //ͼ�����
  TChartSet = record
    ChartType: TChartType;
    View3D: Boolean;
  end;
  //��ӡ�ֶ�����
  TPrintSet = record
    PrintBase: Boolean;
    PrintDept: Boolean;
    PrintContact: Boolean;
    PrintSelf: Boolean;
    PrintFami: Boolean;
    PrintExper: Boolean;
    PrintAP: Boolean;
    PrintTrain: Boolean;
    PrintMove: Boolean;
    PrintOther: Boolean;
  end;
  //���ݳ�ʼ������
  TInitSet = record
    InitAdmin: Boolean;
    InitDept: Boolean;
    InitKind: Boolean;
    InitStaffs: Boolean;
    InitAP: Boolean;
    InitTrain: Boolean;
    InitLeave: Boolean;
    InitMove: Boolean;
    InitLeft: Boolean;
    InitBack: Boolean;
    InitCont: Boolean;
    InitDiary: Boolean;
    InitAddr: Boolean;
  end;       
  //�����ʾ����
  TGridSet = record
    Fields: TStrings;
    FieldLabels: TStrings;
    Indexes: TStrings;
    FieldVisibles: string;
    AutoFitStaffGrid: Boolean;
    DateFormat: string;
  end;
  //����Ա����
  TAdminType = (atSystem, atGeneral, atViewer);

  TApp = class
  private
    FCaption: string;
    FPath: string;
    FBackPath: string;
    FDataPath: string;
    FPhotoPath: string;
    FTmpPath: string;
    FTmpPhotoPath: string;
    FTmpJpg: string;
    FExeName: string;
    FIniFile: TIniFile;
    //��¼����һ�꣬Ϊ��߼������估�������ն�����...Ϊ���һЩ����β���⣬2010-03-14��Ϊÿ���ж�һ��
    FLastDate: string;
    //��¼���
    FUserID: string;
    FUserPwd: string;
    FAdminType: TAdminType;

    FDeptList: TStrings;
    //��˾��Ϣ
    FCompany: TCompany;
    FParamSet: TParamSet;

    //��ʾ���
    FWindowState: TWindowState;
    FViewMode: TViewMode;
    FViewSet: TViewSet;
    //����ʾ����
    FGridSet: TGridSet;
    //��¼��ְ״̬Index
    FStateIndex: Integer;
    //�Ƿ������༭
    FKeepEdit: Boolean;
    //�Ƿ񲻵��빤����ͬ�ļ�¼
    FNoImpSameStaNo: Boolean;
    FNoImpSameContNo: Boolean;
    FChartSet: TChartSet;
    //��ӡ����
    FPrintSet: TPrintSet;
    FInitSet: TInitSet;

    //ע����Ϣ
    FRegMail: string;
    FRegCode: string;
    function GetVersion: string;
    function GetRegType: TRegType;
    procedure GetRegInfo;
    procedure SaveRegInfo;
    procedure LoadFromIni;
    //��ʼ��������
    procedure FillFields(AFields, ALabels: TStrings);
    procedure FillIndexes(AIndexes: TStrings);
  public
    constructor Create;
    destructor Destroy; override;

    procedure SaveToIni;
    procedure BackupData;
    //�������ʾ����ʾ������������ȡ�����
    procedure GetTreeList;
    procedure InitKindCaptions;

    property Caption: string read FCaption;
    property Path: string read FPath;
    property BackPath: string read FBackPath write FBackPath;
    property DataPath: string read FDataPath;
    property PhotoPath: string read FPhotoPath write FPhotoPath;
    property TmpPath: string read FTmpPath;
    property TmpPhotoPath: string read FTmpPhotoPath;
    property TmpJpg: string read FTmpJpg;
    property ExeName: string read FExeName;
    property Version: string read GetVersion;
    property LastDate: string read FLastDate write FLastDate;

    property UserID: string read FUserID write FUserID;
    property UserPwd: string read FUserPwd write FUserPwd;
    property AdminType: TAdminType read FAdminType write FAdminType;
    //ע������
    property RegType: TRegType read GetRegType;

    //��¼����ID�����Ӧ����
    property DeptList: TStrings read FDeptList write FDeptList;
    //����б�
    property Company: TCompany read FCompany write FCompany;
    property ParamSet: TParamSet read FParamSet write FParamSet;

    property WindowState: TWindowState read FWindowState write FWindowState;
    property ViewMode: TViewMode read FViewMode write FViewMode;
    property ViewSet: TViewSet read FViewSet write FViewSet;
    property GridSet: TGridSet read FGridSet write FGridSet;
    property StateIndex: Integer read FStateIndex write FStateIndex;
    property KeepEdit: Boolean read FKeepEdit write FKeepEdit;
    property NoImpSameStaNo: Boolean read FNoImpSameStaNo write FNoImpSameStaNo;
    property NoImpSameContNo: Boolean read FNoImpSameContNo write FNoImpSameContNo;

    property ChartSet: TChartSet read FChartSet write FChartSet;
    property PrintSet: TPrintSet read FPrintSet write FPrintSet;
    property InitSet: TInitSet read FInitSet write FInitSet;

    property RegMail: string read FRegMail write FRegMail;
    property RegCode: string read FRegCode write FRegCode;
  end;

  //��λ��Ϣ��
  TCompany = class
  private
    FName: string;
    FLinkMan: string;
    FLawMan: string;
    FAddress: string;
    FPostCode: string;
    FTel: string;
    FHomePage: string;
    FEMail: string;
    FDescription: string;

    FIniFile: TIniFile;
    //��ע������
    procedure LoadFromIni;
  public
    constructor Create;
    destructor Destroy; override;

    //���浽ע���
    procedure SaveToIni;
    //����
    property Name: string read FName write FName;
    property LinkMan: string read FLinkMan write FLinkMan;
    property LawMan: string read FLawMan write FLawMan;
    property Address: string read FAddress write FAddress;
    property PostCode: string read FPostCode write FPostCode;
    property Tel: string read FTel write FTel;
    property HomePage: string read FHomePage write FHomePage;
    property EMail: string read FEMail write FEMail;
    property Description: string read FDescription write FDescription;
  end;

  //������������...
  //��������
  TAwakeSet = record
    Enabled: Boolean;
    BirthDay: Integer;
    BirthGreg: Boolean;
    ContractDay: Integer;
    StaffDay: Integer;
  end;
  //����ͼƬ
  TLayout = (loCenter, loNone, loTile);
  TBackImage = record
    Enabled : Boolean;
    FileName : string;
    Layout: TLayout;
    Stretch: Boolean;
    KeepScale: Boolean;
    BGColor: TColor;
    NeedPwd: Boolean;
  end;
  //���ݱ���
  TBackType = (btDay, btWeek, btMonth);
  TDataBack = record
    Enabled: Boolean;
    BackType: TBackType;
    WeekIndex: Integer;
    DayIndex: Integer;
    DataPath: string;
  end;

  TParamSet = class
  private
    //��������...
    FDblEdit: Boolean;
    FDoPrint: Boolean;
    FEscClose: Boolean;
    FAutoCode: Boolean;
    FPrefix: string;
    FLeftCanEdit: Boolean;
    //������ʾ������Ա��
    FLightLeave: Boolean;
    FLeaveColor: TColor;
    //������Ч��
    FEffLine: Boolean;
    FEffColor: TColor;

    //��������
    FAwakeSet: TAwakeSet;
    //����ͼƬ
    FBackImage: TBackImage;
    //���ݱ���
    FDataBack: TDataBack;

    FPageIndex: Integer;
    FIniFile: TIniFile;
    //��ע������
    procedure LoadFromIni;
  public
    constructor Create;
    destructor Destroy; override;

    //���浽ע���
    procedure SaveToIni;
    //����
    property DblEdit: Boolean read FDblEdit write FDblEdit;
    property DoPrint: Boolean read FDoPrint write FDoPrint;
    property EscClose: Boolean read FEscClose write FEscClose;
    property AutoCode: Boolean read FAutoCode write FAutoCode;
    property Prefix: string read FPrefix write FPrefix;
    property LeftCanEdit: Boolean read FLeftCanEdit write FLeftCanEdit;
    property LightLeave: Boolean read FLightLeave write FLightLeave;
    property LeaveColor: TColor read FLeaveColor write FLeaveColor;
    property EffLine: Boolean read FEffLine write FEffLine;
    property EffColor: TColor read FEffColor write FEffColor;

    property AwakeSet: TAwakeSet read FAwakeSet write FAwakeSet;
    property BackImage: TBackImage read FBackImage write FBackImage;
    property DataBack: TDataBack read FDataBack write FDataBack;

    property PageIndex: Integer read FPageIndex write FPageIndex;
  end;

implementation

uses uData, uGlobal;   

{ TApp }

constructor TApp.Create;
begin
  FCaption := APP_CAPTION;
  FPath := ExtractFilePath(Application.ExeName);
  FBackPath := FPath + 'backup\';
  FDataPath := FPath + DATA_NAME;
  if not DirectoryExists(FBackPath) then ForceDirectories(FBackPath);
  FBackPath := FBackPath + 'data_' + FormatDateTime('yyyymmdd.bak', Date());
  FTmpPath := FPath + 'temp\';
  if not DirectoryExists(FTmpPath) then ForceDirectories(FTmpPath);
  FTmpPhotoPath := FPath + 'tempPhoto\';
  if not DirectoryExists(FTmpPhotoPath) then ForceDirectories(FTmpPhotoPath);
  FTmpJpg := FTmpPath + 'tmp.jpg';
  FExeName := Application.ExeName;

  FDeptList := TStringList.Create;
  FCompany := TCompany.Create;
  FParamSet := TParamSet.Create;

  with FGridSet do
  begin
    Fields := TStringList.Create;
    FieldLabels := TStringList.Create;
    FillFields(Fields, FieldLabels);
    Indexes := TStringList.Create;
    FillIndexes(Indexes);
  end;

  FIniFile := TIniFile.Create(FPath + INI_FILE);
  LoadFromIni();
  GetRegInfo();
end;

destructor TApp.Destroy;
begin
  SaveToIni();
  SaveRegInfo();

  FDeptList.Free;
  FCompany.Free;
  FIniFile.Free;
  case Win32PlatForm of
    VER_PLATFORM_WIN32_WINDOWS:  //win9x����ϵͳ
    begin
      WinExec(PAnsiChar('command.exe /c rmdir /s/q "' + FTmpPath + '"'), SW_HIDE);
      WinExec(PAnsiChar('command.exe /c rmdir /s/q "' + FTmpPhotoPath + '"'), SW_HIDE);
    end
  else  //win2k/xp/2003����ϵͳ
    WinExec(PAnsiChar('cmd.exe /c rmdir /s/q "' + FTmpPath + '"'), SW_HIDE);
    WinExec(PAnsiChar('cmd.exe /c rmdir /s/q "' + FTmpPhotoPath + '"'), SW_HIDE);
  end;

  //����ini�ļ���ʽ
  with TMemIniFile.Create(FPath + INI_FILE) do
  try
    UpdateFile();
  finally
    Free;
  end;
  
  inherited Destroy;
end;

procedure TApp.FillFields(AFields, ALabels: TStrings);
var
  i: Integer;
begin
  with AFields do
  begin
    Append('no=���');
    Append('staffNo=����');
    Append('staffName=����');
    Append('sex=�Ա�');
    Append('birth=��������');
    Append('age=����');
    Append('folk=����');
    Append('marriage=����״��');
    Append('politics=������ò');
    Append('inPartyDate=����֯����');
    Append('idCardNo=���֤��');
    Append('inWorkDate=�μӹ���ʱ��');
    Append('culture=ѧ��');
    Append('school=��ҵԺУ');
    Append('special=רҵ');
    Append('graduateDate=��ҵ����');
    Append('nativePlace=����');
    Append('npAddr=������ַ');
    Append('recordNo=�������');
    Append('regDate=�Ǽ�����');
    Append('reger=�Ǽ���');
    Append('deptName=����');
    Append('duty=ְ��');
    Append('workKind=����');
    Append('technic=ְ��');
    Append('workState=��ְ״̬');
    Append('inDutyDate=��ְ����');
    Append('toStaffDate=ת������');
    Append('leftDate=��ְ����');
    Append('bankName=��������');
    Append('payNo=�����˺�');
    Append('annuityNo=���ϱ����ʺ�');
    Append('medicareNo=ҽ�Ʊ����ʺ�');
    Append('mobile=�ֻ�');
    Append('tel=�绰');
    Append('email=E-Mail');
    Append('cityTel=С��ͨ');
    Append('postAddr=ͨ�ŵ�ַ');
    Append('postCode=�ʱ�');
    Append('qqCode=QQ��');
  end;

  for i := 0 to AFields.Count - 1 do
    ALabels.Append(AFields.ValueFromIndex[i]);

  InitKindCaptions();
end;

procedure TApp.FillIndexes(AIndexes: TStrings);
var
  i: Integer;
begin
  for i := 0 to 40 do
    AIndexes.Append(IntToStr(i));
end;

function TApp.GetVersion: string;
var
  InfoSize, Wnd: DWORD;
  VerBuf: Pointer;
  szName: array[0..MAX_PATH - 1] of Char;
  Value: Pointer;
  Len: UINT;
  TransString: string;
begin
  InfoSize := GetFileVersionInfoSize(PChar(FExeName), Wnd);
  if InfoSize <> 0 then
  begin
    GetMem(VerBuf, InfoSize);
    try
      if GetFileVersionInfo(PChar(FExeName), Wnd, InfoSize, VerBuf) then
      begin
        Value :=nil;
        VerQueryValue(VerBuf, '\VarFileInfo\Translation', Value, Len);
        if Value <> nil then TransString := IntToHex(MakeLong(HiWord(Longint(Value^)), LoWord(Longint(Value^))), 8);
        Result := '';
        StrPCopy(szName, '\StringFileInfo\' + Transstring + '\FileVersion');  //ProductVersion: ��Ʒ�汾
        if VerQueryValue(VerBuf, szName, Value, Len) then Result := StrPas(PChar(Value));
      end;
    finally
      FreeMem(VerBuf);
    end;
  end;
end;

function TApp.GetRegType: TRegType;
begin
{$IFDEF _TRIAL}
  Result := rtTrial;
{$ELSE}
  if CheckRegCode(FRegMail, FRegCode) then
    Result := rtNone
  else Result := rtUnReged;
{$ENDIF}
end;

procedure TApp.GetRegInfo;
begin
  with TRegistry.Create do
  try
    RootKey := HKEY_CURRENT_USER;
    if not KeyExists(PERMIS_KEY_NAME) then Exit;

    OpenKey(PERMIS_KEY_NAME, False);
  {$IFDEF _TRIAL}
    if ValueExists('RegMail') then DeleteValue('RegMail');
    if ValueExists('RegCode') then DeleteValue('RegCode');
  {$ELSE}
    if ValueExists('RegMail') then FRegMail := ReadString('RegMail');
    if ValueExists('RegCode') then FRegCode := ReadString('RegCode');
  {$ENDIF}
    CloseKey();
  finally
    Free;
  end;
end;

procedure TApp.SaveRegInfo;
begin
  with TRegistry.Create do
  try
    RootKey := HKEY_CURRENT_USER;
    if not OpenKey(PERMIS_KEY_NAME, True) then Exit;

{$IFNDEF _TRIAL}
    WriteString('RegMail', FRegMail);
    WriteString('RegCode', FRegCode);
{$ENDIF}
    CloseKey();
  finally
    Free;
  end;
end;

procedure TApp.InitKindCaptions;
begin
  with FViewSet, FGridSet do
  begin
    DeptStr     := FieldLabels[21];
    DutyStr     := FieldLabels[22];
    TypeStr     := FieldLabels[23];
    TechnicStr  := FieldLabels[24];
    SexStr      := FieldLabels[3];
    FolkStr     := FieldLabels[6];
    MarriageStr := FieldLabels[7];
    PolityStr   := FieldLabels[8];
    CultureStr  := FieldLabels[12];
    SpecialStr  := FieldLabels[14];
    BankStr     := FieldLabels[29];
    RegerStr    := FieldLabels[20];
  end;
end;

procedure TApp.GetTreeList;
begin
  if FViewSet.ShowDept then Exit;

  FDeptList.Clear;
  with dmPer do
  begin
    //��������ӣ�ֻ���ش򿪲��ܶ���
    OpenDept();
    FilterData(aqDept, 'parId = 0');
    while not aqDept.Eof do
    begin
      FDeptList.Append(aqDept.FieldByName('deptName').AsString);
      aqDept.Next;
    end;
  end;
end;

procedure TApp.LoadFromIni;
begin
  with FIniFile do
  begin
    FBackPath        := ReadString('AppSet', 'BackPath', FPath + 'backup\');
    FPhotoPath       := ReadString('AppSet', 'PhotoPath', FPath + 'photos\');
    FLastDate        := ReadString('AppSet', 'LastDate', FormatDateTime('yyyy-mm', Date()));
    FWindowState     := TWindowState(ReadInteger('AppSet', 'WindowState', Ord(wsMaximized)));
    FStateIndex      := ReadInteger('AppSet', 'StateIndex', 1);
    FKeepEdit        := ReadBool('AppSet', 'KeepEdit', False);
    FNoImpSameStaNo  := ReadBool('AppSet', 'NoImpSameStaNo', True);
    FNoImpSameContNo := ReadBool('AppSet', 'NoImpSameContNo', True);

    with FViewMode do
    begin
      ShowTree  := ReadBool('ViewMode', 'ShowTree', True);
      ShowPhoto := ReadBool('ViewMode', 'ShowPhoto', True);
      ShowTool  := ReadBool('ViewMode', 'ShowTool', True);
    end;

    with FViewSet do
    begin
      ShowDept     := ReadBool('ViewSet', 'ShowDept', True);
      ShowDuty     := ReadBool('ViewSet', 'ShowDuty', True);
      ShowType     := ReadBool('ViewSet', 'ShowType', True);
      ShowTechnic  := ReadBool('ViewSet', 'ShowTechnic', True);
      ShowSex      := ReadBool('ViewSet', 'ShowSex', True);
      ShowFolk     := ReadBool('ViewSet', 'ShowFolk', True);
      ShowMarriage := ReadBool('ViewSet', 'ShowMarriage', True);
      ShowPolity   := ReadBool('ViewSet', 'ShowPolity', True);
      ShowCulture  := ReadBool('ViewSet', 'ShowCulture', True);
      ShowSpecial  := ReadBool('ViewSet', 'ShowSpecial', True);
    end;

    //�������
    with FGridSet do
    begin
      if ReadString('GridSet', 'FieldLabels', '') <> '' then
      begin
        //Ini�ļ��в��ܴ��л��е��ı������Դ˴���һ��ת��
        FieldLabels.Text := StringReplace(ReadString('GridSet', 'FieldLabels', ''), '|', #13#10, [rfReplaceAll]);
        InitKindCaptions();
      end;
      if ReadString('GridSet', 'Indexes', '') <> '' then
        Indexes.Text   := StringReplace(ReadString('GridSet', 'Indexes', ''), '|', #13#10, [rfReplaceAll]);
      FieldVisibles    := ReadString('GridSet', 'FieldVisibles', FIELD_VISIBLE);
      AutoFitStaffGrid := ReadBool('GridSet', 'AutoFitStaffGrid', False);
      DateFormat       := ReadString('GridSet', 'DateFormat', 'yyyy-mm-dd');
    end;

    //ͼ����ʾ
    with FChartSet do
    begin
      ChartType := TChartType(ReadInteger('ChartSet', 'ChartType', Ord(ctPie)));
      View3D    := ReadBool('CharSet', 'View3D', True);
    end;

    //��ӡ����
    with FPrintSet do
    begin
      PrintBase    := ReadBool('PrintSet', 'PrintBase', True);
      PrintDept    := ReadBool('PrintSet', 'PrintDept', True);
      PrintContact := ReadBool('PrintSet', 'PrintContact', True);
      PrintSelf    := ReadBool('PrintSet', 'PrintSelf', True);
      PrintFami    := ReadBool('PrintSet', 'PrintFami', True);
      PrintExper   := ReadBool('PrintSet', 'PrintExper', True);
      PrintAP      := ReadBool('PrintSet', 'PrintAP', True);
      PrintTrain   := ReadBool('PrintSet', 'PrintTrain', True);
      PrintMove    := ReadBool('PrintSet', 'PrintMove', True);
      PrintOther   := ReadBool('PrintSet', 'PrintOther', True);
      PrintBase    := ReadBool('PrintSet', 'PrintBase', True);
    end;

    //��ʼ������
    with FInitSet do
    begin
      InitAdmin  := ReadBool('InitSet', 'InitAdmin', False);
      InitDept   := ReadBool('InitSet', 'InitDept', False);
      InitKind   := ReadBool('InitSet', 'InitKind', False);
      InitStaffs := ReadBool('InitSet', 'InitStaffs', True);
      InitAP     := ReadBool('InitSet', 'InitAP', True);
      InitTrain  := ReadBool('InitSet', 'InitTrain', True);
      InitLeave  := ReadBool('InitSet', 'InitLeave', True);
      InitMove   := ReadBool('InitSet', 'InitMove', True);
      InitLeft   := ReadBool('InitSet', 'InitLeft', True);
      InitBack   := ReadBool('InitSet', 'InitBack', True);
      InitCont   := ReadBool('InitSet', 'InitCont', True);
      InitDiary  := ReadBool('InitSet', 'InitDiary', False);
      InitAddr   := ReadBool('InitSet', 'InitAddr', False);
    end;
  end;
end;

procedure TApp.SaveToIni;
begin
  with FIniFile do
  begin
    WriteString('AppSet', 'BackPath', FBackPath);
    WriteString('AppSet', 'PhotoPath', FPhotoPath);
    WriteString('AppSet', 'LastDate', FLastDate);
    WriteInteger('AppSet', 'WindowState', Ord(FWindowState));
    WriteInteger('AppSet', 'StateIndex', FStateIndex);
    WriteBool('AppSet', 'KeepEdit', FKeepEdit);
    WriteBool('AppSet', 'NoImpSameStaNo', FNoImpSameStaNo);
    WriteBool('AppSet', 'NoImpSameContNo', FNoImpSameContNo);

    with FViewMode do
    begin
      WriteBool('ViewMode', 'ShowTree', ShowTree);
      WriteBool('ViewMode', 'ShowPhoto', ShowPhoto);
      WriteBool('ViewMode', 'ShowTool', ShowTool);
    end;

    with FViewSet do
    begin
      WriteBool('ViewSet', 'ShowDept', ShowDept);
      WriteBool('ViewSet', 'ShowDuty', ShowDuty);
      WriteBool('ViewSet', 'ShowType', ShowType);
      WriteBool('ViewSet', 'ShowTechnic', ShowTechnic);
      WriteBool('ViewSet', 'ShowSex', ShowSex);
      WriteBool('ViewSet', 'ShowFolk', ShowFolk);
      WriteBool('ViewSet', 'ShowMarriage', ShowMarriage);
      WriteBool('ViewSet', 'ShowPolity', ShowPolity);
      WriteBool('ViewSet', 'ShowCulture', ShowCulture);
      WriteBool('ViewSet', 'ShowSpecial', ShowSpecial);
    end;

    with FGridSet do
    begin
      WriteString('GridSet', 'FieldLabels', StringReplace(FieldLabels.Text, #13#10, '|', [rfReplaceAll]));
      WriteString('GridSet', 'Indexes', StringReplace(Indexes.Text, #13#10, '|', [rfReplaceAll]));
      WriteString('GridSet', 'FieldVisibles', FieldVisibles);
      WriteBool('GridSet', 'AutoFitStaffGrid', AutoFitStaffGrid);
      WriteString('GridSet', 'DateFormat', DateFormat);
    end;

    with FChartSet do
    begin
      WriteInteger('ChartSet', 'ChartType', Ord(ChartType));
      WriteBool('ChartSet', 'View3D', View3D);
    end;

    with FPrintSet do
    begin
      WriteBool('PrintSet', 'PrintBase', PrintBase);
      WriteBool('PrintSet', 'PrintDept', PrintDept);
      WriteBool('PrintSet', 'PrintContact', PrintContact);
      WriteBool('PrintSet', 'PrintSelf', PrintSelf);
      WriteBool('PrintSet', 'PrintFami', PrintFami);
      WriteBool('PrintSet', 'PrintExper', PrintExper) ;
      WriteBool('PrintSet', 'PrintAP', PrintAP) ;
      WriteBool('PrintSet', 'PrintTrain', PrintTrain);
      WriteBool('PrintSet', 'PrintMove', PrintMove);
      WriteBool('PrintSet', 'PrintOther', PrintOther);
    end;

    with FInitSet do
    begin
      WriteBool('InitSet', 'InitAdmin', InitAdmin);
      WriteBool('InitSet', 'InitDept', InitDept);
      WriteBool('InitSet', 'InitKind', InitKind);
      WriteBool('InitSet', 'InitStaffs', InitStaffs);
      WriteBool('InitSet', 'InitAP', InitAP);
      WriteBool('InitSet', 'InitTrain', InitTrain);
      WriteBool('InitSet', 'InitLeave', InitLeave);
      WriteBool('InitSet', 'InitMove', InitMove);
      WriteBool('InitSet', 'InitLeft', InitLeft);
      WriteBool('InitSet', 'InitBack', InitBack);
      WriteBool('InitSet', 'InitCont', InitCont);
      WriteBool('InitSet', 'InitDiary', InitDiary);
      WriteBool('InitSet', 'InitAddr', InitAddr);
    end;
  end;
end;

procedure TApp.BackupData;
var
  CanBackup: Boolean;
  sBackName: string;
begin
  if not FParamSet.DataBack.Enabled then Exit;

  with FParamSet.DataBack do
  begin
    case BackType of
      btDay  : CanBackup := True;
      btWeek : CanBackup := DayOfWeek(Date()) = WeekIndex + 1;
      btMonth: CanBackup := DayOfTheMonth(Date()) = DayIndex + 1;
    else
      CanBackup := False;
    end;

    if CanBackup then
    begin
      sBackName := DataPath + '\data_' + FormatDateTime('yyyymmdd.bak', Date());
      CopyFile(PAnsiChar(App.DataPath), PAnsiChar(sBackName), False);
      dmPer.CompactAccess(sBackName);
    end;
  end;
end;

{ TCompany }

constructor TCompany.Create;
begin
  FIniFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + INI_FILE);
  LoadFromIni();
end;

destructor TCompany.Destroy;
begin
  SaveToIni();
  FIniFile.Free;
  inherited Destroy;
end;

procedure TCompany.LoadFromIni;
begin
  with FIniFile do
  begin
    FName        := ReadString('Company', 'Name', 'E-Learning��ҵ��');
    FLinkMan     := ReadString('Company', 'LinkMan', '');
    FLawMan      := ReadString('Company', 'LawMan', '');
    FAddress     := ReadString('Company', 'Address', '');
    FPostCode    := ReadString('Company', 'PostCode', '');
    FTel         := ReadString('Company', 'Tel', '');
    FHomePage    := ReadString('Company', 'HomePage', 'http://');
    FEMail       := ReadString('Company', 'EMail', '@');
    FDescription := ReadString('Company', 'Description', '');
  end;
end;

procedure TCompany.SaveToIni;
begin
  with FIniFile do
  begin
    WriteString('Company', 'Name', FName);
    WriteString('Company', 'LinkMan', FLinkMan);
    WriteString('Company', 'LawMan', FLawMan);
    WriteString('Company', 'Address', FAddress);
    WriteString('Company', 'PostCode', FPostCode);
    WriteString('Company', 'Tel', FTel);
    WriteString('Company', 'HomePage', FHomePage);
    WriteString('Company', 'EMail', FEMail);
    WriteString('Company', 'Description', FDescription);
  end;
end;

{ TParamSet }

constructor TParamSet.Create;
begin
  FIniFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + INI_FILE);
  LoadFromIni();
end;

destructor TParamSet.Destroy;
begin
  FIniFile.Free;
  inherited Destroy;
end;

procedure TParamSet.LoadFromIni;
begin
  with FIniFile do
  begin
    FDblEdit     := ReadBool('ParamSet', 'DblEdit', False);
    FDoPrint     := ReadBool('ParamSet', 'DoPrint', False);
    FEscClose    := ReadBool('ParamSet', 'EscClose', False);
    FAutoCode    := ReadBool('ParamSet', 'AutoCode', False);
    FPrefix      := ReadString('ParamSet', 'Prefix', 'el');
    FLeftCanEdit := ReadBool('ParamSet', 'LeftCanEdit', False);
    FLightLeave  := ReadBool('ParamSet', 'LightLeave', True);
    FLeaveColor  := ReadInteger('ParamSet', 'LeaveColor', $00FFC9C9);
    FEffLine     := ReadBool('ParamSet', 'EffLine', True);
    FEffColor    := ReadInteger('ParamSet', 'EffColor', $00EDE0E0);

    with FAwakeSet do
    begin
      Enabled     := ReadBool('ParamSet', 'AwakeEnable', True);
      BirthDay    := ReadInteger('ParamSet', 'BirthDay', 3);
      BirthGreg   := ReadBool('ParamSet', 'BirthGreg', False);
      ContractDay := ReadInteger('ParamSet', 'ContractDay', 30);
      StaffDay    := ReadInteger('ParamSet', 'StaffDay', 15);
    end;

    with FBackImage do
    begin
      Enabled   := ReadBool('ParamSet', 'BGImageEnable', True);
      FileName  := ReadString('ParamSet', 'BGImage', ExtractFilePath(Application.ExeName) + 'bg.jpg');
      Layout    := TLayout(ReadInteger('ParamSet', 'Layout', Ord(loCenter)));
      Stretch   := ReadBool('ParamSet', 'Stretch', True);
      KeepScale := ReadBool('ParamSet', 'KeepScale', False);
      BGColor   := ReadInteger('ParamSet', 'BGColor', clBlack);
      NeedPwd   := ReadBool('ParamSet', 'NeedPwd', True);
    end;

    with FDataBack do
    begin
      Enabled := ReadBool('ParamSet', 'DataBackEnable', False);
      BackType := TBackType(ReadInteger('ParamSet', 'BackType', Ord(btWeek)));
      WeekIndex := ReadInteger('ParamSet', 'WeekIndex', 1);
      DayIndex := ReadInteger('ParamSet', 'DayIndex', 0);
      DataPath := ReadString('ParamSet', 'DataPath', ExtractFilePath(Application.ExeName) + 'backup\');
    end;
  end;
end;

procedure TParamSet.SaveToIni;
begin
  with FIniFile do
  begin
    WriteBool('ParamSet', 'DblEdit', FDblEdit);
    WriteBool('ParamSet', 'DoPrint', FDoPrint);
    WriteBool('ParamSet', 'EscClose', FEscClose);
    WriteBool('ParamSet', 'AutoCode', FAutoCode);
    WriteString('ParamSet', 'Prefix', FPrefix);
    WriteBool('ParamSet', 'LeftCanEdit', FLeftCanEdit);
    WriteBool('ParamSet', 'LightLeave', FLightLeave);
    WriteInteger('ParamSet', 'LeaveColor', FLeaveColor);
    WriteBool('ParamSet', 'EffLine', FEffLine);
    WriteInteger('ParamSet', 'EffColor', FEffColor);

    with FAwakeSet do
    begin
      WriteBool('ParamSet', 'AwakeEnable', Enabled);
      WriteInteger('ParamSet', 'BirthDay', BirthDay);
      WriteBool('ParamSet', 'BirthGreg', BirthGreg);
      WriteInteger('ParamSet', 'ContractDay', ContractDay);
      WriteInteger('ParamSet', 'StaffDay', StaffDay);
    end;

    with FBackImage do
    begin
      WriteBool('ParamSet', 'BGImageEnable', Enabled);
      WriteString('ParamSet', 'BGImage', FileName);
      WriteInteger('ParamSet', 'Layout', Ord(Layout));
      WriteBool('ParamSet', 'Stretch', Stretch);
      WriteBool('ParamSet', 'KeepScale', KeepScale);
      WriteInteger('ParamSet', 'BGColor', BGColor);
      WriteBool('ParamSet', 'NeedPwd', NeedPwd);
    end;

    with FDataBack do
    begin
      WriteBool('ParamSet', 'DataBackEnable', Enabled);
      WriteInteger('ParamSet', 'BackType', Ord(BackType));
      WriteInteger('ParamSet', 'WeekIndex', WeekIndex);
      WriteInteger('ParamSet', 'DayIndex', DayIndex);
      WriteString('ParamSet', 'DataPath', DataPath);
    end;
  end;
end;

end.
