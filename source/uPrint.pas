unit uPrint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBase, StdCtrls, Buttons, ExtCtrls, CheckLst;

type
  TfrmPrint = class(TfrmBase)
    cbPrint: TCheckListBox;
    cbSelAll: TCheckBox;
    procedure cbSelAllClick(Sender: TObject);
    procedure cbPrintClickCheck(Sender: TObject);
  private
    { Private declarations }
  protected
    //数据操作过程...
    procedure InitData; override;
    procedure SaveData; override;
  public
    { Public declarations }
  end;

var
  frmPrint: TfrmPrint;

function ShowPrint(): Boolean;

implementation

uses uGlobal;

{$R *.dfm}

function ShowPrint(): Boolean;
begin
  with TfrmPrint.Create(Application.MainForm) do
  begin
    HelpHtml := 'print.html';
    imgHelp.Visible := False;
    try
      InitData();
      Result := ShowModal() = mrOk;
      if Result then Log.Write(App.UserID + '对类别显示做过改动');
    finally
      Free;
    end;
  end;
end;

procedure TfrmPrint.InitData;
begin
  with cbPrint, App.PrintSet do
  begin
    Checked[0] := PrintBase;
    Checked[1] := PrintDept;
    Checked[2] := PrintContact;
    Checked[3] := PrintSelf;
    Checked[4] := PrintFami;
    Checked[5] := PrintExper;
    Checked[6] := PrintAP;
    Checked[7] := PrintTrain;
    Checked[8] := PrintMove;
    Checked[9] := PrintOther;
  end;
  cbPrint.OnClickCheck(cbPrint);
end;

procedure TfrmPrint.SaveData;
begin
  with cbPrint, App.PrintSet do
  begin
    PrintBase    := Checked[0];
    PrintDept    := Checked[1];
    PrintContact := Checked[2];
    PrintSelf    := Checked[3];
    PrintFami    := Checked[4];
    PrintExper   := Checked[5];
    PrintAP      := Checked[6];
    PrintTrain   := Checked[7];
    PrintMove    := Checked[8];
    PrintOther   := Checked[9];
  end;

  Log.Write(App.UserID + '进行打印字段设置操作');
end;

procedure TfrmPrint.cbSelAllClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to cbPrint.Count - 1 do
    cbPrint.Checked[i] := cbSelAll.Checked;
end;

procedure TfrmPrint.cbPrintClickCheck(Sender: TObject);
var
  i: Integer;
  AllChecked: Boolean;
begin
  AllChecked := True;
  for i := 0 to cbPrint.Count - 1 do
    if not cbPrint.Checked[i] then
    begin
      AllChecked := False;
      Break;
    end;

  //反判断
  if AllChecked and not cbSelAll.Checked then
  begin
    cbSelAll.OnClick := nil;
    cbSelAll.Checked := True;
    cbSelAll.OnClick := cbSelAllClick;
  end;
  if cbSelAll.Checked and not AllChecked then
  begin
    cbSelAll.OnClick := nil;
    cbSelAll.Checked := False;
    cbSelAll.OnClick := cbSelAllClick;
  end;
end;

end.
