unit uView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBase, StdCtrls, Buttons, ExtCtrls, CheckLst;

type
  TfrmView = class(TfrmBase)
    cbView: TCheckListBox;
    cbSelAll: TCheckBox;
    procedure cbSelAllClick(Sender: TObject);
    procedure cbViewClickCheck(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
    FOriStr: string;
    function GetCheckStr: string;
  protected
    //数据操作过程...
    procedure InitData; override;
    procedure SaveData; override;
  public
    { Public declarations }
  end;

var
  frmView: TfrmView;

function ShowView(): Boolean;

implementation

uses uGlobal;

{$R *.dfm}

function ShowView(): Boolean;
begin
  with TfrmView.Create(Application.MainForm) do
  begin
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

function TfrmView.GetCheckStr: string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to cbView.Items.Count - 1 do
    if cbView.Checked[i] then
      Result := Result + '1'
    else Result := Result + '0';
end;

procedure TfrmView.InitData;
begin
  cbView.Items.Clear;
  with cbView.Items, App.ViewSet do
  begin
    Append(DeptStr);
    Append(DutyStr);
    Append(TypeStr);
    Append(TechnicStr);
    Append(SexStr);
    Append(FolkStr);
    Append(MarriageStr);
    Append(PolityStr);
    Append(CultureStr);
    Append(SpecialStr);
  end;

  with cbView, App.ViewSet do
  begin
    Checked[0] := ShowDept;
    Checked[1] := ShowDuty;
    Checked[2] := ShowType;
    Checked[3] := ShowTechnic;
    Checked[4] := ShowSex;
    Checked[5] := ShowFolk;
    Checked[6] := ShowMarriage;
    Checked[7] := ShowPolity;
    Checked[8] := ShowCulture;
    Checked[9] := ShowSpecial;
  end;
  cbView.OnClickCheck(cbView);

  FOriStr := GetCheckStr();
end;

procedure TfrmView.SaveData;
begin
  with cbView, App.ViewSet do
  begin
    ShowDept     := Checked[0];
    ShowDuty     := Checked[1];
    ShowType     := Checked[2];
    ShowTechnic  := Checked[3];
    ShowSex      := Checked[4];
    ShowFolk     := Checked[5];
    ShowMarriage := Checked[6];
    ShowPolity   := Checked[7];
    ShowCulture  := Checked[8];
    ShowSpecial  := Checked[9];
  end;

  Log.Write(App.UserID + '进行类别显示设置操作');
end;

procedure TfrmView.cbSelAllClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to cbView.Count - 1 do
    cbView.Checked[i] := cbSelAll.Checked;
end;

procedure TfrmView.cbViewClickCheck(Sender: TObject);
var
  i: Integer;
  AllChecked: Boolean;
begin
  AllChecked := True;
  for i := 0 to cbView.Count - 1 do
    if not cbView.Checked[i] then
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

procedure TfrmView.btnOkClick(Sender: TObject);
begin
  if GetCheckStr() <> FOriStr then
    inherited
  else ModalResult := mrCancel;
end;

end.
