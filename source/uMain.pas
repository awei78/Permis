{******
  �� Ԫ��uMain.pas
  �� �ߣ�������
  �� �ڣ�2008-5-15                                                             
  ˵ ������������Ԫ
         Ա����ְ״̬
           0����ְ
           1����ְ
           2�����
         ������Position������poDefault����Ȼ�ڿ��������ʱ��������������������Ļ�ϱ�
  �� �£�                                                                  
******}

unit uMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ShellAPI,
  Menus, Buttons, StdCtrls, DBGrids, GridsEh, jpeg, ExtCtrls, ComCtrls, Variants, ImgList,
  ActnList, RzPanel, RzButton, RzTabs, DB, ADODB, CtrlsEx, TeeProcs, TeEngine, Chart,
  uGlobal, uApp, Series, TeeFunci, DBGridEh, PrnDbgeh;

type
  TfrmMain = class(TForm)
    mnuPer: TMainMenu;
    miSys: TMenuItem;
    miChgPwd: TMenuItem;
    miAdmin: TMenuItem;
    miLogin: TMenuItem;
    Space01: TMenuItem;
    miExit: TMenuItem;
    sbPer: TStatusBar;
    tmrTime: TTimer;
    miStaff: TMenuItem;
    miAdd: TMenuItem;
    miInquire: TMenuItem;
    miEdit: TMenuItem;
    miDel: TMenuItem;
    miHelp: TMenuItem;
    miBkData: TMenuItem;
    miData: TMenuItem;
    miReData: TMenuItem;
    ilPer: TImageList;
    alPer: TActionList;
    actDiary: TAction;
    actChgpwd: TAction;
    actAddr: TAction;
    actAdmin: TAction;
    actLogin: TAction;
    actExit: TAction;
    actMove: TAction;
    actAdd: TAction;
    actEdit: TAction;
    actDel: TAction;
    actInqu: TAction;
    miExport: TMenuItem;
    miInport: TMenuItem;
    miLog: TMenuItem;
    miAbout: TMenuItem;
    actLog: TAction;
    actAbout: TAction;
    tbPer: TRzToolbar;
    btnDept: TRzToolButton;
    miSMove: TMenuItem;
    miTools: TMenuItem;
    miCalc: TMenuItem;
    miNote: TMenuItem;
    miDep: TMenuItem;
    Space02: TMenuItem;
    miSort: TMenuItem;
    miBaseData: TMenuItem;
    miSet: TMenuItem;
    Space03: TMenuItem;
    miShow: TMenuItem;
    miPrint: TMenuItem;
    miPGrid: TMenuItem;
    miPCur: TMenuItem;                                       
    miPAll: TMenuItem;
    Space08: TMenuItem;
    miContent: TMenuItem;
    miPage: TMenuItem;
    miReg: TMenuItem;
    N4: TMenuItem;
    miInitData: TMenuItem;
    Space06: TMenuItem;
    miAddrList: TMenuItem;
    miCompany: TMenuItem;
    miLeft: TMenuItem;
    Space05: TMenuItem;
    miMoveI: TMenuItem;
    miLeftI: TMenuItem;
    miBackI: TMenuItem;
    miDiary: TMenuItem;
    btnSort: TRzToolButton;
    Spacer1: TRzSpacer;
    btnAdd: TRzToolButton;
    btnEdit: TRzToolButton;
    btnDel: TRzToolButton;
    btnInqu: TRzToolButton;
    Spacer2: TRzSpacer;
    btnChart: TRzToolButton;
    btnPrint: TRzToolButton;
    Spacer3: TRzSpacer;
    miMove: TMenuItem;
    actBase: TAction;
    actDict: TAction;
    actDept: TAction;
    actCompany: TAction;
    miBack: TMenuItem;
    actLeft: TAction;
    actBack: TAction;
    actField: TAction;
    actPrint: TAction;
    actPList: TAction;
    actPCur: TAction;
    actPAll: TAction;
    actInMove: TAction;
    actInLeft: TAction;
    actInBack: TAction;
    actChart: TAction;
    actSet: TAction;
    actHelp: TAction;
    actPage: TAction;
    actReg: TAction;
    actInitData: TAction;
    actBackData: TAction;
    actExport: TAction;
    actImport: TAction;
    actRestore: TAction;
    pmPrint: TPopupMenu;
    miList: TMenuItem;
    miCur: TMenuItem;
    miAll: TMenuItem;
    btnView: TRzToolButton;
    pmView: TPopupMenu;
    actTree: TAction;
    actPhoto: TAction;
    actTool: TAction;
    miPhoto: TMenuItem;
    miSearch: TMenuItem;
    pmGuide: TMenuItem;
    actPSet: TAction;
    N1: TMenuItem;
    miPSet: TMenuItem;
    pmTree: TPopupMenu;
    miSKind: TMenuItem;
    miTChart: TMenuItem;
    actDKind: TAction;
    actCalc: TAction;
    actNote: TAction;
    miMIn: TMenuItem;
    pmGrid: TPopupMenu;
    pmiView: TMenuItem;
    N3: TMenuItem;
    pmiAdd: TMenuItem;
    pmiEdit: TMenuItem;
    pmiDel: TMenuItem;
    pmiDulAdd: TMenuItem;
    actView: TAction;
    actDup: TAction;
    actSelAll: TAction;
    N2: TMenuItem;
    pmiSelAll: TMenuItem;
    pmiPrint: TMenuItem;
    pmiSMove: TMenuItem;
    pmiMove: TMenuItem;
    pmiLeft: TMenuItem;
    pmiBack: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    miPrintSet: TMenuItem;
    miCal: TMenuItem;
    actCalendar: TAction;
    actCompress: TAction;
    miCompress: TMenuItem;
    btnExport: TRzToolButton;
    actAwake: TAction;
    miAwake: TMenuItem;
    tmrAwake: TTimer;
    actQQ: TAction;
    miQQ: TMenuItem;
    pgPer: TPrintDBGridEh;
    actAP: TAction;
    actTrain: TAction;
    Space04: TMenuItem;
    actLeave: TAction;
    actInLeave: TAction;
    Space07: TMenuItem;
    Space09: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    miLeave: TMenuItem;
    N9: TMenuItem;
    actUnLeave: TAction;
    N10: TMenuItem;
    pmiLeave: TMenuItem;
    pmiUnLeave: TMenuItem;
    miUnLeave: TMenuItem;
    actMBase: TAction;
    N11: TMenuItem;
    miDulAdd: TMenuItem;
    miBatchEdit: TMenuItem;
    actBatchEdit: TAction;
    N12: TMenuItem;
    N13: TMenuItem;
    pmiBEdit: TMenuItem;
    N14: TMenuItem;
    pmiDept: TMenuItem;
    pmiDict: TMenuItem;
    actBuy: TAction;
    miBuy: TMenuItem;
    actCamera: TAction;
    miCamera: TMenuItem;
    actBackImage: TAction;
    btnBack: TRzToolButton;
    pcMain: TRzPageControl;
    tsData: TRzTabSheet;
    tsImage: TRzTabSheet;
    spPer: TSplitter;
    pnlTool: TPanel;
    lblSrh: TLabel;
    lblSort: TLabel;
    lblTips: TLabel;
    cbState: TComboBox;
    edtSrh: TEdit;
    pnlLeft: TPanel;
    tvPer: TTreeView;
    pnlPhoto: TPanel;
    imgPhoto: TImage;
    pnlChart: TPanel;
    pnlTop: TPanel;
    Label1: TLabel;
    btnExportBmp: TRzToolButton;
    rbPie: TRadioButton;
    rbBar: TRadioButton;
    rbLine: TRadioButton;
    cb3D: TCheckBox;
    chtStaff: TChart;
    Series1: TPieSeries;
    dgStaff: TDBGridEh;
    imgMain: TImage;
    miReport: TMenuItem;
    miContract: TMenuItem;
    miNewC: TMenuItem;
    actNewC: TAction;
    actContract: TAction;
    actEndC: TAction;
    actImportC: TAction;
    miCInfo: TMenuItem;
    miEndC: TMenuItem;
    N15: TMenuItem;
    miImportC: TMenuItem;
    actNewR: TAction;
    actLeftR: TAction;
    actBackR: TAction;
    actMoveR: TAction;
    miNewR: TMenuItem;
    miLeftR: TMenuItem;
    miBackR: TMenuItem;
    miMoveR: TMenuItem;
    N16: TMenuItem;
    miChartR: TMenuItem;
    actCode: TAction;
    miCode: TMenuItem;
    actImportP: TAction;
    N17: TMenuItem;
    miImportP: TMenuItem;
    procedure actChgpwdExecute(Sender: TObject);
    procedure actAdminExecute(Sender: TObject);
    procedure actLoginExecute(Sender: TObject);
    procedure actDeptExecute(Sender: TObject);
    procedure actDictExecute(Sender: TObject);
    procedure actCompanyExecute(Sender: TObject);
    procedure actDKindExecute(Sender: TObject);
    procedure actAwakeExecute(Sender: TObject);
    procedure actSetExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
    procedure actInquExecute(Sender: TObject);
    procedure actAPExecute(Sender: TObject);
    procedure actTrainExecute(Sender: TObject);
    procedure actFieldExecute(Sender: TObject);
    procedure actPCurExecute(Sender: TObject);
    procedure actPAllExecute(Sender: TObject);
    procedure actPListExecute(Sender: TObject);
    procedure actPSetExecute(Sender: TObject);
    procedure actViewExecute(Sender: TObject);
    procedure actDupExecute(Sender: TObject);
    procedure actBatchEditExecute(Sender: TObject);
    procedure actSelAllExecute(Sender: TObject);
    procedure actMBaseExecute(Sender: TObject);
    procedure actLeaveExecute(Sender: TObject);
    procedure actUnLeaveExecute(Sender: TObject);
    procedure actMoveExecute(Sender: TObject);
    procedure actLeftExecute(Sender: TObject);
    procedure actBackExecute(Sender: TObject);
    procedure actInLeaveExecute(Sender: TObject);
    procedure actInMoveExecute(Sender: TObject);
    procedure actInLeftExecute(Sender: TObject);
    procedure actInBackExecute(Sender: TObject);
    procedure actChartExecute(Sender: TObject);
    procedure actNewCExecute(Sender: TObject);
    procedure actContractExecute(Sender: TObject);
    procedure actEndCExecute(Sender: TObject);
    procedure actImportCExecute(Sender: TObject);
    procedure actBackupExecute(Sender: TObject);
    procedure actImportExecute(Sender: TObject);
    procedure actRestoreExecute(Sender: TObject);
    procedure actCompressExecute(Sender: TObject);
    procedure actExportExecute(Sender: TObject);
    procedure actImportPExecute(Sender: TObject);
    procedure actInitDataExecute(Sender: TObject);
    procedure actNewRExecute(Sender: TObject);
    procedure actLeftRExecute(Sender: TObject);
    procedure actBackRExecute(Sender: TObject);
    procedure actMoveRExecute(Sender: TObject);
    procedure actDiaryExecute(Sender: TObject);
    procedure actAddrExecute(Sender: TObject);
    procedure actCalendarExecute(Sender: TObject);
    procedure actCodeExecute(Sender: TObject);
    procedure actCameraExecute(Sender: TObject);
    procedure actCalcExecute(Sender: TObject);
    procedure actNoteExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actPageExecute(Sender: TObject);
    procedure actQQExecute(Sender: TObject);
    procedure actLogExecute(Sender: TObject);
    procedure actRegExecute(Sender: TObject);
    procedure actBuyExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actTreeExecute(Sender: TObject);
    procedure actPhotoExecute(Sender: TObject);
    procedure actToolExecute(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
    procedure actBackImageExecute(Sender: TObject);
    procedure alPerExecute(Action: TBasicAction; var Handled: Boolean);
    procedure spPerCanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure tmrTimeTimer(Sender: TObject);
    procedure tvPerChange(Sender: TObject; Node: TTreeNode);
    procedure tvPerGetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure tvPerGetSelectedIndex(Sender: TObject; Node: TTreeNode);
    procedure cbStateChange(Sender: TObject);
    procedure edtSrhChange(Sender: TObject);
    procedure tvPerMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dgStaffDblClick(Sender: TObject);
    procedure dgStaffDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure dgStaffKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dgStaffTitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
    procedure pmGridPopup(Sender: TObject);
    procedure imgPhotoDblClick(Sender: TObject);
    procedure rbPieClick(Sender: TObject);
    procedure rbBarClick(Sender: TObject);
    procedure rbLineClick(Sender: TObject);
    procedure cb3DClick(Sender: TObject);
    procedure btnExportBmpClick(Sender: TObject);
    procedure frpgPrintColumn(ColumnNo: Integer; var Width: Integer);
    procedure tmrAwakeTimer(Sender: TObject);
    procedure imgMainDblClick(Sender: TObject);
  private
    { Private declarations }
    //�Ƿ�Ӳ�ѯ����
    FBackFromInqu: Boolean;
    //������ǩ
    FBookMark: TBookMark;
    procedure InitData;
    //����ͼƬ
    procedure SetImage;
    //����Act״̬
    procedure SetActState;
    //����Field��ʾ������״̬
    procedure SetFieldProp;
    //��������
    procedure DoFilterData;
    //ˢ��Ա������
    procedure RequeryStaffs(const ALocate: Boolean = True);
    //��ȡ��ѯ�����ַ���
    function GetWhrStr: string;
    function GetWhrStrFromState: string;
    //ͼ����ʾ
    procedure MakeChart;
    //�ı�ͼ����ʽ
    procedure ChangeChartType(AChartType: TChartType);
    //���ݼ��¼�����
    procedure StaffDataChange(Sender: TObject; Field: TField);
    //����
    procedure DrawTree;
    //����������Ϣ
    procedure BuildKind;
    //���ý�����ʽ
    procedure SetViewMode(Sender: TObject);
    //Ȩ�޷���
    procedure SetPower;
    //����ϵͳ��Ϣ
    procedure WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
    //ʹģʽ�������������
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    //�����ѸĶ���Ϣ
    procedure WMKindChanged(var Msg: TMessage); message WM_KINDCHANGE;
    //��Ϣ�ѸĶ���Ϣ
    procedure WMStaffChanged(var Msg: TMessage); message WM_STAFFCHANGE;
    procedure WMInquStaff(var Msg: TMessage); message WM_INQUSTAFF;
    //DBGrid�������ѸĶ���Ϣ
    procedure WMFieldChanged(var Msg: TMessage); message WM_FIELDCHANGE;
    //���ݿ���ѹ����Ϣ
    procedure WMDataCompressed(var Msg: TMessage); message WM_DATACOMPRESSED;
    //���ݿ��ѻָ���Ϣ
    procedure WMDataRestore(var Msg: TMessage); message WM_DATARESTORE;
  public
    { Public declarations }
    procedure OnHint(Sender: TObject);
  end;

var
  frmMain: TfrmMain;

implementation

uses uLogin, uChgpwd, uAdmin, uStaff, uDept, uAbout, uData, uParamSet,
  uLogInfo, uReg, uCompany, uDict, uView, uDiary, uAddr, uField,
  uMove, uLeft, uBack, uInquMove, uPrint, uCalendar, uExport, uDataBack,
  uDataRestore, uDataInit, uImport, uInqu, uAwake, uLeave, uInquLeave,
  uBatchEdit, uAP, uTrain, uVideo, uNeedPwd, uCode, uInquR, uContract,
  uContDlg, uImportC, uImportP;

var
  aqStaff: TADOQuery;

{$R *.dfm}

procedure TfrmMain.InitData;
begin
  //���ݱ���
  if App.ParamSet.DataBack.Enabled then App.BackupData();
  //���ݼ�����
  aqStaff := TADOQuery(dgStaff.DataSource.DataSet);
  actTree.Checked := App.ViewMode.ShowTree;
  pnlLeft.Visible := actTree.Checked;
  actPhoto.Enabled := actTree.Checked;
  actPhoto.Checked := App.ViewMode.ShowPhoto;
  pnlPhoto.Visible := actPhoto.Checked;
  actTool.Checked := App.ViewMode.ShowTool;
  pnlTool.Visible := actTool.Checked;
  actBackImage.Visible := App.ParamSet.BackImage.Enabled;
  pcMain.ActivePageIndex := 0;
  //����ͼƬ
  SetImage();
  //ͼ��
  rbPie.Checked := App.ChartSet.ChartType = ctPie;
  rbBar.Checked := App.ChartSet.ChartType = ctBar;
  rbLine.Checked := App.ChartSet.ChartType = ctLine;
  cb3D.Checked := App.ChartSet.View3D;
  //�������ݱ���ʾ������״̬�����ڴ˴���ʹAutoFitWidth()��Application.MainForm������
  SetFieldProp();

  //�ַ���ʾ
  if App.RegType = rtNone then
    Caption := App.Caption + ' v' + Copy(App.Version, 1, 5)
  else Caption := App.Caption + ' v' + Copy(App.Version, 1, 5) + ' (δע���)';

  actReg.Visible := App.RegType = rtUnReged;
  //liujw��2010-04-12�Ĺ������ٷ������ð�
  actPage.Visible := False;
  actBuy.Visible := App.RegType = rtUnReged;

  sbPer.Panels[2].Text := App.Caption + ' v' + Copy(App.Version, 1, 5);
  tvPer.Items.GetFirstNode.Text := App.Company.Name;
  //�¼���ֵ
  dgStaff.DataSource.OnDataChange := StaffDataChange;
  //��������
  pmiView.Default := not App.ParamSet.DblEdit;
  pmiEdit.Default := App.ParamSet.DblEdit;

  //�����...
  DrawTree();
  //Ȩ��
  SetPower();
end;

procedure TfrmMain.SetImage;
var
  x, y, w, h: Integer;
  pic: TPicture;
begin
  if not actBackImage.Enabled then Exit;

  with App.ParamSet.BackImage do
  begin
    actBackImage.Visible := Enabled;
    if Layout <> loTile then
    begin
      if imgMain.Image <> FileName then imgMain.Image := FileName;
      imgMain.Center := Layout = loCenter;
      imgMain.Stretch := Stretch;
      imgMain.Proportional := Stretch and KeepScale;
    end
    else
    begin
      imgMain.Image := '';
      pic := TPicture.Create;
      try
        pic.LoadFromFile(FileName);
        w := pic.Width;
        h := pic.Height;

        y := 0;
        imgMain.Canvas.Refresh;
        while y < Screen.Height do
        begin
          x := 0;
          while x < Screen.Width do
          begin
            imgMain.Canvas.Draw(x, y, pic.Graphic);
            Inc(x, w);
          end;
          Inc(y, h);
        end;
      finally
        pic.Free;
      end;
    end;
    //����ɫ
    tsImage.Color := BGColor;
  end;
end;

procedure TfrmMain.SetActState;
begin
  actAdd.Enabled := not actChart.Checked;
  actEdit.Enabled := aqStaff.Active and (aqStaff.RecordCount <> 0) and not actChart.Checked;
  actDel.Enabled := actEdit.Enabled and not actChart.Checked;
  actInqu.Enabled := actAdd.Enabled;
  actView.Enabled := aqStaff.Active and (aqStaff.RecordCount <> 0);
  actBatchEdit.Enabled := actAdd.Enabled;
  actDup.Enabled := actEdit.Enabled;
  actSelAll.Enabled := actEdit.Enabled;

  actPCur.Enabled := actView.Enabled;
  actPAll.Enabled := actView.Enabled;
  actPList.Enabled := actView.Enabled;
  actField.Enabled := actAdd.Enabled;

  actLeave.Enabled := actEdit.Enabled and (aqStaff.FieldByName('workState').AsInteger = 0);
  actUnLeave.Enabled := actEdit.Enabled and (aqStaff.FieldByName('workState').AsInteger = 2);
  actMove.Enabled := actEdit.Enabled and (aqStaff.FieldByName('workState').AsInteger <> 1);
  actLeft.Enabled := actMove.Enabled;
  actBack.Enabled := actEdit.Enabled and (aqStaff.FieldByName('workState').AsInteger = 1);

  //���ܱ༭��ְ״̬
  actEdit.Enabled := actEdit.Enabled and ((aqStaff.FieldByName('workState').AsInteger <> 1) or App.ParamSet.LeftCanEdit);
end;

procedure TfrmMain.SetFieldProp;
var
  i: Integer;
  ColumnEh: TColumnEh;
begin
  with App.GridSet do
    //�ж�Columns.Count����Ϊ����Index�����ظ�����Ը�Ϊ�ж�Fields
    for i := 0 to Fields.Count - 1 do
    begin
      ColumnEh := dgStaff.FieldColumns[Fields.Names[i]];
      ColumnEh.Title.Caption := FieldLabels[i];
      ColumnEh.Visible := FieldVisibles[i + 1] = '1';
      ColumnEh.Index := StrToInt(Indexes[i]);
      if ColumnEh.Field.DataType = ftDateTime then ColumnEh.DisplayFormat := DateFormat;
    end;

  AutoFitWidth(dgStaff);
end;

procedure TfrmMain.DoFilterData;
var
  sFilter: string;
  Node: TTreeNode;
begin
  if FBackFromInqu then
  begin
    FBackFromInqu := False;
    cbState.OnChange(cbState);
  end;

  //��
  Node := tvPer.Selected;
  if Node = nil then Exit;

  if Node.Level > 1 then
  begin
    case GetNodeType(Node) of
      ntDept:     sFilter := 'deptName LIKE ' + QuotedStr(GetDeptStr(Node) + '%');
      ntDuty:     sFilter := 'duty = ' + QuotedStr(Node.Text);
      ntType:     sFilter := 'workKind = ' + QuotedStr(Node.Text);
      ntTechnic:  sFilter := 'technic = ' + QuotedStr(Node.Text);
      ntSex:      sFilter := 'sex = ' + QuotedStr(Node.Text);
      ntFolk:     sFilter := 'folk = ' + QuotedStr(Node.Text);
      ntMarriage: sFilter := 'marriage = ' + QuotedStr(Node.Text);
      ntPolity:   sFilter := 'politics = ' + QuotedStr(Node.Text);
      ntCulture:  sFilter := 'culture = ' + QuotedStr(Node.Text);
      ntSpecial:  sFilter := 'special = ' + QuotedStr(Node.Text);
    end;
  end;

  //������
  if Trim(edtSrh.Text) <> '' then
  begin
    if sFilter <> '' then
      sFilter := '(' + sFilter + ' AND staffNo LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ') OR ' +
                 '(' + sFilter + ' AND staffName LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ') OR ' +
                 '(' + sFilter + ' AND staffPY LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ') OR ' +
                 '(' + sFilter + ' AND mobile LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ') OR ' +
                 '(' + sFilter + ' AND tel LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ')'
    else
      sFilter := 'staffNo LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ' OR staffName LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') +
                 ' OR staffPY LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ' OR mobile LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') +
                 ' OR tel LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%');
  end;

  if sFilter = '' then
  begin
    aqStaff.Filtered := False;
    AutoFitWidth(dgStaff);
  end
  else
  begin
    FilterData(aqStaff, sFilter);
    //���Է��֣���1000���������ݣ���������
    AutoFitWidth(dgStaff);
  end;

  //ͼ����ʾ
  if actChart.Checked then
    MakeChart()
  else SetActState();
