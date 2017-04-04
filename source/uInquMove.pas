{******
  �� Ԫ��uInquMove.pas
  �� �ߣ�������
  �� �ڣ�2008-12-31
  ˵ �����춯���ѯ����
  �� �£�
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
      Caption := '���±䶯��ѯ - ������ѯ';
      sTblName := '[move]';
    end;
    itLeft:
    begin
      Caption := '���±䶯��ѯ - ��ְ��ѯ';
      sTblName := '[left]';
    end;
    itBack:
    begin
      Caption := '���±䶯��ѯ - ��ְ��ѯ';
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
    //����staffId֮ԭ��
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
            Append('��������');
            Append(ViewSet.RegerStr);
            Append('ԭ' + ViewSet.DeptStr);
            Append('ԭ' + ViewSet.DutyStr);
            Append('ԭ' + ViewSet.TypeStr);
            Append('ԭ' + ViewSet.TechnicStr);
            Append('��' + ViewSet.DeptStr);
            Append('��' + ViewSet.DutyStr);
            Append('��' + ViewSet.TypeStr);
            Append('��' + ViewSet.TechnicStr);
            Append('��ע');
          end;
          itLeft:
          begin
            sl.Append('��ְ����');
            sl.Append(ViewSet.RegerStr);
            sl.Append('ԭ' + ViewSet.DeptStr);
            sl.Append('ԭ' + ViewSet.DutyStr);
            sl.Append('ԭ' + ViewSet.TypeStr);
            sl.Append('ԭ' + ViewSet.TechnicStr);
            sl.Append('��ְԭ��');
            sl.Append('��ע');
            sl.Append('�Ѹ�ְ');
          end;
          itBack:
          begin
            sl.Append('��ְ����');
            sl.Append(ViewSet.RegerStr);
            sl.Append('ԭ' + ViewSet.DeptStr);
            sl.Append('ԭ' + ViewSet.DutyStr);
            sl.Append('ԭ' + ViewSet.TypeStr);
            sl.Append('ԭ' + ViewSet.TechnicStr);
            sl.Append('��ְԭ��');
            sl.Append('��ְ����');
            sl.Append('��ְ' + ViewSet.RegerStr);
            sl.Append('��ְ��ע');
            sl.Append('��' + ViewSet.DeptStr);
            sl.Append('��' + ViewSet.DutyStr);
            sl.Append('��' + ViewSet.TypeStr);
            sl.Append('��' + ViewSet.TechnicStr);
            sl.Append('��ְ��ע');
          end;
        end;
        sl.Append('��������');

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
  //��
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
      sbInqu.Panels[0].Text := sbInqu.Panels[0].Text + ' ' + 'δ��ְ'
    else sbInqu.Panels[0].Text := sbInqu.Panels[0].Text + ' ' + '�Ѹ�ְ';
  end;
end;

end.
