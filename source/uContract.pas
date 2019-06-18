{
  文件名：uContract.pas
  说  明：合同管理单元
  编写人：刘景威
  日  期：2009-03-15
  更  新：
}

unit uContract;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, DB, ADODB, ComCtrls, ExtCtrls, Grids, DBGrids, DBGridEh,
  StdCtrls, RzPanel, RzButton, uInquBase, DateUtils, GridsEh;

type
  TfrmContract = class(TfrmInquBase)
    RzSpacer2: TRzSpacer;
    cbDate: TComboBox;
    dpStart: TDateTimePicker;
    Label4: TLabel;
    dpEnd: TDateTimePicker;
    actFind: TAction;
    actAll: TAction;
    btnAll: TRzToolButton;
    btnFind: TRzToolButton;
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure tvInquGetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure tvInquGetSelectedIndex(Sender: TObject; Node: TTreeNode);
    procedure dgInquDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure actFindExecute(Sender: TObject);
    procedure actAllExecute(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure LoadData; override;
    procedure DrawTree; override;
    procedure OpenQuery; override;
    function GetTvFilter: string; override;
    procedure DoFilterData; override;
  public
    { Public declarations }
  end;

var
  frmContract: TfrmContract;

function ShowContract(): Boolean;

implementation

uses uGlobal, uData, uContDlg;

{$R *.dfm}

function ShowContract(): Boolean;
begin
  with TfrmContract.Create(Application.MainForm) do
  begin
    HelpHtml := 'cont_info.html';
    try
      LoadData();
      Result := ShowModal() = mrOk;
    finally
      Free;
    end;
  end;
end;

procedure TfrmContract.LoadData;
begin
  inherited;
  dpStart.Date := IncYear(Date(), -1);
  dpEnd.Date := Date();
  dgInqu.Columns[4].Title.Caption := App.ViewSet.DeptStr;
end;

procedure TfrmContract.DrawTree;
  procedure AddContNode(AParNode: TTreeNode; ASqlStr: string);
  begin
    with dmPer do
    begin
      OpenQuery(aqTemp, ASqlStr);
      while not aqTemp.Eof do
      begin
        tvInqu.Items.AddChild(AParNode, aqTemp.Fields[0].AsString);
        aqTemp.Next;
      end;
    end;
  end;

var
  PNode: TTreeNode;
begin
  inherited;
  PNode := tvInqu.Items.AddChild(tvInqu.Items.GetFirstNode, '合同类型');
  AddContNode(PNode, 'SELECT kindName FROM [dict] WHERE kindType = ' + IntToStr(Ord(ktState)) + ' ORDER BY sortNo');
  PNode := tvInqu.Items.AddChild(tvInqu.Items.GetFirstNode, '合同属性');
  AddContNode(PNode, 'SELECT contProp FROM [contract] GROUP BY contProp ORDER BY Count(contProp) DESC, contProp');
  PNode := tvInqu.Items.AddChild(tvInqu.Items.GetFirstNode, '合同状态');
  tvInqu.Items.AddChild(PNode, '生效中');
  tvInqu.Items.AddChild(PNode, '未生效');
  tvInqu.Items.AddChild(PNode, '已过期');
  tvInqu.Items.AddChild(PNode, '已解除');
end;

procedure TfrmContract.OpenQuery;
begin
  //同步更新奖惩合同表之内容
  dmPer.ExecSQL('UPDATE [contract] a, [staffs] b SET a.staffName=b.staffName, a.staffPY=b.staffPY, a.sex=b.sex, ' +
    'a.deptName=b.deptName WHERE a.staffId=b.id');
  dmPer.OpenQuery(aqInqu, 'SELECT * FROM [contract]');
end;

function TfrmContract.GetTvFilter: string;
var
  Node: TTreeNode;
begin
  Result := '';
  //树
  Node := tvInqu.Selected;
  if Node = nil then Exit;

  if Node.Level > 1 then
  begin
    if IsDeptNode(Node) then
      Result := 'deptName LIKE ' + QuotedStr(GetDeptStr(Node) + '%')
    else if Node.Parent.Text = '合同类型' then
      Result := 'contType = ' + QuotedStr(Node.Text)
    else if Node.Parent.Text = '合同属性' then
      Result := 'contProp = ' + QuotedStr(Node.Text)
    else Result := 'contState = ' + QuotedStr(Node.Text);
  end;
end;

procedure TfrmContract.DoFilterData;
var
  sFilter: string;
begin
  sFilter := GetTvFilter();

  //搜索框
  if Trim(edtSrh.Text) <> '' then
  begin
    if sFilter <> '' then
      sFilter := '(' + sFilter + ' AND contNo LIKE ' + QuotedStr(Trim(edtSrh.Text) + '%') + ') OR ' +
                 '(' + sFilter + ' AND contName LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ') OR ' +
                 '(' + sFilter + ' AND staffNo LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ') OR ' +
                 '(' + sFilter + ' AND staffName LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ') OR ' +
                 '(' + sFilter + ' AND staffPY LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ')'
    else
      sFilter := 'contNo LIKE ' + QuotedStr(Trim(edtSrh.Text) + '%') + ' OR contName LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + 'OR staffNo LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') +
                 ' OR staffName LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%') + ' OR staffPY LIKE ' + QuotedStr('%' + Trim(edtSrh.Text) + '%');
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

