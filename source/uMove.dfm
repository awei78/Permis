inherited frmMove: TfrmMove
  ActiveControl = edtStaNo
  Caption = #21592#24037#35843#21160
  ClientHeight = 295
  ClientWidth = 387
  DesignSize = (
    387
    295)
  PixelsPerInch = 96
  TextHeight = 12
  inherited bvl: TBevel
    Top = 259
    Width = 387
  end
  inherited imgHelp: TImage
    Top = 268
  end
  object Label3: TLabel [2]
    Left = 200
    Top = 12
    Width = 60
    Height = 12
    Caption = #35843#21160#26085#26399#65306
  end
  object lblReger: TLabel [3]
    Left = 212
    Top = 36
    Width = 48
    Height = 12
    Caption = #30331#35760#20154#65306
    FocusControl = edtReger
  end
  inherited Label1: TLabel
    Top = 12
  end
  inherited Label2: TLabel
    Left = 8
  end
  inherited btnOk: TBitBtn
    Left = 220
    Top = 267
    Caption = #30830#23450
    TabOrder = 7
  end
  inherited btnCancel: TBitBtn
    Left = 301
    Top = 267
    Caption = #21462#28040
    TabOrder = 8
  end
  inherited edtStaNo: TRzButtonEdit
    Top = 8
    Width = 105
  end
  inherited edtStaName: TEdit
    Left = 46
    Width = 105
  end
  object dpMove: TDateTimePicker [10]
    Left = 262
    Top = 8
    Width = 105
    Height = 20
    Date = 39633.522535983800000000
    Time = 39633.522535983800000000
    TabOrder = 2
  end
  object edtReger: TEdit [11]
    Left = 262
    Top = 32
    Width = 105
    Height = 20
    TabOrder = 3
  end
  object gbOld: TGroupBox [12]
    Left = 8
    Top = 60
    Width = 179
    Height = 117
    Caption = #35843#21160#21069#20449#24687
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
      FocusControl = cbDuty
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
  end
  object gbNew: TGroupBox [13]
    Left = 199
    Top = 60
    Width = 179
    Height = 117
    Caption = #35843#21160#21518#20449#24687
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
  end
  object gbDes: TGroupBox [14]
    Left = 8
    Top = 183
    Width = 370
    Height = 68
    Caption = #22791#27880
    TabOrder = 6
    object meoDes: TMemo
      Left = 8
      Top = 16
      Width = 353
      Height = 44
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  inherited pnlStaff: TRzPanel
    TabOrder = 9
  end
end
