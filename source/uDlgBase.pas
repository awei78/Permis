{
  文件名：uDlgBase.pas
  说  明：数据操作类对话框基类，公用员工选择功能
  编写人：刘景威
  日  期：2009-03-15
  更  新：
}

unit uDlgBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBase, uGlobal, DB, ADODB, Grids, DBGridEh, ExtCtrls, RzPanel,
  StdCtrls, Mask, RzEdit, RzBtnEdt, Buttons, GridsEh;

type
  TfrmDlgBase = class(TfrmBase)
    Label1: TLabel;
    edtStaNo: TRzButtonEdit;
    Label2: TLabel;
    edtStaName: TEdit;
    pnlStaff: TRzPanel;
    dg_staff: TDBGridEh;
    ds_staff: TDataSource;
    aq_staff: TADOQuery;
    procedure edtStaNoButtonClick(Sender: TObject);
    procedure edtStaNoChange(Sender: TObject);
    procedure edtStaNoEnter(Sender: TObject);
    procedure edtStaNoExit(Sender: TObject);
    procedure edtStaNoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dg_staffDblClick(Sender: TObject);
    procedure dg_staffDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure dg_staffTitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
    procedure dg_staffExit(Sender: TObject);
  private
    { Private declarations }
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
  protected
    FSqlStr: string;
    FFilter: string;
    FActOper: TActOper;
    FSaved: Boolean;
    procedure InitData; override;
 public
    { Public declarations }
  end;

var
  frmDlgBase: TfrmDlgBase;

implementation

uses uData;

{$R *.dfm}

{ TfrmDlgBase }

procedure TfrmDlgBase.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  inherited;
  if (Msg.Result = HTCLIENT) and ((GetAsyncKeyState(VK_LBUTTON) and $8000) <> 0) and pnlStaff.Visible then
    pnlStaff.Visible := False;
end;

procedure TfrmDlgBase.InitData;
begin
  //数据集赋值
  if FSqlStr = '' then FSqlStr := 'SELECT id, staffNo, staffName, staffPY, sex, deptName FROM [staffs] WHERE workState <> 1';
  dmPer.OpenQuery(aq_staff, FSqlStr);
  if FFilter <> '' then FilterData(aq_staff, FFilter);

  pnlStaff.Visible := False;
  pnlStaff.Left := edtStaNo.Left;
  pnlStaff.Top := edtStaNo.Top + edtStaNo.Height - 1;
  edtStaName.Enabled := False;
  //颜色...
  edtStaName.Color := VIEW_COLOR;
end;

procedure TfrmDlgBase.edtStaNoButtonClick(Sender: TObject);
begin
  //不用新窗体弹出来选择记录，是因为新窗口焦点切换问题
  pnlStaff.Visible := not pnlStaff.Visible;
  btnOk.Default := not pnlStaff.Visible;
  if FFilter = '' then
    aq_staff.Filtered := False
  else FilterData(aq_staff, FFilter);
  aq_staff.Locate('staffNo', edtStaNo.Text, []);
end;

procedure TfrmDlgBase.edtStaNoChange(Sender: TObject);
var
  sFilter: string;
begin
  if pnlStaff.Visible then
  begin
    if Trim(edtStaNo.Text) <> '' then
    begin
      if FFilter <> '' then
        sFilter := '(' + FFilter + ' AND staffNo LIKE ' + QuotedStr('%' + Trim(edtStaNo.Text) + '%') + ') OR ' +
                   '(' + FFilter + ' AND staffName LIKE ' + QuotedStr('%' + Trim(edtStaNo.Text) + '%') + ') OR ' +
                   '(' + FFilter + ' AND staffPY LIKE ' + QuotedStr('%' + Trim(edtStaNo.Text) + '%') + ')'
      else sFilter := 'staffNo LIKE ' + QuotedStr('%' + Trim(edtStaNo.Text) + '%') + ' OR staffName LIKE ' + QuotedStr('%' + Trim(edtStaNo.Text) + '%') + ' OR staffPY LIKE ' + QuotedStr('%' + Trim(edtStaNo.Text) + '%') ;
      FilterData(aq_staff, sFilter);
    end
    else if FFilter = '' then aq_staff.Filtered := False;
  end;
end;

procedure TfrmDlgBase.edtStaNoEnter(Sender: TObject);
begin
  btnOk.Default := not pnlStaff.Visible;
end;

procedure TfrmDlgBase.edtStaNoExit(Sender: TObject);
begin
  //处理直接输入的情况...
  if not dg_staff.Focused and pnlStaff.Visible then pnlStaff.Visible := False;
  btnOk.Default := True;
  if aq_staff.Locate('staffNo', edtStaNo.Text, []) and (edtStaName.Text <> aq_staff.FieldByName('staffName').AsString) then
    dg_staff.OnDblClick(dg_staff);
end;

procedure TfrmDlgBase.edtStaNoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and pnlStaff.Visible then dg_staff.OnDblClick(dg_staff);
end;

procedure TfrmDlgBase.dg_staffDblClick(Sender: TObject);
begin
  if pnlStaff.Visible then pnlStaff.Visible := False;
  if aq_staff.RecordCount > 0 then
  begin
    edtStaNo.Text := aq_staff.FieldByName('staffNo').AsString;
    edtStaName.Text := aq_staff.FieldByName('staffName').AsString;
  end;
end;

procedure TfrmDlgBase.dg_staffDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var
  ImageIndex: Integer;
  DBGrid: TDBGridEh;
begin
  if aq_staff.RecordCount = 0 then Exit;//显示图片的数据列

  DBGrid := TDBGridEh(Sender);
  //画男女标记图象
  if Column.FieldName = 'staffNo' then
  begin
    if aq_staff.FieldByName('sex').AsString = '男' then
      ImageIndex := 4
    else ImageIndex := 5;
    DBGrid.Canvas.FillRect(Rect);                //DBGrid的列的长宽为62*16
    dmPer.ilTree.Draw(DBGrid.Canvas, rect.Left, rect.Top + 1, ImageIndex);

    DBGrid.DefaultDrawColumnCell(Classes.Rect(Rect.Left + 18, Rect.Top, Rect.Right, Rect.Bottom), DataCol, Column, State);
  end;
end;

procedure TfrmDlgBase.dg_staffTitleBtnClick(Sender: TObject; ACol: Integer;
  Column: TColumnEh);
begin
  DBGridEhTitleBtnClick(Sender, ACol, Column);
end;

procedure TfrmDlgBase.dg_staffExit(Sender: TObject);
begin
  if not edtStaNo.Focused then pnlStaff.Visible := False;
end;

end.
