inherited frmBack: TfrmBack
  Left = 290
  Top = 250
  ActiveControl = cbDept
  Caption = #21592#24037#22797#32844
  ClientHeight = 361
  ClientWidth = 387
  OldCreateOrder = True
  DesignSize = (
    387
    361)
  PixelsPerInch = 96
  TextHeight = 12
  inherited bvl: TBevel
    Top = 325
    Width = 387
  end
  inherited imgHelp: TImage
    Top = 334
  end
  object Label1: TLabel [2]
    Left = 8
    Top = 12
    Width = 36
    Height = 12
    Caption = #24037#21495#65306
  end
  object Label2: TLabel [3]
    Left = 8
    Top = 36
    Width = 36
    Height = 12
    Caption = #22995#21517#65306
  end
  object Label3: TLabel [4]
    Left = 200
    Top = 12
    Width = 60
    Height = 12
    Caption = #22797#32844#26085#26399#65306
  end
  object lblReger: TLabel [5]
    Left = 212
    Top = 36
    Width = 48
    Height = 12
    Caption = #30331#35760#20154#65306
    FocusControl = edtReger
  end
  inherited btnOk: TBitBtn
    Left = 220
    Top = 333
    Caption = #30830#23450
    TabOrder = 6
  end
  inherited btnCancel: TBitBtn
    Left = 301
    Top = 333
    Caption = #21462#28040
    TabOrder = 7
  end
  object edtStaNo: TEdit
    Left = 46
    Top = 8
    Width = 105
    Height = 20
    Enabled = False
    TabOrder = 0
  end
  object edtStaName: TEdit
    Left = 46
    Top = 32
    Width = 105
    Height = 20
    Enabled = False
    TabOrder = 1
  end
  object dpBack: TDateTimePicker
    Left = 262
    Top = 8
    Width = 105
    Height = 20
    Date = 39633.522535983800000000
    Time = 39633.522535983800000000
    TabOrder = 2
  end
  object edtReger: TEdit
    Left = 262
    Top = 32
    Width = 105
    Height = 20
    TabOrder = 3
  end
  object gbOld: TGroupBox
    Left = 8
    Top = 60
    Width = 179
    Height = 257
    Caption = #22797#32844#21069#20449#24687
    TabOrder = 4
    object lblDepto: TLabel
      Left = 8
      Top = 20
      Width = 36
      Height = 12
      Caption = #37096#38376#65306
      FocusControl = edtDept
    end
    object lblDutyo: TLabel
      Left = 8
      Top = 44
      Width = 36
      Height = 12
      Caption = #32844#21153#65306
      FocusControl = edtDuty
    end
    object lblKindo: TLabel
      Left = 8
      Top = 68
      Width = 36
      Height = 12
      Caption = #24037#31181#65306
      FocusControl = cbKind
    end
    object lblTecho: TLabel
      Left = 8
      Top = 92
      Width = 36
      Height = 12
      Caption = #32844#31216#65306
      FocusControl = edtTech
    end
    object Label13: TLabel
      Left = 8
      Top = 116
      Width = 36
      Height = 12
      Caption = #21407#22240#65306
    end
    object Label14: TLabel
      Left = 8
      Top = 140
      Width = 36
      Height = 12
      Caption = #26085#26399#65306
    end
    object lblRegero: TLabel
      Left = 8
      Top = 164
      Width = 48
      Height = 12
      Caption = #30331#35760#20154#65306
      FocusControl = edtLReger
    end
    object Label16: TLabel
      Left = 8
      Top = 188
      Width = 36
      Height = 12
      Caption = #22791#27880#65306
    end
    object edtDept: TEdit
      Left = 46
      Top = 16
      Width = 124
      Height = 20
      Enabled = False
      TabOrder = 0
    end
    object edtDuty: TEdit
      Left = 46
      Top = 40
      Width = 124
      Height = 20
      Enabled = False
      TabOrder = 1
    end
    object edtKind: TEdit
      Left = 46
      Top = 64
      Width = 124
      Height = 20
      Enabled = False
      TabOrder = 2
    end
    object edtTech: TEdit
      Left = 46
      Top = 88
      Width = 124
      Height = 20
      Enabled = False
      TabOrder = 3
    end
    object edtReason: TEdit
      Left = 46
      Top = 112
      Width = 124
      Height = 20
      Enabled = False
      TabOrder = 4
    end
    object edtDate: TEdit
      Left = 46
      Top = 136
      Width = 124
      Height = 20
      Enabled = False
      TabOrder = 5
    end
    object edtLReger: TEdit
      Left = 58
      Top = 160
      Width = 112
      Height = 20
      Enabled = False
      TabOrder = 6
    end
    object meoLDes: TMemo
      Left = 46
      Top = 184
      Width = 124
      Height = 64
      Enabled = False
      ScrollBars = ssVertical
      TabOrder = 7
    end
  end
  object gbNew: TGroupBox
    Left = 199
    Top = 60
    Width = 179
    Height = 257
    Caption = #22797#32844#21518#20449#24687
    TabOrder = 5
    object lblDeptn: TLabel
      Left = 8
      Top = 20
      Width = 36
      Height = 12
      Caption = #37096#38376#65306
      FocusControl = cbDept
    end
    object lblDutyn: TLabel
      Left = 8
      Top = 44
      Width = 36
      Height = 12
      Caption = #32844#21153#65306
      FocusControl = cbDuty
    end
    object lblKindn: TLabel
      Left = 8
      Top = 68
      Width = 36
      Height = 12
      Caption = #24037#31181#65306
      FocusControl = cbKind
    end
    object lblTechn: TLabel
      Left = 8
      Top = 92
      Width = 36
      Height = 12
      Caption = #32844#31216#65306
      FocusControl = cbTech
    end
    object Label17: TLabel
      Left = 8
      Top = 116
      Width = 36
      Height = 12
      Caption = #22791#27880#65306
    end
    object cbDept: TComboBox
      Left = 46
      Top = 16
      Width = 124
      Height = 20
      ItemHeight = 12
      TabOrder = 0
    end
    object cbDuty: TComboBox
      Left = 46
      Top = 40
      Width = 124
      Height = 20
      ItemHeight = 12
      TabOrder = 1
    end
    object cbKind: TComboBox
      Left = 46
      Top = 64
      Width = 124
      Height = 20
      ItemHeight = 12
      TabOrder = 2
    end
    object cbTech: TComboBox
      Left = 46
      Top = 88
      Width = 124
      Height = 20
      ItemHeight = 12
      TabOrder = 3
    end
    object meoDes: TMemo
      Left = 46
      Top = 112
      Width = 124
      Height = 136
      ScrollBars = ssVertical
      TabOrder = 4
    end
  end
end
