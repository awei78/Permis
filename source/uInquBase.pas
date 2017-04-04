{******
  单 元：uInquBase.pas
  作 者：刘景威
  日 期：2008-12-31
  说 明：查询类基本窗体
  更 新：
******}

unit uInquBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ActnList, DB, ADODB, ComCtrls, ExtCtrls, GridsEh,
  DBGrids, DBGridEh, RzPanel, RzButton;

type
  TInquClass = class of TfrmInquBase;
  TfrmInquBase = class(TForm)
    tbInqu: TRzToolbar;
    btnDel: TRzToolButton;
    btnExport: TRzToolButton;
    Spacer3: TRzSpacer;
    btnExit: TRzToolButton;
    sbInqu: TStatusBar;
    dgInqu: TDBGridEh;
    dsInqu: TDataSource;
    aqInqu: TADOQuery;
    edtSrh: TEdit;
    Label5: TLabel;
    RzSpacer1: TRzSpacer;
    alInqu: TActionList;
    actDel: TAction;
    actExport: TAction;
    actExit: TAction;
    actHelp: TAction;
    actPrint: TAction;
    btnPrint: TRzToolButton;
    btnEdit: TRzToolButton;
    btnAdd: TRzToolButton;
    actEdit: TAction;
    RzSpacer3: TRzSpacer;
    pnlLeft: TPanel;
    pnlTop: TPanel;
    pnlBtm: TPanel;
    tvInqu: TTreeView;
    pnlLeftT: TPanel;
    pnlRight: TPanel;
    pmInqu: TPopupMenu;
    pmiEdit: TMenuItem;
    pmiAdd: TMenuItem;
    pmiDel: TMenuItem;
    N4: TMenuItem;
    pmiExport: TMenuItem;
    pmiPrint: TMenuItem;
    actAdd: TAction;
    procedure actEditExecute(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
    procedure actExportExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure tvInquChange(Sender: TObject; Node: TTreeNode);
    procedure edtSrhChange(Sender: TObject);
    procedure dsInquDataChange(Sender: TObject; Field: TField);
    procedure dgInquTitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
    procedure tvInquGetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure tvInquGetSelectedIndex(Sender: TObject; Node: TTreeNode);
    procedure dgInquDblClick(Sender: TObject);
    procedure dgInquDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure actAddExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure alInquExecute(Action: TBasicAction; var Handled: Boolean);
  private
    { Private declarations }
    function IsDeptNode(ANode: TTreeNode): Boolean;
    //使模式窗点可闪标题栏
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    //设定最大化区域
    procedure WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
  protected
    HelpHtml: string;
    procedure DrawTree; virtual;
    procedure OpenQuery; virtual;
    procedure LoadData; virtual;
    function GetTvFilter: string; virtual;
    procedure DoFilterData; virtual;
  public
    { Public declarations }
  end;

var
  frmInquBase: TfrmInquBase;

implementation

uses uApp, uGlobal, uData;

{$R *.dfm}

procedure TfrmInquBase.WMSetCursor(var Msg: TWMSetCursor);
begin
  if (SmallInt(Msg.HitTest) = HTERROR) and (Msg.MouseMsg = WM_LBUTTONDOWN) then
    DefaultHandler(Msg)
  else inherited;
end;

procedure TfrmInquBase.WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
var
  iCaptionHeight: Integer;
begin
  inherited;
  iCaptionHeight := GetSystemMetrics(SM_CYCAPTION) + 47;
  with Message.MinMaxInfo^ do
  begin
    //ptMaxPosition.X := Left;
    ptMaxPosition.Y := iCaptionHeight;
    //ptMaxSize.X := Width;
    ptMaxSize.Y := Screen.Height - iCaptionHeight;
  end;
  Message.Result := 0;
end;

procedure TfrmInquBase.DrawTree;
var
  Root, DeptNode: TTreeNode;
begin
  //画树
  tvInqu.Items.Clear;
  Root := tvInqu.Items.AddFirst(nil, App.Company.Name);
  DeptNode := tvInqu.Items.AddChild(Root, App.ViewSet.DeptStr);
  DrawDept(DeptNode, False);
end;

procedure TfrmInquBase.OpenQuery;
begin
  //
end;

procedure TfrmInquBase.LoadData;
begin
  //权限设置
  actAdd.Visible := App.AdminType <> atViewer;
  actEdit.Visible := actAdd.Visible;
  actDel.Visible := actAdd.Visible;
  //画树
  DrawTree();
  //打开数据集
  OpenQuery();
  if aqInqu.RecordCount > 0 then AutoFitWidth(dgInqu);
  if tvInqu.Items.Count > 1 then
  begin
    tvInqu.Items[1].Expand(False);
    tvInqu.Items[1].Selected := True;
  end;

  sbInqu.Panels[1].Text := 'Ctrl+鼠标左键可实现多选';
end;

function TfrmInquBase.GetTvFilter: string;
var
  Node: TTreeNode;
begin
  Result := '';
  //树
  Node := tvInqu.Selected;
  if Node = nil then Exit;

  if IsDeptNode(Node) and (Node.Level > 1) then Result := 'deptName LIKE ' + QuotedStr(GetDeptStr(Node) + '%');
end;

procedure TfrmInquBase.DoFilterData;
var
  sFilter: string;
begin
  sFilter := GetTvFilter();

  //搜索框
  if Trim(edtSrh.Text) <> '' then
  begin
    if sFilter <> '' then
      sFilter := '(' + sFilter + ' AND staffNo LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ') OR ' +
                 '(' + sFilter + ' AND staffName LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ') OR ' +
                 '(' + sFilter + ' AND staffPY LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ')'
    else
      sFilter := 'staffNo LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ' OR staffName LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ' OR staffPY LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%');
  end;

  if sFilter = '' then
  begin
    if aqInqu.Filtered then
    begin
      aqInqu.Filtered := False;
      AutoFitWidth(dgInqu);
    end;
  end
  else
  begin
    FilterData(aqInqu, sFilter);
    AutoFitWidth(dgInqu);
  end;
