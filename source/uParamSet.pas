unit uParamSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBase, StdCtrls, Buttons, ExtCtrls, ComCtrls, uApp, Mask, ExtDlgs,
  RzEdit, RzSpnEdt, CtrlsEx, RzBtnEdt;

type
  TfrmParamSet = class(TfrmBase)
    pcSet: TPageControl;
    tsBasic: TTabSheet;
    tsAwake: TTabSheet;
    tsData: TTabSheet;
    cbPrint: TCheckBox;
    cbDblEdit: TCheckBox;
    cbEscClose: TCheckBox;
    btnReset: TButton;
    cbUseAwake: TCheckBox;
    pnlAwake: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    seBirth: TRzSpinEdit;
    Label4: TLabel;
    seContract: TRzSpinEdit;
    Label5: TLabel;
    seStaff: TRzSpinEdit;
    Label6: TLabel;
    cbEffLine: TCheckBox;
    cbUseData: TCheckBox;
    pnlData: TPanel;
    rbDay: TRadioButton;
    rbWeek: TRadioButton;
    cbWeek: TComboBox;
    rbMonth: TRadioButton;
    cbDay: TComboBox;
    Label7: TLabel;
    bePath: TRzButtonEdit;
    cbCanEdit: TCheckBox;
    lblColor: TLabel;
    cbEffColor: TColorBox;
    cbLightLeave: TCheckBox;
    lblColorL: TLabel;
    cbLeaveColor: TColorBox;
    cbAutoCode: TCheckBox;
    lblPrefix: TLabel;
    edtPrefix: TEdit;
    cbGreg: TCheckBox;
    tsImage: TTabSheet;
    cbUseImage: TCheckBox;
    pnlImage: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    beImage: TRzButtonEdit;
    cbLayout: TComboBox;
    cbNeedPwd: TCheckBox;
    cbStretch: TCheckBox;
    cbKeepScale: TCheckBox;
    cbBGColor: TColorBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnResetClick(Sender: TObject);
    procedure cbAutoCodeClick(Sender: TObject);
    procedure cbLightLeaveClick(Sender: TObject);
    procedure cbEffLineClick(Sender: TObject);
    procedure cbUseAwakeClick(Sender: TObject);
    procedure cbUseImageClick(Sender: TObject);
    procedure beImageButtonClick(Sender: TObject);
    procedure cbLayoutChange(Sender: TObject);
    procedure cbStretchClick(Sender: TObject);
    procedure cbUseDataClick(Sender: TObject);
    procedure RadioChick(Sender: TObject);
    procedure bePathButtonClick(Sender: TObject);
  private
    { Private declarations }
    FParamSet: TParamSet;
  protected
    procedure LoadData; override;
    procedure SaveData; override;
    procedure ResetData; override;
  public
    { Public declarations }
  end;

var
  frmParamSet: TfrmParamSet;

function ShowParamSet(AParamSet: TParamSet; const APageIndex: Integer = -1): Boolean;

implementation

uses uGlobal;

{$R *.dfm}

function ShowParamSet(AParamSet: TParamSet; const APageIndex: Integer): Boolean;
begin
  with TfrmParamSet.Create(Application.MainForm) do
  begin
    HelpHtml := 'paramset.html';
    FParamSet := AParamSet;
    if APageIndex <> -1 then FParamSet.PageIndex := APageIndex;
    try
      LoadData();
      Result := ShowModal() = mrOk
    finally
      Free;
    end;
  end;
end;

{ TfrmSet }

procedure TfrmParamSet.LoadData;
var
  i: Integer;
