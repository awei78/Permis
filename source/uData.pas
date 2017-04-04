{
  �ļ�����uData.pas
  ˵  �������ݲ�����Ԫ
  ��д�ˣ�������
  ��  �ڣ�2008-05-16
  ��  �£�
}

unit uData;

interface

uses
  Classes, Windows, SysUtils, DB, ADODB, Variants, ImgList, Controls, DateUtils,
  ComObj, Forms, FR_Class, FR_DSet, FR_DBSet, Printers;

type
  TdmPer = class(TDataModule)
    acPer: TADOConnection;
    aqStaff: TADOQuery;
    dsStaff: TDataSource;
    aqStafr: TADOQuery;
    aqStat: TADOQuery;
    ilTree: TImageList;
    aqTemp: TADOQuery;
    aqDict: TADOQuery;
    aqDept: TADOQuery;
    ilTool: TImageList;
    frds: TfrDBDataSet;
    frStaff: TfrReport;
    aqLeaver: TADOQuery;
    frdsr: TfrDBDataSet;
    frLeave: TfrReport;
    aqStaffid: TAutoIncField;
    aqStaffstaffNo: TWideStringField;
    aqStaffstaffName: TWideStringField;
    aqStaffstaffPY: TWideStringField;
    aqStaffsex: TWideStringField;
    aqStaffbirth: TDateTimeField;
    aqStaffage: TIntegerField;
    aqStafffolk: TWideStringField;
    aqStaffmarriage: TWideStringField;
    aqStaffpolitics: TWideStringField;
    aqStaffinPartyDate: TDateTimeField;
    aqStaffidCardNo: TWideStringField;
    aqStaffinWorkDate: TDateTimeField;
    aqStaffculture: TWideStringField;
    aqStaffschool: TWideStringField;
    aqStaffspecial: TWideStringField;
    aqStaffgraduateDate: TDateTimeField;
    aqStaffnativePlace: TWideStringField;
    aqStaffnpAddr: TWideStringField;
    aqStaffrecordNo: TWideStringField;
    aqStaffregDate: TDateTimeField;
    aqStaffreger: TWideStringField;
    aqStaffphotoStr: TWideStringField;
    aqStaffdeptName: TWideStringField;
    aqStaffduty: TWideStringField;
    aqStaffworkKind: TWideStringField;
    aqStafftechnic: TWideStringField;
    aqStaffworkState: TIntegerField;
    aqStaffinDutyDate: TDateTimeField;
    aqStafftoStaffDate: TDateTimeField;
    aqStaffleftDate: TDateTimeField;
    aqStaffbankName: TWideStringField;
    aqStaffpayNo: TWideStringField;
    aqStaffannuityNo: TWideStringField;
    aqStaffmedicareNo: TWideStringField;
    aqStaffmobile: TWideStringField;
    aqStafftel: TWideStringField;
    aqStaffemail: TWideStringField;
    aqStaffcityTel: TWideStringField;
    aqStaffpostAddr: TWideStringField;
    aqStaffpostCode: TWideStringField;
    aqStaffqqCode: TWideStringField;
    aqStaffselfBio: TMemoField;
    aqStafffamily: TMemoField;
    aqStaffworkExper: TMemoField;
    aqStaffapRecord: TMemoField;
    aqStafftrainRecord: TMemoField;
    aqStaffothers: TMemoField;
    aqStaffmodifyDate: TDateTimeField;
    aqStaffno: TIntegerField;
    aqLeave: TADOQuery;
    aqStaffbirthGreg: TDateTimeField;
    aqStaffmoveRecord: TMemoField;
    aqGet: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure acPerAfterConnect(Sender: TObject);
    procedure aqStaffCalcFields(DataSet: TDataSet);
    procedure aqStaffworkStateGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure aqStaffworkStateSetText(Sender: TField; const Text: String);
    procedure frStaffGetValue(const ParName: String;
      var ParValue: Variant);
  private
    { Private declarations }
  public
    { Public declarations }
    //������ṹ����ɰ汾����...
    procedure AdjustTable;
    //�����������
    procedure DealBirth;
    //��ѯ���
    function OpenQuery(AADOQuery: TADOQuery; const ASqlStr: string): Boolean;
    function ExecSQL(const ASqlStr: string): Integer;
    procedure OpenDept;
    procedure OpenDict;
    procedure OpenStaff;
    //Ϊʵ�ִ�����Ա��������ʾ������
    procedure OpenLeave;
    procedure OpenStat(const AWhr, AGrpStr: string; AKindType: Integer);
    function GetFieldValue(const ASqlStr, AFieldName: string): Variant;

    //�����͡���ѵ��¼��������
    procedure DealAPRecord;
    procedure DealTrainRecord;
    procedure DealMoveRecord;

    //��ӡ
    procedure PrintCurrent;
    procedure PrintAll;
    procedure SetPrint;
    procedure PrintLeave(const ASqlStr: string); overload;
    procedure PrintLeave(const ALeaveId: Integer); overload;

    //ѹ�����ݿ�
    procedure CompactAccess(const ADBName: string; JetId: string = '4.0');   //ѹ��
    function CompressData(AHandle: THandle): Boolean;

    //�Ƿ������ʾ�¼�����
    function GetCanAwake: Boolean;
  end;

