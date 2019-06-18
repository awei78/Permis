unit uAwake;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzPanel, RzButton, ExtCtrls, uGlobal, DB, ADODB, GridsEh, DBGridEh,
  ComCtrls, StdCtrls, ActnList, ComObj, Mask, RzEdit, RzSpnEdt, FR_View, FR_PTabl,
  DateUtils;

const
  ARR_COL_WIDTH: array[0..5] of Integer = (70, 81, 40, 90, 174, 90);

type
  TfrmAwake = class(TForm)
    tbDiary: TRzToolbar;
    btnExport: TRzToolButton;
    Spacer0: TRzSpacer;
    btnExit: TRzToolButton;
    dsInqu: TDataSource;
    aqInqu: TADOQuery;
    Label5: TLabel;
    Spacer1: TRzSpacer;
    alAddr: TActionList;
    actPrint: TAction;
    actExport: TAction;
    actExit: TAction;
    edtDay: TEdit;               
    udDay: TUpDown;
    Label1: TLabel;
    btnPrint: TRzToolButton;
    pc: TPageControl;
    tsBirth: TTabSheet;
    tsContract: TTabSheet;
    tsStaff: TTabSheet;
    dgInqu: TDBGridEh;
    actHelp: TAction;
    btnSet: TRzToolButton;
    actSet: TAction;
    procedure actExportExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actSetExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure pcChange(Sender: TObject);
    procedure aqInquFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure edtDayChange(Sender: TObject);
    procedure dgInquDblClick(Sender: TObject);
    procedure dgInquDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure dgInquTitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
  private
    { Private declarations }
    FAfterShow: Boolean;
    FAnimateShow: Boolean;
    procedure LoadData;
    function GetSqlStr: string;
    procedure DoFilterData;
    //使模式窗点可闪标题栏
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
  public
    { Public declarations }
  end;

var
  frmAwake: TfrmAwake;

function ShowAwake(AnimateShow: Boolean = False; const APageIndex: Integer = -1): Boolean;

implementation

uses uData, uApp, uParamSet;

{$R *.dfm}

function ShowAwake(AnimateShow: Boolean; const APageIndex: Integer): Boolean;
begin
  if not Assigned(frmAwake) then
  begin
    frmAwake := TfrmAwake.Create(Application.MainForm);
    frmAwake.FAnimateShow := AnimateShow;
    frmAwake.LoadData();
  end
  else frmAwake.FAnimateShow := False;

  if APageIndex <> -1 then frmAWake.pc.ActivePageIndex := APageIndex;
  Result := frmAwake.ShowModal() = mrOk;
end;

procedure TfrmAwake.WMSetCursor(var Msg: TWMSetCursor);
begin
  if (SmallInt(Msg.HitTest) = HTERROR) and (Msg.MouseMsg = WM_LBUTTONDOWN) then
    DefaultHandler(Msg)
  else inherited;
end;

procedure TfrmAwake.LoadData;
var
  sSql: string;