end;

function TfrmInquBase.IsDeptNode(ANode: TTreeNode): Boolean;
begin
  Result := False;
  if (ANode = nil) or (ANode.Level = 0) then Exit;

  while ANode.Level <> 1 do
    ANode := ANode.Parent;
  Result := ANode.Text = App.ViewSet.DeptStr;
end;

procedure TfrmInquBase.FormCreate(Sender: TObject);
begin
  WindowState := Application.MainForm.WindowState;
end;

procedure TfrmInquBase.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  if Msg.CharCode = VK_ESCAPE then btnExit.OnClick(btnExit);
end;

procedure TfrmInquBase.dsInquDataChange(Sender: TObject; Field: TField);
var
  RecNo: Integer;
begin
  if aqInqu.RecNo = -1 then
    RecNo := 0
  else RecNo := aqInqu.RecNo;
  //多选取
  if dgInqu.Focused then
  begin
    if GetAsyncKeyState(VK_CONTROL) <> 0 then
      dgInqu.Options := dgInqu.Options + [dgMultiSelect]
    else dgInqu.Options := dgInqu.Options - [dgMultiSelect];
  end;

  actEdit.Enabled := aqInqu.RecordCount <> 0;
  sbInqu.Panels[0].Text := '记录数：' + IntToStr(RecNo) + '/' + IntToStr(aqInqu.RecordCount);
  actDel.Enabled := actEdit.Enabled;
  actExport.Enabled := actDel.Enabled;
  actPrint.Enabled := actDel.Enabled;
end;

procedure TfrmInquBase.tvInquChange(Sender: TObject; Node: TTreeNode);
begin
  DoFilterData();
end;

procedure TfrmInquBase.edtSrhChange(Sender: TObject);
begin
  DoFilterData();
end;