var
  dmPer: TdmPer;

implementation

uses uGlobal, uLunar, uApp;

{$R *.dfm}

{ TdmPer }

procedure TdmPer.DataModuleCreate(Sender: TObject);
begin
  if acPer.Connected then acPer.Close;

  acPer.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + App.DataPath +
    ';Persist Security Info=False;Jet OLEDB:Database Password=780927+790621';
  acPer.Open();

  //�����ṹ
  AdjustTable();
  DealBirth();
  //�������״̬
  ExecSQL('UPDATE [staffs] SET workState=0 WHERE workState=2 AND NOT EXISTS (SELECT id FROM [leave] WHERE staffId=staffs.id AND isLeave=TRUE)');
  //Ȼ���ٴ����ݼ�
  if not aqStaff.Active then OpenStaff;
  if not aqLeave.Active then OpenLeave;
end;

procedure TdmPer.DataModuleDestroy(Sender: TObject);
begin
  if acPer.Connected then acPer.Close;
end;

procedure TdmPer.acPerAfterConnect(Sender: TObject);
begin
  if not aqLeave.Active then OpenLeave();
end;

procedure TdmPer.AdjustTable;
var
  sl: TStrings;
begin
  //��2.2.5֮ǰ�汾������2.2.5��admin����lgCount�����ã�����lgTime�����
  sl := TStringList.Create;
  try
    acPer.GetFieldNames('admin', sl);
    if sl.IndexOf('lgTime') = -1 then
    begin
      //����lgTime�ֶΣ�������Ĭ��ֵΪNow()
      ExecSQL('ALTER TABLE [admin] ADD COLUMN lgTime DateTime DEFAULT Now()');
      //ȥ��ԭlgCount�ֶ�
      ExecSQL('ALTER TABLE [admin] DROP COLUMN lgCount');
    end;
  finally
    sl.Free;
  end;
end;

procedure TdmPer.DealBirth;
var
  sDate: string;
begin
  sDate := FormatDateTime('yyyy-mm', Date());
  if App.LastDate <> sDate then
  begin
    App.LastDate := sDate;

    //��������ֵ
    ExecSQL('UPDATE [staffs] SET age=DateDiff("yyyy", birth, Date()) WHERE NOT birth IS NULL');
    //�������ն�Ӧ����֮����
    OpenQuery(aqTemp, 'SELECT id, birth, birthGreg FROM [staffs]');
    if aqTemp.RecordCount > 0 then
    begin
      aqTemp.First;
      while not aqTemp.Eof do
      begin
        if not aqTemp.FieldByName('birth').IsNull then
        begin
          aqTemp.Edit;
          aqTemp.FieldByName('birthGreg').AsDateTime := ToGreg(aqTemp.FieldByName('birth').AsDateTime);
          aqTemp.Post;
        end;

        aqTemp.Next;
      end;
      aqTemp.UpdateBatch();
    end;
  end;
