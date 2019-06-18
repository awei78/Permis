program permis;

uses
  Forms,
  SysUtils,
  Windows,
  uGlobal in 'uGlobal.pas',
  uApp in 'uApp.pas',
  uData in 'uData.pas' {dmPer: TDataModule},
  uMain in 'uMain.pas' {frmMain},
  uBase in 'uBase.pas' {frmBase},
  uLogin in 'uLogin.pas' {frmLogin},
  uChgPwd in 'uChgPwd.pas' {frmChgPwd},
  uAdmin in 'uAdmin.pas' {frmAdmin},
  uAddAdmin in 'uAddAdmin.pas' {frmAddAdmin},
  uDept in 'uDept.pas' {frmDept},
  uDict in 'uDict.pas' {frmDict},
  uParamSet in 'uParamSet.pas' {frmParamSet},
  uCompany in 'uCompany.pas' {frmCompany},
  uView in 'uView.pas' {frmView},
  uStaff in 'uStaff.pas' {frmStaff},
  uReg in 'uReg.pas' {frmReg},
  uDiary in 'uDiary.pas' {frmDiary},
  uAddr in 'uAddr.pas' {frmAddr},
  uLog in 'uLog.pas',
  uLogInfo in 'uLogInfo.pas' {frmLog},
  uAbout in 'uAbout.pas' {frmAbout},
  Menus in 'Menus.pas',
  CtrlsEx in 'CtrlsEx.pas',
  uField in 'uField.pas' {frmField},
  uMove in 'uMove.pas' {frmMove},
  uLeft in 'uLeft.pas' {frmLeft},
  uBack in 'uBack.pas' {frmBack},
  uPrint in 'uPrint.pas' {frmPrint},
  uCalendar in 'uCalendar.pas' {frmCalendar},
  uExport in 'uExport.pas' {frmExport},
  uDataBack in 'uDataBack.pas' {frmDataBack},
  uDataRestore in 'uDataRestore.pas' {frmDataRestore},
  uDataInit in 'uDataInit.pas' {frmDataInit},
  uImport in 'uImport.pas' {frmImport},
  uInqu in 'uInqu.pas' {frmInqu},
  uAwake in 'uAwake.pas' {frmAwake},
  uVideo in 'uVideo.pas' {frmVideo},
  uLeave in 'uLeave.pas' {frmLeave},
  uInquLeave in 'uInquLeave.pas' {frmInquLeave},
  uBatchEdit in 'uBatchEdit.pas' {frmBatchEdit},
  DataExp in 'DataExp.pas',
  uAP in 'uAP.pas' {frmAP},
  uAPDlg in 'uAPDlg.pas' {frmAPDlg},
  uInquBase in 'uInquBase.pas' {frmInquBase},
  uInquMove in 'uInquMove.pas' {frmInquMove},
  uTrain in 'uTrain.pas' {frmTrain},
  uTrainDlg in 'uTrainDlg.pas' {frmTrainDlg},
  uLunar in 'uLunar.pas',
  uNeedPwd in 'uNeedPwd.pas' {frmNeedPwd},
  uCode in 'uCode.pas' {frmCode},
  uDlgBase in 'uDlgBase.pas' {frmDlgBase},
  uInquR in 'uInquR.pas' {frmInquR},
  uContract in 'uContract.pas' {frmContract},
  uContDlg in 'uContDlg.pas' {frmContDlg},
  uImportC in 'uImportC.pas' {frmImportC},
  uImportP in 'uImportP.pas' {frmImportP};

var
  hApp, hMain, hLogin: THandle;

{$R *.res}
{$R WindowsXP *.res}

begin
  //ֻ����һ��ʵ��
  hApp := FindWindow('TApplication', 'CR���µ�������ϵͳ');
  if hApp <> 0 then
  begin
    //�ҵ�¼����
    hLogin := FindWindow('TfrmLogin', nil);
    if hLogin <> 0 then
      SetForegroundWindow(hLogin)
    //��������
    else
    begin
      hMain := FindWindow('TfrmMain', nil);
      if hMain <> 0 then
      begin
        if IsIconic(hMain) then OpenIcon(hMain);
        //������ǰhApp������ΪMainFormǰ��ģʽ����ʱ����Ȼ��MainForm���������
        SetForegroundWindow(hApp);
        SetForegroundWindow(hMain);
      end
    end;

    Exit;
  end;

  Application.Title := 'CR���µ�������ϵͳ';
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmPer, dmPer);
  if ShowLogin() then
  begin
    Application.CreateForm(TfrmMain, frmMain);
    Application.Run;
  end;
end.