end;

procedure TfrmMain.RequeryStaffs(const ALocate: Boolean);
begin
  if not aqStaff.Active then Exit;

  if ALocate then
  begin
    aqStaff.DisableControls;
    try
      dgStaff.SaveBookmark;
      aqStaff.Requery();
      dgStaff.RestoreBookmark;
    finally
      aqStaff.EnableControls;
    end;
  end
  else aqStaff.Requery();
end;

function TfrmMain.GetWhrStr: string;
var
  Node: TTreeNode;
begin
  Result := GetWhrStrFromState();

  //��
  Node := tvPer.Selected;
  if (Node <> nil) and (Node.Level > 1) then
  begin
    case GetNodeType(Node) of
      ntDept:     Result := Result + ' AND deptName LIKE ' + QuotedStr(GetDeptStr(Node) + '%');
      ntDuty:     Result := Result + ' AND duty=' + QuotedStr(Node.Text);
      ntType:     Result := Result + ' AND workKind=' + QuotedStr(Node.Text);
      ntTechnic:  Result := Result + ' AND technic=' + QuotedStr(Node.Text);
      ntSex:      Result := Result + ' AND sex=' + QuotedStr(Node.Text);
      ntFolk:     Result := Result + ' AND folk=' + QuotedStr(Node.Text);
      ntMarriage: Result := Result + ' AND marriage=' + QuotedStr(Node.Text);
      ntPolity:   Result := Result + ' AND politics=' + QuotedStr(Node.Text);
      ntCulture:  Result := Result + ' AND culture=' + QuotedStr(Node.Text);
      ntSpecial:  Result := Result + ' AND special=' + QuotedStr(Node.Text);
    end;
  end;

  //������
  if Trim(edtSrh.Text) <> '' then
    Result := Result + ' AND (staffNo LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ' OR staffName LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ' OR staffPY LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ' OR ' +
    'mobile LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ' OR tel LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ')';
