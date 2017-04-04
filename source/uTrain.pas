unit uTrain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, DB, ADODB, ComCtrls, ExtCtrls, Grids, DBGrids, DBGridEh,
  StdCtrls, RzPanel, RzButton, uInquBase, GridsEh;

type
  TfrmTrain = class(TfrmInquBase)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure dgInquDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure aqInquAfterPost(DataSet: TDataSet);
    procedure aqInquAfterDelete(DataSet: TDataSet);
  private
    { Private declarations }
    FChanged: Boolean;
  protected
    procedure LoadData; override;
    procedure OpenQuery; override;
  public
    { Public declarations }
  end;

var
  frmTrain: TfrmTrain;

function ShowTrain(): Boolean;

implementation

uses uGlobal, uData, uTrainDlg;

{$R *.dfm}

function ShowTrain(): Boolean;
begin
  with TfrmTrain.Create(Application.MainForm) do
  begin
    try
      LoadData();
      Result := ShowModal() = mrOk;
    finally
      Free;
    end;
  end;
end;

procedure TfrmTrain.LoadData;
begin
  inherited;
  dgInqu.Columns[4].Title.Caption := App.ViewSet.DeptStr;
end;

procedure TfrmTrain.OpenQuery;
begin
  //同步更新奖惩记录表之内容
  dmPer.ExecSQL('UPDATE [train] a, [staffs] b SET a.staffName=b.staffName, a.staffPY=b.staffPY, a.sex=b.sex, ' +
    'a.deptName=b.deptName WHERE a.staffId=b.id');
  dmPer.OpenQuery(aqInqu, 'SELECT * FROM [train]');
end;

procedure TfrmTrain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if FChanged then
    ModalResult := mrOk
  else ModalREsult := mrCancel;
end;

procedure TfrmTrain.actAddExecute(Sender: TObject);
begin
  if ShowTrainDlg(aoAdd, aqInqu, tvInqu) then AutoFitWidth(dgInqu);
end;

procedure TfrmTrain.actEditExecute(Sender: TObject);
begin
  if ShowTrainDlg(aoEdit, aqInqu, tvInqu) then AutoFitWidth(dgInqu);
end;

procedure TfrmTrain.dgInquDrawColumnCell(Sender: TObject;
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

procedure TfrmTrain.aqInquAfterPost(DataSet: TDataSet);
begin
  inherited;
  FChanged := True;
end;

procedure TfrmTrain.aqInquAfterDelete(DataSet: TDataSet);
begin
  inherited;
  FChanged := True;
end;

end.