begin
  actSet.Visible := App.AdminType <> atViewer;
  pc.ActivePageIndex := 0;
  //显示有数据之页面
  if not App.ParamSet.AwakeSet.BirthGreg then
    sSql := 'SELECT id FROM [staffs] WHERE workState <> 1 AND (' +
            'DateAdd("yyyy", DatePart("yyyy", Date()) - DatePart("yyyy", iif(birth IS NULL, 0, birth)), iif(birth IS NULL, 0, birth)) - Date() BETWEEN 0 AND ' + IntToStr(App.ParamSet.AwakeSet.BirthDay) +
            ' OR ' +
            'DateAdd("yyyy", DatePart("yyyy", Date() + ' + IntToStr(App.ParamSet.AwakeSet.BirthDay) + ') - DatePart("yyyy", iif(birth IS NULL, 0, birth)), iif(birth IS NULL, 0, birth)) - Date() BETWEEN 0 AND ' + IntToStr(App.ParamSet.AwakeSet.BirthDay) +
            ')'
  else
    sSql := 'SELECT id FROM [staffs] WHERE workState <> 1 AND (' +
            'DateAdd("yyyy", DatePart("yyyy", Date()) - DatePart("yyyy", iif(birthGreg IS NULL, 0, birthGreg)), iif(birthGreg IS NULL, 0, birthGreg)) - Date() BETWEEN 0 AND ' + IntToStr(App.ParamSet.AwakeSet.BirthDay) +
            ' OR ' +
            'DateAdd("yyyy", DatePart("yyyy", Date() + ' + IntToStr(App.ParamSet.AwakeSet.BirthDay) + ') - DatePart("yyyy", iif(birthGreg IS NULL, 0, birthGreg)), iif(birthGreg IS NULL, 0, birthGreg)) - Date() BETWEEN 0 AND ' + IntToStr(App.ParamSet.AwakeSet.BirthDay) +
            ')';

  with dmPer do
  begin
    OpenQuery(aqTemp, sSql);
    if not aqTemp.Eof then
      pc.ActivePageIndex := 0
    else
    begin
      sSql := 'SELECT id FROM [contract] WHERE  ' +
              'endDate BETWEEN #' + DateToStr(Date()) + '# AND #' + DateToStr(IncDay(Date(), App.ParamSet.AwakeSet.ContractDay)) + '#';
      OpenQuery(aqTemp, sSql);
      if not aqTemp.Eof then
        pc.ActivePageIndex := 1
      else
      begin
        sSql := 'SELECT id FROM [staffs] WHERE workState <> 1 AND ' +
                'toStaffDate BETWEEN #' + DateToStr(Date()) + '# AND #' + DateToStr(IncDay(Date(), App.ParamSet.AwakeSet.StaffDay)) + '#';

        OpenQuery(aqTemp, sSql);
        if not aqTemp.Eof then pc.ActivePageIndex := 2;
      end;
    end;
  end;

  pc.OnChange(pc);
end;

function TfrmAwake.GetSqlStr: string;
begin
  case pc.ActivePageIndex of
    0:
    begin
      if not App.ParamSet.AwakeSet.BirthGreg then
        Result := 'SELECT id, staffNo AS [工号], staffName AS [姓名], sex AS [' + App.GridSet.FieldLabels[3] + '], birth AS [' + App.GridSet.FieldLabels[4] + '], deptName AS [' + App.ViewSet.DeptStr + '], ' +
                   'duty AS [' + App.GridSet.FieldLabels[22] + '] FROM [staffs] WHERE workState <> 1 AND birth <> NULL'
      else
        Result := 'SELECT id, staffNo AS [工号], staffName AS [姓名], sex AS [' + App.GridSet.FieldLabels[3] + '], birthGreg AS [今年阳历生日], deptName AS [' + App.ViewSet.DeptStr + '], ' +
                   'duty AS [' + App.GridSet.FieldLabels[22] + '] FROM [staffs] WHERE workState <> 1 AND birthGreg <> NULL';
    end;
    1: Result := 'SELECT id, staffNo AS [工号], staffName AS [姓名], sex AS [' + App.GridSet.FieldLabels[3] + '], endDate AS [合同结束日期], deptName AS [' + App.ViewSet.DeptStr + '], contName AS [合同名称] ' +
                 'FROM [contract] WHERE endDate <> NULL';
    2: Result := 'SELECT id, staffNo AS [工号], staffName AS [姓名], sex AS [' + App.GridSet.FieldLabels[3] + '], toStaffDate AS [' + App.GridSet.FieldLabels[27] + '], deptName AS [' + App.ViewSet.DeptStr + '], ' +
                 'duty AS [' + App.GridSet.FieldLabels[22] + '] FROM [staffs] WHERE workState <> 1 AND toStaffDate <> NULL';
  end;
end;

procedure TfrmAwake.DoFilterData;
begin
  aqInqu.Filtered := False;
  aqInqu.Filtered := True;
end;

procedure TfrmAwake.FormShow(Sender: TObject);
begin
  if FAnimateShow then
  begin
    //淡出显示...
    //位置设定居中
    Left := Application.MainForm.Left + (Application.MainForm.Width - Width) div 2;
    Top := Application.MainForm.Top + (Application.MainForm.Height - Height) div 2;
    AnimateWindow(Handle, 900, AW_VER_POSITIVE);
  end;
  
  FAfterShow := True;
  pc.OnChange(pc);
end;

procedure TfrmAwake.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  App.ParamSet.SaveToIni;
end;

procedure TfrmAwake.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  if Msg.CharCode = VK_ESCAPE then btnExit.OnClick(btnExit);
end;

procedure TfrmAwake.actExportExecute(Sender: TObject);
var
  sFileName: string;
