inherited frmInqu: TfrmInqu
  Left = 321
  Top = 180
  ActiveControl = edtBV
  Caption = #26723#26696#26597#35810
  ClientHeight = 216
  ClientWidth = 315
  PixelsPerInch = 96
  TextHeight = 12
  inherited bvl: TBevel
    Top = 180
    Width = 315
  end
  inherited imgHelp: TImage
    Top = 190
  end
  object Label5: TLabel [2]
    Left = 16
    Top = 84
    Width = 60
    Height = 12
    Caption = #36923#36753#20851#31995#65306
  end
  inherited btnOk: TBitBtn
    Left = 67
    Top = 188
    Caption = #26597#35810
    TabOrder = 4
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF996D
      684D4D4D4D4D4DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FF4D4D4D996D684D4D4D4D4D4D4D4D4DFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FF4D4D4D4D4D4D4D4D4D4D4D4DA6A6A64D4D
      4D4D4D4DFF00FFFF00FFFF00FF5F5351B69C97C2AAA7D0BBB9C2AAA74D4D4DA6
      A6A6D3D3D3D3D3D3A6A6A64D4D4DA6A6A6FF00FFFF00FFFF00FFFF00FF996D68
      AA8E89B59A96C2ACA84D4D4DA6A6A6D3D3D3D3D3D3FFFF4DD3D3D3A6A6A64D4D
      4DFF00FFFF00FFFF00FFFF00FFFF00FF38302ED3C3BFD3C3BF4D4D4DD3D3D3D3
      D3D3D3D3D3D3D3D3D3D3D3D3D3D34D4D4DFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FF46759C4D4D4DD3D3D3FFFF4DD3D3D3D3D3D3A6A6A6D3D3D34D4D
      4DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1925309DD1FF4D4D4DA6A6A6FF
      FF4DFFFF4DD3D3D3FFFF4DA6A6A64D4D4DFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF36567392CEFF9FD4FF4D4D4DA6A6A6D3D3D3D3D3D3A6A6A64D4D4DFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0B507DB0DEFFBBE2FFB8DBF54D
      4D4D4D4D4D4D4D4D4D4D4DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF096294C9E9FF6896B60C4D782266912975A1FF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0773AB14517C0B55821163933C
      88B2032B3FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FF0A5D8D09679A2A85B420729AFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
  end
  inherited btnCancel: TBitBtn
    Left = 148
    Top = 188
    Caption = #21462#28040
    TabOrder = 5
  end
  object gbBasic: TGroupBox
    Left = 8
    Top = 8
    Width = 298
    Height = 67
    Caption = #22522#26412#26465#20214
    TabOrder = 0
    object Label2: TLabel
      Left = 8
      Top = 20
      Width = 60
      Height = 12
      Caption = #20381#25454#23383#27573#65306
    end
    object Label3: TLabel
      Left = 8
      Top = 44
      Width = 60
      Height = 12
      Caption = #26597' '#35810' '#20540#65306
    end
    object cbBF: TComboBox
      Left = 70
      Top = 16
      Width = 139
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 0
      OnChange = cbBFChange
    end
    object edtBV: TEdit
      Left = 70
      Top = 40
      Width = 219
      Height = 20
      TabOrder = 2
    end
    object cbBC: TComboBox
      Left = 215
      Top = 16
      Width = 74
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      ItemIndex = 2
      TabOrder = 1
      Text = #31561#20110
      OnChange = cbDCChange
      Items.Strings = (
        #22823#20110
        #22823#20110#31561#20110
        #31561#20110
        #23567#20110#31561#20110
        #23567#20110
        #36817#20284#20110)
    end
    object cbBV: TComboBox
      Left = 70
      Top = 47
      Width = 219
      Height = 20
      ItemHeight = 12
      TabOrder = 3
    end
  end
  object gbDate: TGroupBox
    Left = 8
    Top = 105
    Width = 298
    Height = 67
    Caption = #26085#26399#26465#20214
    TabOrder = 3
    object Label1: TLabel
      Left = 8
      Top = 20
      Width = 60
      Height = 12
      Caption = #20381#25454#23383#27573#65306
    end
    object Label4: TLabel
      Left = 8
      Top = 44
      Width = 60
      Height = 12
      Caption = #26597' '#35810' '#20540#65306
    end
    object lblSpace: TLabel
      Left = 177
      Top = 44
      Width = 6
      Height = 12
      Caption = '-'
    end
    object cbDF: TComboBox
      Left = 70
      Top = 16
      Width = 139
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 0
      OnChange = cbDFChange
    end
    object cbDC: TComboBox
      Left = 215
      Top = 16
      Width = 74
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      ItemIndex = 0
      TabOrder = 1
      Text = #22823#20110
      OnChange = cbDCChange
      Items.Strings = (
        #22823#20110
        #22823#20110#31561#20110
        #31561#20110
        #23567#20110#31561#20110
        #23567#20110
        #20171#20110)
    end
    object dpStart: TDateTimePicker
      Left = 70
      Top = 40
      Width = 105
      Height = 20
      Date = 39638.767912326390000000
      Time = 39638.767912326390000000
      TabOrder = 2
    end
    object dpEnd: TDateTimePicker
      Left = 184
      Top = 40
      Width = 105
      Height = 20
      Date = 39638.767912326390000000
      Time = 39638.767912326390000000
      TabOrder = 3
    end
  end
  object rbOr: TRadioButton
    Left = 78
    Top = 82
    Width = 49
    Height = 17
    Caption = #25110#32773
    Checked = True
    TabOrder = 2
    TabStop = True
  end
  object rbAnd: TRadioButton
    Left = 134
    Top = 82
    Width = 49
    Height = 17
    Caption = #24182#19988
    TabOrder = 1
  end
  object btnReset: TButton
    Left = 227
    Top = 188
    Width = 75
    Height = 22
    Caption = #37325#32622'(&R)'
    TabOrder = 6
    OnClick = btnResetClick
  end
end
