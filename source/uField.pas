unit uField;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBase, StdCtrls, Buttons, ExtCtrls, CheckLst, DBGridEh;

type
  TfrmField = class(TfrmBase)
    cbSelAll: TCheckBox;
    cbAutoFit: TCheckBox;
    btnReset: TButton;
    edtValue: TEdit;
    lblFormat: TLabel;
    edtFormat: TEdit;
    btnUp: TBitBtn;
    btnDown: TBitBtn;
    cbField: TCheckListBox;
    cbSingle: TCheckBox;
    img: TImage;
    Label1: TLabel;
    procedure cbFieldClick(Sender: TObject);
    procedure cbFieldClickCheck(Sender: TObject);
    procedure cbFieldMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cbSelAllClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure cbSingleClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure edtValueEnter(Sender: TObject);
    procedure edtValueExit(Sender: TObject);
  private
    { Private declarations }
    FDBGrid: TDBGridEh;
    procedure FreeData;
  protected
    //数据操作过程...
    procedure InitData; override;
    procedure SaveData; override;
    procedure ResetData; override;
  public
    { Public declarations }
  end;

var
  frmField: TfrmField;

function ShowField(ADBGrid: TDBGridEh): Boolean;

implementation

uses uGlobal, uApp;

type
  PColData = ^TColData;
  TColData = record
    FieldName: string;
  end;

{$R *.dfm}

function ShowField(ADBGrid: TDBGridEh): Boolean;
begin
  with TfrmField.Create(Application.MainForm) do
  begin
    HelpHtml := 'field.html';
    FDBGrid := ADBGrid;
    try
      InitData();
      Result := ShowModal() = mrOk;
      if Result then Log.Write(App.UserId + '对表格字段显示做过改动');
    finally
      FreeData();
      Free;
    end;
  end;
end;

procedure TfrmField.FreeData;
var
  i: Integer;
begin
  for i := 0 to cbField.Items.Count - 1do
    if Assigned(cbField.Items.Objects[i]) then
      Dispose(PColData(cbField.Items.Objects[i]));
  cbField.Items.Clear;
end;

procedure TfrmField.InitData;
var
  i: Integer;
  ColumnEh: TColumnEh;
  ColData: PColData;
begin
  cbField.Columns := 3;
  edtValue.Width := 114;
  edtValue.BringToFront;
  edtValue.Visible := False;

  for i := 0 to FDBGrid.Columns.Count - 5 do
  begin
    ColumnEh := FDBGrid.Columns[i];
    New(ColData);
    ColData.FieldName := ColumnEh.FieldName;
    cbField.Items.AddObject(ColumnEh.Title.Caption, TObject(ColData));
    if Pos(ColumnEh.FieldName, 'staffNo,staffName') > 0 then
    begin
      cbField.Checked[i] := True;
      cbField.ItemEnabled[i] := False;
    end
    else cbField.Checked[i] := ColumnEh.Visible;
  end;

  with App.GridSet do
  begin
    //填充是否选择状态
    cbAutoFit.Checked := AutoFitStaffGrid;
    edtFormat.Text := DateFormat;
  end;

  cbField.OnClick(cbField);
  cbField.OnClickCheck(cbField);
end;

procedure TfrmField.SaveData;
var
  i, j: Integer;
  ColData: PColData;
begin
  //从原始第一个Field开始，找其Label及Index
  if edtValue.Visible then edtValue.OnExit(edtValue);
  with App.GridSet do
  begin
    FieldLabels.Clear;
    Indexes.Clear;
    FieldVisibles := '';
    for i := 0 to Fields.Count - 1 do
      for j := 0 to cbField.Count - 1 do
      begin
        ColData := PColData(cbField.Items.Objects[j]);
        if ColData.FieldName = Fields.Names[i] then
        begin
          FieldLabels.Append(cbField.Items[j]);
          Indexes.Append(IntToStr(j));
          if cbField.Checked[j] then
            FieldVisibles := FieldVisibles + '1'
          else FieldVisibles := FieldVisibles + '0';
          Break;
        end;
      end;

    AutoFitStaffGrid := cbAutoFit.Checked;
    DateFormat := edtFormat.Text;
  end;

  App.InitKindCaptions();
  PostMessage(Application.MainForm.Handle, WM_FIELDCHANGE, 0, 0);
