unit uDataBack;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBase, StdCtrls, Buttons, ExtCtrls, ComCtrls, Mask, RzEdit,
  RzBtnEdt, RzPrgres;

type
  TfrmDataBack = class(TfrmBase)
    Label3: TLabel;
    Label1: TLabel;
    pb: TProgressBar;
    imgBack: TImage;
    bePath: TRzButtonEdit;
    btnReset: TButton;
    procedure bePathButtonClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure InitData; override;
    procedure SaveData; override;
    procedure ResetData; override;
    //�������
    function CheckData: Boolean; override;
  public
    { Public declarations }
  end;

var
  frmDataBack: TfrmDataBack;

function ShowDataBack(): Boolean;

implementation

uses uGlobal, uData;

{$R *.dfm}

function ShowDataBack(): Boolean;
begin
  with TfrmDataBack.Create(Application.MainForm) do
  begin
    HelpHtml := 'databack.html';
    imgHelp.Visible := False;
    try
      InitData();
      Result := ShowModal() = mrOk;
    finally
      Free;
    end;
  end;
end;

function TfrmDataBack.CheckData: Boolean;
begin
  Result := False;
  if not SameText(ExtractFileExt(bePath.Text), '.bak') then
  begin
    MessageBox(Handle, PAnsiChar('��ѡ����Ҫ���ݵ��ļ�·����'), '��ʾ', MB_OK + MB_ICONINFORMATION);
    bePath.OnButtonClick(bePath);
    Exit;
  end;

  Result := inherited CheckData();
end;

procedure TfrmDataBack.InitData;
begin
  bePath.Text := ExtractFilePath(App.BackPath) + 'data_' + FormatDateTime('yyyymmdd.bak', Date());
end;

procedure TfrmDataBack.SaveData;
var
  i: Integer;
begin
  CopyFile(PAnsiChar(App.DataPath), PAnsiChar(bePath.Text), True);
  dmPer.CompactAccess(bePath.Text);

  for i := 0 to pb.Max do
  begin
    Application.ProcessMessages;
    pb.Position := i;
  end;

  App.BackPath := bePath.Text;
  MessageBox(Handle, PAnsiChar('�����ѳɹ�����Ϊ[' + bePath.Text + ']'), '��ʾ', MB_OK + MB_ICONINFORMATION);

  Log.Write(App.UserID + '�������ݣ�[' + bePath.Text + ']');
end;

procedure TfrmDataBack.ResetData;
begin
  bePath.Text := App.Path + 'backup\data_' + FormatDateTime('yyyymmdd.bak', Date());
end;

procedure TfrmDataBack.btnResetClick(Sender: TObject);
begin
  ResetData();
end;

procedure TfrmDataBack.bePathButtonClick(Sender: TObject);
var
  sd: TSaveDialog;
  sFileName: string;
begin
  sd := TSaveDialog.Create(Self);
  try
    sd.Title := '��Ҫ���ݵ����';
    sd.Filter := '���ݱ����ļ�(*.bak)|*.bak';
    sd.InitialDir := ExtractFilePath(App.BackPath);
    sd.FileName := 'data_' + FormatDateTime('yyyymmdd.bak', Date());
    sd.Options := sd.Options + [ofOverwritePrompt];
    if sd.Execute then
    begin
      sFileName := sd.FileName;
      if not SameText(ExtractFileExt(sFileName), '.bak') then sFileName := ChangeFileExt(sFileName, '.bak');
      bePath.Text := sFileName;
    end;
  finally
    sd.Free;
  end;
end;

end.
