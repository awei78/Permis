unit uAP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, DB, ADODB, ComCtrls, ExtCtrls, Grids, DBGrids, DBGridEh,
  StdCtrls, RzPanel, RzButton, uInquBase, GridsEh;

type
  TfrmAP = class(TfrmInquBase)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actEditExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure tvInquGetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure tvInquGetSelectedIndex(Sender: TObject; Node: TTreeNode);
    procedure dgInquDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure aqInquAfterPost(DataSet: TDataSet);
    procedure aqInquAfterDelete(DataSet: TDataSet);
  private
    { Private declarations }
    FChanged: Boolean;
  protected
    procedure LoadData; override;
    procedure DrawTree; override;
    procedure OpenQuery; override;
    function GetTvFilter: string; override;
  public
    { Public declarations }
  end;

var
  frmAP: TfrmAP;

function ShowAP(): Boolean;

implementation

uses uGlobal, uData, uAPDlg;

{$R *.dfm}

function ShowAP(): Boolean;
begin
  with TfrmAP.Create(Application.MainForm) do
  begin
    try
      LoadData();
      Result := ShowModal() = mrOk;
    finally
      Free;
    end;
  end;
end;

procedure TfrmAP.LoadData;
begin
  inherited;
  dgInqu.Columns[4].Title.Caption := App.ViewSet.DeptStr;
end;

procedure TfrmAP.DrawTree;
var
  APNode: TTreeNode;
begin
  inherited;
  APNode := tvInqu.Items.AddChild(tvInqu.Items.GetFirstNode, '奖惩类别');
  tvInqu.Items.AddChild(APNode, '奖励');
  tvInqu.Items.AddChild(APNode, '惩罚');
end;

procedure TfrmAP.OpenQuery;
begin
  //同步更新奖惩记录表之内容
  dmPer.ExecSQL('UPDATE [ap] a, [staffs] b SET a.staffName=b.staffName, a.staffPY=b.staffPY, a.sex=b.sex, ' +
    'a.deptName=b.deptName WHERE a.staffId=b.id');
  dmPer.OpenQuery(aqInqu, 'SELECT * FROM [ap]');
end;

function TfrmAP.GetTvFilter: string;
var
  Node: TTreeNode;
begin
  Result := '';
  //树
  Node := tvInqu.Selected;
  if Node = nil then Exit;

  if Node.Level > 1 then
  begin
    if (Node.Text = '奖励') or (Node.Text = '惩罚') then
      Result := 'apType=''' + Node.Text + ''''
    else Result := 'deptName LIKE ' + QuotedStr(GetDeptStr(Node) + '%');
  end;

  aqInqu.CancelBatch();
end;

procedure TfrmAP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if FChanged then
    ModalResult := mrOk
  else ModalREsult := mrCancel;
end;

procedure TfrmAP.actAddExecute(Sender: TObject);
begin
  if ShowAPDlg(aoAdd, aqInqu, tvInqu) then AutoFitWidth(dgInqu);
end;

procedure TfrmAP.actEditExecute(Sender: TObject);
begin
  if ShowAPDlg(aoEdit, aqInqu, tvInqu) then AutoFitWidth(dgInqu);
end;

procedure TfrmAP.tvInquGetImageIndex(Sender: TObject; Node: TTreeNode);
begin
  if Node.Level <> 0 then
  begin
    if (Node.Level = 2) and (Node.Parent.Text <> App.ViewSet.DeptStr) then
      Node.ImageIndex := 12
    else inherited;
  end;
end;

procedure TfrmAP.tvInquGetSelectedIndex(Sender: TObject; Node: TTreeNode);
begin
  if Node.Level <> 0 then
  begin
    if (Node.Level = 2) and (Node.Parent.Text <> App.ViewSet.DeptStr) then
      Node.SelectedIndex := 12
    else inherited;
  end;
end;

procedure TfrmAP.dgInquDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  DBGrid: TDBGridEh;
begin
  if aqInqu.RecordCount = 0 then Exit;//显示图片的数据列

  DBGrid := TDBGridEh(Sender);
  //画男女标记图象
  if Column.FieldName = 'staffNo' then
    inherited
  else
  begin
    if Column.FieldName = 'apType' then
    begin
      if Pos('奖', Column.Field.AsString) <> 0 then
        DBGrid.Canvas.Font.Color := clGreen
      else DBGrid.Canvas.Font.Color := clRed;
    end;
    if gdSelected in State then
    begin
      DBGrid.Canvas.Brush.Color := $00C56A31;
      DBGrid.Canvas.Font.Color := clWindow;
    end;

    DBGrid.DefaultDrawColumnCell(Classes.Rect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom), DataCol, Column, State);
  end;
end;

procedure TfrmAP.aqInquAfterPost(DataSet: TDataSet);
begin
  inherited;
  FChanged := True;
end;

procedure TfrmAP.aqInquAfterDelete(DataSet: TDataSet);
begin
  inherited;
  FChanged := True;
end;

end.