procedure TfrmContract.actAddExecute(Sender: TObject);
var
  BookMark: TBookMark;
begin
  BookMark := aqInqu.GetBookmark;
  if not ShowContDlg(aoAdd, aqInqu, tvInqu) then
  begin
    if aqInqu.BookmarkValid(BookMark) then
    begin
      aqInqu.GotoBookmark(BookMark);
      aqInqu.FreeBookmark(BookMark);
    end;
    aqInqu.CancelBatch();
  end
  else AutoFitWidth(dgInqu);
end;

procedure TfrmContract.actEditExecute(Sender: TObject);
begin
  if not ShowContDlg(aoEdit, aqInqu, tvInqu) then
    aqInqu.CancelBatch()
  else AutoFitWidth(dgInqu);
end;

procedure TfrmContract.dgInquDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  DBGrid: TDBGridEh;
begin
  if aqInqu.RecordCount = 0 then Exit;//显示图片的数据列

  DBGrid := TDBGridEh(Sender);
  //画男女标记图象
  if Column.FieldName = 'staffNo' then
    inherited dgInquDrawColumnCell(Sender, Rect, DataCol, Column, State)
  else
  begin
    if (Column.FieldName = 'staffName') and (AQInqu.FieldByName('sex').AsString = '女') then
      dgInqu.Canvas.Font.Color := clRed;
    if Column.FieldName = 'contState' then
    begin
      if Pos('生效', Column.Field.AsString) = 1 then
        dgInqu.Canvas.Font.Color := clGreen
      else if Column.Field.AsString = '未生效' then
        dgInqu.Canvas.Font.Color := clWindowText
      else dgInqu.Canvas.Font.Color := clRed;
    end;

    if gdSelected in State then
    begin
      DBGrid.Canvas.Brush.Color := $00C56A31;
      DBGrid.Canvas.Font.Color := clWindow;
    end;

    DBGrid.DefaultDrawColumnCell(Classes.Rect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom), DataCol, Column, State);
  end;
end;

procedure TfrmContract.tvInquGetImageIndex(Sender: TObject; Node: TTreeNode);
begin
  if Node.Level <> 0 then
  begin
    if not IsDeptNode(Node) and (Node.Level <> 1) then
      Node.ImageIndex := 12
    else inherited;
  end;
end;

procedure TfrmContract.tvInquGetSelectedIndex(Sender: TObject; Node: TTreeNode);
begin
  if Node.Level <> 0 then
  begin
    if not IsDeptNode(Node) and (Node.Level <> 1) then
      Node.SelectedIndex := 12
    else inherited;
  end;
end;

procedure TfrmContract.actFindExecute(Sender: TObject);
var
  sSql: string;
begin
  case cbDate.ItemIndex of
    0: sSql := 'startDate BETWEEN #' + DateToStr(dpStart.Date) + '# AND # ' + DateToStr(dpEnd.Date) + '#';
    1: sSql := 'endDate BETWEEN #' + DateToStr(dpStart.Date) + '# AND # ' + DateToStr(dpEnd.Date) + '#';
    2: sSql := 'recDate BETWEEN #' + DateToStr(dpStart.Date) + '# AND # ' + DateToStr(dpEnd.Date) + '#';
  end;
  sSql := 'SELECT * FROM [contract] WHERE ' + sSql;
  dmPer.OpenQuery(aqInqu, sSql);
  DoFilterData();
end;

procedure TfrmContract.actAllExecute(Sender: TObject);
begin
  dmPer.OpenQuery(aqInqu, 'SELECT * FROM [contract]');
  DoFilterData();
end;

end.