procedure TfrmInquBase.dgInquTitleBtnClick(Sender: TObject; ACol: Integer;
  Column: TColumnEh);
begin
  DBGridEhTitleBtnClick(Sender, ACol, Column);
end;

procedure TfrmInquBase.actAddExecute(Sender: TObject);
begin
  //
end;

procedure TfrmInquBase.actEditExecute(Sender: TObject);
begin
  //
end;

procedure TfrmInquBase.actDelExecute(Sender: TObject);
begin
  if MessageBox(Handle, '确定要删除选定的记录么？', '提示', MB_ICONQUESTION + MB_YESNO) = IDNO then Exit;

  //非dgMultiSelect下，其为0
  if dgInqu.SelectedRows.Count = 0 then
    aqInqu.Delete()
  else dgInqu.SelectedRows.Delete;
  aqInqu.UpdateBatch();

  actDel.Enabled := aqInqu.RecordCount <> 0;
  actExport.Enabled := actDel.Enabled;
  actPrint.Enabled := actDel.Enabled;
end;

procedure TfrmInquBase.actExportExecute(Sender: TObject);
begin
  DataToExcel(dgInqu, Caption + '.xls');
end;

procedure TfrmInquBase.actPrintExecute(Sender: TObject);
begin
  PrintDBGridEh(dgInqu, Caption);
end;

procedure TfrmInquBase.actExitExecute(Sender: TObject);
begin
  Close();
end;

procedure TfrmInquBase.actHelpExecute(Sender: TObject);
begin
  if HelpHtml <> '' then HtmlHelp(Handle, App.Path + 'help.chm::/' + HelpHtml, HH_DISPLAY_TOPIC, 0);
end;

procedure TfrmInquBase.tvInquGetImageIndex(Sender: TObject;
  Node: TTreeNode);
begin
  if Node.Level <> 0 then
  begin
    if (Node.Level = 1) or IsDeptNode(Node) and (Node.Level > 1) then
    begin
      if Node.HasChildren then
      begin
        if Node.Expanded then
          Node.ImageIndex := 2
        else Node.ImageIndex := 1;
      end
      else Node.ImageIndex := 1;
    end;
  end;
end;

procedure TfrmInquBase.tvInquGetSelectedIndex(Sender: TObject;
  Node: TTreeNode);
begin
  if Node.Level <> 0 then
  begin
    if (Node.Level = 1) or IsDeptNode(Node) and (Node.Level > 1) then
    begin
      if Node.HasChildren then
      begin
        if Node.Expanded then
          Node.SelectedIndex := 2
        else Node.SelectedIndex := 1;
      end
      else Node.SelectedIndex := 1;
    end;
  end;
end;

procedure TfrmInquBase.dgInquDblClick(Sender: TObject);
begin
  if actEdit.Enabled then actEdit.Execute;
end;

procedure TfrmInquBase.dgInquDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ImageIndex: Integer;
  DBGrid: TDBGridEh;
begin
  if aqInqu.RecordCount = 0 then Exit;//显示图片的数据列

  DBGrid := TDBGridEh(Sender);
  //画男女标记图象
  if Column.FieldName = 'staffNo' then
  begin
    if aqInqu.FieldByName('sex').AsString = '女' then
      ImageIndex := 5
    else ImageIndex := 4;
    DBGrid.Canvas.FillRect(Rect);                //DBGrid的列的长宽为62*16
    dmPer.ilTree.Draw(DBGrid.Canvas, rect.Left, rect.Top + 1, ImageIndex);
    if gdSelected in State then DBGrid.Canvas.Brush.Color := $00C56A31;

    DBGrid.DefaultDrawColumnCell(Classes.Rect(Rect.Left + 18, Rect.Top, Rect.Right, Rect.Bottom), DataCol, Column, State);
  end;
end;

procedure TfrmInquBase.alInquExecute(Action: TBasicAction;
  var Handled: Boolean);
begin
  Handled := not (TAction(Action).Enabled and TAction(Action).Visible);
end;

end.
