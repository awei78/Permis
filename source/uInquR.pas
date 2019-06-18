unit uInquR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uGlobal, uBase, ComCtrls, StdCtrls, Buttons, ExtCtrls;

type
  TfrmInquR = class(TfrmBase)
    gbDate: TGroupBox;
    dpStart: TDateTimePicker;
    dpEnd: TDateTimePicker;
    lblSpace: TLabel;
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
    FStatType: TStatType;
    function GetSqlStr: string;
  protected
    //数据操作过程...
    procedure InitData; override;
  public
    { Public declarations }
  end;

var
  frmInquR: TfrmInquR;

function ShowInquR(const AStatType: TStatType; out AWhr: string): Boolean;

implementation

uses uData;

{$R *.dfm}

function ShowInquR(const AStatType: TStatType; out AWhr: string): Boolean;
begin
  if not Assigned(frmInquR) then
  begin
    frmInquR := TfrmInquR.Create(Application.MainForm);
    with frmInquR do
    begin
      imgHelp.Visible := False;
      dpStart.Date := IncMonth(Date(), -3);
      dpEnd.Date := Date();
    end;
  end;
  with frmInquR do
  begin
    FStatType := AStatType;
    InitData();
    Result := ShowModal() = mrOk;
    if Result then AWhr := GetSqlStr;
  end;
end;

{ TfrmInqu }

function TfrmInquR.GetSqlStr: string;
begin
  case FStatType of
    stNew:  Result := 'inDutyDate >= #' + DateToStr(dpStart.Date) + '# AND inDutyDate <= #' + DateToStr(dpEnd.Date) + '# AND workState <> 1';
    stLeft: Result := 'leftDate >= #' + DateToStr(dpStart.Date) + '# AND leftDate <= #' + DateToStr(dpEnd.Date) + '#';
    stBack: Result := 'backDate >= #' + DateToStr(dpStart.Date) + '# AND backDate <= #' + DateToStr(dpEnd.Date) + '#';
    stMove: Result := 'moveDate >= #' + DateToStr(dpStart.Date) + '# AND moveDate <= #' + DateToStr(dpEnd.Date) + '#';
  end;                   
end;

procedure TfrmInquR.InitData;
begin
  case FStatType of
    stNew:
    begin
      Caption := '新进员工报表';
      gbDate.Caption := '入职日期';
    end;
    stLeft:
    begin
      Caption := '离职员工报表';
      gbDate.Caption := '离职日期';
    end;
    stBack:
    begin
      Caption := '复职员工报表';
      gbDate.Caption := '复职日期';
    end;
    stMove:
    begin
      Caption := '调动员工报表';
      gbDate.Caption := '调动日期';
    end;
  end;
end;

procedure TfrmInquR.btnOkClick(Sender: TObject);
begin
  if FStatType = stNew then
    with dmPer do
      OpenQuery(aqStaff, 'SELECT * FROM [staffs] WHERE ' + GetSqlStr() + ' ORDER BY staffNo')
  else inherited;
end;

end.
