{*****************************************************************
  ��Ԫ����: uLog.pas
  �޸�ʱ��: 2005-06-24
  ��д��Ա: Liujw
  ������������Ϣ��ʾ����¼��Ԫ
*****************************************************************}

unit uLog;

interface

uses
  Windows, Classes, Controls, Forms, SysUtils, StdCtrls;

type
  TLog = class
  private
    FItems: TStrings;
  public
    constructor Create;
    destructor Destroy; override;
    
    property Items: TStrings read FItems write FItems;
    procedure Write(const AMsg: string);
  end;

implementation

uses uGlobal;

{ TLog }

constructor TLog.Create;
begin
  //����¼�ļ�����2MB����ɾ��
  if FileExists(App.Path + 'log.dat') and (GetFileSize(App.Path + 'log.dat') > 2000) then
    DeleteFile(App.Path + 'log.dat');

  FItems := TStringList.Create;
  if FileExists(App.Path + 'log.dat') then FItems.LoadFromFile(App.Path + 'log.dat');
  FItems.Append('');
  FItems.Append('========ϵͳ������ʱ�䣺' + DateTimeToStr(Now()) + '========');
end;

destructor TLog.Destroy;
begin
  FItems.Append('========ϵͳ�رգ�ʱ�䣺' + DateTimeToStr(Now()) + '========');
  FItems.SaveToFile(App.Path + 'log.dat');
  FItems.Free;
  inherited Destroy;
end;

procedure TLog.Write(const AMsg: string);
begin
  FItems.Append(DateTimeToStr(Now()) + '=> ' + AMsg);
end;

end.
