{*****************************************************************
  单元名称: uLog.pas
  修改时间: 2005-06-24
  编写人员: Liujw
  功能描述：信息显示及记录单元
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
  //若记录文件超过2MB，则删除
  if FileExists(App.Path + 'log.dat') and (GetFileSize(App.Path + 'log.dat') > 2000) then
    DeleteFile(App.Path + 'log.dat');

  FItems := TStringList.Create;
  if FileExists(App.Path + 'log.dat') then FItems.LoadFromFile(App.Path + 'log.dat');
  FItems.Append('');
  FItems.Append('========系统启动，时间：' + DateTimeToStr(Now()) + '========');
end;

destructor TLog.Destroy;
begin
  FItems.Append('========系统关闭，时间：' + DateTimeToStr(Now()) + '========');
  FItems.SaveToFile(App.Path + 'log.dat');
  FItems.Free;
  inherited Destroy;
end;

procedure TLog.Write(const AMsg: string);
begin
  FItems.Append(DateTimeToStr(Now()) + '=> ' + AMsg);
end;

end.
