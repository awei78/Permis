{******
  单 元：uLunar.pas
  作 者：刘景威
  日 期：2008-11-29
  说 明：农历日期转阳历日期；摘自lssCalendar控件
  更 新：                                                                  
******}

unit uLunar;

interface

uses
  Controls, SysUtils, DateUtils;

function ToGreg(ADate: TDate): TDate;

implementation

const
  lunarInfo: array[0..200] of Word = (
    $4BD8, $4AE0, $A570, $54D5, $D260, $D950, $5554, $56AF, $9AD0, $55D2,
    $4AE0, $A5B6, $A4D0, $D250, $D295, $B54F, $D6A0, $ADA2, $95B0, $4977,
    $497F, $A4B0, $B4B5, $6A50, $6D40, $AB54, $2B6F, $9570, $52F2, $4970,
    $6566, $D4A0, $EA50, $6A95, $5ADF, $2B60, $86E3, $92EF, $C8D7, $C95F,
    $D4A0, $D8A6, $B55F, $56A0, $A5B4, $25DF, $92D0, $D2B2, $A950, $B557,
    $6CA0, $B550, $5355, $4DAF, $A5B0, $4573, $52BF, $A9A8, $E950, $6AA0,
    $AEA6, $AB50, $4B60, $AAE4, $A570, $5260, $F263, $D950, $5B57, $56A0,
    $96D0, $4DD5, $4AD0, $A4D0, $D4D4, $D250, $D558, $B540, $B6A0, $95A6,
    $95BF, $49B0, $A974, $A4B0, $B27A, $6A50, $6D40, $AF46, $AB60, $9570,
    $4AF5, $4970, $64B0, $74A3, $EA50, $6B58, $5AC0, $AB60, $96D5, $92E0, //1999
    $C960, $D954, $D4A0, $DA50, $7552, $56A0, $ABB7, $25D0, $92D0, $CAB5,
    $A950, $B4A0, $BAA4, $AD50, $55D9, $4BA0, $A5B0, $5176, $52BF, $A930,
    $7954, $6AA0, $AD50, $5B52, $4B60, $A6E6, $A4E0, $D260, $EA65, $D530,
    $5AA0, $76A3, $96D0, $4AFB, $4AD0, $A4D0, $D0B6, $D25F, $D520, $DD45,
    $B5A0, $56D0, $55B2, $49B0, $A577, $A4B0, $AA50, $B255, $6D2F, $ADA0,
    $4B63, $937F, $49F8, $4970, $64B0, $68A6, $EA5F, $6B20, $A6C4, $AAEF,
    $92E0, $D2E3, $C960, $D557, $D4A0, $DA50, $5D55, $56A0, $A6D0, $55D4,
    $52D0, $A9B8, $A950, $B4A0, $B6A6, $AD50, $55A0, $ABA4, $A5B0, $52B0,
    $B273, $6930, $7337, $6AA0, $AD50, $4B55, $4B6F, $A570, $54E4, $D260,
    $E968, $D520, $DAA0, $6AA6, $56DF, $4AE0, $A9D4, $A4D0, $D150, $F252,
    $D520);

type
  TLuDate = record //农历日期
    Year: Integer;
    Month: Integer;
    Day: Integer;
    isLeap: Boolean; //闰月
  end;

function LeapMonth(y: Integer): Integer;
var
  lm: Word;
begin
  lm := lunarInfo[y - 1900] and $F;
  if lm = $F then Result := 0 else Result := lm;
end;

function DaysOfLeapMonth(y: Integer): Integer;
begin
  if leapMonth(y) > 0 then
    if (lunarInfo[y - 1899] and $F) = $F then
      Result := 30
    else Result := 29
  else Result := 0;
end;

function DaysOfMonth(y, m: Integer): Integer;
var
  temp1, temp2, temp3: Word;
begin
  temp1 := lunarInfo[y - 1900];
  temp2 := $8000;
  if m > 1 then temp2 := $8000 shr (m - 1);
  temp3 := temp1 and temp2;
  if temp3 > 0 then
    Result := 30
  else Result := 29;
end;

function DaysOfLunarYear(y: Integer): Integer;
var
  i, sum: Integer;
begin
  sum := 348; //29 * 12
  i := $8000;
  while i > $8 do
  begin
    if (lunarInfo[y - 1900] and i) > 0 then sum := sum + 1;
    i := i shr 1;
  end;
  Result := sum + DaysOfLeapMonth(y);
end;

function ToLunar(ADate: TDate): TLuDate;
var
  y, m, d: Word;
begin
  DecodeDate(ADate, y, m, d);
  Result.Year := YearOf(Date());
  Result.Month := m;
  Result.Day := d;
end;

function ToGreg(ADate: TDate): TDate;
var
  i, j, t, leap, temp, offset: Integer;
  objDate: TLuDate;
  isLeap: Boolean;
  y, m: Integer;
begin
  objDate := ToLunar(ADate);

  isLeap := False;
  y := objDate.Year;
  m := objDate.Month;
  leap := leapMonth(y);

  //本年内从大年初一过来的天数
  offset := 0;
  i := 1;
  while i < m do
  begin
    if i = leap then
    begin
      if isLeap then
      begin
        temp := DaysOfleapMonth(y);
        isLeap := False;
      end
      else
      begin
        temp := DaysOfmonth(y, i);
        isLeap := True;
        i := i - 1;
      end;
    end
    else temp := DaysOfMonth(y, i);
    offset := offset + temp;
    Inc(i);
  end;

  offset := offset + objDate.Day - 1;
  if (m = leap) and objDate.isLeap then //若为闰月，再加上前一个非闰月天数
    offset := offset + DaysOfMonth(y, m);

  //该年到 2000.1.1 这几年的天数
  if y > 2000 then
  begin
    i := 2000;
    j := y - 1;
  end
  else
  begin
    i := y;
    j := 1999;
  end;

  temp := 0;
  for t := i to j do
    temp := temp + DaysOfLunarYear(t);

  if y > 1999 then
    offset := offset + temp
  else offset := offset - temp;

  //农历二零零零年大年初一的阳历为 2000.2.5
  Result := IncDay(EncodeDate(2000, 2, 5), offset);
end;

end.

