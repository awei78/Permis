inherited frmParamSet: TfrmParamSet
  Left = 252
  Top = 176
  Caption = #21442#25968#35774#32622
  ClientHeight = 206
  ClientWidth = 344
  OldCreateOrder = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 12
  inherited bvl: TBevel
    Top = 170
    Width = 344
  end
  inherited imgHelp: TImage
    Top = 179
  end
  inherited btnOk: TBitBtn
    Left = 96
    Top = 178
    Caption = #30830#23450
    TabOrder = 1
  end
  inherited btnCancel: TBitBtn
    Left = 177
    Top = 178
    Caption = #21462#28040
    TabOrder = 2
  end
  object pcSet: TPageControl
    Left = 8
    Top = 8
    Width = 329
    Height = 155
    ActivePage = tsBasic
    TabOrder = 0
    object tsBasic: TTabSheet
      Caption = #22522#26412#21442#25968
      object lblColor: TLabel
        Left = 178
        Top = 92
        Width = 36
        Height = 12
        Caption = #39068#33394#65306
      end
      object lblColorL: TLabel
        Left = 178
        Top = 74
        Width = 36
        Height = 12
        Caption = #39068#33394#65306
      end
      object lblPrefix: TLabel
        Left = 178
        Top = 38
        Width = 36
        Height = 12
        Caption = #21069#32512#65306
      end
      object cbPrint: TCheckBox
        Left = 178
        Top = 0
        Width = 94
        Height = 17
        Caption = #30452#25509#25171#21360#25968#25454
        TabOrder = 1
      end
      object cbDblEdit: TCheckBox
        Left = 8
        Top = 0
        Width = 142
        Height = 17
        Caption = #21592#24037#26723#26696#25968#25454#21452#20987#32534#36753
        TabOrder = 0
      end
      object cbEscClose: TCheckBox
        Left = 8
        Top = 18
        Width = 172
        Height = 17
        Caption = 'Esc'#38190#30452#25509#20851#38381#21592#24037#20449#24687#31383#20307
        TabOrder = 2
      end
      object cbEffLine: TCheckBox
        Left = 8
        Top = 90
        Width = 154
        Height = 17
        Caption = #21592#24037#20449#24687#34920#26684#26001#39532#32447#25928#26524
        TabOrder = 8
        OnClick = cbEffLineClick
      end
      object cbCanEdit: TCheckBox
        Left = 8
        Top = 54
        Width = 130
        Height = 17
        Caption = #31163#32844#21592#24037#26723#26696#21487#32534#36753
        TabOrder = 5
      end
      object cbEffColor: TColorBox
        Left = 216
        Top = 88
        Width = 75
        Height = 20
        AutoDropDown = True
        Style = [cbStandardColors, cbIncludeDefault, cbCustomColor, cbPrettyNames]
        ItemHeight = 14
        TabOrder = 9
      end
      object cbLightLeave: TCheckBox
        Left = 8
        Top = 72
        Width = 130
        Height = 17
        Caption = #39640#20142#26174#31034#24453#38144#20551#21592#24037
        TabOrder = 6
        OnClick = cbLightLeaveClick
      end
      object cbLeaveColor: TColorBox
        Left = 216
        Top = 70
        Width = 75
        Height = 20
        AutoDropDown = True
        Style = [cbStandardColors, cbIncludeDefault, cbCustomColor, cbPrettyNames]
        ItemHeight = 14
        TabOrder = 7
      end
      object cbAutoCode: TCheckBox
        Left = 8
        Top = 36
        Width = 118
        Height = 17
        Caption = #26032#21152#21592#24037#33258#21160#32534#21495
        TabOrder = 3
        OnClick = cbAutoCodeClick
      end
      object edtPrefix: TEdit
        Left = 216
        Top = 34
        Width = 75
        Height = 20
        TabOrder = 4
      end
    end
    object tsAwake: TTabSheet
      Caption = #25552#37266#35774#32622
      ImageIndex = 1
      object cbUseAwake: TCheckBox
        Left = 8
        Top = 0
        Width = 94
        Height = 17
        Caption = #21551#29992#20107#20214#25552#37266
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = cbUseAwakeClick
      end
      object pnlAwake: TPanel
        Left = 24
        Top = 21
        Width = 178
        Height = 85
        AutoSize = True
        BevelOuter = bvNone
        TabOrder = 1
        object Label1: TLabel
          Left = 0
          Top = 4
          Width = 108
          Height = 12
          Caption = #29983#26085#25552#37266#65306'    '#25552#21069
        end
        object Label2: TLabel
          Left = 0
          Top = 45
          Width = 108
          Height = 12
          Caption = #21512#21516#32467#26463#25552#37266#65306#25552#21069
        end
        object Label3: TLabel
          Left = 0
          Top = 69
          Width = 108
          Height = 12
          Caption = #36716#27491#25552#37266#65306'    '#25552#21069
        end
        object Label4: TLabel
          Left = 166
          Top = 4
          Width = 12
          Height = 12
          Caption = #22825
        end
        object Label5: TLabel
          Left = 166
          Top = 45
          Width = 12
          Height = 12
          Caption = #22825
        end
        object Label6: TLabel
          Left = 166
          Top = 69
          Width = 12
          Height = 12
          Caption = #22825
        end
        object seBirth: TRzSpinEdit
          Left = 113
          Top = 0
          Width = 47
          Height = 20
          Value = 3.000000000000000000
          TabOrder = 0
        end
        object seContract: TRzSpinEdit
          Left = 113
          Top = 41
          Width = 47
          Height = 20
          Value = 30.000000000000000000
          TabOrder = 2
        end
        object seStaff: TRzSpinEdit
          Left = 113
          Top = 65
          Width = 47
          Height = 20
          Value = 15.000000000000000000
          TabOrder = 3
        end
        object cbGreg: TCheckBox
          Left = 16
          Top = 22
          Width = 118
          Height = 17
          Caption = #20351#29992#38451#21382#29983#26085#25552#37266
          TabOrder = 1
        end
      end
    end
    object tsImage: TTabSheet
      Caption = #32972#26223#22270#29255
      ImageIndex = 3
      object cbUseImage: TCheckBox
        Left = 8
        Top = 0
        Width = 94
        Height = 17
        Caption = #21551#29992#32972#26223#22270#29255
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = cbUseImageClick
      end
      object pnlImage: TPanel
        Left = 24
        Top = 21
        Width = 289
        Height = 87
        AutoSize = True
        BevelOuter = bvNone
        TabOrder = 1
        object Label8: TLabel
          Left = 0
          Top = 4
          Width = 36
          Height = 12
          Caption = #22270#29255#65306
        end
        object Label9: TLabel
          Left = 0
          Top = 28
          Width = 36
          Height = 12
          Caption = #24067#23616#65306
        end
        object Label10: TLabel
          Left = 0
          Top = 52
          Width = 36
          Height = 12
          Caption = #39068#33394#65306
        end
        object beImage: TRzButtonEdit
          Left = 38
          Top = 0
          Width = 251
          Height = 20
          TabOrder = 0
          OnButtonClick = beImageButtonClick
        end
        object cbLayout: TComboBox
          Left = 38
          Top = 24
          Width = 57
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          ItemIndex = 0
          TabOrder = 1
          Text = #23621#20013
          OnChange = cbLayoutChange
          Items.Strings = (
            #23621#20013
            #19968#33324
            #24179#38138)
        end
        object cbNeedPwd: TCheckBox
          Left = 0
          Top = 70
          Width = 202
          Height = 17
          Caption = #20999#25442#21040#25968#25454#25805#20316#38656#35201#36755#20837#30331#24405#23494#30721
          TabOrder = 5
        end
        object cbStretch: TCheckBox
          Left = 110
          Top = 26
          Width = 46
          Height = 17
          Caption = #25289#20280
          TabOrder = 2
          OnClick = cbStretchClick
        end
        object cbKeepScale: TCheckBox
          Left = 166
          Top = 26
          Width = 70
          Height = 17
          Caption = #20445#25345#27604#20363
          TabOrder = 3
        end
        object cbBGColor: TColorBox
          Left = 38
          Top = 48
          Width = 57
          Height = 20
          AutoDropDown = True
          Style = [cbStandardColors, cbIncludeDefault, cbCustomColor, cbPrettyNames]
          ItemHeight = 14
          TabOrder = 4
        end
      end
    end
    object tsData: TTabSheet
      Caption = #25968#25454#22791#20221
      ImageIndex = 2
      object cbUseData: TCheckBox
        Left = 8
        Top = 0
        Width = 142
        Height = 17
        Caption = #21551#29992#25968#25454#33258#21160#22791#20221#21151#33021
        TabOrder = 0
        OnClick = cbUseDataClick
      end
      object pnlData: TPanel
        Left = 24
        Top = 21
        Width = 289
        Height = 92
        AutoSize = True
        BevelOuter = bvNone
        TabOrder = 1
        object Label7: TLabel
          Left = 0
          Top = 76
          Width = 60
          Height = 12
          Caption = #22791#20221#36335#24452#65306
        end
        object rbDay: TRadioButton
          Left = 0
          Top = 0
          Width = 46
          Height = 17
          Caption = #27599#22825
          TabOrder = 0
          OnClick = RadioChick
        end
        object rbWeek: TRadioButton
          Left = 0
          Top = 24
          Width = 58
          Height = 17
          Caption = #27599#26143#26399
          Checked = True
          TabOrder = 1
          TabStop = True
          OnClick = RadioChick
        end
        object cbWeek: TComboBox
          Left = 62
          Top = 24
          Width = 67
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          ItemIndex = 1
          TabOrder = 2
          Text = #26143#26399#19968
          Items.Strings = (
            #26143#26399#26085
            #26143#26399#19968
            #26143#26399#20108
            #26143#26399#19977
            #26143#26399#22235
            #26143#26399#20116
            #26143#26399#20845)
        end
        object rbMonth: TRadioButton
          Left = 0
          Top = 49
          Width = 44
          Height = 17
          Caption = #27599#26376
          TabOrder = 3
          OnClick = RadioChick
        end
        object cbDay: TComboBox
          Left = 62
          Top = 48
          Width = 67
          Height = 20
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 4
        end
        object bePath: TRzButtonEdit
          Left = 62
          Top = 72
          Width = 227
          Height = 20
          TabOrder = 5
          OnButtonClick = bePathButtonClick
        end
      end
    end
  end
  object btnReset: TButton
    Left = 258
    Top = 178
    Width = 75
    Height = 22
    Anchors = []
    Caption = #37325#32622'(&R)'
    TabOrder = 3
    OnClick = btnResetClick
  end
end