begin
  for i := 0 to 30 do
    cbDay.Items.Append(IntToStr(i + 1) + ' 日');
  cbDay.ItemIndex := 0;
  
  pcSet.ActivePageIndex := FParamSet.PageIndex;
  with FParamSet do
  begin
    cbDblEdit.Checked := DblEdit;
    cbPrint.Checked := DoPrint;
    cbEscClose.Checked := EscClose;
    cbAutoCode.Checked := AutoCode;
    cbAutoCode.OnClick(cbAutoCode);
    edtPrefix.Text := Prefix;
    cbCanEdit.Checked := LeftCanEdit;
    cbLightLeave.Checked := LightLeave;
    cbLightLeave.OnClick(cbLightLeave);
    cbLeaveColor.Selected := LeaveColor;
    cbEffLine.Checked := EffLine;
    cbEffLine.OnClick(cbEffLine);
    cbEffColor.Selected := EffColor;

    with AwakeSet do
    begin
      cbUseAwake.Checked := Enabled;
      seBirth.Value := BirthDay;
      cbGreg.Checked := BirthGreg;
      seContract.Value := ContractDay;
      seStaff.Value := StaffDay;
    end;

    with BackImage do
    begin
      cbUseImage.Checked := Enabled;
      beImage.Text := FileName;
      cbLayout.ItemIndex := Ord(Layout);
      cbStretch.Checked := Stretch;
      cbKeepScale.Checked := KeepScale;
      cbBGColor.Selected := BGColor;
      cbNeedPwd.Checked := NeedPwd;
      cbUseImage.OnClick(cbUseImage);
    end;

    with DataBack do
    begin
      cbUseData.Checked := Enabled;
      rbDay.Checked := BackType = btDay;
      rbWeek.Checked := BackType = btWeek;
      rbMonth.Checked := BackType = btMonth;
      cbWeek.ItemIndex := WeekIndex;
      cbDay.ItemIndex := DayIndex;
      bePath.Text := DataPath;
      cbUseData.OnClick(cbUseData);
    end;
  end;
end;

procedure TfrmParamSet.SaveData;
begin
  with FParamSet do
  begin
    DblEdit := cbDblEdit.Checked;
    DoPrint := cbPrint.Checked;
    EscClose := cbEscClose.Checked;
    AutoCode := cbAutoCode.Checked;
    Prefix := edtPrefix.Text;
    LeftCanEdit := cbCanEdit.Checked;
    LightLeave := cbLightLeave.Checked;
    LeaveColor := cbLeaveColor.Selected;
    EffLine := cbEffLine.Checked;
    EffColor := cbEffColor.Selected;

    with AwakeSet do
    begin
      Enabled := cbUseAwake.Checked;
      BirthDay := Round(seBirth.Value);
      BirthGreg := cbGreg.Checked;
      ContractDay := Round(seContract.Value);
      StaffDay := Round(seStaff.Value);
    end;

    with BackImage do
    begin
      Enabled := cbUseImage.Checked;
      FileName := beImage.Text;
      Layout := TLayout(cbLayout.ItemIndex);
      Stretch := cbStretch.Checked;
      KeepScale := cbKeepScale.Checked;
      BGColor := cbBGColor.Selected;
      NeedPwd := cbNeedPwd.Checked;
    end;

    with DataBack do
    begin
      Enabled := cbUseData.Checked;
      if rbDay.Checked then BackType := btDay;
      if rbWeek.Checked then BackType := btWeek;
      if rbMonth.Checked then BackType := btMonth;
      WeekIndex := cbWeek.ItemIndex;
      DayIndex := cbDay.ItemIndex;
      if DirectoryExists(bePath.Text) then
        DataPath := bePath.Text
      else bePath.Text := App.Path + 'backup\';
    end;

    SaveToIni();
  end;

  Log.Write(App.UserID + '进行参数设置操作');
end;