end;

function TfrmMain.GetWhrStrFromState: string;
begin
  if cbState.ItemIndex = 0 then
    Result := '0=0'
  else if cbState.ItemIndex = 1 then
    Result := 'workState <> 1'
  else Result := 'workState=' + IntToStr(cbState.ItemIndex - 1);
end;

procedure TfrmMain.MakeChart;
var
  Node: TTreeNode;
  NodeType: TNodeType;
  i: Integer;
  sWhr, sGrp, sXValue: string;
  aqStat: TADOQuery;

  //����ͼ������
  procedure MakeDeptChart;
    function GetDeptStaffCount(ANode: TTreeNode): Integer;
    var
      sFilter: string;
    begin
      sFilter := 'deptName LIKE ' + QuotedStr(GetDeptStr(ANode) + '%');
      //������
      if Trim(edtSrh.Text) <> '' then
      begin
        if sFilter <> '' then sFilter := '(' + sFilter + ' AND staffNo LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ') OR ' +
          '(' + sFilter + ' AND staffName LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ') OR (' + sFilter + ' AND staffPY LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ')'
        else sFilter := 'staffNo LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ' OR staffName LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ' OR staffPY LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%');
      end;

      FilterData(aqStat, sFilter);
      Result := aqStat.RecordCount;
    end;

    function GetDeptStr(ANode: TTreeNode): string;
    begin
      Result := App.ViewSet.DeptStr;
      if ANode.Level <= 1 then Exit;

      Result := ANode.Text;
      while ANode.Level <> 1 do
      begin
        ANode := ANode.Parent;
        Result := ANode.Text + '->' + Result;
      end;
    end;

  var
    j, rCount, dCount: Integer;
  begin
    if Node.Level = 0 then Node := Node.getFirstChild;
    if (Node = nil) or (GetNodeType(Node) <> ntDept) then Exit;

    chtStaff.Title.Text.Text := 'ͳ����Ϣ - ' + GetDeptStr(Node);
    aqStat := TADOQuery.Create(Self);
    aqStat.Clone(TADOQuery(dgStaff.DataSource.DataSet), ltReadOnly);
    chtStaff.Series[0].Clear;
    if Node.HasChildren then
    begin
      rCount := GetDeptStaffCount(Node);
      for j := 0 to Node.Count - 1 do
      begin
        sXValue := Node.Item[j].Text;
        dCount := GetDeptStaffCount(Node.Item[j]);
        chtStaff.Series[0].Add(dCount, sXValue);
        Dec(rCount, dCount);
      end;
      if Node.Level >= 2 then chtStaff.Series[0].Add(rCount, Node.Text);
    end
    else chtStaff.Series[0].AddY(GetDeptStaffCount(Node), Node.Text);
  end;

