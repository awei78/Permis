inherited frmContDlg: TfrmContDlg
  Left = 281
  Top = 184
  Caption = #21512#21516#25991#20214
  ClientHeight = 416
  ClientWidth = 442
  PixelsPerInch = 96
  TextHeight = 12
  inherited bvl: TBevel
    Top = 380
    Width = 442
  end
  inherited imgHelp: TImage
    Top = 389
  end
  object lblDate: TLabel [2]
    Left = 8
    Top = 108
    Width = 60
    Height = 12
    Caption = #31614#35746#26085#26399#65306
  end
  inherited Label1: TLabel
    Left = 32
    Top = 12
  end
  inherited Label2: TLabel
    Left = 274
    Top = 12
  end
  object lblDept: TLabel [5]
    Left = 32
    Top = 36
    Width = 36
    Height = 12
    Caption = #37096#38376#65306
  end
  object Label3: TLabel [6]
    Left = 8
    Top = 60
    Width = 60
    Height = 12
    Caption = #21512#21516#32534#21495#65306
  end
  object Label4: TLabel [7]
    Left = 250
    Top = 60
    Width = 60
    Height = 12
    Caption = #21512#21516#21517#31216#65306
  end
  object Label5: TLabel [8]
    Left = 8
    Top = 84
    Width = 60
    Height = 12
    Caption = #21512#21516#31867#22411#65306
  end
  object Label6: TLabel [9]
    Left = 250
    Top = 84
    Width = 60
    Height = 12
    Caption = #21512#21516#23646#24615#65306
  end
  object Label7: TLabel [10]
    Left = 250
    Top = 108
    Width = 84
    Height = 12
    Caption = #21512#21516#26399#38480'('#26376')'#65306
  end
  object Label8: TLabel [11]
    Left = 8
    Top = 132
    Width = 60
    Height = 12
    Caption = #29983#25928#26085#26399#65306
  end
  object Label9: TLabel [12]
    Left = 250
    Top = 132
    Width = 60
    Height = 12
    Caption = #32456#27490#26085#26399#65306
  end
  object lblReger: TLabel [13]
    Left = 262
    Top = 36
    Width = 48
    Height = 12
    Caption = #30331#35760#20154#65306
    FocusControl = edtReger
  end
  object Label10: TLabel [14]
    Left = 8
    Top = 180
    Width = 60
    Height = 12
    Caption = #21512#21516#25991#20214#65306
  end
  object Label11: TLabel [15]
    Left = 8
    Top = 204
    Width = 60
    Height = 12
    Caption = #21512#21516#22791#27880#65306
  end
  object Label12: TLabel [16]
    Left = 8
    Top = 156
    Width = 60
    Height = 12
    Caption = #21512#21516#29366#24577#65306
  end
  inherited btnOk: TBitBtn
    Left = 275
    Top = 388
    TabOrder = 16
  end
  inherited btnCancel: TBitBtn
    Left = 356
    Top = 388
    TabOrder = 17
  end
  inherited edtStaNo: TRzButtonEdit
    Left = 70
    Top = 8
    Width = 121
  end
  inherited edtStaName: TEdit
    Left = 312
    Top = 8
    Width = 121
  end
  object deRecDate: TDateTimePicker [21]
    Left = 70
    Top = 104
    Width = 121
    Height = 20
    Date = 39887.933767523150000000
    Time = 39887.933767523150000000
    TabOrder = 8
  end
  object edtDept: TEdit [22]
    Left = 70
    Top = 32
    Width = 121
    Height = 20
    TabOrder = 2
  end
  object edtContNo: TEdit [23]
    Left = 70
    Top = 56
    Width = 121
    Height = 20
    TabOrder = 4
  end
  object edtContName: TEdit [24]
    Left = 312
    Top = 56
    Width = 121
    Height = 20
    TabOrder = 5
  end
  object cbType: TComboBox [25]
    Left = 70
    Top = 80
    Width = 121
    Height = 20
    ItemHeight = 12
    TabOrder = 6
  end
  object cbProp: TComboBox [26]
    Left = 312
    Top = 80
    Width = 121
    Height = 20
    ItemHeight = 12
    ItemIndex = 0
    TabOrder = 7
    Text = #27491#24335#21512#21516
    Items.Strings = (
      #27491#24335#21512#21516
      #35797#29992#21512#21516
      #26080#26399#38480#21512#21516)
  end
  object deStartDate: TDateTimePicker [27]
    Left = 70
    Top = 128
    Width = 121
    Height = 20
    Date = 39887.933505659720000000
    Time = 39887.933505659720000000
    TabOrder = 10
    OnChange = deStartDateChange
  end
  object deEndDate: TDateTimePicker [28]
    Left = 312
    Top = 128
    Width = 121
    Height = 20
    Date = 39887.933505659720000000
    Time = 39887.933505659720000000
    TabOrder = 11
  end
  object edtReger: TEdit [29]
    Left = 312
    Top = 32
    Width = 121
    Height = 20
    TabOrder = 3
  end
  object beContFile: TRzButtonEdit [30]
    Left = 70
    Top = 176
    Width = 291
    Height = 20
    TabOrder = 13
    OnButtonClick = beContFileButtonClick
  end
  object btnOpen: TBitBtn [31]
    Left = 365
    Top = 175
    Width = 65
    Height = 21
    Caption = #25171#24320
    TabOrder = 14
    OnClick = btnOpenClick
  end
  object meoDes: TMemo [32]
    Left = 70
    Top = 200
    Width = 363
    Height = 171
    ScrollBars = ssVertical
    TabOrder = 15
  end
  object seMonth: TRzSpinEdit [33]
    Left = 336
    Top = 104
    Width = 97
    Height = 20
    Value = 12.000000000000000000
    TabOrder = 9
    OnChange = seMonthChange
  end
  object cbState: TComboBox [34]
    Left = 70
    Top = 152
    Width = 121
    Height = 20
    ItemHeight = 12
    TabOrder = 12
    Text = #29983#25928
    Items.Strings = (
      #29983#25928#20013
      #26410#29983#25928
      #24050#36807#26399
      #24050#35299#38500)
  end
  inherited pnlStaff: TRzPanel
    Left = 435
    TabOrder = 18
  end
  inherited ds_staff: TDataSource
    Left = 382
    Top = 219
  end
  inherited aq_staff: TADOQuery
    Left = 351
    Top = 219
  end
end
