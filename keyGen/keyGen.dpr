program keyGen;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  md5 in 'md5.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
