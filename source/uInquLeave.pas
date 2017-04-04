unit uInquLeave;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, DB, ADODB, ComCtrls, ExtCtrls, GridsEh, DBGrids, DBGridEh,
  StdCtrls, RzPanel, RzButton, uInquBase;

type
  TfrmInquLeave = class(TfrmInquBase)
    btnUnLeave: TRzToolButton;
    actUnLeave: TAction;
    actPrintBand: TAction;
    aqInquid: TAutoIncField;
    aqInqustaffId: TIntegerField;
    aqInqustaffNo: TWideStringField;
    aqInqustaffName: TWideStringField;
    aqInqustaffPY: TWideStringField;
    aqInqusex: TWideStringField;
    aqInqudeptName: TWideStringField;
    aqInquleaveDate: TDateTimeField;
    aqInquleaveDay: TFloatField;
    aqInquleaveReason: TWideStringField;
    aqInqudes: TWideStringField;
    aqInquunLeaveDate: TDateTimeField;
    aqInqureger: TWideStringField;
    aqInquisLeave: TBooleanField;
    aqInquoperDate: TDateTimeField;
    pmiUnLeave: TMenuItem;
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actUnLeaveExecute(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
    procedure actPrintBandExecute(Sender: TObject);
    procedure pmInquPopup(Sender: TObject);
    procedure dsInquDataChange(Sender: TObject; Field: TField);
    procedure aqInquisLeaveGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure dgInquDblClick(Sender: TObject);
    procedure dgInquDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure tvInquGetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure tvInquGetSelectedIndex(Sender: TObject; Node: TTreeNode);
  private
    { Private declarations }
  protected
    procedure DrawTree; override;
    procedure OpenQuery; override;
    procedure LoadData; override;
    function GetTvFilter: string; override;
  public
    { Public declarations }
  end;

var
  frmInquLeave: TfrmInquLeave;

function ShowInquLeave(): Boolean;

implementation

uses uApp, uGlobal, uData, uLeave;

{$R *.dfm}

function ShowInquLeave(): Boolean;
begin
  with TfrmInquLeave.Create(Application.MainForm) do
  begin
    try
      LoadData();
      Result := ShowModal() = mrOk;
    finally
      Free;
    end;
  end;
end;

procedure TfrmInquLeave.DrawTree;
var
  LeaveNode: TTreeNode;
begin
  inherited;
  LeaveNode := tvInqu.Items.AddChild(tvInqu.Items.GetFirstNode, '请假状态');
  tvInqu.Items.AddChild(LeaveNode, '未销假');
  tvInqu.Items.AddChild(LeaveNode, '已销假');
end;

function TfrmInquLeave.GetTvFilter: string;
var
  Node: TTreeNode;
begin
  Result := '';
  //树
  Node := tvInqu.Selected;
  if Node = nil then Exit;

  if Node.Level > 1 then
  begin
    if Node.Text = '未销假' then
      Result := 'isLeave = True'
    else if Node.Text = '已销假' then
      Result := 'isLeave = False'
    else Result := 'deptName LIKE ' + QuotedStr(GetDeptStr(Node) + '%');
  end;
end;

procedure TfrmInquLeave.OpenQuery;
begin
  //同步请假信息中员工信息
  dmPer.ExecSQL('UPDATE [leave] a, [staffs] b SET a.staffName=b.staffName, a.staffPY=b.staffPY, a.sex=b.sex, ' +
    'a.deptName=b.deptName WHERE a.staffId=b.id');
  dmPer.OpenQuery(aqInqu, 'SELECT * FROM [leave]');
end;

procedure TfrmInquLeave.LoadData;
begin
  inherited;
  actUnLeave.Visible := actEdit.Visible;
  //静态指定不行
  pmiPrint.Action := actPrintBand;
  dgInqu.Columns[2].Title.Caption := App.ViewSet.DeptStr;
  dgInqu.Columns[8].Title.Caption := App.ViewSet.RegerStr;
end;

procedure TfrmInquLeave.actAddExecute(Sender: TObject);
begin
  ShowLeave(ltLeave, aqInqu, tvInqu);
end;

procedure TfrmInquLeave.actEditExecute(Sender: TObject);
begin
  ShowLeave(ltEdit, aqInqu, tvInqu);
end;

procedure TfrmInquLeave.actUnLeaveExecute(Sender: TObject);
begin
  ShowLeave(ltUnLeave, aqInqu, tvInqu);
end;

procedure TfrmInquLeave.actDelExecute(Sender: TObject);
var
  NeedRequery: Boolean;
  i: Integer;
  BookMark: TBookMark;
begin
  if MessageBox(Handle, '确定要删除选定的记录么？', '提示', MB_ICONQUESTION + MB_YESNO) = IDNO then Exit;

  NeedRequery := False;
  //非dgMultiSelect下，其为0
  if dgInqu.SelectedRows.Count = 0 then
  begin
    if aqInqu.FieldByName('isLeave').AsBoolean then
    begin
      dmPer.ExecSQL('UPDATE [staffs] SET workState = 0 WHERE id=' + aqInqu.FieldByName('staffId').AsString);
      NeedRequery := True;
    end;
    aqInqu.Delete();
  end
  else
  begin
    with dmPer do
    begin
      aqTemp.Clone(TADOQuery(dgInqu.DataSource.DataSet), ltReadOnly);
      for i := 0 to dgInqu.SelectedRows.Count - 1 do
      begin
        aqTemp.GotoBookmark(TBookMark(dgInqu.SelectedRows.Items[i]));
        if aqTemp.FieldByName('isLeave').AsBoolean then
        begin
          dmPer.ExecSQL('UPDATE [staffs] SET workState = 0 WHERE id=' + aqTemp.FieldByName('staffId').AsString);
          NeedRequery := True;
        end;
      end;
    end;

    dgInqu.SelectedRows.Delete;
  end;

  aqInqu.UpdateBatch();
  if NeedRequery then
  begin
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
  end;

  actDel.Enabled := aqInqu.RecordCount <> 0;
  actExport.Enabled := actDel.Enabled;
  actPrint.Enabled := actDel.Enabled;
end;

procedure TfrmInquLeave.actPrintBandExecute(Sender: TObject);
begin
  dmPer.PrintLeave(aqInqu.FieldByName('id').AsInteger);
end;

procedure TfrmInquLeave.aqInquisLeaveGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if aqInqu.RecordCount = 0 then Exit;

  if Sender.AsBoolean then
    Text := '未销假'
  else Text := '已销假';
end;

procedure TfrmInquLeave.tvInquGetImageIndex(Sender: TObject;
  Node: TTreeNode);
begin
  if Node.Level <> 0 then
  begin
    if (Node.Level = 2) and (Node.Text = '已销假') then
      Node.ImageIndex := 4
    else if (Node.Level = 2) and (Node.Text = '未销假') then
      Node.ImageIndex := 10
    else inherited;
  end;
end;

procedure TfrmInquLeave.tvInquGetSelectedIndex(Sender: TObject;
  Node: TTreeNode);
begin
  if Node.Level <> 0 then
  begin
    if (Node.Level = 2) and (Node.Text = '已销假') then
      Node.SelectedIndex := 4
    else if (Node.Level = 2) and (Node.Text = '未销假') then
      Node.SelectedIndex := 10
    else inherited;
  end;
end;

procedure TfrmInquLeave.pmInquPopup(Sender: TObject);
begin
  if actPrintBand.Enabled then actPrintBand.Caption := '打印[' + aqInqu.FieldByName('staffName').AsString + ']请假条';
  if actUnLeave.Enabled then
    pmiUnLeave.Default := True
  else if actEdit.Enabled then pmiEdit.Default := True;
end;

procedure TfrmInquLeave.dsInquDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  actPrintBand.Enabled := actDel.Enabled;
  actUnLeave.Enabled := aqInqu.FieldByName('isLeave').AsBoolean;
end;

procedure TfrmInquLeave.dgInquDblClick(Sender: TObject);
begin
  if actUnLeave.Enabled then
    actUnLeave.Execute
  else inherited;
end;

procedure TfrmInquLeave.dgInquDrawColumnCell(Sender: TObject;
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
    if aqInqu.FieldByName('sex').AsString = '男' then
    begin
      if aqInqu.FieldByName('isLeave').AsBoolean then
        ImageIndex := 10
      else ImageIndex := 4;
    end
    else
    begin
      if aqInqu.FieldByName('isLeave').AsBoolean then
        ImageIndex := 11
      else ImageIndex := 5;
    end;
    DBGrid.Canvas.FillRect(Rect);                //DBGrid的列的长宽为62*16
    dmPer.ilTree.Draw(DBGrid.Canvas, rect.Left, rect.Top + 1, ImageIndex);
    //高亮显示待销假记录
    if aqInqu.FieldByName('isLeave').AsBoolean and App.ParamSet.LightLeave and (aqInqu.FieldByName('unLeaveDate').AsDateTime <= Date()) then
      DBGrid.Canvas.Brush.Color := App.ParamSet.LeaveColor;
    if gdSelected in State then DBGrid.Canvas.Brush.Color := $00C56A31;

    DBGrid.DefaultDrawColumnCell(Classes.Rect(Rect.Left + 18, Rect.Top, Rect.Right, Rect.Bottom), DataCol, Column, State);
  end
  else
  begin
    if Column.FieldName = 'isLeave' then
    begin
      if Column.Field.AsBoolean then
        DBGrid.Canvas.Font.Color := clRed
      else DBGrid.Canvas.Font.Color := clGreen;
    end;
    //高亮显示待销假记录
    if aqInqu.FieldByName('isLeave').AsBoolean and App.ParamSet.LightLeave and (aqInqu.FieldByName('unLeaveDate').AsDateTime <= Date()) then
      DBGrid.Canvas.Brush.Color := App.ParamSet.LeaveColor;
    if gdSelected in State then
    begin
      DBGrid.Canvas.Brush.Color := $00C56A31;
      DBGrid.Canvas.Font.Color := clWindow;
    end;

    DBGrid.DefaultDrawColumnCell(Classes.Rect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom), DataCol, Column, State);
  end;
end;

end.