procedure TfrmParamSet.ResetData;
begin
  case pcSet.ActivePageIndex of
    0:
    begin
      cbDblEdit.Checked := False;
      cbPrint.Checked := False;
      cbEscClose.Checked := False;
      cbAutoCode.Checked := False;
      cbCanEdit.Checked := False;
      cbLightLeave.Checked := False;
      cbLeaveColor.Selected := $00FFC9C9;
      cbEffLine.Checked := True;
      cbEffColor.Selected := $00EDE0E0;
    end;
    1:
    begin
      cbUseAwake.Checked := True;
      seBirth.Value := 3;
      seContract.Value := 30;
      seStaff.Value := 15;
    end;
    2:
    begin
      cbUseImage.Checked := True;
      beImage.Text := App.Path + 'bg.jpg';
      cbLayout.ItemIndex := 0;
      cbStretch.Checked := True;
      cbKeepScale.Checked := False;
      cbBGColor.Selected := clBlack;
      cbNeedPwd.Checked := True;
    end;
    3:
    begin
      cbUseData.Checked := False;
      rbWeek.Checked := True;
      cbWeek.ItemIndex := 1;
      cbDay.ItemIndex := 0;
      bePath.Text := App.Path + 'backup\';
    end;
  end;
end;

procedure TfrmParamSet.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FParamSet.PageIndex := pcSet.ActivePageIndex;
end;

procedure TfrmParamSet.btnResetClick(Sender: TObject);
begin
  ResetData();
end;

procedure TfrmParamSet.cbAutoCodeClick(Sender: TObject);
begin
  lblPrefix.Enabled := cbAutoCode.Checked;
  edtPrefix.Enabled := cbAutoCode.Checked;
end;

procedure TfrmParamSet.cbLightLeaveClick(Sender: TObject);
begin
  lblColorL.Enabled := cbLightLeave.Checked;
  cbLeaveColor.Enabled := cbLightLeave.Checked;
end;

procedure TfrmParamSet.cbEffLineClick(Sender: TObject);
begin
  lblColor.Enabled := cbEffLine.Checked;
  cbEffColor.Enabled := cbEffLine.Checked;
end;

procedure TfrmParamSet.cbUseAwakeClick(Sender: TObject);
begin
  pnlAwake.Enabled := cbUseAwake.Checked;
end;

procedure TfrmParamSet.cbUseImageClick(Sender: TObject);
begin
  pnlImage.Enabled := cbUseImage.Checked;
  cbLayout.OnChange(cbLayout);
end;

procedure TfrmParamSet.beImageButtonClick(Sender: TObject);
var
  od: TOpenPictureDialog;
begin
  od := TOpenPictureDialog.Create(Self);
  try
    od.Filter := '图片文件 (*.jpg;*.jpeg;*.bmp;*.png;*.gif;*.ico;*.emf;*.wmf)|*.jpg;*.jpeg;*.bmp;*.png;*.gif;*.ico;*.emf;*.wmf';
    od.Options := od.Options + [ofFileMustExist];
    if od.Execute then beImage.Text := od.FileName;
  finally
    od.Free;
  end;
end;

procedure TfrmParamSet.cbLayoutChange(Sender: TObject);
begin
  cbStretch.Enabled := cbLayout.Enabled and (cbLayout.ItemIndex < 2);
  cbStretch.OnClick(cbStretch);
end;

procedure TfrmParamSet.cbStretchClick(Sender: TObject);
begin
  cbKeepScale.Enabled := cbStretch.Enabled and cbStretch.Checked;
end;

procedure TfrmParamSet.cbUseDataClick(Sender: TObject);
begin
  pnlData.Enabled := cbUseData.Checked;
  rbWeek.OnClick(rbWeek);
end;

procedure TfrmParamSet.RadioChick(Sender: TObject);
begin
  cbWeek.Enabled := cbUseData.Checked and rbWeek.Checked;
  cbDay.Enabled := cbUseData.Checked and rbMonth.Checked;
end;

procedure TfrmParamSet.bePathButtonClick(Sender: TObject);
var
  sDir: string;
begin
  if SelectDirectory(Handle, '请选择数据备份文件夹', bePath.Text, sDir) then
    bePath.Text := sDir;
end;

end.
