{******
  单 元：uInquMove.pas
  作 者：刘景威
  日 期：2008-12-31
  说 明：异动类查询窗体
  更 新：
******}

unit uInquMove;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ActnList, DB, ADODB, ComCtrls, ExtCtrls, Grids,
  DBGrids, DBGridEh, RzPanel, RzButton, uGlobal, uInquBase;

type
  TfrmInquMove = class(TfrmInquBase)
    actBack: TAction;
    btnBack: TRzToolButton;
    pmiBack: TMenuItem;
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actBackExecute(Sender: TObject);
    procedure dsInquDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    FInquType: TInquType;
    FWhr: string;
  protected
    procedure OpenQuery; override;
    procedure LoadData; override;
    function GetTvFilter: string; override;
  public
    { Public declarations }
  end;

var
  frmInquMove: TfrmInquMove;

function ShowInquMove(AInquType: TInquType; const AWhr: string = ''): Boolean;

implementation

uses uApp, uData, uMove, uLeft, uBack;

{$R *.dfm}

function ShowInquMove(AInquType: TInquType; const AWhr: string): Boolean;
begin
  with TfrmInquMove.Create(Application.MainForm) do
  begin
    FInquType := AInquType;
    FWhr := AWhr;
    try
      LoadData();
      Result := ShowModal() = mrOk;
    finally
      Free;
    end;
  end;
end;

{ TfrmInquMove }

procedure TfrmInquMove.OpenQuery;
var
  sTblName, sSql: string;
begin
  case FInquType of
    itMove:
    begin
      Caption := '人事变动查询 - 调动查询';
      sTblName := '[move]';
    end;
    itLeft:
    begin
      Caption := '人事变动查询 - 离职查询';
      sTblName := '[left]';
    end;
    itBack:
    begin
      Caption := '人事变动查询 - 复职查询';
      sTblName := '[back]';
    end;
  end;

  sSql := 'SELECT * FROM ' + sTblName;
  if FWhr <> '' then sSql := sSql + ' WHERE ' + FWhr;
  dmPer.OpenQuery(aqInqu, sSql);
  if FInquType <> itMove then
  begin
    aqInqu.Fields[0].Visible := False;
    aqInqu.Fields[3].Visible := False;
    aqInqu.Fields[4].Visible := False;
  end
  else
  begin
    //加了staffId之原因
    aqInqu.Fields[0].Visible := False;
    aqInqu.Fields[1].Visible := False;
    aqInqu.Fields[4].Visible := False;
    aqInqu.Fields[5].Visible := False;
  end;
end;

procedure TfrmInquMove.LoadData;
  function GetColCaption(): string;
  var
    sl: TStrings;
  begin
    sl := TStringList.Create;
    try
      with sl, App do
      begin
        Append(GridSet.FieldLabels[1]);
        Append(GridSet.FieldLabels[2]);
        case FInquType of
          itMove:
          begin
            Append('调动日期');
            Append(ViewSet.RegerStr);
            Append('原' + ViewSet.DeptStr);
            Append('原' + ViewSet.DutyStr);
            Append('原' + ViewSet.TypeStr);
            Append('原' + ViewSet.TechnicStr);
            Append('新' + ViewSet.DeptStr);
            Append('新' + ViewSet.DutyStr);
            Append('新' + ViewSet.TypeStr);
            Append('新' + ViewSet.TechnicStr);
            Append('备注');
          end;
          itLeft:
          begin
            sl.Append('离职日期');
            sl.Append(ViewSet.RegerStr);
            sl.Append('原' + ViewSet.DeptStr);
            sl.Append('原' + ViewSet.DutyStr);
            sl.Append('原' + ViewSet.TypeStr);
            sl.Append('原' + ViewSet.TechnicStr);
            sl.Append('离职原因');
            sl.Append('备注');
            sl.Append('已复职');
          end;
          itBack:
          begin
            sl.Append('复职日期');
            sl.Append(ViewSet.RegerStr);
            sl.Append('原' + ViewSet.DeptStr);
            sl.Append('原' + ViewSet.DutyStr);
            sl.Append('原' + ViewSet.TypeStr);
            sl.Append('原' + ViewSet.TechnicStr);
            sl.Append('离职原因');
            sl.Append('离职日期');
            sl.Append('离职' + ViewSet.RegerStr);
            sl.Append('离职备注');
            sl.Append('现' + ViewSet.DeptStr);
            sl.Append('现' + ViewSet.DutyStr);
            sl.Append('现' + ViewSet.TypeStr);
            sl.Append('现' + ViewSet.TechnicStr);
            sl.Append('复职备注');
          end;
        end;
        sl.Append('操作日期');

        Result := Text;
      end;
    finally
      sl.Free;
    end;
  end;

var
  sl: TStrings;
  i: Integer;
begin
  inherited;

  actAdd.Visible := actAdd.Visible and (FInquType <> itBack);
  actEdit.Visible := actAdd.Visible;
  actBack.Visible := actAdd.Visible and (FInquType = itLeft);

  sl := TStringList.Create;
  try
    sl.Text := GetColCaption();
    for i := 0 to dgInqu.Columns.Count - 1 do
      dgInqu.Columns[i].Title.Caption := sl[i];
  finally
    sl.Free;
  end;

  AutoFitWidth(dgInqu);
end;

function TfrmInquMove.GetTvFilter: string;
var
  Node: TTreeNode;
begin
  Result := '';
  //树
  Node := tvInqu.Selected;
  if Node = nil then Exit;

  if Node.Level > 1 then
  begin
    case FInquType of
      itMove: Result := 'newDept LIKE ' + QuotedStr('%' + Node.Text + '%');
      itLeft: Result := 'oldDept LIKE ' + QuotedStr('%' + Node.Text + '%');
      itBack: Result := 'backDept LIKE ' + QuotedStr('%' + Node.Text + '%');
    end;
  end;
end;

procedure TfrmInquMove.actAddExecute(Sender: TObject);
begin
  if FInquType = itMove then
    ShowMove(aoAdd, aqInqu, tvInqu)
  else ShowLeft(aoAdd, aqInqu, tvInqu);
end;

procedure TfrmInquMove.actEditExecute(Sender: TObject);
begin
  if FInquType = itMove then
    ShowMove(aoEdit, aqInqu, tvInqu)
  else ShowLeft(aoEdit, aqInqu, tvInqu);
end;

procedure TfrmInquMove.actBackExecute(Sender: TObject);
begin
  ShowBack(aqInqu);
end;

procedure TfrmInquMove.dsInquDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if (FInquType = itLeft) and actBack.Visible then
  begin
    actBack.Enabled := actDel.Enabled and not aqInqu.FieldByName('isBacked').AsBoolean;
    if actBack.Enabled then
      sbInqu.Panels[0].Text := sbInqu.Panels[0].Text + ' ' + '未复职'
    else sbInqu.Panels[0].Text := sbInqu.Panels[0].Text + ' ' + '已复职';
  end;
end;

end.