begin
  Node := tvPer.Selected;
  NodeType := GetNodeType(Node);
  if NodeType in [ntNone, ntDept] then
  begin
    try
      MakeDeptChart();
      Exit;
    finally
      aqStat.Free;
    end;
  end
  else if Node.Level > 1 then Node := Node.Parent;

  sGrp := GetNodeField(NodeType);
  chtStaff.Title.Text.Text := 'ͳ����Ϣ - ' + Node.Text;

  //WHERE��ѯ����
  sWhr := GetWhrStrFromState();
  if Trim(edtSrh.Text) <> '' then
    sWhr := sWhr + ' AND (staffNo LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ' OR staffName LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ' OR staffPY LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ')';

  //����ͼ��
  if NodeType <> ntSex then
    dmPer.OpenStat(sWhr, sGrp, GetNodeKind(Node))
  else dmPer.OpenQuery(dmPer.aqStat, 'SELECT sex AS kindName, Count(id) AS [staCount] FROM [staffs] WHERE ' + sWhr + ' GROUP BY sex');
  aqStat := dmPer.aqStat;
  chtStaff.Series[0].Clear;
  for i := 0 to aqStat.RecordCount - 1 do
  begin
    sXValue := aqStat.FieldByName('kindName').AsString;
    if sXValue = '' then sXValue := 'δָ��';

    chtStaff.Series[0].Add(aqStat.FieldByName('staCount').AsFloat, sXValue);
    aqStat.Next;
  end;
end;

procedure TfrmMain.ChangeChartType(AChartType: TChartType);
var
  ts: TChartSeries;
begin
  ts := chtStaff.Series[0];
  case AChartType of
    ctPie: ChangeSeriesType(ts, TChartSeriesClass(TPieSeries));
    ctBar: ChangeSeriesType(ts, TChartSeriesClass(TBarSeries));
    ctLine: ChangeSeriesType(ts, TChartSeriesClass(TLineSeries));
  end;
  with App.ChartSet do
    ChartType := AChartType;
end;

