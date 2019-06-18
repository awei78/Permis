unit uDataRestore;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBase, StdCtrls, Buttons, ExtCtrls, ComCtrls, Mask, RzEdit,
  RzBtnEdt, RzPrgres;

type
  TfrmDataRestore = class(TfrmBase)
    Label3: TLabel;
    Label1: TLabel;
    pb: TProgressBar;
    imgRestore: TImage;
    bePath: TRzButtonEdit;
    procedure bePathButtonClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure InitData; override;
    procedure SaveData; override;
    procedure ResetData; override;
    //检查数据
    function CheckData: Boolean; override;
  public
    { Public declarations }
  end;

var
  frmDataRestore: TfrmDataRestore;

function ShowDataRestore(): Boolean;

implementation

uses uGlobal, uData;

{$R *.dfm}

function ShowDataRestore(): Boolean;
begin
  with TfrmDataRestore.Create(Application.MainForm) do
  begin
    HelpHtml := 'datarestore.html';
    imgHelp.Visible := False;
    try
      InitData();
      Result := ShowModal() = mrOk;
    finally
      Free;
    end;
  end;
end;

function TfrmDataRestore.CheckData: Boolean;
begin
  Result := False;
  if not FileExists(bePath.Text) then
  begin
    MessageBox(Handle, PAnsiChar('请选择您要恢复的数据文件。'), '提示', MB_OK + MB_ICONINFORMATION);
    bePath.OnButtonClick(bePath);
    Exit;
  end;

  Result := inherited CheckData() and (MessageBox(Handle, '数据恢复将覆盖当前数据，您确定要恢复吗？', '提示',  MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON2) = IDYES);
end;

procedure TfrmDataRestore.InitData;
begin
  bePath.Text := App.BackPath;
end;

procedure TfrmDataRestore.SaveData;
var
  i: Integer;
begin
  with dmPer do
  begin
    if acPer.Connected then acPer.Close;
    try
      if not DeleteFile(App.DataPath) or not CopyFile(PAnsiChar(bePath.Text), PAnsiChar(App.DataPath), True) then
      begin
        MessageBox(Handle, PAnsiChar('数据恢复失败，您是否打开了数据库文件？'), '提示', MB_OK + MB_ICONINFORMATION);
        Exit;
      end;
    finally
      acPer.Connected := True;
      PostMessage(Application.MainForm.Handle, WM_DATARESTORE, 0, 0);
    end;
  end;

  for i := 0 to pb.Max do
  begin
    Application.ProcessMessages;
    pb.Position := i;
  end;

  //MessageBox(Handle, PAnsiChar('您选择的数据已成功恢复。'), '提示', MB_OK + MB_ICONINFORMATION);
  Log.Write(App.UserID + '恢复数据库：[' + bePath.Text + ']');
end;

procedure TfrmDataRestore.ResetData;
begin
  bePath.Text := App.Path + 'backup\data_' + FormatDateTime('yyyymmdd.bak', Date());
end;

procedure TfrmDataRestore.bePathButtonClick(Sender: TObject);
var
  od: TOpenDialog;
begin
  od := TOpenDialog.Create(Self);
  try
    od.Title := '您要还原哪个数据备份文件？';
    od.Filter := '数据备份文件(*.bak)|*.bak';
    od.InitialDir := ExtractFilePath(App.BackPath);
    od.FileName := ExtractFileName(App.BackPath);
    od.Options := od.Options + [ofPathMustExist];
    if od.Execute then bePath.Text := od.FileName;
  finally
    od.Free;
  end;
end;

end.
