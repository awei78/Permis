unit uData;

interface

uses
  Windows, Messages, Classes, SysUtils, Registry, md5;

resourcestring
  PER_KEY_NAME = 'Software\APermis';
  //呦呦鹿鸣，食野之苹；我有嘉宾，鼓瑟吹笙;
  PER_REG_SEED = '223|207|223|207|194|185|195|249|163|172|202|179|210|176|214|174|198|187|163|187|206|210|211|208|188|206|177|246|163|172|185|196|201|170|180|181|243|207';
  //秋风人事档案管理系统
  CAPTION_CODE = '199|239|183|231|200|203|202|194|181|181|176|184|185|220|192|237|207|181|205|179';
  //试用版
  TRIAL_CODE   = '202|212|211|195|176|230';
  //TfrmMain
  CLASS_NAME   = '84|102|114|109|77|97|105|110';
const
  MAX_RECORD   = 20;

//检测是否注册成功
function Autumn(const AKey, ACode: string): Boolean; export; stdcall;
//判断记录数
function Wind(const ARecordCount: Integer = 0): Boolean; export; stdcall;

implementation

function CodeToStr(const ACode: string): string;
var
  sl: TStrings;
  i: Integer;
begin
  //获取seed...
  sl := TStringList.Create;
  try
    ExtractStrings(['|'], [], PAnsiChar(ACode), sl);
    for i := 0 to sl.Count - 1 do
      Result := Result + Char(StrToInt(sl[i]));
  finally
    sl.Free;
  end;
end;

function Autumn(const AKey, ACode: string): Boolean;
  function GetMidCode(const s: string): string;
  var
    sMid: string;
    i: Integer;
  begin
    sMid := UpperCase(MD5Print(MD5String(s)));
    for i := 1 to Length(sMid) do
      if i Mod 8 = 0 then Result := Result + sMid[i];
  end;

var
  s, sCode, sSeed: string;
  i: Integer;
begin
  if (AKey = '') or (ACode = '') then
  begin
    Result := False;
    Exit;
  end;

  s := UpperCase(MD5Print(MD5String('780927+' + AKey + '+790621')));
  for i := 1 to Length(s) do
    if not Odd(i) then sCode := sCode + s[i];

  sSeed := CodeToStr(PER_REG_SEED);
  sCode := Copy(sCode, 1, 8) + GetMidCode(sSeed + AKey + sSeed) + Copy(sCode, 9, 8);
  Result := sCode = ACode;
end;

function Wind(const ARecordCount: Integer): Boolean;
var
  hWnd: THandle;
  buf: array[0..MAX_PATH] of Char;
begin
  Result := True;
  //记录之判断
  hWnd := FindWindow(PAnsiChar(CodeToStr(CLASS_NAME)), nil);
  if hWnd <> 0 then
  begin
    GetWindowText(hWnd, buf, MAX_PATH);
    if (Pos(CodeToStr(CAPTION_CODE), StrPas(buf)) > 0) and (Pos(CodeToStr(TRIAL_CODE), StrPas(buf)) > 0) then
    begin
      Randomize();
      if (ARecordCount > MAX_RECORD) and (Random(10) = 2) then
      begin
        PostMessage(hWnd, WM_CLOSE, 0, 0);
        Result := False;
      end;
    end;
  end;
end;

end.