end;

function TdmPer.OpenQuery(AADOQuery: TADOQuery; const ASqlStr: string): Boolean;
begin
  with AADOQuery do
  begin
    try
      if Active then Close;

      Connection := acPer;
      Filtered := False;
      LockType := ltBatchOptimistic;
      SQL.Clear;
      SQL.Text := ASqlStr;
      Open;
      Result := True;
    except
      Result := False;
    end;
  end;
end;

function TdmPer.ExecSQL(const ASqlStr: string): Integer;
begin
  Result := 0;
  if not acPer.Connected or (Trim(ASqlStr) = '') then Exit;
  
  acPer.Execute(ASqlStr, Result);
end;

procedure TdmPer.OpenStaff;
var
  sSql: string;
begin
  if App.StateIndex = 0 then
    sSql := 'SELECT * FROM [staffs] ORDER BY staffNo'
  else if App.StateIndex = 1 then
    sSql := 'SELECT * FROM [staffs] WHERE workState <> 1 ORDER BY staffNo'
  else sSql := 'SELECT * FROM [staffs] WHERE workState=1 ORDER BY staffNo';
  OpenQuery(aqStaff, sSql);
end;

procedure TdmPer.OpenLeave;
begin
  OpenQuery(aqLeave, 'SELECT * FROM [leave] ORDER BY id DESC');
end;

procedure TdmPer.OpenDept;
begin
  OpenQuery(aqDept, 'SELECT * FROM [dept] ORDER BY sortNo');
end;

procedure TdmPer.OpenDict;
begin
  OpenQuery(aqDict, 'SELECT * FROM [dict] ORDER BY sortNo');
end;

//ͳ��������� Access��֧��GROUP BY ALL��ѯ���
procedure TdmPer.OpenStat(const AWhr, AGrpStr: string; AKindType: Integer);
var
  sSql: string;
begin
  //sSql := 'SELECT '+ AGrpStr +', Count(id) AS [staCount] FROM [staffs] WHERE '
  //  + AWhr + ' GROUP BY '+ AGrpStr;
  //���´��룬���Access��֧��GROUP BY ALL����
  sSql := 'SELECT sortNo, kindName, sc.staCount FROM [dict] LEFT JOIN ' +
    '(SELECT ' + AGrpStr + ', Count(staffs.id) as [staCount] FROM [staffs] WHERE ' + AWhr + ' GROUP BY ' + AGrpStr + ') sc ' +
    'ON dict.kindName=sc.' + AGrpStr + ' WHERE dict.kindType=' + IntToStr(AKindType) +
    ' UNION ' +
    'SELECT 1000, ''δָ��'' AS kindName, Count(id) AS staCount FROM [staffs] WHERE ' + AWhr + ' AND (' + AGrpStr + ' IS NULL OR NOT EXISTS ' +
    '(SELECT id FROM [dict] WHERE kindType=' + IntToStr(AKindType) + ' AND kindName=' + AGrpStr + '))';
    //��������IN��䣬����ΪEXISTSЧ�ʴ���IN
    //'SELECT 1, ''δָ��'' AS kindName, Count(id) AS staCount FROM [staffs] WHERE ' + AWhr + ' AND (' + AGrpStr + ' IS NULL OR ' + AGrpStr + ' NOT IN ' +
    //'(SELECT kindName FROM [dict] WHERE kindType=' + IntToStr(AKindType) + '))';

  OpenQuery(aqStat, sSql);
end;