end;

procedure TfrmField.ResetData;
var
  i: Integer;
  ColData: PColData;
begin
  FreeData();
  //填充状态
  with App.GridSet do
    for i := 0 to Fields.Count - 1 do
    begin
      New(ColData);
      ColData.FieldName := Fields.Names[i];
      cbField.Items.AddObject(Fields.ValueFromIndex[i], TObject(ColData));
      if Pos(Fields.Names[i], 'staffNo,staffName') > 0 then
      begin
        cbField.Checked[i] := True;
        cbField.ItemEnabled[i] := False;
      end
      else cbField.Checked[i] := FIELD_VISIBLE[i + 1] = '1';
    end;
  cbField.Repaint;

  cbAutoFit.Checked := True;
  edtFormat.Text := 'yyyy-mm-dd';
  cbSingle.Checked := False;
end;

procedure TfrmField.cbFieldClick(Sender: TObject);
begin
  btnUp.Enabled := cbField.ItemIndex > 0;
  btnDown.Enabled := cbField.ItemIndex < cbField.Items.Count - 1;
end;

procedure TfrmField.cbFieldClickCheck(Sender: TObject);
var
  i: Integer;
  AllChecked: Boolean;
begin
  AllChecked := True;
  for i := 0 to cbField.Count - 1 do
    if not cbField.Checked[i] then
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

procedure TfrmField.cbFieldMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (ssDouble in Shift) and (cbField.ItemIndex <> -1) and (Pos(PColData(cbField.Items.Objects[cbField.ItemIndex]).FieldName, 'staffNo,staffName') = 0) and
    (X - cbField.ItemRect(cbField.ItemIndex).Left >= 16) then
  begin
    edtValue.Left := cbField.Left + cbField.ItemRect(cbField.ItemIndex).Left + 17;
    edtValue.Top := cbField.Top + cbField.ItemRect(cbField.ItemIndex).Top + 2;
    edtValue.Text := cbField.Items[cbField.ItemIndex];
    edtValue.Visible := True;
    edtValue.SetFocus;
  end;
end;

procedure TfrmField.cbSelAllClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to cbField.Count - 1 do
  begin
    if Pos(PColData(cbField.Items.Objects[i]).FieldName, 'staffNo,staffName') > 0 then Continue;
    cbField.Checked[i] := cbSelAll.Checked;
  end;
end;

procedure TfrmField.btnUpClick(Sender: TObject);
begin
  cbField.Items.Exchange(cbField.ItemIndex, cbField.ItemIndex - 1);
  cbField.OnClick(cbField);
end;

procedure TfrmField.btnDownClick(Sender: TObject);
begin
  cbField.Items.Exchange(cbField.ItemIndex, cbField.ItemIndex + 1);
  cbField.OnClick(cbField);
end;

procedure TfrmField.cbSingleClick(Sender: TObject);
begin
  if cbSingle.Checked then
    cbField.Columns := 0
  else cbField.Columns := 3;
end;

procedure TfrmField.btnResetClick(Sender: TObject);
begin
  ResetData();
end;

procedure TfrmField.edtValueEnter(Sender: TObject);
begin
  //须写入此处才起作用
  if edtValue.Height <> 17 then edtValue.Height := 17;
  cbField.ShowHint := False;
end;

procedure TfrmField.edtValueExit(Sender: TObject);
begin
  if edtValue.Visible then
  begin
    if cbField.Items[cbField.ItemIndex] <> edtValue.Text then
      cbField.Items[cbField.ItemIndex] := edtValue.Text;
    edtValue.Visible := False;
  end;
end;

end.