procedure TfrmMain.StaffDataChange(Sender: TObject; Field: TField);
begin
  if dgStaff.Focused then
  begin
    if GetAsyncKeyState(VK_CONTROL) <> 0 then
      dgStaff.Options := dgStaff.Options + [dgMultiSelect]
    else dgStaff.Options := dgStaff.Options - [dgMultiSelect];
  end;

  //����ͼƬ
  if App.ViewMode.ShowPhoto then
  begin
    if FileExists(App.Path + 'photos\' + aqStaff.FieldByName('photoStr').AsString) then
      imgPhoto.Image := App.Path + 'photos\' + aqStaff.FieldByName('photoStr').AsString
    else imgPhoto.Image := App.Path + 'photos\photo.bmp';
  end;

  SetActState();
  sbPer.Panels[1].Text := Format('��¼���� %d / %d', [Abs(aqStaff.RecNo), aqStaff.RecordCount]);
end;

procedure TfrmMain.DrawTree;
var
  Root: TTreeNode;
begin
  //��ȡ�Ƿ��в����б�
  App.GetTreeList();
  //������һ���ڵ�
  Root := tvPer.Items.GetFirstNode;
  Root.DeleteChildren;
  with App.ViewSet, tvPer.Items do
  begin
    if ShowDept then AddChildObject(Root, DeptStr, PInteger(0));
    if ShowDuty then AddChildObject(Root, DutyStr, PInteger(1));
    if ShowType then AddChildObject(Root, TypeStr, PInteger(2));
    if ShowTechnic then AddChildObject(Root, TechnicStr, PInteger(3));
    if ShowSex then AddChildObject(Root, SexStr, PInteger(4));
    if ShowFolk then AddChildObject(Root, FolkStr, PInteger(5));
    if ShowMarriage then AddChildObject(Root, MarriageStr, PInteger(6));
    if ShowPolity then AddChildObject(Root, PolityStr, PInteger(7));
    if ShowCulture then AddChildObject(Root, CultureStr, PInteger(8));
    if ShowSpecial then AddChildObject(Root, SpecialStr, PInteger(9));
  end;

  //���
  BuildKind();

  if Root.Count <> 0 then
  begin
    Root.getFirstChild.Expand(False);
    Root.getFirstChild.Selected := True;
  end;
end;

procedure TfrmMain.BuildKind;
var
  i: Integer;
  Root, Node: TTreeNode;
begin
  Root := tvPer.Items.GetFirstNode;
  for i := 0 to Root.Count - 1 do
  begin
    Node := Root.Item[i];
    case GetNodeType(Node) of
      ntDept: DrawDept(Node);
      ntDuty: DrawKind(Node, ktDuty);
      ntType: DrawKind(Node, ktType);
      ntTechnic: DrawKind(Node, ktTechnic);
      ntSex:
      begin
        Node.DeleteChildren;
        tvPer.Items.AddChild(Node, '��');
        tvPer.Items.AddChild(Node, 'Ů');
      end;
      ntFolk: DrawKind(Node, ktFolk);
      ntMarriage: DrawKind(Node, ktMarriage);
      ntPolity: DrawKind(Node, ktPolity);
      ntCulture: DrawKind(Node, ktCulture);
      ntSpecial: DrawKind(Node, ktSpecial);
    else
      //do nothing;
    end;
  end;
  if Root.getFirstChild <> nil then Root.getFirstChild.Expand(False);

  if App.StateIndex <= cbState.Items.Count - 1 then cbState.ItemIndex := App.StateIndex;
end;

procedure TfrmMain.SetViewMode(Sender: TObject);
var
  ViewMode: TViewMode;
begin
  TAction(Sender).Checked := not TAction(Sender).Checked;

  actPhoto.Enabled := actTree.Checked;
  spPer.Visible := actTree.Checked;
  pnlLeft.Visible := actTree.Checked;
  pnlPhoto.Visible := actPhoto.Checked;
  pnlTool.Visible := actTool.Checked;

  with ViewMode do
  begin
    ShowTree := actTree.Checked;
    ShowPhoto := actPhoto.Checked;
    ShowTool := actTool.Checked;
  end;
  App.ViewMode := ViewMode;
end;

procedure TfrmMain.SetPower;
begin
  //ϵͳ����Ա
  actAdmin.Visible := App.AdminType = atSystem;
  actInitData.Visible := App.AdminType = atSystem;
  actLog.Visible := App.AdminType = atSystem;

  //����û�...
  //ϵͳ
  actBase.Visible := App.AdminType <> atViewer;
  miBaseData.Visible := actBase.Visible;
  actDept.Visible := actBase.Visible;
  actDict.Visible := actBase.Visible;
  actSet.Visible := actBase.Visible;
  actAwake.Visible := actBase.Visible;
  actDKind.Visible := actBase.Visible;
  //����
  Spacer1.Visible := actBase.Visible;
  actAdd.Visible := actBase.Visible;
  actBatchEdit.Visible := actAdd.Visible;
  actDup.Visible := actBase.Visible;
  actEdit.Visible := actBase.Visible;
  actDel.Visible := actBase.Visible;
  actBatchEdit.Visible := actBase.Visible;
  actField.Visible := actBase.Visible;

  //�����˵�
  actSelAll.Visible := actBase.Visible;
  pmiSMove.Visible := actBase.Visible;

  actLeave.Visible := actBase.Visible;
  actUnLeave.Visible := actBase.Visible;
  actMove.Visible := actBase.Visible;
  actLeft.Visible := actBase.Visible;
  actBack.Visible := actBase.Visible;
  //��ͬ
  actNewC.Visible := actBase.Visible;
  actImportC.Visible :=actBase.Visible;
  //����
  actDiary.Visible := actBase.Visible;
  actAddr.Visible := actBase.Visible;
  //����
  miData.Visible := actBase.Visible;
  //����
  actReg.Visible := actReg.Visible and actBase.Visible;

  sbPer.Panels[0].Text := ADMIN_TYPE[Ord(App.AdminType)] + '��' + App.UserID;
end;

procedure TfrmMain.OnHint(Sender: TObject);
begin
  if not Application.MainForm.Active then Exit;

  if Application.Hint <> '' then
    sbPer.Panels[2].Text := Application.Hint
  else sbPer.Panels[2].Text := App.Caption + ' v' + Copy(App.Version, 1, 5);
end;

procedure TfrmMain.WMSetCursor(var Msg: TWMSetCursor);
begin
  if (SmallInt(Msg.HitTest) = HTERROR) and (Msg.MouseMsg = WM_LBUTTONDOWN) then
    DefaultHandler(Msg)
  else inherited;
end;

procedure TfrmMain.WMSysCommand(var Msg: TWMSysCommand);
begin
  if Msg.CmdType = SC_MINIMIZE then
    WindowState := wsMinimized
  else inherited;
end;

procedure TfrmMain.WMKindChanged(var Msg: TMessage);
begin
  BuildKind();
end;

procedure TfrmMain.WMStaffChanged(var Msg: TMessage);
begin
  AutoFitWidth(dgStaff);
end;

procedure TfrmMain.WMInquStaff(var Msg: TMessage);
var
  buf: array[0..MAX_PATH - 1] of Char;
begin
  GlobalGetAtomName(Msg.LParam, buf, MAX_PATH);
  edtSrh.Text := StrPas(buf);
  GlobalDeleteAtom(Msg.LParam);
end;

procedure TfrmMain.WMFieldChanged(var Msg: TMessage);
var
  i: Integer;
  Node: TTreeNode;
begin
  SetFieldProp();
  for i := 0 to tvPer.Items.GetFirstNode.Count - 1 do
  begin
    with tvPer.Items, App.ViewSet do
    begin
      Node := GetFirstNode.Item[i];
      case GetNodeType(Node) of
        ntDept:     Node.Text := DeptStr;
        ntDuty:     Node.Text := DutyStr;
        ntType:     Node.Text := TypeStr;
        ntTechnic:  Node.Text := TechnicStr;
        ntSex:      Node.Text := SexStr;
        ntFolk:     Node.Text := FolkStr;
        ntMarriage: Node.Text := MarriageStr;
        ntPolity:   Node.Text := PolityStr;
        ntCulture:  Node.Text := CultureStr;
        ntSpecial:  Node.Text := SpecialStr;
      end;
    end;
  end;
end;

procedure TfrmMain.WMDataCompressed(var Msg: TMessage);
begin
  cbState.OnChange(cbState);
end;

procedure TfrmMain.WMDataRestore(var Msg: TMessage);
begin
  DrawTree();
  cbState.OnChange(cbState);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  //��ʾȫ�˵�
  SetWindowLong(Application.Handle, GWL_EXSTYLE, GetWindowLong(Application.Handle, GWL_EXSTYLE) or not WS_EX_APPWINDOW);
  //�������䣬˳���в��ɱ�
  SetWindowLong(Handle, GWL_HWNDPARENT, HWND_DESKTOP);
  SetWindowLong(Application.Handle, GWL_HWNDPARENT, Handle);
  //���洰��״̬
  WindowState := TWindowState(App.WindowState);

  Application.ShowHint := True;
  Application.OnHint := OnHint;
  InitData();
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  //�жϲ���
  if (App.DeptList.Count = 0) and (MessageBox(Handle, '����û���趨��˾���ţ�������Ա����������ģ���Ҫ��������ô��', '��ʾ',  MB_ICONQUESTION + MB_YESNO) = IDYES) then actDept.Execute;
  //�¼���ʾ
  if App.ParamSet.AwakeSet.Enabled then tmrAwake.Enabled := dmPer.GetCanAwake();

  //���жϣ�Ϊ���ӽڵ㶼����ʾ����
  if tvPer.Items.GetFirstNode.Count <> 0 then
    with tvPer.Items.GetFirstNode do
    begin
      Expand(False);
      getFirstChild.Expand(False);
      getFirstChild.Selected := True;
    end;

  //�п�����Ӧ
  AutoFitWidth(dgStaff);
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if WindowState <> wsMinimized then App.WindowState := WindowState;
  App.StateIndex := cbState.ItemIndex;
end;

procedure TfrmMain.FormPaint(Sender: TObject);
begin
  //����ƽ������
  with App.ParamSet.BackImage do
    if Enabled and (Layout = loTile) and (pcMain.ActivePageIndex = 1) then
    SetImage();
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  sbPer.Panels[2].Width := sbPer.Width - sbPer.Panels[0].Width - sbPer.Panels[1].Width - sbPer.Panels[3].Width;
end;

procedure TfrmMain.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  //���actDel�õ���Del��ݼ��Ա༭�������
  case Msg.CharCode of
    VK_DELETE:
    begin
      //��ݼ�����...
      if not Active or (ActiveControl is TCustomEdit) then
        actDel.ShortCut := 0
      else actDel.ShortCut := ShortCut(VK_DELETE, []);
    end;
  else
    //;
  end;
end;

procedure TfrmMain.tmrTimeTimer(Sender: TObject);
begin
  sbPer.Panels[3].Text := FormatDateTime('yyyy��mm��dd�� hhʱnn��ss��', Now()) + '  [' + FormatDateTime('ddd', Date()) + ']   ';
end;

procedure TfrmMain.actChgpwdExecute(Sender: TObject);
begin
  ShowChgPwd();
end;

procedure TfrmMain.actDeptExecute(Sender: TObject);
var
  DeptNode: TTreeNode;
begin
  if ShowDept() then
  begin
    DeptNode := tvPer.Items.GetFirstNode.getFirstChild;
    if (DeptNode <> nil) and (GetNodeType(DeptNode) = ntDept) then
    begin
      DrawDept(DeptNode);
      DeptNode.Expand(False);
      DoFilterData();
    end;
  end;
end;

procedure TfrmMain.actDictExecute(Sender: TObject);
begin
  if ShowDict() then DoFilterData();
end;

procedure TfrmMain.actCompanyExecute(Sender: TObject);
begin
  if ShowCompany(App.Company) and (tvPer.Items.GetFirstNode.Text <> App.Company.Name) then
  begin
    tvPer.Items.GetFirstNode.Text := App.Company.Name;
    Caption := Copy(Caption, 1, Pos('-', Caption)) + ' ' + App.Company.Name;
  end;
end;

procedure TfrmMain.actDKindExecute(Sender: TObject);
begin
  if ShowView() then DrawTree();
end;

procedure TfrmMain.actAwakeExecute(Sender: TObject);
begin
  ShowAwake();
end;

procedure TfrmMain.actSetExecute(Sender: TObject);
begin
  if ShowParamSet(App.ParamSet) then
  begin
    SetImage();
    
    pmiView.Default := not App.ParamSet.DblEdit;
    pmiEdit.Default := App.ParamSet.DblEdit;
    //�ı���ְ��Ա�����༭״̬
    dgStaff.DataSource.OnDataChange(dgStaff.DataSource, nil);
    //��������ʾ������
    dgStaff.Repaint;
  end;
end;

procedure TfrmMain.actExitExecute(Sender: TObject);
begin
  if MessageBox(Handle, '��Ҫ�˳�������µ�������ϵͳô��', '��ʾ',  MB_ICONQUESTION + MB_YESNO) = IDYES then Close();
end;

procedure TfrmMain.actAdminExecute(Sender: TObject);
begin
  ShowAdmin();
end;

procedure TfrmMain.actLoginExecute(Sender: TObject);
begin
  if ShowLogin() then SetPower();
end;

procedure TfrmMain.actAddExecute(Sender: TObject);
var
  sDeptStr: string;
begin
  if not GetCanAdd(Handle) then Exit;

  Screen.Cursor := crHourGlass;
  try
    FBookMark := aqStaff.GetBookmark;
    if Assigned(tvPer.Selected) and (tvPer.Selected.Level > 1) and (GetNodeType(tvPer.Selected) = ntDept) then
      sDeptStr := GetDeptStr(tvPer.Selected)
    else sDeptStr := '';
    if not ShowStaff(aoAdd, sDeptStr) and aqStaff.BookmarkValid(FBookMark) then
    begin
      aqStaff.GotoBookmark(FBookMark);
      aqStaff.FreeBookmark(FBookMark);
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmMain.actEditExecute(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    ShowStaff(aoEdit);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmMain.actDelExecute(Sender: TObject);
var
  sPhoto: string;
  i: Integer;
  aqTemp: TADOQuery;
begin
  if MessageBox(Handle, '��ȷ��Ҫɾ��ѡ���ļ�¼��', '��ʾ',  MB_ICONQUESTION + MB_YESNO) = IDYES then
  begin
    //��dgMultiSelect�£���Ϊ0
    if dgStaff.SelectedRows.Count = 0 then
    begin
      //ɾ����Ƭ
      sPhoto := App.Path + 'photos\' + aqStaff.FieldByName('photoStr').AsString;
      if FileExists(sPhoto) then DeleteFile(sPhoto);

      Log.Write(App.UserId + 'ɾ����Ա����[' + aqStaff.FieldByName('staffNo').AsString + '(' + aqStaff.FieldByName('staffName').AsString + ')]');
      aqStaff.Delete()
    end
    else
    begin
      //ɾ��ͼƬ
      aqTemp := TADOQuery.Create(Self);
      try
        aqTemp.Clone(TADOQuery(dgStaff.DataSource.DataSet), ltReadOnly);
        for i := 0 to dgStaff.SelectedRows.Count - 1 do
        begin
          aqTemp.GotoBookmark(TBookMark(dgStaff.SelectedRows.Items[i]));
          sPhoto := App.Path + 'photos\' + aqTemp.FieldByName('photoStr').AsString;
          if FileExists(sPhoto) then DeleteFile(sPhoto);

          Log.Write(App.UserId + 'ɾ����Ա����[' + aqTemp.FieldByName('staffNo').AsString + '(' + aqTemp.FieldByName('staffName').AsString + ')]');
        end;
      finally
        aqTemp.Free;
      end;

      dgStaff.SelectedRows.Delete;
    end;

    aqStaff.UpdateBatch();
    SetActState();
  end;
end;

procedure TfrmMain.actInquExecute(Sender: TObject);
var
  sWhr: string;
begin
  if ShowInqu(dgStaff, sWhr) then
  begin
    edtSrh.Text := '';
    dmPer.OpenQuery(aqStaff, 'SELECT * FROM [staffs] WHERE ' + sWhr + ' AND ' + GetWhrStrFromState() + ' ORDER BY staffNo');

    //����ڴ˴����������¼�����DoFilterData֮����
    FBackFromInqu := True;
  end;
end;

procedure TfrmMain.actAPExecute(Sender: TObject);
begin
  if ShowAP() then dmPer.DealAPRecord();
end;

procedure TfrmMain.actTrainExecute(Sender: TObject);
begin
  if ShowTrain() then dmPer.DealTrainRecord;
end;

procedure TfrmMain.actFieldExecute(Sender: TObject);
begin
  ShowField(dgStaff);
end;

procedure TfrmMain.actPCurExecute(Sender: TObject);
begin
  dmPer.PrintCurrent();
end;

procedure TfrmMain.actPAllExecute(Sender: TObject);
begin
  dmPer.PrintAll();
end;

procedure TfrmMain.actPListExecute(Sender: TObject);
begin
  PrintDBGridEh(dgStaff, App.Company.Name + 'Ա��������Ϣ');
end;

procedure TfrmMain.actPSetExecute(Sender: TObject);
begin
  ShowPrint();
end;

procedure TfrmMain.actViewExecute(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    ShowStaff(aoView);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmMain.actDupExecute(Sender: TObject);
begin
  if not GetCanAdd(Handle) then Exit;

  Screen.Cursor := crHourGlass;
  try
    FBookMark := aqStaff.GetBookmark;
    if not ShowStaff(aoDulAdd) and aqStaff.BookmarkValid(FBookMark) then
    begin
      aqStaff.GotoBookmark(FBookMark);
      aqStaff.FreeBookmark(FBookMark);
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmMain.actBatchEditExecute(Sender: TObject);
begin
  ShowBatchEdit(dgStaff, GetWhrStr());
end;

procedure TfrmMain.actSelAllExecute(Sender: TObject);
begin
  if dgStaff.DataSource.DataSet.RecordCount = 0 then Exit;

  //�����¼���
  dgStaff.DataSource.OnDataChange := nil;
  dgStaff.Options := dgStaff.Options + [dgMultiSelect];
  with dgStaff.DataSource.DataSet do
  begin
    First;
    while not EOF do
    begin
      dgStaff.SelectedRows.CurrentRowSelected := True;
      Next;
    end;
  end;
  dgStaff.DataSource.OnDataChange := StaffDataChange;
end;

procedure TfrmMain.actMBaseExecute(Sender: TObject);
begin
  //
end;

procedure TfrmMain.actLeaveExecute(Sender: TObject);
begin
  if ShowLeave(ltLeave) then dgStaff.Repaint;
end;

procedure TfrmMain.actUnLeaveExecute(Sender: TObject);
begin
  if ShowLeave(ltUnLeave) then dgStaff.Repaint;
end;

procedure TfrmMain.actMoveExecute(Sender: TObject);
begin
  ShowMove(aoAdd);
end;

procedure TfrmMain.actLeftExecute(Sender: TObject);
begin
  if ShowLeft(aoAdd) and (cbState.ItemIndex = 1) then
  begin
    aqStaff.Delete;
    RequeryStaffs();
  end;
end;

procedure TfrmMain.actBackExecute(Sender: TObject);
begin
  if ShowBack() and (cbState.ItemIndex = 2) then
  begin
    aqStaff.Delete;
    RequeryStaffs();
  end;
end;

procedure TfrmMain.actInLeaveExecute(Sender: TObject);
begin
  ShowInquLeave();
  dmPer.OpenLeave();
end;

procedure TfrmMain.actInMoveExecute(Sender: TObject);
begin
  ShowInquMove(itMove);
end;

procedure TfrmMain.actInLeftExecute(Sender: TObject);
begin
  ShowInquMove(itLeft);
end;

procedure TfrmMain.actInBackExecute(Sender: TObject);
begin
  ShowInquMove(itBack);
end;

procedure TfrmMain.actChartExecute(Sender: TObject);
begin
  actChart.Checked := not actChart.Checked;
  btnChart.Down := actChart.Checked;

  if actChart.Checked then
    pnlChart.BringToFront
  else dgStaff.BringToFront;

  SetActState();
  if actChart.Checked then MakeChart();
end;

procedure TfrmMain.actNewCExecute(Sender: TObject);
begin
  ShowContDlg(aoAdd);
end;

procedure TfrmMain.actContractExecute(Sender: TObject);
begin
  ShowContract();
end;

procedure TfrmMain.actEndCExecute(Sender: TObject);
begin
  ShowAwake(False, 1);
end;

procedure TfrmMain.actImportCExecute(Sender: TObject);
begin
  ShowImportC();
end;

procedure TfrmMain.actBackupExecute(Sender: TObject);
begin
  ShowDataBack();
end;

procedure TfrmMain.actExportExecute(Sender: TObject);
begin
  ShowExport(dgStaff, GetWhrStr());
end;

procedure TfrmMain.actImportExecute(Sender: TObject);
begin
  ShowImport(dgStaff);
end;

procedure TfrmMain.actImportPExecute(Sender: TObject);
begin
  ShowImportP();
end;

procedure TfrmMain.actRestoreExecute(Sender: TObject);
begin
  ShowDataRestore();
end;

procedure TfrmMain.actCompressExecute(Sender: TObject);
begin
  dmPer.CompressData(Handle);
end;

procedure TfrmMain.actInitDataExecute(Sender: TObject);
begin
  ShowDataInit();
end;

procedure TfrmMain.actNewRExecute(Sender: TObject);
var
  sWhr: string;
begin
  ShowInquR(stNew, sWhr);
  FBackFromInqu := True;
end;

procedure TfrmMain.actLeftRExecute(Sender: TObject);
var
  sWhr: string;
begin
  if ShowInquR(stLeft, sWhr) then ShowInquMove(itLeft, sWhr);
end;

procedure TfrmMain.actBackRExecute(Sender: TObject);
var
  sWhr: string;
begin
  if ShowInquR(stBack, sWhr) then ShowInquMove(itBack, sWhr);
end;

procedure TfrmMain.actMoveRExecute(Sender: TObject);
var
  sWhr: string;
begin
  if ShowInquR(stMove, sWhr) then ShowInquMove(itMove, sWhr);
end;

procedure TfrmMain.actDiaryExecute(Sender: TObject);
begin
  ShowDiary();
end;

procedure TfrmMain.actAddrExecute(Sender: TObject);
begin
  ShowAddr();
end;

procedure TfrmMain.actCalendarExecute(Sender: TObject);
begin
  ShowCalendar();
end;

procedure TfrmMain.actCodeExecute(Sender: TObject);
begin
  ShowCode();
end;

procedure TfrmMain.actCameraExecute(Sender: TObject);
begin
  ShowVideo(Self, 'cap_image', True);
end;

procedure TfrmMain.actCalcExecute(Sender: TObject);
begin
  WinExec('calc.exe', SW_SHOW);
end;

procedure TfrmMain.actNoteExecute(Sender: TObject);
begin
  WinExec('notepad.exe', SW_SHOW);
end;

procedure TfrmMain.actHelpExecute(Sender: TObject);
begin
  HtmlHelp(Application.Handle, App.Path + 'help.chm::/welcome.html' + '', HH_DISPLAY_TOPIC, 0);
end;

procedure TfrmMain.actPageExecute(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PAnsiChar(AW_HOMEPAGE), nil, nil, SW_SHOW);
end;

procedure TfrmMain.actQQExecute(Sender: TObject);
begin
  ShellExecute(Handle, 'open', 'tencent://message/?uin=7515933&Site=www.awindsoft.net&Menu=yes', nil, nil, SW_SHOW);
end;

procedure TfrmMain.actLogExecute(Sender: TObject);
begin
  ShowLog();
end;

procedure TfrmMain.actRegExecute(Sender: TObject);
begin
  ShowReg();
end;

procedure TfrmMain.actBuyExecute(Sender: TObject);
begin
  //ShellExecute(Handle, 'open', PAnsiChar(AW_HOMEPAGE + '/order.asp?pid=1&ver=' + App.Version), nil, nil, SW_SHOW);
  ShellExecute(Handle, 'open', PAnsiChar('http://www.sharebank.com.cn/soft/SoftBuy_28396.htm'), nil, nil, SW_SHOW);
end;

procedure TfrmMain.actAboutExecute(Sender: TObject);
begin
  ShowAbout();
end;

procedure TfrmMain.spPerCanResize(Sender: TObject; var NewSize: Integer;
  var Accept: Boolean);
begin
  Accept := (NewSize >= 75) and (NewSize <= 225);
end;

procedure TfrmMain.actTreeExecute(Sender: TObject);
begin
  SetViewMode(Sender);
end;

procedure TfrmMain.actPhotoExecute(Sender: TObject);
begin
  SetViewMode(Sender);
end;                   

procedure TfrmMain.actToolExecute(Sender: TObject);
begin
  SetViewMode(Sender);
end;

procedure TfrmMain.actClearExecute(Sender: TObject);
begin
  //
end;

procedure TfrmMain.actBackImageExecute(Sender: TObject);
begin
  if pcMain.ActivePageIndex = 0 then
  begin
    pcMain.ActivePageIndex := 1;
    OnPaint(Self);
  end
  else if (App.AdminType = atViewer) or App.ParamSet.BackImage.NeedPwd and ShowNeedPwd() or not App.ParamSet.BackImage.NeedPwd then pcMain.ActivePageIndex := 0;
end;

procedure TfrmMain.alPerExecute(Action: TBasicAction;
  var Handled: Boolean);
begin
  Handled := (App.UserID = '') or not TAction(Action).Visible;
  //�ֿ�д���ύЩЧ��
  if not Handled and (App.AdminType <> atViewer) and (Action.Name <> 'actBackImage') and App.ParamSet.BackImage.NeedPwd and (pcMain.ActivePageIndex = 1) then
    Handled := not ShowNeedPwd();
  //��Ҫ�л������ݲ������ڵĲ���
  if not Handled and (Action.Name <> 'actBackImage') and (pcMain.ActivePageIndex = 1) and
    ((Pos(',' + Action.Name + ',', ',actAdd,actEdit,actDel,actInqu,actBatchEdit,actDup,actChart,actNewR,') <> 0)
    or (TAction(Action).Category = 'View')) then
    pcMain.ActivePageIndex := 0;
end;

procedure TfrmMain.tvPerChange(Sender: TObject; Node: TTreeNode);
begin
  DoFilterData();
end;

procedure TfrmMain.tvPerGetImageIndex(Sender: TObject; Node: TTreeNode);
begin
  if Node.Level <> 0 then
  begin
    if Node.HasChildren then
    begin
      if Node.Expanded then
        Node.ImageIndex := 2
      else Node.ImageIndex := 1;
    end
    else
    begin
      if (GetNodeType(Node) = ntDept) or (Node.Level = 1) then
        Node.ImageIndex := 1
      else if GetNodeType(Node) <> ntSex then
        Node.ImageIndex := 3
      else
      begin
        if Node.Text = '��' then
          Node.ImageIndex := 4
        else Node.ImageIndex := 5;
      end;
    end;
  end;
end;

procedure TfrmMain.tvPerGetSelectedIndex(Sender: TObject; Node: TTreeNode);
begin
  if Node.Level <> 0 then
  begin
    if Node.HasChildren then
    begin
      if Node.Expanded then
        Node.SelectedIndex := 2
      else Node.SelectedIndex := 1;
    end
    else
    begin
      if (GetNodeType(Node) = ntDept) or (Node.Level = 1) then
        Node.SelectedIndex := 1
      else if GetNodeType(Node) <> ntSex then
        Node.SelectedIndex := 3
      else
      begin
        if Node.Text = '��' then
          Node.SelectedIndex := 4
        else Node.SelectedIndex := 5;
      end;
    end;
  end;
end;

procedure TfrmMain.cbStateChange(Sender: TObject);
begin
  App.StateIndex := cbState.ItemIndex;

  dmPer.OpenQuery(aqStaff, 'SELECT * FROM [staffs] WHERE ' + GetWhrStrFromState() + ' ORDER BY staffNo');
  DoFilterData();
end;

procedure TfrmMain.edtSrhChange(Sender: TObject);
begin
  DoFilterData();
end;

procedure TfrmMain.tvPerMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Node: TTreeNode;
begin
  if Button = mbRight then
  begin
    Node := tvPer.GetNodeAt(X, Y);
    if Node <> nil then tvPer.Selected := Node;
  end;
end;

procedure TfrmMain.dgStaffDblClick(Sender: TObject);
begin
  if App.ParamSet.DblEdit and actEdit.Enabled then
    actEdit.Execute
  else actView.Execute;
end;

procedure TfrmMain.dgStaffDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ImageIndex: Integer;
  DBGrid: TDBGridEh;
  sDate: string;
  UnLeaveDate: TDate;
begin
  if aqStaff.RecordCount = 0 then Exit;

  DBGrid := TDBGridEh(Sender);
  //����Ů���ͼ��
  if Column.FieldName = 'staffNo' then
  begin
    if aqStaff.FieldByName('sex').AsString = '��' then
    begin
      if aqStaff.FieldByName('workState').AsInteger = 0 then
        ImageIndex := 4
      else if aqStaff.FieldByName('workState').AsInteger = 2 then
        ImageIndex := 10
      else ImageIndex := 6;
    end
    else
    begin
      if aqStaff.FieldByName('workState').AsInteger = 0 then
        ImageIndex := 5
      else if aqStaff.FieldByName('workState').AsInteger = 1 then
        ImageIndex := 11
      else ImageIndex := 7;
    end;
    DBGrid.Canvas.FillRect(Rect);                //DBGrid���еĳ���Ϊ62*16
    dmPer.ilTree.Draw(DBGrid.Canvas, rect.Left, rect.Top + 1, ImageIndex);

    if App.ParamSet.EffLine then
    begin
      if not Odd(aqStaff.RecNo) then
        DBGrid.Canvas.Brush.Color := App.ParamSet.EffColor
      else DBGrid.Canvas.Brush.Color := clWindow;
    end;
    //������ʾ�����ټ�¼
    if (aqStaff.FieldByName('workState').AsInteger = 2) and App.ParamSet.LightLeave then
    begin
      sDate := VarToStrDef(dmPer.aqLeave.Lookup('staffNo;isLeave', VarArrayOf([aqStaff.FieldByName('staffNo').AsString, True]), 'unLeaveDate'), '');
      if sDate <> '' then
      begin
        UnLeaveDate := StrToDate(sDate);
        if UnLeaveDate <= Date() then DBGrid.Canvas.Brush.Color := App.ParamSet.LeaveColor;
      end;
    end;
    if gdSelected in State then DBGrid.Canvas.Brush.Color := $00C56A31;

    DBGrid.DefaultDrawColumnCell(Classes.Rect(Rect.Left + 18, Rect.Top, Rect.Right, Rect.Bottom), DataCol, Column, State);
  end
  else
  begin
    if (Column.FieldName = 'sex') and (Column.Field.AsString = 'Ů') then
      DBGrid.Canvas.Font.Color := clRed;

    if App.ParamSet.EffLine then
    begin
      if not Odd(aqStaff.RecNo) then
        DBGrid.Canvas.Brush.Color := App.ParamSet.EffColor
      else DBGrid.Canvas.Brush.Color := clWindow;
    end;
    //������ʾ�����ټ�¼
    if (aqStaff.FieldByName('workState').AsInteger = 2) and App.ParamSet.LightLeave then
    begin
      sDate := VarToStrDef(dmPer.aqLeave.Lookup('staffNo;isLeave', VarArrayOf([aqStaff.FieldByName('staffNo').AsString, True]), 'unLeaveDate'), '');
      if sDate <> '' then
      begin
        UnLeaveDate := StrToDate(sDate);
        if UnLeaveDate <= Date() then DBGrid.Canvas.Brush.Color := App.ParamSet.LeaveColor;
      end;
    end;
    if gdSelected in State then DBGrid.Canvas.Brush.Color := $00C56A31;

    DBGrid.DefaultDrawColumnCell(Classes.Rect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom), DataCol, Column, State);
  end;
end;

procedure TfrmMain.dgStaffKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: dgStaff.OnDblClick(dgStaff);
    VK_F5: if aqStaff.Active then aqStaff.Requery();
  end;
end;

procedure TfrmMain.dgStaffTitleBtnClick(Sender: TObject; ACol: Integer;
  Column: TColumnEh);
begin
  DBGridEhTitleBtnClick(Sender, ACol, Column);
end;

procedure TfrmMain.pmGridPopup(Sender: TObject);
begin
  if (dgStaff.DataSource = nil) or (dgStaff.DataSource.DataSet = nil) or (dgStaff.DataSource.DataSet.RecordCount = 0) then
  begin
    pmiView.Caption := '�鿴[...]...';
    pmiPrint.Caption := '��ӡ[...]';

    Exit;
  end;

  if dgStaff.DataSource.DataSet.Active then
  begin
    pmiView.Caption := '�鿴[' + dgStaff.DataSource.DataSet.FieldByName('staffName').AsString + ']...';
    pmiPrint.Caption := '��ӡ[' + dgStaff.DataSource.DataSet.FieldByName('staffName').AsString + ']';
  end;
end;

procedure TfrmMain.imgPhotoDblClick(Sender: TObject);
begin
  if imgPhoto.Image <> App.Path + 'photos\photo.bmp' then ShowPhoto(Self, aqStaff.FieldByName('staffName').AsString, imgPhoto.Image);
end;

procedure TfrmMain.rbPieClick(Sender: TObject);
begin
  ChangeChartType(ctPie);
end;

procedure TfrmMain.rbBarClick(Sender: TObject);
begin
  ChangeChartType(ctBar);
end;

procedure TfrmMain.rbLineClick(Sender: TObject);
begin
  ChangeChartType(ctLine);
end;

procedure TfrmMain.cb3DClick(Sender: TObject);
begin
  chtStaff.View3D := cb3D.Checked;
  with App.ChartSet do
    View3D := cb3D.Checked;
end;

procedure TfrmMain.btnExportBmpClick(Sender: TObject);
var
  sd: TSaveDialog;
  sFileName: string;
begin
  sd := TSaveDialog.Create(Self);
  sd.FileName := Trim(chtStaff.Title.Text.Text) + '.bmp';
  sd.Filter := 'λͼ�ļ�(*.bmp)|*.bmp';
  try
    if sd.Execute then
    begin
      sFileName := sd.FileName;
      if not SameText(ExtractFileName(sFileName), '.bmp') then ChangeFileExt(sFileName, '.bmp');
      chtStaff.SaveToBitmapFile(sd.FileName);
    end;
  finally
    sd.Free;
  end;
end;

procedure TfrmMain.frpgPrintColumn(ColumnNo: Integer; var Width: Integer);
var
  i, iCol: Integer;
begin
  iCol := 0;
  for i := 0 to dgStaff.Columns.Count - 1 do
  begin
    if not dgStaff.Columns[i].Visible then Continue;

    Inc(iCol);
    if iCol = ColumnNo then
    begin
      Width := dgStaff.Columns[i].Width + 8;
      Break;
    end;
  end;
end;

procedure TfrmMain.tmrAwakeTimer(Sender: TObject);
begin
  tmrAwake.Enabled := False;
  ShowAwake(True);
end;

procedure TfrmMain.imgMainDblClick(Sender: TObject);
begin
  if App.AdminType = atViewer then Exit;
  if (App.ParamSet.BackImage.NeedPwd and ShowNeedPwd() or not App.ParamSet.BackImage.NeedPwd)
    and ShowParamSet(App.ParamSet, 2) then
    SetImage();
end;

end.
