object frmMain: TfrmMain
  Left = 201
  Top = 112
  ActiveControl = dgStaff
  Caption = #26970#20154#20154#20107#26723#26696#31649#29702#31995#32479
  ClientHeight = 574
  ClientWidth = 859
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  Menu = mnuPer
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnPaint = FormPaint
  OnResize = FormResize
  OnShortCut = FormShortCut
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object sbPer: TStatusBar
    Left = 0
    Top = 555
    Width = 859
    Height = 19
    Panels = <
      item
        Width = 156
      end
      item
        Width = 135
      end
      item
        Width = 275
      end
      item
        Alignment = taRightJustify
        Width = 250
      end>
    ExplicitTop = 535
  end
  object tbPer: TRzToolbar
    Left = 0
    Top = 0
    Width = 859
    Height = 27
    AutoStyle = False
    Images = ilPer
    Margin = 1
    TopMargin = 1
    ButtonWidth = 60
    ShowButtonCaptions = True
    TextOptions = ttoSelectiveTextOnRight
    BorderInner = fsNone
    BorderOuter = fsGroove
    BorderSides = []
    BorderWidth = 0
    TabOrder = 0
    ToolbarControls = (
      btnDept
      btnSort
      Spacer1
      btnAdd
      btnEdit
      btnDel
      btnInqu
      Spacer2
      btnChart
      btnPrint
      btnExport
      Spacer3
      btnView
      btnBack)
    object btnDept: TRzToolButton
      Left = 1
      Top = 1
      Width = 76
      Hint = #35774#32622#24744#20844#21496#30340#37096#38376#20449#24687
      Action = actDept
      Caption = #37096#38376#35774#32622
    end
    object btnSort: TRzToolButton
      Left = 77
      Top = 1
      Width = 76
      Hint = #35774#32622#22522#26412#25968#25454
      Action = actDict
      Caption = #20998#31867#20449#24687
    end
    object Spacer1: TRzSpacer
      Left = 153
      Top = 1
      Grooved = True
    end
    object btnAdd: TRzToolButton
      Left = 161
      Top = 1
      Action = actAdd
      Caption = #28155#21152
    end
    object btnEdit: TRzToolButton
      Left = 221
      Top = 1
      Action = actEdit
      Caption = #32534#36753
    end
    object btnDel: TRzToolButton
      Left = 281
      Top = 1
      Action = actDel
    end
    object btnInqu: TRzToolButton
      Left = 341
      Top = 1
      Action = actInqu
      Caption = #26597#35810
    end
    object Spacer2: TRzSpacer
      Left = 401
      Top = 1
      Grooved = True
    end
    object btnChart: TRzToolButton
      Left = 409
      Top = 1
      AllowAllUp = True
      GroupIndex = 2
      Action = actChart
      Caption = #22270#34920
    end
    object btnPrint: TRzToolButton
      Left = 469
      Top = 1
      Width = 74
      DropDownMenu = pmPrint
      ImageIndex = 12
      ToolStyle = tsDropDown
      Caption = #25171#21360
    end
    object Spacer3: TRzSpacer
      Left = 603
      Top = 1
      Grooved = True
    end
    object btnView: TRzToolButton
      Left = 611
      Top = 1
      Width = 74
      DropDownMenu = pmView
      ImageIndex = 36
      ToolStyle = tsDropDown
      Caption = #35270#22270
    end
    object btnExport: TRzToolButton
      Left = 543
      Top = 1
      Action = actExport
      Caption = #23548#20986
    end
    object btnBack: TRzToolButton
      Left = 685
      Top = 1
      Action = actBackImage
    end
  end
  object pcMain: TRzPageControl
    Left = 0
    Top = 27
    Width = 859
    Height = 528
    ActivePage = tsData
    Align = alClient
    UseColoredTabs = True
    ShowCardFrame = False
    ShowShadow = False
    TabOrder = 2
    ExplicitHeight = 508
    FixedDimension = 0
    object tsData: TRzTabSheet
      TabVisible = False
      Caption = 'tsData'
      ExplicitWidth = 0
      ExplicitHeight = 508
      object spPer: TSplitter
        Left = 155
        Top = 22
        Width = 2
        Height = 506
        OnCanResize = spPerCanResize
        ExplicitHeight = 470
      end
      object pnlTool: TPanel
        Left = 0
        Top = 0
        Width = 859
        Height = 22
        Align = alTop
        TabOrder = 0
        object lblSrh: TLabel
          Left = 156
          Top = 5
          Width = 60
          Height = 12
          Caption = #24555#36895#26597#25214#65306
        end
        object lblSort: TLabel
          Left = 8
          Top = 5
          Width = 60
          Height = 12
          Caption = #27983#35272#20998#31867#65306
        end
        object lblTips: TLabel
          Left = 352
          Top = 5
          Width = 288
          Height = 12
          Caption = #25552#31034#65306#24744#21487#20197#22312#36825#37324#36755#20837#24037#21495#12289#22995#21517#12289#25340#38899#31561#36827#34892#26597#35810
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object cbState: TComboBox
          Left = 70
          Top = 1
          Width = 75
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          ItemIndex = 1
          TabOrder = 0
          Text = #22312#32844#21592#24037
          OnChange = cbStateChange
          Items.Strings = (
            #20840#37096
            #22312#32844#21592#24037
            #31163#32844#21592#24037)
        end
        object edtSrh: TEdit
          Left = 218
          Top = 1
          Width = 121
          Height = 20
          TabOrder = 1
          OnChange = edtSrhChange
        end
      end
      object pnlLeft: TPanel
        Left = 0
        Top = 22
        Width = 155
        Height = 506
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitHeight = 486
        object tvPer: TTreeView
          Left = 0
          Top = 0
          Width = 155
          Height = 390
          Align = alClient
          HideSelection = False
          HotTrack = True
          Images = dmPer.ilTree
          Indent = 19
          PopupMenu = pmTree
          ReadOnly = True
          ShowRoot = False
          TabOrder = 0
          OnChange = tvPerChange
          OnGetImageIndex = tvPerGetImageIndex
          OnGetSelectedIndex = tvPerGetSelectedIndex
          OnMouseDown = tvPerMouseDown
          Items.NodeData = {
            0101000000210000000000000000000000FFFFFFFFFFFFFFFF000000000A0000
            00046C51F8530D54F0791D0000000100000001000000FFFFFFFFFFFFFFFF0000
            00000000000002E890E8951D0000000100000001000000FFFFFFFFFFFFFFFF00
            00000000000000024C80A1521D0000000100000001000000FFFFFFFFFFFFFFFF
            000000000000000002E55DCD791D0000000100000001000000FFFFFFFFFFFFFF
            FF0000000000000000024C80F0791D0000000100000001000000FFFFFFFFFFFF
            FFFF00000000020000000227602B521B0000000400000004000000FFFFFFFFFF
            FFFFFF00000000000000000137751B0000000500000005000000FFFFFFFFFFFF
            FFFF00000000000000000173591D0000000100000001000000FFFFFFFFFFFFFF
            FF000000000000000002116CCF65210000000100000001000000FFFFFFFFFFFF
            FFFF0000000000000000045A5AFB59B672B551210000000100000001000000FF
            FFFFFFFFFFFFFF0000000000000000043F65BB6C62978C8C1D00000001000000
            01000000FFFFFFFFFFFFFFFF000000000000000002665B86531D000000010000
            0001000000FFFFFFFFFFFFFFFF000000000000000002134E1A4E}
          ExplicitHeight = 370
        end
        object pnlPhoto: TPanel
          Left = 0
          Top = 390
          Width = 155
          Height = 116
          Align = alBottom
          BevelOuter = bvSpace
          TabOrder = 1
          ExplicitTop = 370
          object imgPhoto: TImage
            Left = 1
            Top = 1
            Width = 153
            Height = 114
            Align = alClient
            Center = True
            Picture.Data = {
              07544269746D6170E6130000424DE61300000000000036000000280000002E00
              0000240000000100180000000000B01300000000000000000000000000000000
              0000D8AA9ED6A89DD6A59CD4A59AD4A39AD5A49AD3A29AD3A39BD4A199D2A299
              D2A098D3A198D19F98D1A099D29E97D09F97D09D97D19D97CF9C97CF9C98CF9B
              96D09B96CE9A96CE9A97CC9997CC9996CC9896CD9896CB9896CB9796CC9797CA
              9695CA9695CB9595C99595C99495C99495C99496C99496C99496C99496C99496
              C99496CA9496CB9697CC99990000D7AA9CF1DACDFBEEE0FAEEDFFAEDE1FAEDE0
              FAEDE0FAEDE0FAEDE0FAEDE2FAEDE1FAEEE1FAECE1FBECE1F9ECE1F9EDE2F9ED
              E0F9EDE0F9EDE0F9EDE0F9EDE1F9EDDFF9EDDFFAECE0FAECDEFAECDDFAEBDEFA
              EBDCFAEBDDFAEADBFAEADAFAE9D8FAE9D9F9E9D8F9E8D6F9E8D5F9E8D4F9E7D5
              F9E7D3F9E6D2F9E6D1F9E6D0F9E6CFF9E6CFF4DCC7CB96970000D8A89CF3E1D3
              FFF8EBFFF7E9FFF7E9FFF7EAFFF7EAFFF7EAFFF7EBFFF7EBFFF7EBFFF7EBFFF7
              EBFFF7EBFFF7EBFFF7EBFFF7EBFFF7EBFFF7EBFFF7EAFFF7EAFFF7EAFFF7E9FF
              F7E9FFF6E8FFF6E8FFF6E7FFF5E6FFF5E6FFF5E5FFF4E4FFF4E3FFF4E2FFF3E1
              FFF3E0FFF3DFFFF2DEFFF2DDFFF1DCFFF1DBFFF1DAFFF0D9FFF0D8FFF0D8F9E4
              CDC994960000D8A99CF4E0D3FFF8EBFFF6E9FFF7EBFFF9EDFFF9EDFFFBEEFFFA
              EEFFFAEEFFFAEEFFFAEEFFFAEEFFFAEEFFFAEDFFFAEDFFFAEDFFFAEDFFFAEEFF
              FAECFFF9ECFFF9EDFFF9EBFFF9ECFFF9EAFFF9EAFFF7E8FFF7E9FFF8E7FFF6E6
              FFF6E5FFF7E4FFF5E3FFF5E4FFF5E2FFF3E1FFF4DFFFF2DEFFF3DDFFF1DCFFF1
              DBFFF1D9FFEFD8FFF0D8F9E5CEC994960000D9AA9CF4E1D4FFF7ECFFF6EAF9F1
              E6D3CCC9DBCECFDDCFD1DDCFD2DFD0D2DED0D3E0D1D5E0D1D5E1D2D6E1D2D6E2
              D3D7E2D3D7E4D5D7E3D4D9E5D6D9E5D6DBE7D7DBE6D7DBE8D8DCE9D8DDE9DADD
              EAD9DFEADBDFECDBDFEBDBDFEDDDE0EDDDE0EEDEE0EEE0E0EFE0E0F0E2E0F0E3
              E0F1E3E1F1E4E1F1E4DFE9DFD9FCEDDBFFEFD9FFF0D9F9E5CFC994960000D9AA
              9CF4E3D5FFF9EDFFF8EBFFFAF1719F7E20B34022B44222B24123B34021B13F22
              B23E20B03B1FAF3B1EAE381CAD361BAB341AAA3119A92F18A82D17A72B16A629
              15A52615A42413A32212A22011A11C10A01B0FA1190E9F160C9B130B930D098A
              0B088409087D0909770A0D740E0E710F0F7010106F11729E76FDEFDFFFF1DAFF
              F0D9F9E5D0C994960000DAAC9DF4E2D6FFF8EEFFF7ECFFFCF372A47E1CBE4222
              BB4622BC4621BA4421BB4320B9411FB93F1DB63C1CB53A1BB53718B23418B232
              15AF2F14AE2C14AE2911AB2710AA2410AA210EA81E0DA91C0AA41705970D028B
              05008101007900007700007500007300007200007000006E00006C00006B0000
              6400679A6AFFEEE1FFF1DBFFF1DAF9E6D2C994960000DAAD9DF4E4D8FFF8EFFF
              F9EDFFFBF473A37F20C04824BD4A24BD4923BC4822BB4621BA4420B9421FB83F
              1DB63D1CB53A1AB33719B23417B03116AF2E15AE2B13AD2913AD2611AB240B9D
              15038D07008100007F00007F00007D00007B0000790000770000750000730000
              7100006F00006D00006C00006800689C6BFFF0E2FFF2DDFFF1DBF9E6D1C99596
              0000DAAD9DF4E3D7FFFAF0FFF8EEFFFBF573A38020C04B26BF4E26BF4D25BE4B
              24BD4923BC4722BB4520B9421FB83F1DB63C1CB5391AB33618B13317B03116AF
              2F15AF2C0A9B15018901008400008300008200008000007F00007E00007C0000
              7A00007800007600007400007200007000006F00006E00006A00689C6BFFEFE3
              FFF2DCFFF1DCF9E6D2CB95960000DBAE9DF5E3D8FFF9F1FFFAF1FFFBF673A481
              23C24F28C15227C05027C04F26BF4D24BD4A23BC4721BA4520B9421EB73E1DB6
              3B1BB43819B3351AB43510A521018C0300870000870000850000840000820000
              8100007F00007E00007C00007B00007900007700007500007300007200007100
              007000006C00699D6AFFEFE3FFF2DDFFF2DDF9E7D4CA96960000DBAF9FF5E5D9
              FFFBF2FFF9F1FFFCF672A48125C5532AC35529C25428C15227C05026BF4D24BD
              4A23BC4721BA441FB8401EB83E1DB63A1AB438089A11008B00008A00008A0000
              8800008700008500008300008100008000007F00007D00007C00007A00007800
              007600007500007400007200007100006E00679E6AFFEFE4FFF3DEFFF2DEF9E6
              D3CC97970000DEAF9FF5E4DBFFFAF3FFF9F2FFFCF774A48227C7572CC5592BC4
              572AC35528C15227C04F25BE4C24BD4922BB4520B9431FB84118B13302920500
              8E00008C00008D00008B00007D00006E0006710F19804E20896C208F6C138C3E
              007D00007D00007B00007900007800007700007500007400007300007000679E
              6AFFF1E5FFF3DFFFF2DEF8E6D4CB99970000DDB09FF5E5DAFFFAF4FFFBF3FFFC
              F873A38329C95C2EC75C2DC65A2BC4582AC35528C15126BF4E25BE4C24BD4824
              BF4813AB26009200009100009100008B000077000064001B7F623EA3DC4EB3FF
              4DB3FF4CB1FF4DB1FF4DB1FF3BA5D5078213007C00007B000079000078000077
              00007600007500007200679E69FFF0E5FFF3E1FFF3DFF8E8D6CD98970000DFB1
              9FF5E7DBFFFCF5FFFAF4FFFEFA75A5842BCB5F2FC8612EC75D2CC55A2BC45729
              C25328C14F26C14E24BE490B7F14006D00007A00007700006C00005F00157A56
              3CA2F244AAFF41A7FF40A6FF40A6FF40A6FF40A6FF41A6FF42A7FF42A8FF0B85
              29007B00007B00007A00007900007800007800007400689F69FFF0E7FFF2E0FF
              F3E0FAE9D5CD99960000DEB1A0F5E6DDFFFBF6FFFAF5FFFDFB74A4832ECE6432
              CB622FC85F2DC65D2BC4592AC3552AC6551BA938006600005E00005F00005E00
              016501468A4957A4D739A1FF399FFF389EFF389EFF389EFF389EFF389EFF389E
              FF389EFF389EFF399FFF3B9FFF0B842E007D00007C00007B00007A00007A0000
              760066A169FFF0E6FFF4E2FFF3E0FAE8D7CE9A980000E0B4A0F6E8DCFFFDF7FF
              FCF6FFFFFC75A5832FCF6531CA652FC9612EC85E2FCB5D24BD4D017E0E0C670A
              5D966595B5A3B6C5C8C1CCD6CCD1E3CED3E183B5EC2C96FF3197FF3197FF3197
              FF3197FF3197FF3197FF3197FF3197FF3197FF3197FF3298FF3399FF08842900
              7E00007D00007C00007C0000780066A068FFF0E6FFF4E1FFF3E1F9E8D6CE9C97
              0000DFB59FF6E7DDFFFCF8FFFBF8FFFFFD74A58331D46835D16A31CD6321AF45
              0583160F6B0E8AAA90D3D3E0CED1DBCACFD7C8CDD5C6CDD3C4CCD4C6CDD3B5C5
              D91F8CFF2A90FF2A90FF2A90FF2A90FF2A90FF2A90FF2A90FF2A90FF2A90FF2A
              90FF2A90FF2B91FF2B90FF088335007D00007E00007E00007B0066A168FFF0E8
              FFF4E2FFF4E2F9E8D8D09B970000E1B49FF6E7DFFFFCFAFFFDF7FFFFFF688567
              006300006902005C00005E00729E73D8D1DAD1CFD4CACDCFC9CCCEC9CCCEC8CC
              CFC8CCCFC8CCCFC9CCCFD1CFCF4C9AF41E87FF2288FF2288FF2288FF2288FF22
              88FF2288FF2288FF2288FF2288FF2288FF2288FF2288FF248AFF62A66B007F00
              007B000078005F9F62FDF0E6FFF4E4FFF4E2F9EAD7CF9C990000E0B5A1F6E8DE
              FFFEF9FFFCF8FFFFFF638564005B000D6C0C61965DCCCBC8D7D1D2CECDCACDCC
              CBCDCCCACCCCCACCCCCBCCCCCBCCCCCBCBCCCCCBCCCCCECDCCC4C8CF1981FF1A
              82FF1C82FF1C82FF1C82FF1C82FF1C82FF1C82FF1C82FF1C82FF1C82FF1C82FF
              0F7DFF89B1E4D5D2D9CDCFD9A1BEAAA3BFADC4C5CCF8EEE1FFF5E3FFF4E3F9E9
              D9D19D980000E0B7A0F6E8E0FFFDFAFFFCF9FFFFFFA2A19ED3CCC3E0D2D1DBD1
              CED5CDC8D2CDC6D4CEC8D4CFC8D1CDC7D0CCC8D0CCC7CFCCC7CFCCC8CFCCC8CE
              CCC8CECCC9D4CFC9AABBD50F78FF0F79FF147AFF147AFF147AFF147AFF147AFF
              147AFF147AFF137AFF0674FF68A0E8D5D0CBCBCCCECACDCFCCCDD1CCCED2C3C5
              C7F7EDE1FFF5E3FFF4E3F9E9D8D09F980000E2B6A0F6E9DFFFFDFCFFFCFBFFFF
              FEA8A3A1DACFC3D7CDC2D7CDC2D8CFC4DCD2C8B4ADA6BCB5ADAEA7A1D7CEC4D3
              CCC3D3CCC5D4CDC5D2CCC4D2CCC6D3CCC6D2CDC6D8CFC6C2C4CB3384F3006BFF
              056FFF0971FF0B72FF0A71FF0770FF016DFF0F74FE91B0DBD9D0C7CECDCACDCC
              CACCCCCACCCCCBCCCCCCC4C5C5F7EFE0FFF5E5FFF4E3F9E9D8D29E980000E1B7
              A0F7E9E1FFFDFBFFFEFAFFFFFFA6A29EDDCFBFDBCDBEC6B8ADBBB0A567625E71
              6A64A0978EDDD0C3DCD0C2DACFC3DDD2C5CFC6BADDD1C6DFD5C8DACFC5C7BEB5
              D6CDC3D7CDC2E1D2C0ABB8D05993E6277BF41674FA1D77F84388ED86A8DAD6CE
              C5D8CFC4D2CDC6D1CCC6D0CCC6D0CCC7D0CCC7CFCCC7C5C3C4F7EDE0FFF5E4FF
              F4E4F9E9DAD19F9A0000E3BAA0F7EAE0FFFFFDFFFDFCFFFFFFA7A39DE2CFBADD
              CCBBDDCCBBAFA396CDBDADE5D4C3E1D1C0CCBEAF968C83C5B7AAA99D932B2B2A
              323130726B666D6961D9CCBFD8CCBED8CCBFD9CDBFDCCFBFE0D1BFE4D2BDE5D3
              BDE4D3BFE1D1C0DBCFC0D6CDC2D5CCC2D5CCC2D4CCC2D4CCC3D4CCC3D3CCC3D4
              CCC4C6C3C2F7EDE0FFF5E4FFF5E4F9EBD9D3A0990000E2B9A0F7E9E2FFFEFCFF
              FDFBFFFFFFA8A19DE5CFB8E1CCB6E1CDB7E3CFBAE1CDB8E1CCB7DFCCB9E2CFBB
              CCBBA9766C647B7369D0BFAEE5D3C1D3C3B1E2D1BFDDCDBBDCCCBBDCCCBBDBCC
              BBDBCCBCDBCCBCDACCBCDACCBDDACCBDD9CCBDD9CCBED9CCBED9CCBED8CCBFD8
              CCBFD7CCBFD7CCBFD7CCC0D8CCC0C8C4C0F5EDE1FFF5E6FFF5E4F9EAD9D2A299
              0000E5BAA2F7E9E2FFFEFEFFFDFDFFFFFFA9A19AEACFB3E4CCB2E4CCB3E4CCB3
              E3CCB3E3CCB4E4CDB5EBD2BAECD5BDEDD6BEEFD7BFDEC9B3BEAD9BE4CFB8E0CC
              B6E0CCB7E0CCB7DFCCB7DFCCB8DFCCB8DECCB8DECCB9DECCB9DDCCB9DDCCBADD
              CCBADCCCBADCCCBBDCCCBBDCCCBBDBCCBCDBCCBCDBCCBCDBCCBDC9C2BEF5EDE3
              FFF5E6FFF5E4FBEAD9D4A1990000E4BCA1F7EBE1FFFEFDFFFFFCFFFFFFAAA29A
              ECCFAFE9CBB0EBCEB1E8CDB0E7CDB1EACFB2F7D9BC635A52796D62C4AE98AF9D
              89534C46EACFB6E4CCB2E4CCB3E4CCB3E3CCB3E3CCB4E3CCB4E2CCB4E2CCB5E2
              CCB5E1CCB5E1CCB6E1CCB6E0CCB6E0CCB7E0CCB7E0CCB7DFCCB8DFCCB8DFCCB8
              DECCB8DFCCB9CBC2BCF5EDE2FFF5E5FFF5E5FAEADBD3A39B0000E6BBA1F7EAE3
              FFFEFDFFFEFCFFFFFFA9A098F1CFACEDCCACAF9983E9C9AAFAD8B6E7C9AA685E
              531B1C1D61574E4D47406F6358E2C6A9EBCEB1E8CCAFE8CCAFE7CCAFE7CCB0E7
              CCB0E6CCB0E6CCB1E6CCB1E5CCB1E5CCB2E5CCB2E4CCB2E4CCB3E4CCB3E3CCB3
              E3CCB4E3CCB4E3CCB4E2CCB5E2CCB5E4CCB5CCC2BAF5EDE3FFF5E5FFF5E5FAEC
              DAD5A49A0000E5BCA1F8EAE3FFFEFDFFFEFCFFFFFFAAA097F5CFA8F1CDA8EBC7
              A56F6053312D2B19191B5F554AE3C4A3FAD7B3F8D5B2F6D3B0EECEACECCCABEC
              CCABEBCCACEBCCACEBCCACEACCACEACCADEACCADE9CCADE9CCAEE9CCAEE8CCAE
              E8CCAFE8CCAFE8CCAFE7CCB0E7CCB0E7CCB0E6CCB1E6CCB1E6CCB1E6CDB2CCC3
              B8F4EDE3FFF5E5FFF5E5FAEBDAD4A69A0000E7BEA3F8EAE3FFFEFDFFFEFCFFFF
              FFABA195F9CFA3F3CCA5F5CEA5FCD3AAFFD6ADFFD7ADFDD5ACF4CFA8F1CCA6F1
              CCA6F0CCA7F0CCA7F0CCA7EFCCA8EFCCA8EFCCA8EECCA9EECCA9EECCA9EDCCA9
              EDCCAAEDCCAAEDCCAAECCCABECCCABECCCABEBCCACEBCCACEBCCACEACCADEACC
              ADEACCADE9CCAEEBCDAECFC1B6F4EDE2FFF5E5FFF5E5FAEBDAD6A59C0000E6BD
              A2F8ECE2FFFEFDFFFFFCFFFFFFAC9F94FDCFA1F8CCA0F8CCA0F7CCA1F7CCA1F7
              CCA1F6CCA2F6CCA2F6CCA2F4CCA3F5CCA3F5CCA3F3CCA4F3CCA4F4CCA4F2CCA5
              F2CCA5F3CCA5F1CCA5F1CCA6F2CCA6F0CCA6F0CCA7F0CCA7F1CCA7EFCCA8EFCC
              A8F0CCA8EECCA9EECCA9EFCCA9EDCCAAEDCCAAF0CDAAD0C1B4F4EDE2FFF5E6FF
              F5E5FAEBDAD5A69B0000E8BEA2F8EBE3FFFEFDFFFDFCFFFFFFAA9E91FCCA9BF7
              C99CF5C89BF5C89BF5C89DF5C89CF6C89CF4C89EF4C89DF4C89DF4C89EF3C89E
              F3C89FF3C99FF3C99EF3C9A0F2C99FF2C99FF2C9A1F2C9A1F2C9A2F1C9A2F1C9
              A2F1C9A3F0C9A3F1CAA3EFCAA5EFCAA4EFCAA6EFCAA5F0CAA5EECAA7EECAA6F0
              CAA5CEC0B1F4EDE2FFF5E6FFF5E4FAEADAD7A79B0000E8C1A2F7EBE1FFFEFEFF
              FDFDFFFFFFB4B5B6B5B8BCB5B9BDB7BABEB6BABEB7BBBFB9BCC0B8BCC0BABDC1
              BCBFC2BBBEC2BDC0C3BEC2C5BEC1C4BFC2C5C0C4C7C0C3C6C1C5C7C3C5C7C2C5
              C8C3C6C8C5C6C8C4C7C8C6C7C9C8C8C9C7C8C9C9C9C9CACBCACACACACBCCCACC
              CCCBCCCECBCDCDCBCECFCDD0CFCCCFCECBF8EFE2FFF4E5FFF5E4FAEADAD6A99B
              0000E8C1A5F9EBE1FFFFFCFFFDFBFFFEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFDFFFFFCFFFFF9FFFFF8FFFDF7FFFEF6FF
              FCF5FFFCF4FFFDF3FFFBF1FFFCF0FFFAEFFFFAEEFFF9EDFFF9ECFFF8E9FFF6E7
              FFF4E5FFF5E4FAEADBD8A89D0000E9C2A5F9ECE2FFFFFDFFFEFCFFFEFDFFFFFE
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFDFFFEFCFFFEFBFFFDFAFFFDF9FFFDF8FF
              FCF7FFFCF6FFFBF5FFFBF4FFFAF3FFFAF1FFF9F0FFF9EFFFF9EEFFF8EDFFF8EC
              FFF7EBFFF7E9FFF6E8FFF6E7FFF5E5FFF5E5FAECDAD8A99D0000E9C4A5F7E7DB
              FCF7F2FCF6F2FCF6F1FCF7F3FCF7F4FCF7F5FCF7F5FCF7F5FCF7F5FCF7F5FBF7
              F5FBF7F5FBF7F5FBF7F5FBF7F5FBF8F5FBF6F5FBF6F4FBF7F3FBF5F3FBF5F2FB
              F6F1FBF4F0FBF5EFFBF3EEFBF3ECFCF4EBFAF2EAFAF3E9FAF1E8FAF2E9FAF0E7
              FAF1E6FAEFE5FAF0E4FAEEE3FAEFE2FAEDE1FAEEE0FBECDDFBEDDCFCEDDDF7E4
              D2D9AB9D0000EBC5A8EAC4A6E8C2A4E8C1A3E9C0A3E7C0A2E7BFA2E8BFA2E6BE
              A2E6BEA2E7BDA2E5BDA1E5BCA1E6BCA1E4BBA1E4BBA1E5BAA1E3BAA0E3B9A0E4
              B9A0E2B8A0E2B6A0E1B69FE1B79FE1B59FE0B69FE0B49FE0B5A0DFB39EDFB49E
              DFB29EDEB19EDEB29EDEB09FDDB19DDDAF9EDDB09EDCAE9EDCAF9EDCAD9FDBAE
              9DDBAC9DDAAD9EDAAC9EDAAD9FDBAFA10000}
            Proportional = True
            Stretch = True
            OnDblClick = imgPhotoDblClick
          end
        end
      end
      object pnlChart: TPanel
        Left = 157
        Top = 22
        Width = 702
        Height = 506
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 2
        ExplicitHeight = 486
        object pnlTop: TPanel
          Left = 0
          Top = 0
          Width = 702
          Height = 22
          Align = alTop
          TabOrder = 0
          object Label1: TLabel
            Left = 23
            Top = 5
            Width = 36
            Height = 12
            Caption = #26679#24335#65306
          end
          object btnExportBmp: TRzToolButton
            Left = 372
            Top = 0
            Width = 76
            Height = 21
            ImageIndex = 9
            ShowCaption = True
            UseToolbarShowCaption = False
            Caption = #23548#20986#22270#29255'...'
            OnClick = btnExportBmpClick
          end
          object rbPie: TRadioButton
            Left = 63
            Top = 2
            Width = 65
            Height = 17
            Caption = #39292#29366#22270
            Checked = True
            TabOrder = 0
            TabStop = True
            OnClick = rbPieClick
          end
          object rbBar: TRadioButton
            Left = 135
            Top = 2
            Width = 65
            Height = 17
            Caption = #26609#29366#22270
            TabOrder = 1
            OnClick = rbBarClick
          end
          object rbLine: TRadioButton
            Left = 207
            Top = 2
            Width = 65
            Height = 17
            Caption = #25240#32447#22270
            TabOrder = 2
            OnClick = rbLineClick
          end
          object cb3D: TCheckBox
            Left = 303
            Top = 2
            Width = 65
            Height = 17
            Caption = '3D'#26174#31034
            Checked = True
            State = cbChecked
            TabOrder = 3
            OnClick = cb3DClick
          end
        end
        object chtStaff: TChart
          Left = 0
          Top = 22
          Width = 702
          Height = 484
          AllowPanning = pmNone
          BackWall.Brush.Color = clWhite
          BackWall.Brush.Style = bsClear
          BackWall.Pen.Visible = False
          LeftWall.Brush.Color = clWhite
          Title.Text.Strings = (
            #32479#35745#20449#24687)
          AxisVisible = False
          ClipPoints = False
          Frame.Visible = False
          ScaleLastPage = False
          View3DOptions.Elevation = 315
          View3DOptions.Orthogonal = False
          View3DOptions.Perspective = 0
          View3DOptions.Rotation = 360
          View3DWalls = False
          Zoom.Allow = False
          Align = alClient
          Color = clWindow
          TabOrder = 1
          ExplicitHeight = 464
          object Series1: TPieSeries
            Marks.Callout.Brush.Color = clBlack
            Marks.Style = smsLabelPercent
            Marks.Visible = True
            Circled = True
            Gradient.Direction = gdRadial
            OtherSlice.Legend.Visible = False
            OtherSlice.Text = 'Other'
            PieValues.Name = 'Pie'
            PieValues.Order = loNone
          end
        end
      end
      object dgStaff: TDBGridEh
        Left = 157
        Top = 22
        Width = 702
        Height = 506
        Align = alClient
        ColumnDefValues.Title.TitleButton = True
        DataSource = dmPer.dsStaff
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = ANSI_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -12
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        PopupMenu = pmGrid
        ReadOnly = True
        TabOrder = 3
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        OnDblClick = dgStaffDblClick
        OnDrawColumnCell = dgStaffDrawColumnCell
        OnKeyDown = dgStaffKeyDown
        OnTitleBtnClick = dgStaffTitleBtnClick
        Columns = <
          item
            EditButtons = <>
            FieldName = 'no'
            Footers = <>
            Title.Caption = #24207#21495
            Width = 32
          end
          item
            EditButtons = <>
            FieldName = 'staffNo'
            Footers = <>
            Title.Caption = #24037#21495
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'staffName'
            Footers = <>
            Title.Caption = #22995#21517
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'sex'
            Footers = <>
            Title.Caption = #24615#21035
            Width = 36
          end
          item
            EditButtons = <>
            FieldName = 'birth'
            Footers = <>
            Title.Caption = #20986#29983#26085#26399
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'age'
            Footers = <>
            Title.Caption = #24180#40836
            Width = 36
          end
          item
            EditButtons = <>
            FieldName = 'folk'
            Footers = <>
            Title.Caption = #27665#26063
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'marriage'
            Footers = <>
            Title.Caption = #23130#23035#29366#20917
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'politics'
            Footers = <>
            Title.Caption = #25919#27835#38754#35980
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'inPartyDate'
            Footers = <>
            Title.Caption = #20837#32452#32455#26085#26399
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'idCardNo'
            Footers = <>
            Title.Caption = #36523#20221#35777#21495
            Width = 125
          end
          item
            EditButtons = <>
            FieldName = 'inWorkDate'
            Footers = <>
            Title.Caption = #21442#21152#24037#20316#26102#38388
            Width = 76
          end
          item
            EditButtons = <>
            FieldName = 'culture'
            Footers = <>
            Title.Caption = #23398#21382
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'school'
            Footers = <>
            Title.Caption = #27605#19994#38498#26657
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'special'
            Footers = <>
            Title.Caption = #19987#19994
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'graduateDate'
            Footers = <>
            Title.Caption = #27605#19994#26085#26399
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'nativePlace'
            Footers = <>
            Title.Caption = #31821#36143
            Width = 125
          end
          item
            EditButtons = <>
            FieldName = 'npAddr'
            Footers = <>
            Title.Caption = #25143#31821#22320#22336
            Width = 125
          end
          item
            EditButtons = <>
            FieldName = 'recordNo'
            Footers = <>
            Title.Caption = #26723#26696#32534#21495
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'regDate'
            Footers = <>
            Title.Caption = #30331#35760#26085#26399
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'reger'
            Footers = <>
            Title.Caption = #30331#35760#20154
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'deptName'
            Footers = <>
            Title.Caption = #37096#38376
            Width = 125
          end
          item
            EditButtons = <>
            FieldName = 'duty'
            Footers = <>
            Title.Caption = #32844#21153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'workKind'
            Footers = <>
            Title.Caption = #24037#31181
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'technic'
            Footers = <>
            Title.Caption = #32844#31216
            Width = 60
          end
          item
            Alignment = taLeftJustify
            EditButtons = <>
            FieldName = 'workState'
            Footers = <>
            Title.Caption = #20219#32844#29366#24577
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'inDutyDate'
            Footers = <>
            Title.Caption = #20837#32844#26085#26399
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'toStaffDate'
            Footers = <>
            Title.Caption = #36716#27491#26085#26399
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'leftDate'
            Footers = <>
            Title.Caption = #31163#32844#26085#26399
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'bankName'
            Footers = <>
            Title.Caption = #21457#21345#38134#34892
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'payNo'
            Footers = <>
            Title.Caption = #24037#36164#36134#21495
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'annuityNo'
            Footers = <>
            Title.Caption = #20859#32769#20445#38505#24080#21495
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'medicareNo'
            Footers = <>
            Title.Caption = #21307#30103#20445#38505#24080#21495
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'mobile'
            Footers = <>
            Title.Caption = #25163#26426
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'tel'
            Footers = <>
            Title.Caption = #30005#35805
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'email'
            Footers = <>
            Title.Caption = 'E-Mail'
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'cityTel'
            Footers = <>
            Title.Caption = #23567#28789#36890
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'postAddr'
            Footers = <>
            Title.Caption = #36890#20449#22320#22336
            Width = 200
          end
          item
            EditButtons = <>
            FieldName = 'postCode'
            Footers = <>
            Title.Caption = #37038#32534
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'qqCode'
            Footers = <>
            Title.Caption = 'QQ'#21495
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'selfBio'
            Footers = <>
            Title.Caption = #20010#20154#31616#21382
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'family'
            Footers = <>
            Title.Caption = #23478#24237#25104#21592'&'#31038#20250#20851#31995
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'workExper'
            Footers = <>
            Title.Caption = #24037#20316#32463#21382
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'others'
            Footers = <>
            Title.Caption = #20854#23427#20449#24687
            Visible = False
          end>
      end
    end
    object tsImage: TRzTabSheet
      Color = clBlack
      TabVisible = False
      Caption = 'tsImage'
      ExplicitWidth = 0
      ExplicitHeight = 508
      object imgMain: TImage
        Left = 0
        Top = 0
        Width = 859
        Height = 528
        Align = alClient
        OnDblClick = imgMainDblClick
        ExplicitWidth = 784
        ExplicitHeight = 492
      end
    end
  end
  object mnuPer: TMainMenu
    AutoHotkeys = maManual
    Images = ilPer
    Top = 384
    object miSys: TMenuItem
      Caption = #31995#32479'(&S)'
      object miChgPwd: TMenuItem
        Action = actChgpwd
        Caption = #26356#26032#23494#30721'...'
      end
      object miAdmin: TMenuItem
        Action = actAdmin
        Caption = #31649#29702#21592'...'
      end
      object miLogin: TMenuItem
        Action = actLogin
      end
      object Space01: TMenuItem
        Caption = '-'
      end
      object miBaseData: TMenuItem
        Caption = #22522#26412#25968#25454
        Hint = #35774#32622#37096#38376#12289#20998#31867#12289#20844#21496#20449#24687
        object miDep: TMenuItem
          Action = actDept
        end
        object miSort: TMenuItem
          Action = actDict
        end
        object miCompany: TMenuItem
          Action = actCompany
        end
      end
      object miAwake: TMenuItem
        Action = actAwake
      end
      object miSet: TMenuItem
        Action = actSet
      end
      object Space02: TMenuItem
        Caption = '-'
      end
      object miExit: TMenuItem
        Action = actExit
      end
    end
    object miStaff: TMenuItem
      Caption = #26723#26696#31649#29702'(&E)'
      object miAdd: TMenuItem
        Action = actAdd
      end
      object miEdit: TMenuItem
        Action = actEdit
      end
      object miDel: TMenuItem
        Action = actDel
        ImageIndex = -2
      end
      object miInquire: TMenuItem
        Action = actInqu
      end
      object Space04: TMenuItem
        Caption = '-'
      end
      object miBatchEdit: TMenuItem
        Action = actBatchEdit
      end
      object miDulAdd: TMenuItem
        Action = actDup
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object N7: TMenuItem
        Action = actAP
      end
      object N8: TMenuItem
        Action = actTrain
      end
      object Space03: TMenuItem
        Caption = '-'
      end
      object miShow: TMenuItem
        Action = actField
        ImageIndex = -2
      end
      object miPrint: TMenuItem
        Caption = #25171#21360'(&P)'
        ImageIndex = 12
        object miPCur: TMenuItem
          Action = actPCur
        end
        object miPAll: TMenuItem
          Action = actPAll
        end
        object miPGrid: TMenuItem
          Action = actPList
        end
        object N1: TMenuItem
          Caption = '-'
        end
        object miPSet: TMenuItem
          Action = actPSet
        end
      end
    end
    object miSMove: TMenuItem
      Caption = #20154#20107#21464#21160'(&M)'
      object miLeave: TMenuItem
        Action = actLeave
      end
      object miUnLeave: TMenuItem
        Action = actUnLeave
      end
      object Space07: TMenuItem
        Caption = '-'
      end
      object miMove: TMenuItem
        Action = actMove
      end
      object miLeft: TMenuItem
        Action = actLeft
      end
      object miBack: TMenuItem
        Action = actBack
      end
      object Space05: TMenuItem
        Caption = '-'
      end
      object miMIn: TMenuItem
        Caption = #21464#21160#26597#35810
        object N9: TMenuItem
          Action = actInLeave
        end
        object Space09: TMenuItem
          Caption = '-'
        end
        object miMoveI: TMenuItem
          Action = actInMove
        end
        object miLeftI: TMenuItem
          Action = actInLeft
        end
        object miBackI: TMenuItem
          Action = actInBack
        end
      end
    end
    object miContract: TMenuItem
      Caption = #21512#21516#31649#29702'(&C)'
      object miNewC: TMenuItem
        Action = actNewC
      end
      object miCInfo: TMenuItem
        Action = actContract
      end
      object miEndC: TMenuItem
        Action = actEndC
      end
      object N15: TMenuItem
        Caption = '-'
      end
      object miImportC: TMenuItem
        Action = actImportC
      end
    end
    object miData: TMenuItem
      Caption = #25968#25454#32500#25252'(&D)'
      object miBkData: TMenuItem
        Action = actBackData
      end
      object miReData: TMenuItem
        Action = actRestore
      end
      object miCompress: TMenuItem
        Action = actCompress
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object miExport: TMenuItem
        Action = actExport
      end
      object miInport: TMenuItem
        Action = actImport
      end
      object N17: TMenuItem
        Caption = '-'
      end
      object miImportP: TMenuItem
        Action = actImportP
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object miInitData: TMenuItem
        Action = actInitData
      end
    end
    object miReport: TMenuItem
      Caption = #32479#35745#25253#34920'(&R)'
      object miNewR: TMenuItem
        Action = actNewR
      end
      object miLeftR: TMenuItem
        Action = actLeftR
      end
      object miBackR: TMenuItem
        Action = actBackR
      end
      object miMoveR: TMenuItem
        Action = actMoveR
      end
      object N16: TMenuItem
        Caption = '-'
      end
      object miChartR: TMenuItem
        Action = actChart
      end
    end
    object miTools: TMenuItem
      Caption = #36741#21161#24037#20855'(&T)'
      object miDiary: TMenuItem
        Action = actDiary
      end
      object miAddrList: TMenuItem
        Action = actAddr
      end
      object miCal: TMenuItem
        Action = actCalendar
      end
      object miCode: TMenuItem
        Action = actCode
      end
      object miCamera: TMenuItem
        Action = actCamera
      end
      object Space06: TMenuItem
        Caption = '-'
      end
      object miCalc: TMenuItem
        Action = actCalc
      end
      object miNote: TMenuItem
        Action = actNote
      end
    end
    object miHelp: TMenuItem
      Caption = #24110#21161'(&H)'
      object miContent: TMenuItem
        Action = actHelp
      end
      object miPage: TMenuItem
        Action = actPage
      end
      object miQQ: TMenuItem
        Action = actQQ
      end
      object miLog: TMenuItem
        Action = actLog
        Caption = #26085#24535'...'
      end
      object Space08: TMenuItem
        Caption = '-'
      end
      object miBuy: TMenuItem
        Action = actBuy
        Visible = False
      end
      object miReg: TMenuItem
        Action = actReg
      end
      object miAbout: TMenuItem
        Action = actAbout
        Caption = #20851#20110#26412#36719#20214'(&A)'
      end
    end
  end
  object tmrTime: TTimer
    OnTimer = tmrTimeTimer
    Left = 96
    Top = 352
  end
  object ilPer: TImageList
    Left = 32
    Top = 352
    Bitmap = {
      494C010127002C00100010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000040000000A0000000010020000000000000A0
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D004D4D4D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004D4D4D00D8E9EC00FFFF
      FF00D8E9EC004D4D4D00D8E9EC00FFFFFF00D8E9EC00FFFFFF00D8E9EC00FFFF
      FF00D8E9EC00FFFFFF004D4D4D000000000000000000B4B4B400800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004D4D4D00FFFFFF00D8E9
      EC00FFFFFF004D4D4D00FFFFFF00D8E9EC00FFFFFF00D8E9EC00FFFFFF00D8E9
      EC00FFFFFF00D8E9EC004D4D4D000000000000000000B4B4B40000190000004E
      3800004F4E00003F2300046D5E00005D470000574500005E4900004520000050
      31000E696D00005A4E0080000000000000000000000000000000000000000000
      000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D00D8E9EC00FFFFFF00D8E9EC00FFFFFF00D8E9EC00FFFF
      FF00D8E9EC00FFFFFF004D4D4D000000000000000000B4B4B400573546009584
      9400CDB3BE006F5F680075656900856C71005D3C41008E707900D7D1DD00847E
      8A004C302F004732330080000000000000000000000000000000000000000000
      000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000BF
      BF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004D4D4D00FFFFFF00D8E9
      EC00FFFFFF004D4D4D00FFFFFF00D8E9EC00FFFFFF00D8E9EC00FFFFFF00D8E9
      EC00FFFFFF00D8E9EC004D4D4D000000000000000000B4B4B400F9D2AD000703
      000000000000201517005C557000141C10001E1C120031363200675372003234
      3A0059486B003F4852008000000000000000000000005F535100B69C9700C2AA
      A700FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      000000BFBF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004D4D4D00D8E9EC00FFFF
      FF00D8E9EC004D4D4D00D8E9EC00FFFFFF00D8E9EC00FFFFFF00D8E9EC00FFFF
      FF00D8E9EC00FFFFFF004D4D4D000000000000000000B4B4B400F3C29100EDC8
      A2009EA2BE00B0B8D20033281D00170D1C0034271800AB8F6700483D57007172
      910058556D0044515300800000000000000000000000996D6800AA8E8900B59A
      9600DAC9C700CDBAB70000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF000000000000BFBF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004D4D4D00FFFFFF00D8E9
      EC00FFFFFF004D4D4D00FFFFFF00D8E9EC00FFFFFF00D8E9EC00FFFFFF00D8E9
      EC00FFFFFF00D8E9EC004D4D4D000000000000000000B4B4B400FCBA7C00FEC8
      94009888880078687A00473B5700FFFBB900FFCD9800FFCA9400FFD59D00FFF2
      AD00AA8759002C2214008000000000000000000000000000000038302E008753
      4F00B98A8900D3C3BF00FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004D4D4D00FFFFFF00D8E9
      EC00FFFFFF004D4D4D00FFFFFF00D8E9EC00FFFFFF00D8E9EC00FFFFFF00D8E9
      EC00FFFFFF00D8E9EC004D4D4D000000000000000000B4B4B400F7AB6B00F7BB
      8500FFC4870089868E00EFA86E00F7BB8700FABE8800F9BF8900F9C08A00FBC0
      8C00FCBF8B00FFC18D0080000000000000000000000000000000000000000000
      000046759C0093CBFF007EBBED005082A60000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004D4D4D00D8E9EC00FFFF
      FF00D8E9EC004D4D4D00D8E9EC00FFFFFF00D8E9EC00FFFFFF00D8E9EC00FFFF
      FF00D8E9EC00FFFFFF004D4D4D000000000000000000B4B4B400EE9D5800EEAE
      7400F0AE7600F2B07800F1AE7600F0AF7800F0B07900F0B17C00F2B27A00F2B3
      7C00F4B47D00F4B27D0080000000000000000000000000000000000000001925
      30009DD1FF0085C6FF0086C7FF0086C7FF000C4D78005082A600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D004D4D4D000000000000000000B4B4B400E38E4900E8A1
      6B00E8A06B00E8A06B00E8A26C00E8A16B00EAA36D00EBA46E00EBA56F00EBA7
      7000EDA87100EEA66F0080000000000000000000000000000000000000003656
      730092CEFF009FD4FF00ABDAFF0090CAF6005082A60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004D4D4D00FFFFFF00D8E9
      EC00FFFFFF00FFFFFF00FFFFFF00D8E9EC00FFFFFF00D8E9EC00FFFFFF00D8E9
      EC00FFFFFF00D8E9EC004D4D4D00000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000000000000000000000000000000000000B50
      7D00B0DEFF00BBE2FF00B8DBF5005082A60007436A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000000000000000000080000000FFFFFF008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000000000000000000000000000000000000962
      9400C9E9FF006896B6000C4D7800226691002975A10000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000FFFFFF008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000000000000000000000000000000000000773
      AB0014517C000B558200116393003C88B200032B3F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000A5D8D0009679A002A85B40020729A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000808000008080000080
      8000000080000000800000008000000080000000800000008000000080000080
      8000008080000080800000000000000000000000000000000000000000000000
      0000000000000000000028282800282828000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000080800000FFFF0000FF
      FF000080800000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000080800000FF
      FF0000FFFF000080800000000000000000000000000000000000000000002A2A
      2A00282828000A0A0A00BCBCBC00C2C2C2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000080
      800000FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000FFFF000080
      800000808000000000000000000000000000000000000000000044444400E8E8
      E800CACACA005C5C5C00C0C0C000B2B2B2000000000000000000000000000000
      0000000000000000000030141400000000000000000000000000000000000000
      000095761F0095761F0000000000000000000000000000000000000000009576
      1F0095761F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      00000000000000000000000000000000000000000000000000000080800000FF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000FF
      FF0000808000000000000000000000000000000000000000000008080800AAAA
      AA00AEAEAE0000000000ACACAC00B4B4B4000000000000000000000000000000
      0000241818002C00000000FFFF002C3838000000000000000000000000000000
      000095761F0095761F0000000000000000000000000000000000000000009576
      1F0095761F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000072727200C0C0
      C000A6A6A60052525200BABABA00B2B2B2000000000000000000000000000000
      00005CB8B80000FFFF00607C7C00001414000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000004040400ACAC
      AC00A4A4A40076767600E4E4E400AEAEAE000000000000000000240C0C002C54
      540000DFDF00607C7C0000404000000000000000000000000000000000000000
      00000000000095761F0095761F0095761F0095761F0095761F0095761F009576
      1F00000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000080000000800000008000000080000000800000FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF0000008000000080000000FF000000FF000000FF000000FF00C0C0C000FFFF
      FF0000000000000000000000000000000000000000000000000066666600BABA
      BA00A2A2A20068686800E4E4E400B6B6B60000000000000000005CDCDC0000FF
      FF00607878000040400000000000000000000000000000000000000000000000
      00000000000095761F0095761F0095761F0095761F0095761F0095761F009576
      1F00000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00008000000080000000800000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000000000000000000000000000000000000000000000008A8A8A00E6E6
      E6008E8E8E00F4F4F400C0B8B8005A4A4A001C0404000020200000FFFF006070
      7000004040000000000000000000000000000000000000000000000000000000
      000095761F000000000000000000000000000000000000000000000000000000
      000095761F0000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00008000000080000000800000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000000000000000FF000000
      FF000000FF0000008000000080000000800000008000000080000000FF000000
      FF000000FF0000000000000000000000000000000000000000007E7E7E00C4C4
      C400F6F6F60038181800386868003ECDCD004AC9C90014FFFF00566666000040
      4000000000000000000000000000000000000000000000000000000000000000
      000095761F0095761F0095761F0095761F0095761F0095761F0095761F009576
      1F0095761F0000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00008000000080000000800000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000080000000
      800000008000C0C0C00000FFFF0000FFFF0000FFFF00C0C0C000000080000000
      800000008000000000000000000000000000000000008C8C8C00E4E4E400CACA
      CA00562E2E001AF9F90000FFFF003AFFFF0028FFFF0074E4E4002EC6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000095761F00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000800000008000000080000000800000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000C0C0C00000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00C0C0C0000000
      0000000000000000000000000000000000007E7E7E00E4E4E400E8E8E800DECE
      CE000494940000FFFF0000B7B7000064640036AEAE0072F2F20030C0C0000000
      0000000000000000000000000000000000000000000000000000000000009576
      1F0095761F0095761F0095761F0095761F0095761F0095761F0095761F009576
      1F0095761F0095761F00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000000000C0C0C000FFFFFF0000000000FFFFFF00C0C0C000000000000000
      000000000000000000000000000000000000C8C8C800BABABA00FFFFFF002616
      16004ACACA0000FFFF005AD1D100007C7C00006C6C002AAAAA003CD4D4000000
      0000000000000000000000000000000000000000000000000000000000009576
      1F00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000FF00000080000000FF0000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000000000FFFFFF00000000008080800000000000FFFFFF00000000000000
      000000000000000000000000000000000000D4D4D400C8C8C8004C4C4C00E0D0
      D00038D8D80000727200301010008A5A5A0000CBCB0084FFFF00002E2E000000
      0000000000000000000000000000000000000000000000000000000000009576
      1F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00008000000080000000800000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000C0C0C000FFFFFF0000000000FFFFFF00C0C0C000000000000000
      00000000000000000000000000000000000000000000FFFFFF00909090002222
      22004E3636004A9A9A000E0000000020200000FFFF003C707000000000000000
      0000000000000000000000000000000000000000000095761F0095761F009576
      1F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000FF00000080000000FF0000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FDFDFD005E5E
      5E00B6B6B600322A2A00CCCCCC00DCD0D0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001A1A1A000000000018181800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000099A8AC0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080000000
      000080000000FFFF0000FF000000800000000000000000000000DD998A00DD99
      8A00DD998A00DD998A00DD998A00DD998A00DD998A00DD998A00DD998A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000099A8AC00FFFFFF00FFFFFF00D8E9
      EC008000000080000000D8E9EC00FFFFFF00FFFFFF00D8E9EC00FFFFFF00FFFF
      FF00D8E9EC00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000000000000000000080808000C0C0C00000FFFF00C0C0C0008000
      0000FFFF0000FF000000800000000000000000000000DD998A00DBE1AF00DECA
      9D00D1AF8400BE936D00A6795C00936E60008E746C00988B8700B9B8B700DD99
      8A00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      00000000000000000000000000000000000099A8AC00FFFFFF00FFFFFF00D8E9
      EC008000000080000000D8E9EC00FFFFFF00FFFFFF00D8E9EC00FFFFFF00FFFF
      FF00D8E9EC00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000080808000C0C0C00000FFFF0000FFFF00C0C0C00080000000FFFF
      0000FF00000080000000000000000000000000000000DD998A00CFFFDA00C5F6
      C900D7EAB000BFE49100C7EB9D00DCE3A300D8D49800D8B27D007E645A00DD99
      8A00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      00000000000000000000000000000000000099A8AC00D8E9EC00D8E9EC00D8E9
      EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
      EC00D8E9EC00D8E9EC00D8E9EC00000000000000000000000000000000008080
      8000C0C0C00000FFFF0000FFFF00008080000080800080000000FFFF0000FF00
      000080000000C0C0C000000000000000000000000000DD998A00C9F7D000D4ED
      C100E2B06200C99D4900D1AB5700DBBC6D00DBCE7B00C58D4400BC996F00BC99
      6F00BC996F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000099A8AC00FFFFFF00FFFFFF00D8E9
      EC00FFFFFF00FFFFFF00D8E9EC00FFFFFF00FFFFFF00D8E9EC000000FF000000
      FF00D8E9EC00FFFFFF00FFFFFF00000000008080800080808000C0C0C00000FF
      FF0000FFFF0000808000808080000000000000000000FFFFFF00FF0000008000
      0000C0C0C00080808000C0C0C0000000000000000000DD998A00D1FBDA00D7DF
      A300D8A25100BD914200BB8E4100C68D4800C58D4400CA8A4100D58A5200DBA0
      7000DDA56D008E7E680000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      00000000000000000000000000000000000099A8AC00FFFFFF00FFFFFF00D8E9
      EC00FFFFFF00FFFFFF00D8E9EC00FFFFFF00FFFFFF00D8E9EC000000FF000000
      FF00D8E9EC00FFFFFF00FFFFFF000000000080808000C0C0C00000FFFF000080
      800000808000808080008080000080800000808000000000000080808000FFFF
      FF008080800000000000808080000000000000000000DD998A00C9FAD200E1CE
      8600DCA54B00C7A04200CA9D4600CD9B4A00C58D4400C28C4000C37D4900CB8D
      6A00E8A87300A599870000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      00000000000000000000000000000000000099A8AC00D8E9EC00D8E9EC00D8E9
      EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
      EC00D8E9EC00D8E9EC00D8E9EC00000000008080800000000000000000000000
      00008080800080800000FFFF0000C0C0C000FFFF00008080000000000000C0C0
      C00000FFFF0080808000C0C0C0000000000000000000DD998A00D2F7CF00E6BF
      6B00E2AE4B00D3AA4500CFA64300D6A44A00D5A24A00CD984000D0894A00DC9E
      6B00DAA56B00BC996F0000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      00000000000000000000000000000000000099A8AC00FFFFFF00FFFFFF00D8E9
      EC000000FF000000FF00D8E9EC00FFFFFF00FFFFFF00D8E9EC00FFFFFF00FFFF
      FF00D8E9EC00FFFFFF00FFFFFF00000000000000000080808000FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFF0000C0C0C000FFFF00000000000000FF
      FF00C0C0C000C0C0C000808080000000000000000000DD998A00D1EBB200EBBB
      5800EDBB5300DAB44300DCB04400E3AF4D00DBAB4800D5A13F00DB944A00F1B2
      7100BC996F000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      00000000000000000000000000000000000099A8AC00FFFFFF00FFFFFF00D8E9
      EC000000FF000000FF00D8E9EC00FFFFFF00FFFFFF00D8E9EC00FFFFFF00FFFF
      FF00D8E9EC00FFFFFF00FFFFFF0000000000000000000000000080808000FFFF
      FF0080808000FFFFFF00FFFF0000C0C0C000FFFF0000C0C0C00080808000C0C0
      C00000FFFF00FFFFFF00C0C0C0000000000000000000DD998A00E0DF9E00F0C1
      5F00EDC45F00E2BD4C00E4BA4800EAB84C00E7B54700E1AB4000E69D4900FEC0
      7500BC996F000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000FFFF00000000000000
      00000000000000000000000000000000000099A8AC00D8E9EC00D8E9EC00D8E9
      EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
      EC00D8E9EC00D8E9EC00D8E9EC00000000000000000000000000000000008080
      8000FFFFFF0080808000FFFFFF00FFFFFF00C0C0C0008080800000000000C0C0
      C000C0C0C00080808000808080000000000000000000DD998A00E3D58500ECCC
      7500F1CC7400E2C45E00E1C15600ECC05700EEBE5000E7B44100F4AC4A00F0B8
      7000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000FFFF0000FFFF000000
      00000000000000000000000000000000000099A8AC0080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000000000000000000000000000000000000000
      000080808000FFFFFF0080808000808080008080800080808000808080000000
      00008080800000000000000000000000000000000000DD998A00EDD38400EDD8
      9000EED38600E0CC7100E4CA6B00EFC96C00EBC66000E7BC4E00FEB75300BC99
      6F00000000000000000000000000000000000000000000000000000000000000
      000000FFFF00000000000000000000000000000000000000000000FFFF000000
      00000000000000000000000000000000000099A8AC008000000099A8AC0099A8
      AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8
      AC0099A8AC0099A8AC0080000000000000000000000000000000000000000000
      00000000000080808000FFFFFF00C0C0C000FFFFFF00C0C0C000FFFFFF00C0C0
      C0000000000000000000000000000000000000000000DD998A00F2E4B800FAEE
      C300F4E6B800E8E2A100E8DC9400F3DF9800F6DD8F00F3D27D00BC996F00B6B2
      AE00000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF000000
      00000000000000000000000000000000000099A8AC0080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000000000000000000000000000000000000000
      0000000000000000000080808000FFFFFF00C0C0C000FFFFFF00C0C0C000FFFF
      FF00C0C0C00000000000000000000000000000000000DD998A0097A1A900DFCD
      BA009FB7BB00DCCBBA00A0A9A800E7CCAB00BDC0B600F4D5AA00978D76000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080008080800080808000FFFFFF00C0C0
      C000FFFFFF00C0C0C0000000000000000000000000000000000064A4B700888B
      9200699DAA008B8991006795A700968C9200729CAB00BB9A9C00658A9B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E5E5E500B97E6000B4785C00AA9C9600DDE8EE00F7FC
      FE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004D4D4D004D4D
      4D004D4D4D000000000000000000000000000000000000000000000000000000
      0000F2F2F200ACACAC008F7E8000CACACA00DEDEDE00ECECEC00F8F8F8000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F7FFFF00AE582100EACBB000E5C6AD00CF865D00A75728009E75
      6500C7D2D700EDF3F60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004D4D4D0000BF
      BF004D4D4D000000000000000000000000000000000000000000000000000000
      00008F7E8000C5C5C500C9D7E500D2DBE500D0DBE700A4BAD1006E88A3005869
      79007A7E8200B0B0B000DDDDDD00F4F4F4000000000000000000000000000000
      000000000000B4724600DEB39A00C9A9A400D2B7B100CDACA500D1A69900D595
      6F00B95F2C009B644C00B2B2B300E7F0F4000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004D4D4D0000BF
      BF004D4D4D000000000000000000000000000000000000000000000000000000
      00008F7E80007F858D007BA8D5007FABD9007DABD90076A4D4007AA4D000AAC3
      DC00E9EEF300F0F3F700B8CEE500658BB1000000000000000000000000000000
      0000BC9E8A00DB9C6D00D2B3AF00DAC1BB00EFE3E200E7D5D200DEC2BC00C99A
      9000CB9C8F00DDA58300C56F3B009D6145000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004D4D4D0000BF
      BF004D4D4D000000000000000000000000000000000000000000000000000000
      00008F7E80008F7E800086B0DB0088B1DA0088B1DB008DB2DA0080A7D00080A7
      D8007795B30079A7D6007CA8D400718CA800000000000000000000000000E0DC
      DB00D2884B00CAA09700ECDDDA00E0C9C500F1E9EA00DDC2BC00F3EBED00EFE5
      E500E0C5C000CA9F9700E2BCA600AA5528000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005F535100B69C9700C2AA
      A700D0BBB900DAC9C700D9CBC900D0BBB900000000004D4D4D0000BFBF0000BF
      BF0000BFBF004D4D4D000000000000000000000000000000000000000000F7F7
      F700CBCBCB008F7E800091B8DF0094B6DA0074A2CA000087DE006CC5F200AFCA
      E5008DB4DC008AB2DB0087B0DA007F899400000000000000000000000000C48F
      6300DCB29C00DFC5BF00E6D2CC00F2E8E900ECE0E000F1E6E500DCBFB800F0E5
      E700F0E7E900DCC2BE00E0A77D00AD7C68000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000996D6800AA8E8900B59A
      9600C2ACA800CDBAB700D5C4C200D9CBC9004D4D4D0000BFBF0000BFBF0000BF
      BF0000BFBF0000BFBF004D4D4D00000000000000000000000000000000008F7E
      8000B6B6B500819FBF0085A8CB000E8DDF000DB7F90082E4FE00E8EEF600D6E5
      F30093B8DE0093B8DE0092B9E100DEDEDE000000000000000000F9FFFF00CF8A
      4A00CCA29B00FEFDFD00DBBDB500F5EFF000EEE3E300EDE1E200E4CCC500E9DA
      D900F2EAEB00CFA69D00C8692E00D1D7DA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000038302E008753
      4F00D3C3BF00F3EFEE00FFFFFF00B98A89004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D004D4D4D00000000000000000000000000FCFCFC008F7E
      8000ADADAD00259BE60003B1F80075E2FE00BFD7ED00EDF2F800B1CCE700D8E6
      F400D7E4F300A0C0E2009FC5EB00000000000000000000000000D0B8A200DEA6
      7A00D8B9B200F3E8E500EADAD800F6F0F000F1E7E700ECDFDF00F6EFF000D8B7
      AE00EBDDDD00DCAD92009E4F2500FDFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000046759C0093CBFF007EBBED00000000004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D004D4D4D000000000000000000F7F7F700BFBFBF002C70
      950000B0FD006AE2FF00A2CAE800EEF2F800E4EDF500C7DAEE00C5D9ED00E2EB
      F500E9F0F700A4C3E3008395A500000000000000000000000000C78E5300D5AC
      9E00EFE2DF00DFC2BA00FDFDFE00F7F1F100F2EAEA00EEE4E500EDE0DD00E6D3
      D000D8BAB700DC946100B3998D00000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000001925
      30009DD1FF0085C6FF0086C7FF00628CB2004D4D4D00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF004D4D4D0000000000E4E4E4005B5B5A0062BBE30056D7
      F4007EA1B200B0C8E500E3ECF500D3E3F200D7E5F300B6CFE900D3E2F200E0EB
      F600E7EEF600BBD3EB00BABBBB000000000000000000E2E3E500E2A26100CBA0
      9A0000000000E2C8C100FEFFFF00F9F3F300F4EDED00F2EAEB00E1C7BF00F7F4
      F700CEA19400BB612400E5F0F600000000000000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000000000000000000000000000000000000000000000000000003656
      730092CEFF009FD4FF00ABDAFF0090CAF6004D4D4D00FFFFFF0080808000FFFF
      FF0080808000FFFFFF004D4D4D00000000005F89F700D2E0F900A3A3A3008E8C
      8A0085929F00B9D2EC00BFD5EB00C3D8ED00EEF3F900EAF2F900ECF2F800F1F4
      F900B5CFE900BBD8F400FEFEFE000000000000000000D2A87C00DFB39700E3CA
      C500DAC3BC00F0E3DF0000000000FAF7F700F6F1F100F8F5F600DEC1BA00E8D7
      D500DFAD8B00AA6F4B0000000000000000000000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000000000000000000000000000000000000000000000000000000B50
      7D00B0DEFF00BBE2FF00B8DBF5005082A6004D4D4D00FFFFFF0080808000FFFF
      FF0080808000FFFFFF004D4D4D0000000000000000000000000000000000D0D0
      D00095A5B700C1D7ED00C2D7EC00C4D8ED00ECF2F800E9F0F800CBDDEF00DCE8
      F500D4E3F200A6BCD000000000000000000000000000D69D5500D3ABA400E4CB
      C400CFCDCC00C9AEA80000000000FDFBFB00F9F6F700EAD8D400F5EDED00D1AE
      A900DB8C4E00C0BAB80000000000000000000000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000000000000000000000000000000000000000000000000000000962
      9400C9E9FF006896B6000C4D78004D4D4D004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D004D4D4D0000000000000000000000000000000000C0C0
      C000A1B4C600D5E9FE00D1E4F600D2E3F300D2E2F100D5E4F200D8E6F300DAE7
      F400DBE8F4009B9D9F000000000000000000D8D1C600ECB78100CD9F9600BAAD
      AA0000000000EBEBEB00DFC7BF000000000000000000DAB8AF00F1EAEA00D9A7
      8D00B0652C00F6FFFF0000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000773
      AB0014517C000B558200116393003C88B200032B3F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FEFEFE00DEDEDE00A3A4A600B8C1C800EDF9FF00E7F1
      FB00EAF4FE00F4F4F4000000000000000000DBAB7200D09F8500B2908900FDFF
      FF000000000000000000C3B1AB00FFFEFD00FFFEFD00B3A29D00E0D9DA00B87D
      4E00C6A993000000000000000000000000000000000080000000000000008000
      0000800000000000000080000000800000000000000080000000800000000000
      0000800000000000000000000000000000000000000000000000000000000000
      00000A5D8D0009679A002A85B40020729A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F5F5
      F500A1A3A600000000000000000000000000C58E4E00F2FCFF00FAFDFE000000
      0000000000000000000000000000C7ADA500E4CFC900D8DBDC00000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E2DDDD00C2A59E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000066663300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000033000033CCFF00003333000033330000330000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000080000000800000008000000080
      0000008000000080000000800000000000000000000000000000000000000000
      00000000000000000000996D6800AA8E8900B59A9600C2ACA800CDBAB700D5C4
      C200FFFFFF00B59A9600996D6800000000000000000000000000000000000000
      00000033330099FFFF0099CC9900333333000099660000CCCC00003300000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005151FF004080FF005151FF00000000004080FF000080000000800000C0C0
      C000008000000080000000800000000000000000000000000000000000000000
      000000000000000000000000000038302E0087534F00D3C3BF00F3EFEE00FFFF
      FF00D3C3BF00B98A890000000000000000000000000000000000000000000033
      000099CCFF00000000000033660000FFFF0000FFFF0000FFFF0000CCCC000000
      0000333366000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005151
      FF004080FF004080FF004080FF004080FF000000FF0000800000C0C0C0000080
      0000008000000080000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000046759C0093CBFF007EBB
      ED00000000000000000000000000000000000000000000000000003300000033
      33003366660066FFFF0099FFFF0066FFFF003399FF00000000006666FF003399
      FF006666FF000033330000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000000000000000000000000000004080
      FF0000000000000000004080FF005151FF000000FF00C0C0C000008000000080
      0000008000000000000000000000000000000000000000000000000000005151
      FF004080FF005151FF00000000004080FF00192530009DD1FF0085C6FF0086C7
      FF00628CB200000000000000000000000000000000000000000066669900CCFF
      FF00CCFFFF00CCFFFF0066CCCC0099CCCC000000FF003399FF003399FF003399
      FF003399FF006666FF0033669900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00800000000000000000000000000000000000
      0000000000004080FF000000FF000000FF000000FF0000800000008000000080
      00000080000000800000000000000000000000000000000000005151FF004080
      FF004080FF004080FF004080FF000000FF003656730092CEFF009FD4FF00ABDA
      FF0090CAF60000000000000000000000000033000000FFFFFF00CCFFFF00CCFF
      FF0099CCCC0099CCCC00CCFFCC00669999000000FF006666FF003399FF00FFFF
      FF00FFFFFF003399FF0000000000669999000000000000000000000000000000
      0000000000000000000000000000000000000000800080000000FFFFFF008080
      80008080800080808000FFFFFF008000000000000000996D6800AA8E8900B59A
      9600C2ACA800CDBAB700D5C4C200FFFFFF000080000000800000000000000000
      00000080000000800000000000000000000000000000000000004080FF000000
      0000000000004080FF005151FF000000FF000B507D00B0DEFF00BBE2FF00B8DB
      F5005082A60007436A0000000000000000000000000033333300FFFFFF00FFFF
      FF00FFFFFF0066999900CCCCFF00FFFFCC000000FF000000FF000000FF003399
      FF00FFFFFF00FFFFFF0099CCCC00000000008000000080000000800000008000
      0000800000008000000080000000000000000000800080000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080000000000000000000000038302E008753
      4F00D3C3BF00F3EFEE00FFFFFF00D3C3BF00B98A890000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004080FF000000FF000000FF000000FF0009629400C9E9FF006896B6000C4D
      7800226691002975A1000000000000000000000000000000000066663300FFFF
      FF00FFFFFF00FFFFFF0066999900CCFFFF00FFFFFF0000800000008000000080
      00000080000000800000008000000000000080000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080000000000080000000000080000000800000008000
      0000800000008000000080000000800000000000000000000000000000000000
      000046759C0093CBFF007EBBED00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000800000008000000080
      0000008000000080000000800000000000000773AB0014517C000B5582001163
      93003C88B200032B3F0000000000000000000000000000000000000000003333
      3300FFFFFF00FFFFFF00FFFFFF00CCFFCC00FFFFFF000080000000800000C0C0
      C0000080000000800000000000000000000080000000FFFFFF00808080008080
      800080808000FFFFFF0080000000000080000000000080000000000000008000
      0000000000008000000000000000800000000000000000000000000000001925
      30009DD1FF0085C6FF0086C7FF00628CB2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008000000080
      0000C0C0C000008000000080000000000000000000000A5D8D0009679A002A85
      B40020729A000000000000000000000000000000000000000000000000000000
      000066333300FFFFFF00FFFFFF00FFFFFF006699990000800000008000000080
      0000C0C0C00000800000000000000000000080000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080000000000000000000000080000000800000008000
      0000800000008000000080000000800000000000000000000000000000003656
      730092CEFF009FD4FF00ABDAFF0090CAF6000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000800000C0C0
      C000008000000080000000800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000033333300FFFFFF00336633000000000000000000008000000080
      000000800000C0C0C00000000000000000008000000080000000800000008000
      0000800000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000B50
      7D00B0DEFF00BBE2FF00B8DBF5005082A60007436A0000000000000000000000
      0000000000000000000000000000000000000000000000000000C0C0C0000080
      0000008000000080000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000066663300000000000000000000800000008000000080
      0000008000000080000000000000000000008000000000000000800000000000
      0000800000000000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000962
      9400C9E9FF006896B6000C4D7800226691002975A10000000000000000000000
      0000000000000000000000000000000000000000000000000000008000000080
      0000008000000080000000800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000800000008000000000
      0000000000000080000000800000000000008000000080000000800000008000
      0000800000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000773
      AB0014517C000B558200116393003C88B200032B3F0000000000000000000000
      0000000000000000000000000000000000000000000000800000008000000000
      0000000000000080000000800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000A5D8D0009679A002A85B40020729A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000033333300669999000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001F9020000067000000000000000000000000000000000000000000000000
      00000000000000000000000000004D4D4D000000000000000000000000000000
      0000000000000066000033CCFF00006633000033330033660000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000038302E0087534F00B59A9600C2AAA700D0BBB900DAC9
      C700B8B5BB00C2AAA700B59A960087534F000000000000000000000000000000
      0000000000000000000038302E0087534F00B59A9600C2AAA700D0BBB900DAC9
      C700B8B5BB00C2AAA700B59A960087534F000000000000000000006700000067
      0000109020001F90200000670000000000000000000000000000000000000000
      000000000000996D68004D4D4D004D4D4D000000000000000000000000000000
      00000066330099FFFF0099CC9900333333000099660000CCCC00336600000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000038302E00B69C9700B59A9600C2ACA800CDBA
      B700D5C4C200D9CBC900CDBAB700B59A96000000000000000000000000000000
      000000000000000000000000000038302E00B69C9700B59A9600C2ACA800CDBA
      B700D5C4C200D9CBC900CDBAB700B59A960000000000006700000F8810001FB0
      3F0030CF600040DF70001F902000006700000000000000000000000000004D4D
      4D00996D68004D4D4D004D4D4D004D4D4D000000000000000000000000003366
      000099CCFF00000000000033660000FFFF0000FFFF0000FFFF0000CCCC000000
      0000333366000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AA8E890087534F00D3C3BF00F3EF
      EE00FFFFFF00B98A890087534F00000000000000000000000000000000000000
      000000000000000000000000000000000000AA8E890087534F00D3C3BF00F3EF
      EE00FFFFFF00B98A890087534F0000000000000000000F88100010A72F002FB7
      4F003FD06F0050E78000209F3F00004F0000000000004D4D4D004D4D4D004D4D
      4D004D4D4D00A6A6A6004D4D4D00000000000000000000000000336600000033
      33003366660066FFFF0099FFFF0099FFFF0066FFCC0099FFFF0099FFFF0066CC
      FF00666666003366330033336600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000046759C0093CB
      FF007EBBED000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000046759C0093CB
      FF007EBBED000000000000000000000000000070000010982000006700000000
      00001F9020001F88200000670000000000004D4D4D00A6A6A600D3D3D300D3D3
      D300A6A6A6004D4D4D00A6A6A60000000000000000000000000066669900CCFF
      FF00CCFFFF00CCFFFF0000000000003300000033660000000000333366003366
      3300003333003366330000003300336633000000000000000000000000000000
      0000000000000000000000000000403FD00000000000192530009DD1FF0085C6
      FF0086C7FF00628CB2000C4D7800000000000000000000000000000000000000
      00001F90200000670000000000000000000000000000192530009DD1FF0085C6
      FF0086C7FF00628CB2000C4D78000000000010972F0000700F00000000000000
      00001F90200000000000000000004D4D4D00A6A6A600D3D3D300D3D3D300FFFF
      4D00D3D3D300A6A6A6004D4D4D000000000000000000FFFFFF00CCFFFF00CCFF
      FF0099CCCC0099CCFF0066996600333366003333330099CCCC006699990099CC
      CC00CCFFCC006699CC0000330000336699000000000000000000000000000000
      00000000000000000000403FD000403FD000000000003656730092CEFF009FD4
      FF00ABDAFF0090CAF60000000000000000000000000000000000006700000067
      0000109020001F9020000067000000000000000000003656730092CEFF009FD4
      FF00ABDAFF0090CAF60000000000000000000067000000670000000000000000
      00000000000000000000000000004D4D4D00D3D3D300D3D3D300D3D3D300D3D3
      D300D3D3D300D3D3D3004D4D4D00000000000000000033333300FFFFFF00FFFF
      FF00FFFFFF0066999900CCCCFF00FFCCCC003333990000000000CCCCCC00CCFF
      FF00FFFFFF00FFFFFF0099FFCC0066009900000000000000000000000000403F
      D00000000000000000003F5FFF00403FD000000000000B507D00B0DEFF00BBE2
      FF00B8DBF5005082A60007436A000000000000000000006700000F8810001FB0
      3F0030CF600040DF70001F90200000670000000000000B507D00B0DEFF00BBE2
      FF00B8DBF5005082A60007436A00000000000067000000000000000000000000
      00000000000000000000403FD0004D4D4D00D3D3D300FFFF4D00D3D3D300D3D3
      D300A6A6A600D3D3D3004D4D4D0000000000000000000000000033333300FFFF
      FF00FFFFFF00FFFFFF00669999006666660099CC9900009999000066CC00CCCC
      CC00FFFFFF0033666600330066000000000000000000403FD000403FD0004F48
      EF0000000000403FD0006F77FF00403FD0000000000009629400C9E9FF006896
      B6000C4D7800226691002975A10000000000000000000F88100010A72F002FB7
      4F003FD06F0050E78000209F3F00004F00000000000009629400C9E9FF006896
      B6000C4D7800226691002975A10000000000000000000000000000000000403F
      D00000000000000000003F5FFF004D4D4D00A6A6A600FFFF4D00FFFF4D00D3D3
      D300FFFF4D00A6A6A6004D4D4D00000000000000000000000000000000003333
      3300FFFFFF00FFFFFF00FFFFFF006699660066CCFF00CCFFCC00006699000066
      CC0000000000000000000000000000000000403FD0002F30F000EFEFFF00B0C7
      FF006F77FF006F77FF00403FD00000000000000000000773AB0014517C000B55
      8200116393003C88B200032B3F00000000000070000010982000006700000000
      00001F9020001F8820000067000000000000000000000773AB0014517C000B55
      8200116393003C88B200032B3F000000000000000000403FD000403FD0004F48
      EF0000000000403FD0006F77FF00403FD0004D4D4D00A6A6A600D3D3D300D3D3
      D300A6A6A6004D4D4D0000000000000000000000000000000000000000000000
      000033333300FFFFFF00FFFFFF00FFFFFF006699990066CCFF00CCFFFF000066
      99003399CC006600CC0000000000000000004037EF006F77FF00B0C7FF00B0C7
      FF006F77FF002F30FF00403FD0000000000000000000000000000A5D8D000967
      9A002A85B40020729A00000000000000000010972F0000700F00000000000000
      00001F90200000000000000000000000000000000000000000000A5D8D000967
      9A002A85B40020729A000000000000000000403FD0002F30F000EFEFFF00B0C7
      FF006F77FF006F77FF00403FD00000000000000000004D4D4D004D4D4D004D4D
      4D004D4D4D000000000000000000000000000000000000000000000000000000
      00000000000033333300FFFFFF0066993300330066006633990066CCFF00CCFF
      CC00006699000099CC006600CC000000000000000000403FD0001F0FF0001F0F
      F0004F48EF004F48EF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000067000000670000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004037EF006F77FF00B0C7FF00B0C7
      FF006F77FF002F30FF00403FD000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000330033000000000000000000000000006666660066CC
      FF00CCFFFF0033333300336633006600CC000000000000000000403FD0001F0F
      F000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000067000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000403FD0001F0FF0001F0F
      F0004F48EF004F48EF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006666
      660033999900FFFFFF0033339900333333000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000403FD0001F0F
      F000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006633660066669900FFFFFF00333366000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006633660099999900FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004D4D4D004D4D
      4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000038302E0087534F00B59A9600C2AAA700D0BBB900DAC9
      C700B8B5BB00C2AAA700B59A960087534F00000000004D4D4D00D3D3D300D3D3
      D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D3004D4D
      4D00D3D3D3004D4D4D000000000000000000A0777000C0909000C0909000C090
      9000C0909000C0909000C0909000C2AAA700B69C9700C7B0AD00D7C3C100E7D7
      D600EFE1E100FFFFFF00D7C3C100B69C97000000000081521D0081521D008152
      1D0081521D0081521D0081521D004D4D4D004D4D4D004D4D4D004D4D4D004D4D
      4D00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000038302E00B69C9700B59A9600C2ACA800CDBA
      B700D5C4C200D9CBC900CDBAB700B59A96004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D00D3D3D3004D4D4D0000000000A0777000E0E7E000FFF0EF00F0F0
      E000F0EFDF00F0EFDF00F0E8D000917F7C00B0959000BFA7A300CEB8B500DCCB
      C900E6D7D700DCCBC900CEB8B500917F7C000000000081521D00FFFFFF0022A1
      2200FFFFFF00FFFFFF0081521D00D3D3D300D3D3D300D3D3D300D3D3D3004444
      44004D4D4D000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AA8E890087534F00D3C3BF00F3EF
      EE00FFFFFF00B98A890087534F00000000004D4D4D00D3D3D300D3D3D300D3D3
      D300D3D3D300D3D3D300D3D3D3004DFFFF004DFFFF004DFFFF00D3D3D300D3D3
      D3004D4D4D004D4D4D004D4D4D0000000000A0787000FFF7F0009F989F009F98
      9F009F989F009F989F009F989F00FFFFFF00B69C9700B69C9700C2AAA700D0BB
      B900DAC9C700D0BBB900B59A960087534F000000000081521D0022A12200FFFF
      FF0022A12200FFFFFF0081521D005D5D5D00685B5B006B5B5B00675F5F003D3D
      3D00797979004D4D4D0000000000000000000000000000000000000000000080
      800000000000000000000000000000000000000000000000000046759C0093CB
      FF007EBBED000000000000000000000000004D4D4D00D3D3D300D3D3D300D3D3
      D300D3D3D300D3D3D300D3D3D300A6A6A600A6A6A600A6A6A600D3D3D300D3D3
      D3004D4D4D00D3D3D3004D4D4D0000000000AF7F7000FFF8F000F0F0EF00E0E0
      DF00E0DFDF00E0DFDF00E0DFD000FFFFFF00AA8E8900B59A9600C2ACA800CDBA
      B700D5C4C200D9CBC900CDBAB700B59A96000000000081521D00FFFFFF00FFFF
      FF0022A12200FFFFFF0081521D00D3D3D3007AFFFF0054FFFF00A3F7F700D3D3
      D3004D4D4D004D4D4D0000000000000000000000000000000000008080000080
      80000000000000000000000000000000000000000000192530009DD1FF0085C6
      FF0086C7FF00628CB2000C4D7800000000004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D00D3D3D300D3D3D3004D4D4D00B0877F00FFFFFF009F989F009F98
      9F009F989F009F989F009F989F00FFFFFF00FFFFFF0087534F00D3C3BF00F3EF
      EE00FFFFFF00B98A890087534F00000000000000000081521D00FFFFFF00FFFF
      FF00FFFFFF0022A1220081521D004D4D4D004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D00D3D3D3004D4D4D00000000000000000000000000008080000080
      800000000000FFFFFF000000000000000000000000003656730092CEFF009FD4
      FF00ABDAFF0090CAF60000000000000000004D4D4D00D3D3D300D3D3D300D3D3
      D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D3004D4D
      4D00D3D3D3004D4D4D00D3D3D3004D4D4D00C0907F00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFF8F000FFFFFF00FFF8FF00FFFFFF0046759C0093CB
      FF007EBBED000000000000000000000000000000000081521D0081521D008152
      1D0081521D0081521D0081521D00BCBCBC00BEBEBE00C0C0C000BBBBBB004D4D
      4D0098989800D3D3D3004D4D4D00000000000000000000000000008080000000
      000000000000FFFFFF000000000000000000000000000B507D00B0DEFF00BBE2
      FF00B8DBF5005082A60007436A0000000000000000004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D00D3D3
      D3004D4D4D00D3D3D3004D4D4D004D4D4D00CF988000FFFFFF009F989F009F98
      9F009F989F009F989F009F989F00FFFFFF00EFEFEF00192530009DD1FF0085C6
      FF0086C7FF00628CB2000C4D7800000000000000000000000000000000004D4D
      4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D
      4D00D3D3D3004D4D4D004D4D4D00000000000000000000000000008080000080
      800000000000FFFFFF0000000000000000000000000009629400C9E9FF006896
      B6000C4D7800226691002975A1000000000000000000000000004D4D4D00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004D4D
      4D00D3D3D3004D4D4D00D3D3D3004D4D4D00D0A08000FFFFFF00FFF8FF00FFF8
      FF00F0F7F000F0F7F000F0F0F000F0F0F000DFA880003656730092CEFF009FD4
      FF00ABDAFF0090CAF60000000000000000000000000081521D0081521D008152
      1D0081521D0081521D0081521D00BBBBBB00BBBBBB00BBBBBB00EBEBEB004D4D
      4D004D4D4D004D4D4D0000000000000000000000000000000000008080000080
      800000000000FFFFFF000000000000000000800000000773AB0014517C000B55
      8200116393003C88B200032B3F00000000000000000000000000000000004D4D
      4D00FFFFFF004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D00FFFFFF004D4D
      4D004D4D4D004D4D4D004D4D4D0000000000DFA78000DFA88000DFA88000DFA8
      8000DFA88000DFA88000DFA88000DFA88000DFA880000B507D00B0DEFF00BBE2
      FF00B8DBF5005082A60007436A00000000000000000081521D00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0081521D00F6F6F600F6F6F600F6F6F600FDFDFD00F6F6
      F6004D4D4D000000000000000000000000000000000000000000008080000080
      800000000000FFFFFF00000000008000000080000000800000000A5D8D000967
      9A002A85B40020729A0000000000000000000000000000000000000000004D4D
      4D00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF004D4D4D000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000009629400C9E9FF006896
      B6000C4D7800226691002975A100000000000000000081521D00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0081521D00F6F6F6004D4D4D004D4D4D004D4D4D00FCFC
      FC004D4D4D000000000000000000000000000000000000000000008080000080
      800000000000FFFFFF0000000000000000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004D4D4D00FFFFFF004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D00FFFF
      FF004D4D4D000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000773AB0014517C000B55
      8200116393003C88B200032B3F00000000000000000081521D00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0081521D00F6F6F600F6F6F600F6F6F600F6F6F600F6F6
      F600F6F6F6004D4D4D0000000000000000000000000000000000008080000000
      0000FFFFFF00FFFFFF0000000000000000000000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004D4D4D00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF004D4D4D0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000A5D8D000967
      9A002A85B40020729A0000000000000000000000000081521D00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0081521D004D4D4D004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000081521D0081521D008152
      1D0081521D0081521D0081521D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000081521D0081521D008152
      1D0081521D0081521D0081521D00000000000000000000000000000000000000
      000000000000000000000000000000000000000000005F535100B69C9700C2AA
      A700D0BBB900DAC9C700D9CBC900D0BBB900C2AAA700B59A960087534F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000996D68004D4D4D004D4D4D00000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000081521D00FFFFFF0022A1
      2200FFFFFF00FFFFFF0081521D0087534F00B59A9600C2AAA700D0BBB900DAC9
      C700B8B5BB00C2AAA700B59A960087534F0000000000996D6800AA8E8900B59A
      9600C2ACA800CDBAB700D5C4C200D9CBC900D5C4C200CDBAB700996D68000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004D4D4D00996D
      68004D4D4D004D4D4D004D4D4D00000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000081521D0022A12200FFFF
      FF0022A12200FFFFFF0081521D0038302E00B69C9700B59A9600C2ACA800CDBA
      B700D5C4C200D9CBC900CDBAB700B59A9600000000000000000038302E008753
      4F00C2ACA800DAC9C700FFFFFF00D9CBC900C2ACA800B98A8900D9CBC900D0BB
      B900C2AAA700B59A960087534F00000000000000000000000000000000000000
      00000000000000000000000000004D4D4D004D4D4D004D4D4D004D4D4D00A6A6
      A6004D4D4D004D4D4D000000000000000000000000000000000000FFFF000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      000000FF00000000000000000000000000000000000081521D00FFFFFF00FFFF
      FF0022A12200FFFFFF0081521D0000000000AA8E890087534F00D3C3BF00F3EF
      EE00FFFFFF00B98A890087534F00000000000000000000000000000000000000
      000046759C0093CBFF007EBBED0000000000C2ACA800CDBAB700D5C4C200D9CB
      C900D5C4C200CDBAB700996D680000000000000000005F535100B69C9700C2AA
      A700D0BBB900C2AAA7004D4D4D00A6A6A600D3D3D300D3D3D300A6A6A6004D4D
      4D00A6A6A600000000000000000000000000000000000000000000FFFF0000FF
      FF00000000000000FF000000FF000000FF000000FF000000FF000000000000FF
      000000FF00000000000000000000000000000000000081521D00FFFFFF00FFFF
      FF00FFFFFF0022A1220081521D0000000000000000000000000046759C0093CB
      FF007EBBED000000000000000000000000000000000000000000000000001925
      30009DD1FF0085C6FF0086C7FF00628CB20000000000DAC9C700FFFFFF00D9CB
      C900C2ACA800B98A8900000000000000000000000000996D6800AA8E8900B59A
      9600C2ACA8004D4D4D00A6A6A600D3D3D300D3D3D300FFFF4D00D3D3D300A6A6
      A6004D4D4D000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF00000000000000FF000000FF000000FF000000000000FF000000FF
      000000FF000000FF000000000000000000000000000081521D0081521D008152
      1D0081521D0081521D0081521D000000000000000000192530009DD1FF0085C6
      FF0086C7FF00628CB2000C4D7800000000000000000000000000000000003656
      730092CEFF009FD4FF00ABDAFF0090CAF6000000000093CBFF007EBBED000000
      000000000000000000000000000000000000000000000000000038302E00D3C3
      BF00D3C3BF004D4D4D00D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3
      D3004D4D4D000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF00000000000000FF000000000000FF000000FF000000FF
      000000FF000000FF000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003656730092CEFF009FD4
      FF00ABDAFF0090CAF60000000000000000000000000000000000000000000B50
      7D00B0DEFF00BBE2FF00B8DBF5005082A60007436A0085C6FF0086C7FF00628C
      B200000000000000000000000000000000000000000000000000000000000000
      000046759C004D4D4D00D3D3D300FFFF4D00D3D3D300D3D3D300A6A6A600D3D3
      D3004D4D4D000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000FF000000FF000000FF
      000000FF000000FF000000000000000000000000000081521D0081521D008152
      1D0081521D0081521D0081521D0000000000000000000B507D00B0DEFF00BBE2
      FF00B8DBF5005082A60007436A00000000000000000000000000000000000962
      9400C9E9FF006896B6000C4D7800226691002975A1009FD4FF00ABDAFF0090CA
      F600000000000000000000000000000000000000000000000000000000001925
      30009DD1FF004D4D4D00A6A6A600FFFF4D00FFFF4D00D3D3D300FFFF4D00A6A6
      A6004D4D4D0000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF0000000000000000FF000000FF000000FF
      000000FF000000FF000000000000000000000000000081521D00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0081521D00000000000000000009629400C9E9FF006896
      B6000C4D7800226691002975A100000000000000000000000000000000000773
      AB0014517C000B558200116393003C88B200032B3F00BBE2FF00B8DBF5005082
      A60007436A000000000000000000000000000000000000000000000000003656
      730092CEFF009FD4FF004D4D4D00A6A6A600D3D3D300D3D3D300A6A6A6004D4D
      4D000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF0000000000000000FF000000FF
      000000FF000000FF000000000000000000000000000081521D00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0081521D0000000000000000000773AB0014517C000B55
      8200116393003C88B200032B3F00000000000000000000000000000000000000
      00000A5D8D0009679A002A85B40020729A00C9E9FF006896B6000C4D78002266
      91002975A1000000000000000000000000000000000000000000000000000B50
      7D00B0DEFF00BBE2FF00B8DBF5004D4D4D004D4D4D004D4D4D004D4D4D000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF0000000000000000FF
      000000FF00000000000000000000000000000000000081521D00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0081521D000000000000000000000000000A5D8D000967
      9A002A85B40020729A0000000000000000000000000000000000000000000000
      00000000000000000000000000000773AB0014517C000B558200116393003C88
      B200032B3F000000000000000000000000000000000000000000000000000962
      9400C9E9FF006896B6000C4D7800226691002975A10000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000
      000000FF00000000000000000000000000000000000081521D00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0081521D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000A5D8D0009679A002A85B4002072
      9A00000000000000000000000000000000000000000000000000000000000773
      AB0014517C000B558200116393003C88B200032B3F0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000081521D0081521D008152
      1D0081521D0081521D0081521D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000A5D8D0009679A002A85B40020729A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005F535100B69C9700C2AA
      A700D0BBB900DAC9C700D9CBC900D0BBB900C2AAA700B59A960087534F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      9900000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000996D6800AA8E8900B59A
      9600C2ACA800CDBAB700D5C4C200D9CBC900D5C4C200CDBAB700996D68000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003333CC000000
      FF00000099000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008080000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000038302E008753
      4F00D3C3BF00F3EFEE00FFFFFF00B98A8900D3C3BF00B98A8900FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003333CC003399
      FF000000FF000000990000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000080
      8000008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000046759C0093CBFF007EBBED0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000005F535100B69C9700C2AA
      A700D0BBB900DAC9C700D9CBC900D0BBB900C2ACA8000000000000FFFF00C0C0
      C000000000000000000000000000000000000000000000000000000000003333
      CC000066FF000000CC0000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000008080000080
      8000008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001925
      30009DD1FF0085C6FF0086C7FF00628CB20000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000996D6800AA8E8900B59A
      9600C2ACA800CDBAB700D5C4C200D9CBC900D5C4C200000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000CC000000FF0000009900000000000000000000000000000000000000
      FF00000099000000000000000000000000000000000000000000008080000080
      8000008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003656
      730092CEFF009FD4FF00ABDAFF0090CAF60000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000038302E00AA8E
      8900D3C3BF00F3EFEE00FFFFFF00D3C3BF00AA8E8900000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000CC000000FF000000990000000000000000000000FF000000
      9900000000000000000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000000000000000000000000000000000000000000000B50
      7D00B0DEFF00BBE2FF00B8DBF5005082A60007436A00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000046759C0093CBFF007EBBED00000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      000000000000000000000000CC000000FF00000099000000FF00000099000000
      0000000000000000000000000000000000000000000000000000008080000080
      8000008080000000000000000000000000000000000000000000000000000000
      0000800000008000000000000000000000000000000000000000000000000962
      9400C9E9FF006896B6000C4D7800226691002975A100FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000001925
      30009DD1FF0085C6FF0086C7FF00628CB2000000000000000000000000000000
      0000000080000000800000000000000000000000000000000000000000000000
      00000000000000000000000000000000CC000000FF0000009900000000000000
      0000000000000000000000000000000000000000000000000000008080000080
      8000008080000000000000000000000000000000000000000000000000008000
      0000800000008000000080000000800000000000000000000000000000000773
      AB0014517C000B558200116393003C88B200032B3F00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000003656
      730092CEFF009FD4FF00ABDAFF0090CAF6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000CC000000FF00000099000000CC00000099000000
      0000000000000000000000000000000000000000000000000000008080000080
      8000008080000000000000000000000000000000000000000000800000008000
      0000800000008000000080000000800000000000000000000000000000000319
      28000A5D8D0009679A002A85B40020729A00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000B50
      7D00B0DEFF00BBE2FF00B8DBF5005082A60007436A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000CC000000FF000000990000000000000000000000CC000000
      9900000000000000000000000000000000000000000000000000008080000080
      8000008080000000000000000000000000000000000000000000000000008000
      0000800000008000000080000000800000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000962
      9400C9E9FF006896B6000C4D7800226691002975A10000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      CC000000FF000000FF0000009900000000000000000000000000000000000000
      CC00000099000000000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      0000800000008000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000773
      AB0014517C000B558200116393003C88B200032B3F0000000000000000000000
      00000000000000000000000000000000000000000000000000000000CC003399
      FF000000FF000000990000000000000000000000000000000000000000000000
      00000000CC000000990000000000000000000000000000000000008080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000A5D8D0009679A002A85B40020729A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000666699000000
      CC00666699000000000000000000000000000000000000000000000000000000
      000000000000000000000000CC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF0000000000000000000000000000000000000000000000000000FF
      FF00808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000080000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000FFFF008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000800000000000000000000000
      000000000000008080000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008000000000000000
      0000000000000080800000808000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000800000008000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000080
      800000808000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000080
      800000808000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000080
      8000008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000080800000808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000A00000000100010000000000000500000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF00008001FFFFFFFF0000
      80018001F81F000080018001F00F000080018001F00700008001800180030000
      800180018001000080018001C001000080018001F001000080018001E0030000
      80018001E07F000080018001E07F000080018001E07F000080018001E07F0000
      8001FFFFF0FF0000FFFFFFFFFFFF00008003FCFFFFFFFF3F8003E0FFFFFFFE3F
      C007C0FDF3E7FC3FC007C0F0F3E7F01F4005C0F0FFFFC0070001C0C1F80F8003
      0001C0C3F80F80030001C007F7F700018003C00FF0070001C007801FFFFB0001
      C007001FE0030001C007001FEFFF0001C007001FEFFF8003E00F803F8FFF8003
      F01FC0FFFFFFC007F83FF1FFFFFFF01FFFFFFF98FFFFFFFF0000FE00C01FFE3F
      0000F801800FFC1F0000E003800FFC1F000080018007FE7F000000008003FC3F
      000000008003FC3F000000008003FC3F000080008007FC1F0000C0008007F20F
      0000E001800FE1070000F007800FE1870000F807800FE0070000FC03801FF00F
      FFFFFE01C01FF81FFFFFFFC1FFFFFFFFFFFFFFFFFFFFFC0FFFFBFFC7F01FF803
      FFFBFFC7F000F800FFE0FFC7F000F000FFFBFFC7F000E000000B8083E000E000
      7FEF8001E000C000492FC001C001C0007FEFF0018001C0010007E00100018801
      BFF7E00100018203A497E001E0038203BFF7E001E00309838007E07FFC030C07
      A497F0FFFFE71E3F8007FFFFFFFFFE7FFDFFFFFFFFFFFFFFF83FFFFFFF01FC01
      F01FFFFFF101FE03E007FFFFE003FF87C043FF80EC07E2038001FF80F803C003
      0000FF008033D80380010100C07FF003C0010080F0FF8103E00300AAE07FC187
      F0030180E07FC1FFF8C301FFE07FC3FFFD8355FFE07FC1FFFF9901FFE07F99FF
      FFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFFFFFFFFFFF3FEF83F
      FC00FC00C1F8F01FFE00FE0080E0E007FF01FF018081C001FFC3FFC311018000
      FE81F38136010000FC81C1813E018000EC8180817C01C00188818081EC01E007
      018111818803F00301C337C30187F80183FF3FFF01FFFDC0CFFF7FFF83FFFFE0
      FFFFFFFFCFFFFFF0FFFFFFFFFFFFFFF8FFFFFFFFFFFFFFFFC007FFFFFFFFFC00
      80030000800FF600000100008007E701000100008003C7C30001000080030001
      0000000180018181000000038001818180000001E0018181C000000180038101
      E001000180078003E007FF818007813FF007FF81800381BFF003FFC3800381FF
      F803FFFF81FF81FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF83F81FF
      801FFFF1E00F8000801FFFC1C0078000C001FE0380038101F0018007800381C3
      E003800700018181E00FC0070001FF81E007F00700018181E007E00700018181
      E007E00F00018181F007E01F800381C3FE07E07F800381FFFF0FE07FC00781FF
      FFFFF0FFE00FFFFFFFFFFFFFF83FFFFFFFFFFFFFFFFFFFFFFBFF801FEABFEFFD
      F3FF8003FF9FC7FFE3FFC003FF8FC3FBC3FFF003800FE3F70007E0038007F1E7
      837FE003C047F8CF837BE003F0C3FC1F8373E003E061FE3F8360E003E073FC1F
      8340E003E07FF8CF8360E003E07FE1E78773E007E07FC3F38F7BE00FF0FFC7FD
      9F7FE01FFFFFFFFF807FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC7FFF8FFFFF
      EABF847FE08F9FCFFF9FBC7FEF8F8FAFFF8FBFFFEFFFC75FFF87BFF1EF8FE2BF
      8097BE11E08FF17FC1C3BEF1EF8FFAFFC0CBBFFFEFFFF47B80E1BC7FEF8F0A31
      00E1847FE08F07000070BC7FEF8F678100F1FFFFFFFFE78301FF1FFFC7FFC703
      00FF1FFFC7FFFC0781FF1FFFC7FFFE1F00000000000000000000000000000000
      000000000000}
  end
  object alPer: TActionList
    Images = ilPer
    OnExecute = alPerExecute
    Top = 352
    object actMBase: TAction
      Category = 'Move'
      Caption = #24322#21160
      Hint = #35831#20551#12289#35843#21160#12289#31163#32844#12289#22797#32844#21450#20854#26597#35810
      OnExecute = actMBaseExecute
    end
    object actLeave: TAction
      Category = 'Move'
      Caption = #35831#20551'...'
      Hint = #23545#24403#21069#21592#24037#36827#36827#35831#20551#25805#20316
      ImageIndex = 15
      ShortCut = 16460
      OnExecute = actLeaveExecute
    end
    object actDiary: TAction
      Category = 'Tools'
      Caption = #26085#35760#26412
      ImageIndex = 26
      OnExecute = actDiaryExecute
    end
    object actChgpwd: TAction
      Category = 'System'
      Caption = #26356#26032#23494#30721
      Hint = #26356#26032#24403#21069#31649#29702#21592#30340#30331#24405#23494#30721
      OnExecute = actChgpwdExecute
    end
    object actAdmin: TAction
      Category = 'System'
      Caption = #31649' '#29702' '#21592
      Hint = #31649#29702#21592#20449#24687#31649#29702
      ImageIndex = 0
      OnExecute = actAdminExecute
    end
    object actLogin: TAction
      Category = 'System'
      Caption = #37325#26032#30331#24405
      Hint = #37325#26032#30331#24405#31995#32479
      OnExecute = actLoginExecute
    end
    object actAddr: TAction
      Category = 'Tools'
      Caption = #36890#35759#24405
      ImageIndex = 27
      OnExecute = actAddrExecute
    end
    object actBase: TAction
      Category = 'System'
      Caption = #22522#26412#25968#25454
      Hint = #35774#32622#37096#38376#12289#20998#31867#12289#20844#21496#20449#24687
    end
    object actDept: TAction
      Category = 'System'
      Caption = #37096#38376#35774#32622'...'
      Hint = #20844#21496#37096#38376#32467#26500#35774#32622
      ImageIndex = 1
      OnExecute = actDeptExecute
    end
    object actDict: TAction
      Category = 'System'
      Caption = #20998#31867#20449#24687'...'
      Hint = #20998#31867#20449#24687#35774#32622
      ImageIndex = 2
      OnExecute = actDictExecute
    end
    object actCompany: TAction
      Category = 'System'
      Caption = #20844#21496#20449#24687'...'
      Hint = #21333#20301#20449#24687#35774#32622
      OnExecute = actCompanyExecute
    end
    object actDKind: TAction
      Category = 'System'
      Caption = #31867#21035#26174#31034#35774#32622'...'
      Hint = #35774#23450#35201#23548#33322#26641#20013#26174#31034#30340#31867#21035
      OnExecute = actDKindExecute
    end
    object actAwake: TAction
      Category = 'System'
      Caption = #20107#20214#25552#37266'...'
      Hint = #24744#21487#20197#22312#36825#37324#26597#30475#36817#26399#29983#26085#21592#24037#12289#21512#21516#21040#26399#21592#24037#21450#36817#26399#36716#27491#21592#24037#20449#24687
      OnExecute = actAwakeExecute
    end
    object actSet: TAction
      Category = 'System'
      Caption = #36873#39033'(&O)...'
      Hint = #21442#25968#35774#32622
      ImageIndex = 3
      OnExecute = actSetExecute
    end
    object actExit: TAction
      Category = 'System'
      Caption = #36864#20986#31995#32479'(&X)'
      Hint = #36864#20986#31179#39118#20154#20107#26723#26696#31649#29702#31995#32479
      ImageIndex = 4
      OnExecute = actExitExecute
    end
    object actAdd: TAction
      Category = 'Staff'
      Caption = #28155#21152'...'
      Hint = #28155#21152#21592#24037#26723#26696
      ImageIndex = 5
      ShortCut = 16449
      OnExecute = actAddExecute
    end
    object actEdit: TAction
      Category = 'Staff'
      Caption = #32534#36753'...'
      Hint = #26356#26032#24403#21069#21592#24037#26723#26696
      ImageIndex = 6
      ShortCut = 16453
      OnExecute = actEditExecute
    end
    object actDel: TAction
      Category = 'Staff'
      Caption = #21024#38500
      Hint = #21024#38500#24403#21069#36873#23450#30340#21592#24037#26723#26696'(Ctrl+'#21333#20987#23454#29616#22810#36873')'
      ImageIndex = 7
      ShortCut = 46
      OnExecute = actDelExecute
    end
    object actBatchEdit: TAction
      Category = 'Staff'
      Caption = #25209#37327#20462#25913'...'
      Hint = #25209#37327#20462#25913#25351#23450#23383#27573#25968#20540
      OnExecute = actBatchEditExecute
    end
    object actDup: TAction
      Category = 'Staff'
      Caption = #22797#21046#28155#21152'...'
      Hint = #20197#24403#21069#21592#24037#20449#24687#20026#21021#22987#20540#28155#21152#21592#24037#26723#26696
      ImageIndex = 8
      ShortCut = 16452
      OnExecute = actDupExecute
    end
    object actInqu: TAction
      Category = 'Staff'
      Caption = #26597#35810'...'
      Hint = #26597#35810#21592#24037#26723#26696#20449#24687
      ImageIndex = 9
      ShortCut = 16454
      OnExecute = actInquExecute
    end
    object actAP: TAction
      Category = 'Staff'
      Caption = #22870#24809#35760#24405'...'
      Hint = #22870#24809#20449#24687#31649#29702
      ShortCut = 16471
      OnExecute = actAPExecute
    end
    object actTrain: TAction
      Category = 'Staff'
      Caption = #22521#35757#35760#24405'...'
      Hint = #22521#35757#20449#24687#31649#29702
      ShortCut = 16468
      OnExecute = actTrainExecute
    end
    object actChart: TAction
      Category = 'Staff'
      Caption = #22270#34920#20998#26512'...'
      Hint = #20197#22270#34920#26041#24335#26174#31034#21592#24037#20998#24067
      ImageIndex = 10
      ShortCut = 123
      OnExecute = actChartExecute
    end
    object actUnLeave: TAction
      Category = 'Move'
      Caption = #38144#20551'...'
      Hint = #23545#24403#21069#21592#24037#38144#20551
      OnExecute = actUnLeaveExecute
    end
    object actMove: TAction
      Category = 'Move'
      Caption = #35843#21160'...'
      Hint = #35843#21160#24403#21069#21592#24037
      ShortCut = 16461
      OnExecute = actMoveExecute
    end
    object actHelp: TAction
      Category = 'Help'
      Caption = #20869#23481
      ImageIndex = 31
      ShortCut = 112
      OnExecute = actHelpExecute
    end
    object actPage: TAction
      Category = 'Help'
      Caption = #20027#39029
      Hint = #35775#38382#31179#39118#36719#20214#24037#20316#23460
      OnExecute = actPageExecute
    end
    object actQQ: TAction
      Category = 'Help'
      Caption = 'QQ'#32852#31995
      Hint = #19982#31179#39118'QQ'#32852#31995
      ImageIndex = 32
      OnExecute = actQQExecute
    end
    object actLog: TAction
      Category = 'Help'
      Caption = #26085#24535
      OnExecute = actLogExecute
    end
    object actBuy: TAction
      Category = 'Help'
      Caption = #36141#20080
      ImageIndex = 34
      OnExecute = actBuyExecute
    end
    object actReg: TAction
      Category = 'Help'
      Caption = #27880#20876'...'
      Hint = #27880#20876#31179#39118#20154#20107#26723#26696#31649#29702#31995#32479
      ImageIndex = 33
      OnExecute = actRegExecute
    end
    object actAbout: TAction
      Category = 'Help'
      Caption = #20851' '#20110'...'
      ImageIndex = 35
      OnExecute = actAboutExecute
    end
    object actLeft: TAction
      Category = 'Move'
      Caption = #31163#32844'...'
      Hint = #23545#24403#21069#21592#24037#36827#34892#31163#32844#25805#20316
      ImageIndex = 16
      OnExecute = actLeftExecute
    end
    object actBack: TAction
      Category = 'Move'
      Caption = #22797#32844'...'
      Hint = #23545#24403#21069#21592#24037#36827#34892#22797#32844#25805#20316
      ImageIndex = 17
      ShortCut = 16450
      OnExecute = actBackExecute
    end
    object actInLeave: TAction
      Category = 'Move'
      Caption = #35831#20551#26597#35810'...'
      Hint = #21592#24037#35831#20551#20449#24687#31649#29702
      OnExecute = actInLeaveExecute
    end
    object actField: TAction
      Category = 'Staff'
      Caption = #23383#27573#26174#31034'...'
      Hint = #35774#23450#34920#26684#20013#35201#26174#31034#30340#23383#27573#21450#20462#25913#39033#30446#21517#31216
      ImageIndex = 11
      OnExecute = actFieldExecute
    end
    object actPrint: TAction
      Category = 'Staff'
      Caption = #25171#21360'(&P)'
      Hint = #25171#21360#21592#24037#20449#24687
      ImageIndex = 12
    end
    object actPCur: TAction
      Category = 'Staff'
      Caption = #25171#21360#24403#21069#21592#24037
      Hint = #25171#21360#24403#21069#21592#24037#26723#26696
      ImageIndex = 13
      ShortCut = 16464
      OnExecute = actPCurExecute
    end
    object actPAll: TAction
      Category = 'Staff'
      Caption = #25171#21360#25152#26377#21592#24037
      Hint = #25171#21360#26174#31034#30340#21592#24037#26723#26696
      OnExecute = actPAllExecute
    end
    object actPList: TAction
      Category = 'Staff'
      Caption = #25171#21360#21592#24037#21015#34920
      Hint = #20197#34920#26684#26041#24335#25171#21360#24403#21069#26174#31034#30340#21592#24037
      OnExecute = actPListExecute
    end
    object actInMove: TAction
      Category = 'Move'
      Caption = #35843#21160#26597#35810'...'
      Hint = #26597#35810#21592#24037#35843#21160#20449#24687
      ImageIndex = 18
      OnExecute = actInMoveExecute
    end
    object actInLeft: TAction
      Category = 'Move'
      Caption = #31163#32844#26597#35810'...'
      Hint = #26597#35810#21592#24037#31163#32844#35760#24405
      OnExecute = actInLeftExecute
    end
    object actInBack: TAction
      Category = 'Move'
      Caption = #22797#32844#26597#35810'...'
      Hint = #26597#35810#21592#24037#22797#32844#35760#24405
      OnExecute = actInBackExecute
    end
    object actBackData: TAction
      Category = 'Data'
      Caption = #22791#20221'...'
      Hint = #22791#20221#24403#21069#25968#25454
      ImageIndex = 21
      OnExecute = actBackupExecute
    end
    object actRestore: TAction
      Category = 'Data'
      Caption = #24674#22797'...'
      Hint = #24674#22797#20026#20197#21069#22791#20221#36807#30340#25968#25454
      OnExecute = actRestoreExecute
    end
    object actCompress: TAction
      Category = 'Data'
      Caption = #21387#32553#20462#22797
      Hint = #23545#25968#25454#24211#36827#34892#21387#32553#20462#22797#25805#20316
      ImageIndex = 24
      OnExecute = actCompressExecute
    end
    object actExport: TAction
      Category = 'Data'
      Caption = #23548#20986'Excel...'
      Hint = #21592#24037#26723#26696#23548#20986#20026'Excel'#25991#26723
      ImageIndex = 22
      OnExecute = actExportExecute
    end
    object actImport: TAction
      Category = 'Data'
      Caption = #23548#20837'Excel...'
      Hint = #23548#20837#22806#37096'Excel'#25968#25454
      ImageIndex = 23
      OnExecute = actImportExecute
    end
    object actImportP: TAction
      Category = 'Data'
      Caption = #23548#20837#29031#29255'...'
      Hint = #24744#21487#20197#25351#23450#19968#20010#29031#29255#30446#24405#65292#25209#37327#23548#20837#21592#24037#29031#29255
      OnExecute = actImportPExecute
    end
    object actInitData: TAction
      Category = 'Data'
      Caption = #21021#22987#21270'...'
      Hint = #21021#22987#21270#25968#25454'...'#24744#21487#20197#36873#25321#38656#35201#21021#22987#21270#30340#25968#25454#34920
      ImageIndex = 25
      OnExecute = actInitDataExecute
    end
    object actTree: TAction
      Category = 'View'
      Caption = #26174#31034#20998#31867#21015#34920
      Checked = True
      OnExecute = actTreeExecute
    end
    object actPhoto: TAction
      Category = 'View'
      Caption = #26174#31034#21592#24037#29031#29255
      Checked = True
      OnExecute = actPhotoExecute
    end
    object actTool: TAction
      Category = 'View'
      Caption = #26174#31034#24555#36895#26597#35810
      Checked = True
      OnExecute = actToolExecute
    end
    object actPSet: TAction
      Category = 'Staff'
      Caption = #25171#21360#23383#27573#35774#32622'...'
      Hint = #25171#21360#23383#27573#35774#32622
      ImageIndex = 14
      OnExecute = actPSetExecute
    end
    object actCalendar: TAction
      Category = 'Tools'
      Caption = #19975#24180#21382
      ImageIndex = 28
      OnExecute = actCalendarExecute
    end
    object actCode: TAction
      Category = 'Tools'
      Caption = #21306#21495#37038#32534
      ImageIndex = 29
      OnExecute = actCodeExecute
    end
    object actCamera: TAction
      Category = 'Tools'
      Caption = #29031#30456#26426
      OnExecute = actCameraExecute
    end
    object actCalc: TAction
      Category = 'Tools'
      Caption = #35745#31639#22120'(&C)'
      OnExecute = actCalcExecute
    end
    object actNote: TAction
      Category = 'Tools'
      Caption = #35760#20107#26412'(&N)'
      ImageIndex = 30
      OnExecute = actNoteExecute
    end
    object actView: TAction
      Category = 'Staff'
      Caption = #26597#30475
      Hint = #26597#30475#24403#21069#21592#24037#20449#24687
      OnExecute = actViewExecute
    end
    object actSelAll: TAction
      Category = 'Staff'
      Caption = #20840#36873
      Hint = #36873#25321#20840#37096#21592#24037
      OnExecute = actSelAllExecute
    end
    object actBackImage: TAction
      Category = 'View'
      Caption = #32972#26223
      Hint = #28857#20987#26174#31034#32972#26223#22270#29255
      ImageIndex = 37
      OnExecute = actBackImageExecute
    end
    object actNewC: TAction
      Category = 'Contract'
      Caption = #26032#31614#21512#21516'...'
      Hint = #28155#21152#19968#26465#21512#21516#35760#24405
      ImageIndex = 19
      OnExecute = actNewCExecute
    end
    object actContract: TAction
      Category = 'Contract'
      Caption = #21512#21516#20449#24687'...'
      Hint = #26597#30475#21512#21516#21015#34920#65292#31649#29702#24050#26377#30340#21512#21516#20449#24687
      OnExecute = actContractExecute
    end
    object actEndC: TAction
      Category = 'Contract'
      Caption = #21040#26399#25552#37266'...'
      Hint = #21512#21516#21040#26399#21592#24037#25552#37266
      OnExecute = actEndCExecute
    end
    object actImportC: TAction
      Category = 'Contract'
      Caption = #20174'Excel'#23548#20837'...'
      Hint = #20174#22806#37096'Excel'#25991#31456#23548#20837#21512#21516#25968#25454
      ImageIndex = 20
      OnExecute = actImportCExecute
    end
    object actNewR: TAction
      Category = 'Report'
      Caption = #26032#36827#21592#24037#25253#34920'...'
      OnExecute = actNewRExecute
    end
    object actLeftR: TAction
      Category = 'Report'
      Caption = #31163#32844#21592#24037#25253#34920'...'
      OnExecute = actLeftRExecute
    end
    object actBackR: TAction
      Category = 'Report'
      Caption = #22797#32844#21592#24037#25253#34920'...'
      OnExecute = actBackRExecute
    end
    object actMoveR: TAction
      Category = 'Report'
      Caption = #35843#21160#21592#24037#25253#34920'...'
      OnExecute = actMoveRExecute
    end
  end
  object pmPrint: TPopupMenu
    AutoHotkeys = maManual
    Images = ilPer
    Left = 96
    Top = 384
    object miCur: TMenuItem
      Action = actPCur
    end
    object miAll: TMenuItem
      Action = actPAll
    end
    object miList: TMenuItem
      Action = actPList
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object miPrintSet: TMenuItem
      Action = actPSet
    end
  end
  object pmView: TPopupMenu
    AutoHotkeys = maManual
    Left = 128
    Top = 384
    object pmGuide: TMenuItem
      Action = actTree
    end
    object miPhoto: TMenuItem
      Action = actPhoto
    end
    object miSearch: TMenuItem
      Action = actTool
    end
  end
  object pmTree: TPopupMenu
    AutoHotkeys = maManual
    Images = ilPer
    Left = 64
    Top = 384
    object miSKind: TMenuItem
      Action = actDKind
    end
    object miTChart: TMenuItem
      Action = actChart
      Caption = #22270#34920#20998#26512
    end
    object N14: TMenuItem
      Caption = '-'
    end
    object pmiDept: TMenuItem
      Action = actDept
    end
    object pmiDict: TMenuItem
      Action = actDict
    end
  end
  object pmGrid: TPopupMenu
    AutoHotkeys = maManual
    Images = ilPer
    OnPopup = pmGridPopup
    Left = 32
    Top = 384
    object pmiView: TMenuItem
      Action = actView
      Default = True
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object pmiAdd: TMenuItem
      Action = actAdd
    end
    object pmiEdit: TMenuItem
      Action = actEdit
    end
    object pmiDel: TMenuItem
      Action = actDel
    end
    object N12: TMenuItem
      Caption = '-'
    end
    object pmiBEdit: TMenuItem
      Action = actBatchEdit
    end
    object pmiDulAdd: TMenuItem
      Action = actDup
    end
    object pmiSMove: TMenuItem
      Action = actMBase
      object pmiLeave: TMenuItem
        Action = actLeave
      end
      object pmiUnLeave: TMenuItem
        Action = actUnLeave
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object pmiMove: TMenuItem
        Action = actMove
      end
      object pmiLeft: TMenuItem
        Action = actLeft
      end
      object pmiBack: TMenuItem
        Action = actBack
      end
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object N5: TMenuItem
      Action = actField
    end
    object pmiSelAll: TMenuItem
      Action = actSelAll
    end
    object pmiPrint: TMenuItem
      Action = actPCur
    end
  end
  object tmrAwake: TTimer
    Enabled = False
    Interval = 50
    OnTimer = tmrAwakeTimer
    Left = 64
    Top = 353
  end
  object pgPer: TPrintDBGridEh
    Options = [pghColored, pghOptimalColWidths]
    PageFooter.Font.Charset = DEFAULT_CHARSET
    PageFooter.Font.Color = clWindowText
    PageFooter.Font.Height = -11
    PageFooter.Font.Name = 'MS Sans Serif'
    PageFooter.Font.Style = []
    PageHeader.Font.Charset = DEFAULT_CHARSET
    PageHeader.Font.Color = clWindowText
    PageHeader.Font.Height = -11
    PageHeader.Font.Name = 'MS Sans Serif'
    PageHeader.Font.Style = []
    PrintFontName = #23435#20307
    Units = MM
    Left = 128
    Top = 353
  end
end
