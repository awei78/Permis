unit uCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, ADODB, Grids, DBGridEh, ComCtrls, Buttons;

type
  TfrmCode = class(TForm)
    sbCode: TStatusBar;
    dgCode: TDBGridEh;
    dsCode: TDataSource;
    aqCode: TADOQuery;
    Label5: TLabel;
    edtSrh: TEdit;
    aqCodeid: TAutoIncField;
    aqCodeprovince: TWideStringField;
    aqCodearea: TWideStringField;
    aqCodeacode: TWideStringField;
    aqCodepcode: TWideStringField;
    aqCodeNo: TIntegerField;
    btnExit: TBitBtn;
    btnAll: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure aqCodeCalcFields(DataSet: TDataSet);
    procedure edtSrhChange(Sender: TObject);
    procedure btnAllClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure dgCodeTitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
    procedure dsCodeDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCode: TfrmCode;

function ShowCode(): Boolean;

implementation

uses uData, uGlobal;

{$R *.dfm}

function ShowCode(): Boolean;
begin
  Result := True;

  if not Assigned(frmCode) then frmCode := TfrmCode.Create(Application.MainForm);
  if frmCode.WindowState = wsMinimized then frmCode.WindowState := wsNormal;

  dmPer.OpenQuery(frmCode.aqCode, 'SELECT * FROM [pacode]');
  frmCode.Show();
end;

procedure TfrmCode.FormCreate(Sender: TObject);
begin
  SetWindowLong(Handle, GWL_HWNDPARENT, HWND_DESKTOP);

  sbCode.Panels[1].Text := '点击列标题可以对记录进行排序';
end;

procedure TfrmCode.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  if Msg.CharCode = VK_ESCAPE then btnExit.OnClick(btnExit);
end;

procedure TfrmCode.btnAllClick(Sender: TObject);
begin
  edtSrh.Text := '';
  edtSrh.SetFocus;
end;

procedure TfrmCode.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCode.aqCodeCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('no').AsInteger := Abs(DataSet.RecNo);
end;

procedure TfrmCode.edtSrhChange(Sender: TObject);
var
  sSql: string;
begin
  //不用Filter只为了滚动条的人性化显示
  if Trim(edtSrh.Text) <> '' then
    sSql := 'SELECT * FROM [pacode] WHERE province LIKE ' + QuotedStr(edtSrh.Text + '%') +
            ' OR area LIKE ' + QuotedStr(edtSrh.Text + '%') +
            ' OR acode LIKE ' + QuotedStr('%' + edtSrh.Text + '%') +
            ' OR pcode LIKE ' + QuotedStr('%' + edtSrh.Text + '%')
  else sSql := 'SELECT * FROM [pacode]';
  dmPer.OpenQuery(aqCode, sSql);
end;

procedure TfrmCode.dgCodeTitleBtnClick(Sender: TObject; ACol: Integer;
  Column: TColumnEh);
begin
  DBGridEhTitleBtnClick(Sender, ACol, Column);
end;

procedure TfrmCode.dsCodeDataChange(Sender: TObject; Field: TField);
var
  RecNo: Integer;
begin
  if aqCode.RecNo = -1 then
    RecNo := 0
  else RecNo := aqCode.RecNo;
  sbCode.Panels[0].Text := '记录数：' + IntToStr(RecNo) + '/' + IntToStr(aqCode.RecordCount);
end;

end.