function TdmPer.GetFieldValue(const ASqlStr, AFieldName: string): Variant;
begin
  if OpenQuery(aqGet, ASqlStr) and not aqGet.Eof and not aqGet.FieldByName(AFieldName).IsNull then
    Result := aqGet.FieldByName(AFieldName).AsVariant
  else Result := '';
end;

procedure TdmPer.DealAPRecord;
var
  sAP: string;
  i, curId: Integer;
begin
  OpenQuery(aqTemp, 'SELECT * FROM [ap] ORDER BY staffId, apDate');
  if aqTemp.Eof then Exit;

  ExecSQL('UPDATE [staffs] SET apRecord=''''');
  aqTemp.First;
  for i := 0 to aqTemp.RecordCount - 1 do
  begin
    //ȡֵ
    curId := aqTemp.FieldByName('staffId').AsInteger;
    sAP := sAP + '�������ڣ�' +aqTemp.FieldByName('apDate').AsString + '�����' + aqTemp.FieldByName('apType').AsString + '��ԭ��' +
      aqTemp.FieldByName('reason').AsString + '�������' + aqTemp.FieldByName('result').AsString + '�������ţ�' +
      aqTemp.FieldByName('operDept').AsString + '����ע��Ϣ��' + aqTemp.FieldByName('des').AsString + #13#10;

    aqTemp.Next;
    //���
    if (curId <> aqTemp.FieldByName('staffId').AsInteger) or aqTemp.Eof then
    begin
      ExecSQL('UPDATE [staffs] SET apRecord=''' + sAp + ''' WHERE id=' + IntToStr(curId));
      sAP := '';
    end;
  end;
end;

procedure TdmPer.DealTrainRecord;
var
  sTrain: string;
  i, curId: Integer;
begin
  OpenQuery(aqTemp, 'SELECT * FROM [train] ORDER BY staffId, trDate');
  if aqTemp.Eof then Exit;

  ExecSQL('UPDATE [staffs] SET trainRecord=''''');
  aqTemp.First;
  for i := 0 to aqTemp.RecordCount - 1 do
  begin
    //ȡֵ
    curId := aqTemp.FieldByName('staffId').AsInteger;
    sTrain := sTrain + '��ѵ���ƣ�' + aqTemp.FieldByName('trName').AsString + '�����ڣ�' + aqTemp.FieldByName('trDate').AsString + '���ص㣺' +
      aqTemp.FieldByName('trSite').AsString + '����ʦ��' + aqTemp.FieldByName('trainer').AsString + '�����ݣ�' +
      aqTemp.FieldByName('content').AsString + '����ע��Ϣ��' + aqTemp.FieldByName('des').AsString + #13#10;

    aqTemp.Next;
    //���
    if (curId <> aqTemp.FieldByName('staffId').AsInteger) or aqTemp.Eof then
    begin
      ExecSQL('UPDATE [staffs] SET trainRecord=''' + sTrain + ''' WHERE id=' + IntToStr(curId));
      sTrain := '';
    end;
  end;
end;

procedure TdmPer.DealMoveRecord;
var
  sMove: string;
  i, curId: Integer;
begin
  OpenQuery(aqTemp, 'SELECT * FROM [move] ORDER BY staffId, moveDate');
  if aqTemp.Eof then Exit;

  ExecSQL('UPDATE [staffs] SET moveRecord=''''');
  aqTemp.First;
  for i := 0 to aqTemp.RecordCount - 1 do
  begin
    //ȡֵ
    curId := aqTemp.FieldByName('staffId').AsInteger;
    sMove := sMove + '�������ڣ�' + aqTemp.FieldByName('moveDate').AsString + '��' +
             '��ע��Ϣ��' + aqTemp.FieldByName('newTech').AsString + #13#10 +
             '����ǰ' + App.ViewSet.DeptStr + '��' + aqTemp.FieldByName('oldDept').AsString +
             '������ǰ' + App.ViewSet.DutyStr + '��' + aqTemp.FieldByName('oldDuty').AsString +
             '������ǰ' + App.ViewSet.TypeStr + '��' + aqTemp.FieldByName('oldKind').AsString +
             '������ǰ' + App.ViewSet.TechnicStr + '��' + aqTemp.FieldByName('oldTech').AsString + #13#10 +
             '������' + App.ViewSet.DeptStr + '��' + aqTemp.FieldByName('newDept').AsString +
             '��������' + App.ViewSet.DutyStr + '��' + aqTemp.FieldByName('newDuty').AsString +
             '��������' + App.ViewSet.TypeStr + '��' + aqTemp.FieldByName('newKind').AsString +
             '��������' + App.ViewSet.TechnicStr + '��' + aqTemp.FieldByName('newTech').AsString + #13#10;
    aqTemp.Next;
    //���
    if (curId <> aqTemp.FieldByName('staffId').AsInteger) or aqTemp.Eof then
    begin
      ExecSQL('UPDATE [staffs] SET moveRecord=''' + sMove + ''' WHERE id=' + IntToStr(curId));
      sMove := '';
    end;
  end;
end;

procedure TdmPer.aqStaffCalcFields(DataSet: TDataSet);
begin
  aqStaff.FieldByName('no').AsInteger := Abs(aqStaff.RecNo);
end;

procedure TdmPer.aqStaffworkStateGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
  if Sender.DataSet.RecordCount = 0 then Exit;

  if Sender.AsInteger = 1 then
    Text := '��ְ'
  else if Sender.AsInteger = 2 then
    Text := '���'
  else Text := '��ְ';
end;

procedure TdmPer.aqStaffworkStateSetText(Sender: TField;
  const Text: String);
begin
  if Text = '��ְ' then
    Sender.AsInteger := 1
  else Sender.AsInteger := 0;
end;

procedure TdmPer.PrintCurrent;
begin
  OpenQuery(aqStafr, 'SELECT * FROM [staffs] WHERE id=' + aqStaff.FieldByName('id').AsString);

  SetPrint();
end;

procedure TdmPer.PrintAll;
begin
  aqStafr.Clone(aqStaff, ltReadOnly);
  aqStafr.Requery();
  if aqStaff.Filtered then FilterData(aqStafr, aqStaff.Filter);

  SetPrint();
end;

procedure TdmPer.SetPrint;
var
  fs, fv: TfrBandView;
  i, Index: Integer;
  meoCap: TfrMemoView;

  procedure DealBound(const ABandName: string);
  begin
    if fv <> nil then fv.ChildBand := ABandName;
    fv := TfrBandView(frStaff.FindObject(ABandName));
    if fs.ChildBand = '' then fs.ChildBand := ABandName;
  end;

begin
  fs := TfrBandView(frStaff.FindObject('bvStaff'));
  fv := nil;

  TfrBandView(frStaff.FindObject('bvStaff')).ChildBand := '';
  TfrBandView(frStaff.FindObject('bvBasic')).ChildBand := '';
  TfrBandView(frStaff.FindObject('bvContact')).ChildBand := '';
  TfrBandView(frStaff.FindObject('bvSelf')).ChildBand := '';
  TfrBandView(frStaff.FindObject('bvFami')).ChildBand := '';
  TfrBandView(frStaff.FindObject('bvExper')).ChildBand := '';
  TfrBandView(frStaff.FindObject('bvAP')).ChildBand := '';
  TfrBandView(frStaff.FindObject('bvTrain')).ChildBand := '';
  TfrBandView(frStaff.FindObject('bvMove')).ChildBand := '';
  TfrBandView(frStaff.FindObject('bvOther')).ChildBand := '';

  with App.PrintSet do
  begin
    //������Ϣ
    if PrintBase then DealBound('bvBasic');
    if PrintDept then DealBound('bvDept');
    if PrintContact then DealBound('bvContact');
    if PrintSelf then DealBound('bvSelf');
    if PrintFami then DealBound('bvFami');
    if PrintExper then DealBound('bvExper');
    if PrintAP then DealBound('bvAP');
    if PrintTrain then DealBound('bvTrain');
    if PrintMove then DealBound('bvMove');
    if PrintOther then DealBound('bvOther');
  end;
  //��Ŀ���Ƹ�ֵ...�˱�ʶΪ����[��ְ״̬]����
  Index := 1;
  with App.GridSet do
    for i := 1 to FieldLabels.Count - 1 do
    begin
      if i = 25 then Continue;

      meoCap := TfrMemoView(frStaff.FindObject('Label' + IntToStr(Index)));
      if meoCap <> nil then meoCap.Memo.Text := FieldLabels[i];
      Inc(Index);
    end;

  //��Ƭ·������ֵ���ټ�˫����
  frStaff.Dictionary.Variables['photoPath'] := QuotedStr(App.Path + 'photos\');

  //��ӡ
  if App.ParamSet.DoPrint then
  begin
    if Printer.Printers.Count = 0 then
    begin
      MessageBox(Application.MainForm.Handle, '����ϵͳ��û�п��õĴ�ӡ�����밲װ��ӡ����', '��ʾ', MB_OK + MB_ICONINFORMATION);
      Exit;
    end;

    frStaff.PrepareReport;
    frStaff.PrintPreparedReportDlg;
  end
  else frStaff.ShowReport;
end;

procedure TdmPer.PrintLeave(const ASqlStr: string);
begin
  if ASqlStr = '' then Exit;

  OpenQuery(aqLeaver, ASqlStr);
  if App.ParamSet.DoPrint then
  begin
    if Printer.Printers.Count = 0 then
    begin
      MessageBox(Application.MainForm.Handle, '����ϵͳ��û�п��õĴ�ӡ�����밲װ��ӡ����', '��ʾ', MB_OK + MB_ICONINFORMATION);
      Exit;
    end;

    frLeave.PrepareReport;
    frLeave.PrintPreparedReportDlg;
  end
  else frLeave.ShowReport;
end;

procedure TdmPer.PrintLeave(const ALeaveId: Integer);
begin
  PrintLeave('SELECT * FROM [leave] WHERE id=' + IntToStr(ALeaveId));
end;

procedure TdmPer.frStaffGetValue(const ParName: String;
  var ParValue: Variant);
begin
  if ParName = 'company' then
  begin
    ParValue := App.Company.Name;
    if App.RegType = rtUnReged then ParValue := ParValue + ' - δע���';
  end;
end;

procedure TdmPer.CompactAccess(const ADBName: string; JetId: string);
var
  vData: Variant;
begin
  if not FileExists(ADBName) then Exit;
  if FileExists(ADBName + '.tmp') then DeleteFile(ADBName + '.tmp');

  vData := CreateOleObject('JRO.JetEngine');
  vData.CompactDataBase('Provider=Microsoft.Jet.OLEDB.' + JetId + ';Jet OLEDB:DataBase Password=780927+790621;Data Source=' + ADBName ,
    'Provider=Microsoft.Jet.OLEDB.' + JetId + ';Jet OLEDB:DataBase Password=780927+790621;Data Source=' + ADBName + '.tmp');
  DeleteFile(ADBName);
  RenameFile(ADBName + '.tmp', ADBName);
end;

function TdmPer.CompressData(AHandle: THandle): Boolean;
var
  sOldSize, sNewSize: string;
begin
  if acPer.Connected then acPer.Close;
  try
    try
      sOldSize := FormatFloat('0.## KB', GetFileSize(App.DataPath));
      CompactAccess(App.DataPath);
      sNewSize := FormatFloat('0.## KB', GetFileSize(App.DataPath));
      Result := True;
      MessageBox(AHandle, PAnsiChar('���ݿ�ѹ���޸������ɹ���' + #13#10 + 'ѹ��ǰ��С��' + sOldSize + '��ѹ�����С��' + sNewSize), '��ʾ', MB_OK + MB_ICONINFORMATION);

      Log.Write(App.UserID + '�����ݿ����ѹ���޸�����');
    except
      on E: Exception do
      begin
        Log.Write(App.UserID + 'ѹ�����ݿ�ʧ�ܣ���Ϣ��' + E.Message);
        MessageBox(AHandle, PAnsiChar('���ݿ�ѹ���޸�ʧ�ܣ���ȷ�����ݿⲻ��ʹ���С�' + #13#10 + '��Ϣ:' + E.Message), '��ʾ', MB_OK + MB_ICONWARNING);
        Result := False;
      end;
    end;
  finally
    acPer.Connected := True;
    PostMessage(AHandle, WM_DATACOMPRESSED, 0, 0);
  end;
end;

function TdmPer.GetCanAwake: Boolean;
var
  sSql: string;
begin
  Result := False;
  if not App.ParamSet.AwakeSet.Enabled then Exit;

  //��������
  if not App.ParamSet.AwakeSet.BirthGreg then
    sSql := 'SELECT id FROM [staffs] WHERE workState <> 1 AND (' +
            //����
            'DateAdd("yyyy", DatePart("yyyy", Date()) - DatePart("yyyy", iif(birth IS NULL, 0, birth)), iif(birth IS NULL, 0, birth)) - Date() BETWEEN 0 AND ' + IntToStr(App.ParamSet.AwakeSet.BirthDay) +
            ' OR ' +
            //����
            'DateAdd("yyyy", DatePart("yyyy", Date() + ' + IntToStr(App.ParamSet.AwakeSet.BirthDay) + ') - DatePart("yyyy", iif(birth IS NULL, 0, birth)), iif(birth IS NULL, 0, birth)) - Date() BETWEEN 0 AND ' + IntToStr(App.ParamSet.AwakeSet.BirthDay) +
            ')'
  else
    sSql := 'SELECT id FROM [staffs] WHERE workState <> 1 AND (' +
            //����
            'DateAdd("yyyy", DatePart("yyyy", Date()) - DatePart("yyyy", iif(birthGreg IS NULL, 0, birthGreg)), iif(birthGreg IS NULL, 0, birthGreg)) - Date() BETWEEN 0 AND ' + IntToStr(App.ParamSet.AwakeSet.BirthDay) +
            ' OR ' +
            //����
            'DateAdd("yyyy", DatePart("yyyy", Date() + ' + IntToStr(App.ParamSet.AwakeSet.BirthDay) + ') - DatePart("yyyy", iif(birthGreg IS NULL, 0, birthGreg)), iif(birthGreg IS NULL, 0, birthGreg)) - Date() BETWEEN 0 AND ' + IntToStr(App.ParamSet.AwakeSet.BirthDay) +
            ')';

  OpenQuery(aqTemp, sSql);
  Result := not aqTemp.Eof;
  if Result then Exit;

  //��ͬ��������
  sSql := 'SELECT id FROM [contract] WHERE endDate BETWEEN #' + DateToStr(Date()) + '# AND #' + DateToStr(IncDay(Date(), App.ParamSet.AwakeSet.ContractDay)) + '#';
  OpenQuery(aqTemp, sSql);
  Result := not aqTemp.Eof;
  if Result then Exit;

  //����ת��Ա��
  sSql := 'SELECT id FROM [staffs] WHERE workState <> 1 AND toStaffDate BETWEEN #' + DateToStr(Date()) + '# AND #' + DateToStr(IncDay(Date(), App.ParamSet.AwakeSet.StaffDay)) + '#';
  OpenQuery(aqTemp, sSql);
  Result := not aqTemp.Eof;
end;

end.