begin
  case pc.ActivePageIndex of
    0: sFileName := '近期生日员工.xls';
    1: sFileName := '合同到期员工.xls';
    2: sFileName := '近期转正员工.xls';
  end;

  DataToExcel(dgInqu, sFileName);
end;

procedure TfrmAwake.actPrintExecute(Sender: TObject);
begin
  PrintDBGridEh(dgInqu, App.Company.Name + pc.ActivePage.Caption);
end;

procedure TfrmAwake.actSetExecute(Sender: TObject);
var
  BirthGreg: Boolean;
begin
  BirthGreg := App.ParamSet.AwakeSet.BirthGreg;
  if ShowParamSet(App.ParamSet, 1) then
  begin
    case pc.ActivePageIndex of
      0: if (udDay.Position <> App.ParamSet.AwakeSet.BirthDay) or (BirthGreg <> App.ParamSet.AwakeSet.BirthGreg) then pc.OnChange(pc);
      1: if udDay.Position <> App.ParamSet.AwakeSet.ContractDay then pc.OnChange(pc);
      2: if udDay.Position <> App.ParamSet.AwakeSet.StaffDay then pc.OnChange(pc);
    end;
  end;
end;

procedure TfrmAwake.actExitExecute(Sender: TObject);
begin
  Close();
end;

procedure TfrmAwake.actHelpExecute(Sender: TObject);
begin
  HtmlHelp(Handle, App.Path + 'help.chm::/awake.html', HH_DISPLAY_TOPIC, 0);
end;

procedure TfrmAwake.pcChange(Sender: TObject);
var
  i: Integer;
begin
  case pc.ActivePageIndex of
    0: udDay.Position := App.ParamSet.AwakeSet.BirthDay;
    1: udDay.Position := App.ParamSet.AwakeSet.ContractDay;
    2: udDay.Position := App.ParamSet.AwakeSet.StaffDay;
  end;
  dmPer.OpenQuery(aqInqu, GetSqlStr());
  aqInqu.FieldByName('id').Visible := False;
  for i := 0 to dgInqu.Columns.Count - 1 do
    dgInqu.Columns[i].Width := ARR_COL_WIDTH[i];

  DoFilterData();
  dgInqu.Parent := pc.ActivePage;
  if FAfterShow then dgInqu.SetFocus;
end;

procedure TfrmAwake.edtDayChange(Sender: TObject);
begin
  if not aqInqu.Active then Exit;

  with App.ParamSet.AwakeSet do
  begin
    case pc.ActivePageIndex of
      0: BirthDay := udDay.Position;
      1: ContractDay := udDay.Position;
      2: StaffDay := udDay.Position;
    end;
  end;
  DoFilterData();
end;

procedure TfrmAwake.aqInquFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
var
  FieldDate: TDate;
begin
  FieldDate := aqInqu.Fields[4].AsDateTime;
  //阳历生日已换算为本年生日
  if (pc.ActivePageIndex = 0) and not App.ParamSet.AwakeSet.BirthGreg then
    FieldDate := IncYear(FieldDate, YearsBetween(FieldDate, Date()) + 1);

  Accept := (FieldDate >= Date()) and (FieldDate <= IncDay(Date, udDay.Position));
  actExport.Enabled := not aqInqu.Eof;
  actPrint.Enabled := not aqInqu.Eof;
end;

procedure TfrmAwake.dgInquDblClick(Sender: TObject);
var
  sStaffID: string;
begin
  if aqInqu.RecordCount <> 0 then
  begin
    sStaffID := aqInqu.Fields[1].AsString;
    PostMessage(Application.MainForm.Handle, WM_INQUSTAFF, 0, GlobalAddAtom(PAnsiChar(sStaffID)));
  end;
end;

procedure TfrmAwake.dgInquDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  if aqInqu.RecordCount = 0 then Exit;

  if (Column.FieldName = '性别') and (Column.Field.AsString = '女') then
    dgInqu.Canvas.Font.Color := clRed;
  dgInqu.DefaultDrawColumnCell(Classes.Rect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom), DataCol, Column, State);
end;

procedure TfrmAwake.dgInquTitleBtnClick(Sender: TObject; ACol: Integer;
  Column: TColumnEh);
begin
  DBGridEhTitleBtnClick(Sender, ACol, Column);
end;

end.
