unit uLogInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, StdCtrls;

type
  TfrmLog = class(TForm)
    meoLog: TMemo;
    pmLog: TPopupMenu;
    miDel: TMenuItem;
    ilDel: TImageList;
    miExport: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure pmLogPopup(Sender: TObject);
    procedure miDelClick(Sender: TObject);
    procedure miExportClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLog: TfrmLog;

function ShowLog(): Boolean;

implementation

uses uGlobal;

{$R *.dfm}

function ShowLog(): Boolean;
begin
  with TfrmLog.Create(Application.MainForm) do
  begin
    try
      Result := ShowModal() = mrOk;
    finally
      Free;
    end;
  end;
end;

procedure TfrmLog.FormCreate(Sender: TObject);
begin
  meoLog.Lines.Text := Log.Items.Text;
end;

procedure TfrmLog.pmLogPopup(Sender: TObject);
begin
  miDel.Enabled := meoLog.Text <> '';
end;

procedure TfrmLog.miDelClick(Sender: TObject);
begin
  if FileExists(App.Path + 'log.dat') then DeleteFile(App.Path + 'log.dat');
  Log.Items.Clear;
  meoLog.Lines.Clear;
end;

procedure TfrmLog.miExportClick(Sender: TObject);
var
  sd: TSaveDialog;
  sFileName: string;
begin
  sd := TSaveDialog.Create(Self);
  sd.FileName := 'CR人事档案管理系统操作日志_ ' + FormatDateTime('yyyymmdd', Date()) + '.txt';
  sd.Options := sd.Options + [ofOverwritePrompt];
  sd.Filter := '文本文档 (*.txt)|*.txt';
  try
    if sd.Execute then
    begin
      sFileName := sd.FileName;
      if not SameText(ExtractFileName(sFileName), '.txt') then ChangeFileExt(sFileName, '.txt');
      meoLog.Lines.SaveToFile(sFileName);
    end;
  finally
    sd.Free;
  end;
end;

end.
