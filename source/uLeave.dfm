inherited frmLeave: TfrmLeave
  ActiveControl = edtStaNo
  Caption = #21592#24037#35831#20551
  ClientHeight = 258
  ClientWidth = 387
  OnShow = FormShow
  DesignSize = (
    387
    258)
  PixelsPerInch = 96
  TextHeight = 12
  inherited bvl: TBevel
    Top = 222
    Width = 387
  end
  inherited imgHelp: TImage
    Top = 236
  end
  object lblDate: TLabel [2]
    Left = 8
    Top = 36
    Width = 60
    Height = 12
    Caption = #35831#20551#26085#26399#65306
  end
  object lblReger: TLabel [3]
    Left = 216
    Top = 198
    Width = 48
    Height = 12
    Caption = #30331#35760#20154#65306
    FocusControl = edtReger
  end
  object Label5: TLabel [4]
    Left = 226
    Top = 36
    Width = 36
    Height = 12
    Caption = #22825#25968#65306
  end
  object Label6: TLabel [5]
    Left = 8
    Top = 60
    Width = 36
    Height = 12
    Caption = #21407#22240#65306
  end
  object Label7: TLabel [6]
    Left = 8
    Top = 129
    Width = 36
    Height = 12
    Caption = #22791#27880#65306
  end
  object lblUnDate: TLabel [7]
    Left = 8
    Top = 198
    Width = 60
    Height = 12
    Caption = #38144#20551#26085#26399#65306
  end
  inherited Label1: TLabel
    Top = 12
  end
  inherited Label2: TLabel
    Top = 12
  end
  inherited btnOk: TBitBtn
    Left = 220
    Top = 230
    TabOrder = 10
  end
  inherited btnCancel: TBitBtn
    Left = 301
    Top = 230
    TabOrder = 11
  end
  inherited edtStaNo: TRzButtonEdit
    Top = 8
    Width = 117
  end
  inherited edtStaName: TEdit
    Top = 8
    Width = 105
  end
  object dpLeave: TDateTimePicker [14]
    Left = 70
    Top = 32
    Width = 93
    Height = 20
    Date = 39633.522535983800000000
    Time = 39633.522535983800000000
    TabOrder = 2
    OnChange = dpLeaveChange
  end
  object edtReger: TEdit [15]
    Left = 266
    Top = 194
    Width = 103
    Height = 20
    TabOrder = 8
  end
  object edtDay: TRzNumericEdit [16]
    Left = 264
    Top = 32
    Width = 51
    Height = 20
    MaxLength = 4
    TabOrder = 3
    OnChange = edtDayChange
    IntegersOnly = False
    Max = 100.000000000000000000
    Value = 1.000000000000000000
    DisplayFormat = '0.#'
  end
  object udDay: TUpDown [17]
    Left = 315
    Top = 32
    Width = 17
    Height = 20
    Position = 1
    TabOrder = 4
    OnChangingEx = udDayChangingEx
  end
  object meoReason: TMemo [18]
    Left = 46
    Top = 56
    Width = 323
    Height = 65
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object meoDes: TMemo [19]
    Left = 46
    Top = 125
    Width = 323
    Height = 65
    ScrollBars = ssVertical
    TabOrder = 6
  end
  object dpUnDate: TDateTimePicker [20]
    Left = 70
    Top = 194
    Width = 91
    Height = 20
    Date = 39633.522535983800000000
    Time = 39633.522535983800000000
    TabOrder = 7
  end
  object btnPrint: TBitBtn [21]
    Left = 12
    Top = 230
    Width = 75
    Height = 22
    Anchors = [akRight, akBottom]
    Caption = #25171#21360'(&P)'
    TabOrder = 9
    OnClick = btnPrintClick
    Glyph.Data = {
      36060000424D3606000000000000360000002800000020000000100000000100
      1800000000000006000000000000000000000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D
      4DFF00FFFF00FFFF00FFFF00FFFF00FFB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
      B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2FF00FFFF00FFFF00FFFF00FF4D4D4D
      D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D34D4D4DD3D3
      D34D4D4DFF00FFFF00FFFF00FFB2B2B2D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3
      D3D3D3D3D3D3D3D3D3D3D3B2B2B2D3D3D3B2B2B2FF00FFFF00FF4D4D4D4D4D4D
      4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D
      4DD3D3D34D4D4DFF00FFB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
      B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2D3D3D3B2B2B2FF00FF4D4D4DD3D3D3
      D3D3D3D3D3D3D3D3D3D3D3D3D3D3D34DFFFF4DFFFF4DFFFFD3D3D3D3D3D34D4D
      4D4D4D4D4D4D4DFF00FFB2B2B2D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D34D
      FFFF4DFFFF4DFFFFD3D3D3D3D3D3B2B2B2B2B2B2B2B2B2FF00FF4D4D4DD3D3D3
      D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3A6A6A6A6A6A6A6A6A6D3D3D3D3D3D34D4D
      4DD3D3D34D4D4DFF00FFB2B2B2D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3A6
      A6A6A6A6A6A6A6A6D3D3D3D3D3D3B2B2B2D3D3D3B2B2B2FF00FF4D4D4D4D4D4D
      4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D
      4DD3D3D3D3D3D34D4D4DB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
      B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2D3D3D3D3D3D3B2B2B24D4D4DD3D3D3
      D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D34D4D4DD3D3
      D34D4D4DD3D3D34D4D4DB2B2B2D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3
      D3D3D3D3D3D3D3D3D3D3D3B2B2B2D3D3D3B2B2B2D3D3D3B2B2B2FF00FF4D4D4D
      4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4DD3D3D34D4D
      4DD3D3D34D4D4D4D4D4DFF00FFB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
      B2B2B2B2B2B2B2B2B2B2B2D3D3D3B2B2B2D3D3D3B2B2B2B2B2B2FF00FFFF00FF
      4D4D4DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4D4D4DD3D3
      D34D4D4DD3D3D34D4D4DFF00FFFF00FFB2B2B2FFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFB2B2B2D3D3D3B2B2B2D3D3D3B2B2B2FF00FFFF00FF
      FF00FF4D4D4DFFFFFF4D4D4D4D4D4D4D4D4D4D4D4D4D4D4DFFFFFF4D4D4D4D4D
      4D4D4D4D4D4D4DFF00FFFF00FFFF00FFFF00FFB2B2B2FFFFFFB2B2B2B2B2B2B2
      B2B2B2B2B2B2B2B2FFFFFFB2B2B2B2B2B2B2B2B2B2B2B2FF00FFFF00FFFF00FF
      FF00FF4D4D4DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4D4D
      4DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB2B2B2FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFB2B2B2FF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FF4D4D4DFFFFFF4D4D4D4D4D4D4D4D4D4D4D4D4D4D4DFFFFFF4D4D
      4DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB2B2B2FFFFFFB2B2B2B2
      B2B2B2B2B2B2B2B2B2B2B2FFFFFFB2B2B2FF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FF4D4D4DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FF4D4D4DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB2B2B2FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB2B2B2FF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FF4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D
      4D4D4D4DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB2B2B2B2B2B2B2
      B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2FF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    NumGlyphs = 2
  end
  inherited pnlStaff: TRzPanel
    TabOrder = 12
  end
end
