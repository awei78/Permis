object frmStaff: TfrmStaff
  Left = 204
  Top = 137
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = #21592#24037#20449#24687
  ClientHeight = 541
  ClientWidth = 737
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnShortCut = FormShortCut
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object tbStaff: TRzToolbar
    Left = 0
    Top = 0
    Width = 737
    Height = 27
    AutoStyle = False
    Images = ilStaff
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
      tbPrev
      tbNext
      Spacer0
      tbAdd
      tbEdit
      tbDel
      tbDulAdd
      Spacer1
      tbSave
      tbCancel
      Spacer2
      tbExit
      Spacer3
      cbKeepEdit)
    object tbAdd: TRzToolButton
      Left = 137
      Top = 1
      Action = actAdd
    end
    object tbEdit: TRzToolButton
      Left = 197
      Top = 1
      Action = actEdit
    end
    object tbDel: TRzToolButton
      Left = 257
      Top = 1
      Action = actDel
    end
    object Spacer1: TRzSpacer
      Left = 393
      Top = 1
      Grooved = True
    end
    object tbCancel: TRzToolButton
      Left = 461
      Top = 1
      Action = actCancel
    end
    object tbSave: TRzToolButton
      Left = 401
      Top = 1
      DisabledIndex = 7
      Action = actSave
    end
    object Spacer2: TRzSpacer
      Left = 521
      Top = 1
      Grooved = True
    end
    object tbExit: TRzToolButton
      Left = 529
      Top = 1
      Action = actPrint
    end
    object tbPrev: TRzToolButton
      Left = 1
      Top = 1
      Width = 64
      Action = actPrev
    end
    object tbNext: TRzToolButton
      Left = 65
      Top = 1
      Width = 64
      Action = actNext
    end
    object Spacer0: TRzSpacer
      Left = 129
      Top = 1
      Grooved = True
    end
    object tbDulAdd: TRzToolButton
      Left = 317
      Top = 1
      Width = 76
      Action = actDulAdd
    end
    object Spacer3: TRzSpacer
      Left = 589
      Top = 1
      Grooved = True
    end
    object cbKeepEdit: TCheckBox
      Left = 597
      Top = 5
      Width = 130
      Height = 17
      Hint = #20320#22312#32534#36753#25968#25454#26102#65292#21487#29992'['#19978#19968#20010']'#12289'['#19979#19968#20010']'#27983#35272#35760#24405#65292#24744#25152#20570#30340#20462#25913#20250#33258#21160#20445#23384
      Caption = #20801#35768#36830#32493#28155#21152#12289#32534#36753
      TabOrder = 0
    end
  end
  object gbBasic: TGroupBox
    Left = 8
    Top = 32
    Width = 721
    Height = 181
    Caption = #22522#26412#20449#24687
    TabOrder = 1
    object Label1: TLabel
      Left = 32
      Top = 18
      Width = 36
      Height = 12
      Caption = #24037#21495#65306
      FocusControl = edtNo
    end
    object Label2: TLabel
      Left = 224
      Top = 18
      Width = 36
      Height = 12
      Caption = #22995#21517#65306
      FocusControl = edtName
    end
    object Label3: TLabel
      Left = 416
      Top = 18
      Width = 36
      Height = 12
      Caption = #24615#21035#65306
      FocusControl = cbSex
    end
    object Label4: TLabel
      Left = 8
      Top = 41
      Width = 60
      Height = 12
      Caption = #20986#29983#26085#26399#65306
      FocusControl = deBirth
    end
    object Label5: TLabel
      Left = 224
      Top = 41
      Width = 36
      Height = 12
      Caption = #24180#40836#65306
      FocusControl = edtAge
    end
    object Label6: TLabel
      Left = 416
      Top = 41
      Width = 36
      Height = 12
      Caption = #27665#26063#65306
      FocusControl = cbFolk
    end
    object Label7: TLabel
      Left = 8
      Top = 64
      Width = 60
      Height = 12
      Caption = #23130#23035#29366#20917#65306
      FocusControl = cbMarriage
    end
    object Label8: TLabel
      Left = 200
      Top = 64
      Width = 60
      Height = 12
      Caption = #25919#27835#38754#35980#65306
      FocusControl = cbPolitics
    end
    object Label9: TLabel
      Left = 380
      Top = 64
      Width = 72
      Height = 12
      Caption = #20837#32452#32455#26085#26399#65306
      FocusControl = deInPoliDate
    end
    object Label10: TLabel
      Left = 8
      Top = 87
      Width = 60
      Height = 12
      Caption = #36523#20221#35777#21495#65306
      FocusControl = edtCardNo
    end
    object Label11: TLabel
      Left = 200
      Top = 87
      Width = 84
      Height = 12
      Caption = #21442#21152#24037#20316#26102#38388#65306
      FocusControl = deWorkDate
    end
    object Label12: TLabel
      Left = 416
      Top = 87
      Width = 36
      Height = 12
      Caption = #23398#21382#65306
      FocusControl = cbCulture
    end
    object Label13: TLabel
      Left = 8
      Top = 110
      Width = 60
      Height = 12
      Caption = #27605#19994#38498#26657#65306
      FocusControl = edtSchool
    end
    object Label14: TLabel
      Left = 224
      Top = 110
      Width = 36
      Height = 12
      Caption = #19987#19994#65306
      FocusControl = cbSpecial
    end
    object Label15: TLabel
      Left = 392
      Top = 110
      Width = 60
      Height = 12
      Caption = #27605#19994#26085#26399#65306
      FocusControl = deGraDate
    end
    object Label16: TLabel
      Left = 32
      Top = 133
      Width = 36
      Height = 12
      Caption = #31821#36143#65306
      FocusControl = edtNative
    end
    object Label17: TLabel
      Left = 200
      Top = 133
      Width = 60
      Height = 12
      Caption = #25143#31821#22320#22336#65306
      FocusControl = edtNaAddr
    end
    object Label18: TLabel
      Left = 8
      Top = 156
      Width = 60
      Height = 12
      Caption = #26723#26696#32534#21495#65306
      FocusControl = edtFileNo
    end
    object Label19: TLabel
      Left = 200
      Top = 156
      Width = 60
      Height = 12
      Caption = #30331#35760#26085#26399#65306
      FocusControl = deRegDate
    end
    object Label20: TLabel
      Left = 404
      Top = 156
      Width = 48
      Height = 12
      Caption = #30331#35760#20154#65306
      FocusControl = edtReger
    end
    object edtNo: TDBEdit
      Left = 70
      Top = 14
      Width = 105
      Height = 20
      DataField = 'staffNo'
      DataSource = dmPer.dsStaff
      TabOrder = 0
    end
    object edtName: TDBEdit
      Left = 262
      Top = 14
      Width = 105
      Height = 20
      DataField = 'staffName'
      DataSource = dmPer.dsStaff
      TabOrder = 1
    end
    object edtSchool: TDBEdit
      Left = 70
      Top = 106
      Width = 121
      Height = 20
      DataField = 'school'
      DataSource = dmPer.dsStaff
      TabOrder = 12
    end
    object cbSex: TDBComboBox
      Left = 454
      Top = 14
      Width = 105
      Height = 20
      Style = csDropDownList
      DataField = 'sex'
      DataSource = dmPer.dsStaff
      ItemHeight = 12
      Items.Strings = (
        #30007
        #22899)
      TabOrder = 3
    end
    object deBirth: TDBDateTimeEditEh
      Left = 70
      Top = 37
      Width = 105
      Height = 20
      DataField = 'birth'
      DataSource = dmPer.dsStaff
      EditButtons = <>
      Kind = dtkDateEh
      ShowHint = True
      TabOrder = 4
      Visible = True
      OnExit = deBirthExit
    end
    object edtAge: TDBEdit
      Left = 262
      Top = 37
      Width = 51
      Height = 20
      Color = 16769762
      DataField = 'age'
      DataSource = dmPer.dsStaff
      ReadOnly = True
      TabOrder = 5
    end
    object cbFolk: TDBComboBox
      Left = 454
      Top = 37
      Width = 105
      Height = 20
      AutoComplete = False
      DataField = 'folk'
      DataSource = dmPer.dsStaff
      ItemHeight = 12
      TabOrder = 6
    end
    object cbMarriage: TDBComboBox
      Left = 70
      Top = 60
      Width = 89
      Height = 20
      AutoComplete = False
      DataField = 'marriage'
      DataSource = dmPer.dsStaff
      ItemHeight = 12
      TabOrder = 7
    end
    object cbPolitics: TDBComboBox
      Left = 262
      Top = 60
      Width = 105
      Height = 20
      AutoComplete = False
      DataField = 'politics'
      DataSource = dmPer.dsStaff
      ItemHeight = 12
      TabOrder = 8
    end
    object deInPoliDate: TDBDateTimeEditEh
      Left = 454
      Top = 60
      Width = 105
      Height = 20
      DataField = 'inPartyDate'
      DataSource = dmPer.dsStaff
      EditButtons = <>
      Kind = dtkDateEh
      ShowHint = True
      TabOrder = 9
      Visible = True
    end
    object cbCulture: TDBComboBox
      Left = 454
      Top = 83
      Width = 105
      Height = 20
      AutoComplete = False
      DataField = 'culture'
      DataSource = dmPer.dsStaff
      ItemHeight = 12
      TabOrder = 11
    end
    object cbSpecial: TDBComboBox
      Left = 262
      Top = 106
      Width = 105
      Height = 20
      AutoComplete = False
      DataField = 'special'
      DataSource = dmPer.dsStaff
      ItemHeight = 12
      TabOrder = 13
    end
    object deGraDate: TDBDateTimeEditEh
      Left = 454
      Top = 106
      Width = 105
      Height = 20
      DataField = 'graduateDate'
      DataSource = dmPer.dsStaff
      EditButtons = <>
      Kind = dtkDateEh
      ShowHint = True
      TabOrder = 14
      Visible = True
    end
    object edtNative: TDBEdit
      Left = 70
      Top = 129
      Width = 121
      Height = 20
      DataField = 'nativePlace'
      DataSource = dmPer.dsStaff
      TabOrder = 15
    end
    object edtNaAddr: TDBEdit
      Left = 262
      Top = 129
      Width = 297
      Height = 20
      DataField = 'npAddr'
      DataSource = dmPer.dsStaff
      TabOrder = 16
    end
    object deWorkDate: TDBDateTimeEditEh
      Left = 283
      Top = 83
      Width = 84
      Height = 20
      DataField = 'inWorkDate'
      DataSource = dmPer.dsStaff
      EditButtons = <>
      Kind = dtkDateEh
      ShowHint = True
      TabOrder = 10
      Visible = True
    end
    object edtFileNo: TDBEdit
      Left = 70
      Top = 152
      Width = 121
      Height = 20
      DataField = 'recordNo'
      DataSource = dmPer.dsStaff
      TabOrder = 17
    end
    object deRegDate: TDBDateTimeEditEh
      Left = 262
      Top = 152
      Width = 105
      Height = 20
      DataField = 'regDate'
      DataSource = dmPer.dsStaff
      EditButtons = <>
      Kind = dtkDateEh
      ShowHint = True
      TabOrder = 18
      Visible = True
    end
    object edtCardNo: TDBEdit
      Left = 70
      Top = 83
      Width = 121
      Height = 20
      DataField = 'idCardNo'
      DataSource = dmPer.dsStaff
      MaxLength = 18
      TabOrder = 2
      OnExit = edtCardNoExit
      OnKeyPress = edtCardNoKeyPress
    end
    object pnlPhoto: TPanel
      Left = 588
      Top = 14
      Width = 113
      Height = 135
      BevelOuter = bvLowered
      Caption = #29031#29255
      TabOrder = 20
      object imgPhoto: TImage
        Left = 1
        Top = 1
        Width = 111
        Height = 133
        Align = alClient
        Center = True
        Proportional = True
        Stretch = True
        OnDblClick = imgPhotoDblClick
      end
    end
    object edtReger: TDBEdit
      Left = 454
      Top = 152
      Width = 105
      Height = 20
      Color = 16769762
      DataField = 'reger'
      DataSource = dmPer.dsStaff
      TabOrder = 19
    end
    object btnAdd: TBitBtn
      Left = 576
      Top = 151
      Width = 41
      Height = 22
      Caption = #36873#25321
      TabOrder = 21
      OnClick = btnAddClick
    end
    object btnDel: TBitBtn
      Left = 619
      Top = 151
      Width = 41
      Height = 22
      Caption = #21024#38500
      TabOrder = 22
      OnClick = btnDelClick
    end
    object btnCap: TBitBtn
      Left = 662
      Top = 151
      Width = 51
      Height = 22
      Caption = #29031#30456
      TabOrder = 23
      OnClick = btnCapClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF00000000000000000000000000000000000000
        0000000000000000000000000000000000000000FF00FFFF00FF99A8AC99A8AC
        00808099A8AC000000D8E9ECD8E9ECD8E9EC99A8AC99A8ACFFFFFFFFFFFFD8E9
        EC000000000000FF00FF99A8ACD8E9EC00808099A8AC000000D8E9EC80800000
        0000D8E9EC808000808000000000000000000000000000FF00FF99A8ACD8E9EC
        00808099A8AC000000D8E9EC000000FFFF00D8E9EC99A8AC0000000000008080
        0080800080800099A8AC99A8ACD8E9EC00808099A8AC000000D8E9ECD8E9ECD8
        E9ECD8E9EC000000008080000000D8E9EC00FFFF99A8AC00000099A8ACD8E9EC
        00808099A8AC000000000000000000000000000000000000D8E9EC000000FFFF
        FF00FFFF00FFFF00000099A8ACD8E9EC00808099A8AC000000FFFFFFD8E9ECFF
        FFFFD8E9EC000000FFFFFF000000D8E9ECFFFFFFD8E9EC00000099A8ACD8E9EC
        00808099A8AC000000D8E9ECFFFF0099A8ACFFFFFF000000D8E9EC00000099A8
        AC99A8AC00808000000099A8ACD8E9EC99A8AC99A8AC000000FFFFFFD8E9ECFF
        FFFFD8E9ECFFFFFF00000099A8AC00000000000000000099A8AC99A8ACFFFFFF
        0080800000000000000000000000000000000000000000000000000000000000
        00000000000000FF00FFFF00FF99A8AC00000000808000808000808000808000
        000099A8ACD8E9ECD8E9ECD8E9ECD8E9EC00808099A8ACFF00FFFF00FFFF00FF
        99A8ACD8E9ECFFFFFFFFFFFFD8E9EC00000099A8ACD8E9ECD8E9ECD8E9EC0000
        0099A8ACFF00FFFF00FFFF00FFFF00FFFF00FF00808000808000808000000000
        808000808000808000808000808099A8ACFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    end
  end
  object gbDept: TGroupBox
    Left = 8
    Top = 217
    Width = 721
    Height = 89
    Caption = #21333#20301#20449#24687
    TabOrder = 2
    object Label21: TLabel
      Left = 32
      Top = 18
      Width = 36
      Height = 12
      Caption = #37096#38376#65306
      FocusControl = cbDept
    end
    object Label22: TLabel
      Left = 224
      Top = 18
      Width = 36
      Height = 12
      Caption = #32844#21153#65306
      FocusControl = cbDuty
    end
    object Label23: TLabel
      Left = 399
      Top = 18
      Width = 36
      Height = 12
      Caption = #24037#31181#65306
      FocusControl = cbType
    end
    object Label24: TLabel
      Left = 575
      Top = 18
      Width = 36
      Height = 12
      Caption = #32844#31216#65306
      FocusControl = cbTechnic
    end
    object Label25: TLabel
      Left = 8
      Top = 41
      Width = 60
      Height = 12
      Caption = #20837#32844#26085#26399#65306
      FocusControl = deDeptDate
    end
    object Label26: TLabel
      Left = 200
      Top = 41
      Width = 60
      Height = 12
      Caption = #36716#27491#26085#26399#65306
      FocusControl = deDWDate
    end
    object Label27: TLabel
      Left = 375
      Top = 41
      Width = 60
      Height = 12
      Caption = #31163#32844#26085#26399#65306
      FocusControl = deLeftDate
    end
    object Label28: TLabel
      Left = 551
      Top = 41
      Width = 60
      Height = 12
      Caption = #21457#21345#38134#34892#65306
      FocusControl = cbBank
    end
    object Label29: TLabel
      Left = 8
      Top = 64
      Width = 60
      Height = 12
      Caption = #24037#36164#24080#21495#65306
      FocusControl = edtSalaryNo
    end
    object Label30: TLabel
      Left = 231
      Top = 64
      Width = 84
      Height = 12
      Caption = #20859#32769#20445#38505#24080#21495#65306
      FocusControl = edtOldNo
    end
    object Label31: TLabel
      Left = 479
      Top = 64
      Width = 84
      Height = 12
      Caption = #21307#30103#20445#38505#24080#21495#65306
      FocusControl = edtMedNo
    end
    object cbDept: TDBComboBox
      Left = 70
      Top = 14
      Width = 145
      Height = 20
      AutoComplete = False
      DataField = 'deptName'
      DataSource = dmPer.dsStaff
      ItemHeight = 12
      TabOrder = 0
    end
    object deDeptDate: TDBDateTimeEditEh
      Left = 70
      Top = 37
      Width = 97
      Height = 20
      DataField = 'inDutyDate'
      DataSource = dmPer.dsStaff
      EditButtons = <>
      Kind = dtkDateEh
      ShowHint = True
      TabOrder = 4
      Visible = True
    end
    object cbDuty: TDBComboBox
      Left = 262
      Top = 14
      Width = 97
      Height = 20
      AutoComplete = False
      DataField = 'duty'
      DataSource = dmPer.dsStaff
      ItemHeight = 12
      TabOrder = 1
    end
    object cbTechnic: TDBComboBox
      Left = 613
      Top = 14
      Width = 97
      Height = 20
      AutoComplete = False
      DataField = 'technic'
      DataSource = dmPer.dsStaff
      ItemHeight = 12
      TabOrder = 3
    end
    object cbType: TDBComboBox
      Left = 437
      Top = 14
      Width = 97
      Height = 20
      AutoComplete = False
      DataField = 'workKind'
      DataSource = dmPer.dsStaff
      ItemHeight = 12
      TabOrder = 2
    end
    object edtSalaryNo: TDBEdit
      Left = 70
      Top = 60
      Width = 145
      Height = 20
      DataField = 'payNo'
      DataSource = dmPer.dsStaff
      TabOrder = 8
    end
    object edtOldNo: TDBEdit
      Left = 317
      Top = 60
      Width = 145
      Height = 20
      DataField = 'annuityNo'
      DataSource = dmPer.dsStaff
      TabOrder = 9
    end
    object edtMedNo: TDBEdit
      Left = 565
      Top = 60
      Width = 145
      Height = 20
      DataField = 'medicareNo'
      DataSource = dmPer.dsStaff
      TabOrder = 10
    end
    object deDWDate: TDBDateTimeEditEh
      Left = 262
      Top = 37
      Width = 97
      Height = 20
      DataField = 'toStaffDate'
      DataSource = dmPer.dsStaff
      EditButtons = <>
      Kind = dtkDateEh
      ShowHint = True
      TabOrder = 5
      Visible = True
    end
    object cbBank: TDBComboBox
      Left = 613
      Top = 37
      Width = 97
      Height = 20
      AutoComplete = False
      DataField = 'bankName'
      DataSource = dmPer.dsStaff
      ItemHeight = 12
      TabOrder = 7
    end
    object deLeftDate: TDBDateTimeEditEh
      Left = 437
      Top = 37
      Width = 97
      Height = 20
      Color = 16769762
      DataField = 'leftDate'
      DataSource = dmPer.dsStaff
      EditButtons = <>
      Kind = dtkDateEh
      ReadOnly = True
      ShowHint = True
      TabOrder = 6
      Visible = True
    end
  end
  object gbContact: TGroupBox
    Left = 8
    Top = 310
    Width = 721
    Height = 66
    Caption = #32852#31995#26041#27861
    TabOrder = 3
    object Label32: TLabel
      Left = 32
      Top = 18
      Width = 36
      Height = 12
      Caption = #25163#26426#65306
      FocusControl = edtMobile
    end
    object Label33: TLabel
      Left = 224
      Top = 18
      Width = 36
      Height = 12
      Caption = #30005#35805#65306
      FocusControl = edtTel
    end
    object Label34: TLabel
      Left = 387
      Top = 18
      Width = 48
      Height = 12
      Caption = 'E-Mail'#65306
      FocusControl = edtMail
    end
    object Label35: TLabel
      Left = 562
      Top = 18
      Width = 48
      Height = 12
      Caption = #23567#28789#36890#65306
      FocusControl = edtCityTel
    end
    object Label36: TLabel
      Left = 8
      Top = 41
      Width = 60
      Height = 12
      Caption = #36890#20449#22320#22336#65306
      FocusControl = edtAddr
    end
    object Label37: TLabel
      Left = 399
      Top = 41
      Width = 36
      Height = 12
      Caption = #37038#32534#65306
      FocusControl = edtPostCode
    end
    object Label38: TLabel
      Left = 574
      Top = 41
      Width = 36
      Height = 12
      Caption = 'QQ'#21495#65306
      FocusControl = edtQQCode
    end
    object edtMobile: TDBEdit
      Left = 70
      Top = 14
      Width = 121
      Height = 20
      DataField = 'mobile'
      DataSource = dmPer.dsStaff
      TabOrder = 0
    end
    object edtPostCode: TDBEdit
      Left = 437
      Top = 37
      Width = 121
      Height = 20
      DataField = 'postCode'
      DataSource = dmPer.dsStaff
      TabOrder = 5
    end
    object edtTel: TDBEdit
      Left = 262
      Top = 14
      Width = 121
      Height = 20
      DataField = 'tel'
      DataSource = dmPer.dsStaff
      TabOrder = 1
    end
    object edtMail: TDBEdit
      Left = 437
      Top = 14
      Width = 121
      Height = 20
      DataField = 'email'
      DataSource = dmPer.dsStaff
      TabOrder = 2
    end
    object edtCityTel: TDBEdit
      Left = 613
      Top = 14
      Width = 97
      Height = 20
      DataField = 'cityTel'
      DataSource = dmPer.dsStaff
      TabOrder = 3
    end
    object edtAddr: TDBEdit
      Left = 70
      Top = 37
      Width = 313
      Height = 20
      DataField = 'postAddr'
      DataSource = dmPer.dsStaff
      TabOrder = 4
    end
    object edtQQCode: TDBEdit
      Left = 613
      Top = 37
      Width = 97
      Height = 20
      DataField = 'qqCode'
      DataSource = dmPer.dsStaff
      TabOrder = 6
    end
  end
  object gbOther: TGroupBox
    Left = 8
    Top = 380
    Width = 721
    Height = 155
    Caption = #38468#21152#20449#24687
    TabOrder = 4
    object pcOther: TPageControl
      Left = 2
      Top = 14
      Width = 717
      Height = 139
      ActivePage = tsMove
      Align = alClient
      TabOrder = 0
      object tsSelf: TTabSheet
        Caption = #20010#20154#31616#21382
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object meoSelf: TDBMemo
          Left = 0
          Top = 0
          Width = 709
          Height = 112
          Align = alClient
          DataField = 'selfBio'
          DataSource = dmPer.dsStaff
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
      object tsFami: TTabSheet
        Caption = #23478#24237#25104#21592'&&'#31038#20250#20851#31995
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object meoFami: TDBMemo
          Left = 0
          Top = 0
          Width = 709
          Height = 90
          Align = alClient
          DataField = 'family'
          DataSource = dmPer.dsStaff
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
      object tsExper: TTabSheet
        Caption = #24037#20316#32463#21382
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object meoExper: TDBMemo
          Left = 0
          Top = 0
          Width = 709
          Height = 112
          Align = alClient
          DataField = 'workExper'
          DataSource = dmPer.dsStaff
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
      object tsAandP: TTabSheet
        Caption = #22870#24809#35760#24405
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object dgAP: TDBGridEh
          Left = 0
          Top = 0
          Width = 709
          Height = 112
          Hint = #24744#21487#20197#22312#33756#21333'['#26723#26696#31649#29702']->['#22870#24809#35760#24405']'#20013#28155#21152#21592#24037#30340#22870#24809#35760#24405
          Align = alClient
          ColumnDefValues.Title.TitleButton = True
          DataSource = dsAP
          Flat = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          FooterColor = clWindow
          FooterFont.Charset = ANSI_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -12
          FooterFont.Name = #23435#20307
          FooterFont.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = #23435#20307
          TitleFont.Style = []
          OnTitleBtnClick = dgAPTitleBtnClick
          Columns = <
            item
              EditButtons = <>
              FieldName = 'apDate'
              Footers = <>
              Title.Caption = #26085#26399
              Width = 72
            end
            item
              EditButtons = <>
              FieldName = 'apType'
              Footers = <>
              Title.Caption = #31867#21035
              Width = 50
            end
            item
              EditButtons = <>
              FieldName = 'reason'
              Footers = <>
              Title.Caption = #21407#22240
              Width = 175
            end
            item
              EditButtons = <>
              FieldName = 'result'
              Footers = <>
              Title.Caption = #32467#26524
              Width = 175
            end
            item
              EditButtons = <>
              FieldName = 'operDept'
              Footers = <>
              Title.Caption = #22788#29702#37096#38376
              Width = 95
            end
            item
              EditButtons = <>
              FieldName = 'des'
              Footers = <>
              Title.Caption = #22791#27880
              Width = 104
            end>
        end
      end
      object tsTrain: TTabSheet
        Caption = #22521#35757#35760#24405
        ImageIndex = 4
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object dgTrain: TDBGridEh
          Left = 0
          Top = 0
          Width = 709
          Height = 112
          Hint = #24744#21487#20197#22312#33756#21333'['#26723#26696#31649#29702']->['#22521#35757#35760#24405']'#20013#28155#21152#21592#24037#30340#22521#35757#35760#24405
          Align = alClient
          ColumnDefValues.Title.TitleButton = True
          DataSource = dsTrain
          Flat = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          FooterColor = clWindow
          FooterFont.Charset = ANSI_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -12
          FooterFont.Name = #23435#20307
          FooterFont.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = #23435#20307
          TitleFont.Style = []
          OnTitleBtnClick = dgTrainTitleBtnClick
          Columns = <
            item
              EditButtons = <>
              FieldName = 'trName'
              Footers = <>
              Title.Caption = #22521#35757#21517#31216
              Width = 145
            end
            item
              EditButtons = <>
              FieldName = 'trDate'
              Footers = <>
              Title.Caption = #22521#35757#26085#26399
              Width = 72
            end
            item
              EditButtons = <>
              FieldName = 'trSite'
              Footers = <>
              Title.Caption = #22521#35757#22320#28857
              Width = 72
            end
            item
              EditButtons = <>
              FieldName = 'trainer'
              Footers = <>
              Title.Caption = #35762#24072
              Width = 60
            end
            item
              EditButtons = <>
              FieldName = 'content'
              Footers = <>
              Title.Caption = #22521#35757#20869#23481
              Width = 197
            end
            item
              EditButtons = <>
              FieldName = 'des'
              Footers = <>
              Title.Caption = #22791#27880
              Width = 125
            end>
        end
      end
      object tsMove: TTabSheet
        Caption = #35843#21160#35760#24405
        ImageIndex = 6
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object dgMove: TDBGridEh
          Left = 0
          Top = 0
          Width = 709
          Height = 112
          Hint = #24744#21487#20197#22312#33756#21333'['#20154#20107#21464#21160']->['#35843#21160']'#20013#28155#21152#21592#24037#30340#35843#21160#20449#24687
          Align = alClient
          ColumnDefValues.Title.TitleButton = True
          DataSource = dsMove
          Flat = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          FooterColor = clWindow
          FooterFont.Charset = ANSI_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -12
          FooterFont.Name = #23435#20307
          FooterFont.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = #23435#20307
          TitleFont.Style = []
          OnTitleBtnClick = dgTrainTitleBtnClick
          Columns = <
            item
              EditButtons = <>
              FieldName = 'moveDate'
              Footers = <>
              Title.Caption = #35843#21160#26085#26399
              Width = 62
            end
            item
              EditButtons = <>
              FieldName = 'oldDept'
              Footers = <>
              Title.Caption = #21407#37096#38376
              Width = 90
            end
            item
              EditButtons = <>
              FieldName = 'oldDuty'
              Footers = <>
              Title.Caption = #21407#32844#21153
              Width = 73
            end
            item
              EditButtons = <>
              FieldName = 'oldKind'
              Footers = <>
              Title.Caption = #21407#24037#31181
              Width = 70
            end
            item
              EditButtons = <>
              FieldName = 'oldTech'
              Footers = <>
              Title.Caption = #21407#32844#31216
              Width = 70
            end
            item
              EditButtons = <>
              FieldName = 'newDept'
              Footers = <>
              Title.Caption = #26032#37096#38376
              Width = 90
            end
            item
              EditButtons = <>
              FieldName = 'newDuty'
              Footers = <>
              Title.Caption = #26032#32844#21153
              Width = 73
            end
            item
              EditButtons = <>
              FieldName = 'newKind'
              Footers = <>
              Title.Caption = #26032#24037#31181
              Width = 70
            end
            item
              EditButtons = <>
              FieldName = 'newTech'
              Footers = <>
              Title.Caption = #26032#32844#31216
              Width = 70
            end>
        end
      end
      object tsOther: TTabSheet
        Caption = #20854#23427#20449#24687
        ImageIndex = 5
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object meoOther: TDBMemo
          Left = 0
          Top = 0
          Width = 709
          Height = 112
          Align = alClient
          DataField = 'others'
          DataSource = dmPer.dsStaff
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
  end
  object ilStaff: TImageList
    Left = 648
    Top = 48
    Bitmap = {
      494C01010A000E00080010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
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
      00000000000000000000000000000000000000000000000000004D4D4D004D4D
      4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF0000000000000000000000000000000000000000004D4D4D00D3D3D300D3D3
      D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D3004D4D
      4D00D3D3D3004D4D4D0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF0000000000000000000000
      00000000FF000000FF0000000000000000004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D00D3D3D3004D4D4D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005F535100B69C9700C2AA
      A700D0BBB900DAC9C700D9CBC9000000FF000000FF00B59A960087534F000000
      0000000000000000FF0000000000000000004D4D4D00D3D3D300D3D3D300D3D3
      D300D3D3D300D3D3D300D3D3D3004DFFFF004DFFFF004DFFFF00D3D3D300D3D3
      D3004D4D4D004D4D4D004D4D4D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000996D6800AA8E8900B59A
      9600C2ACA800CDBAB7000000FF00D9CBC900D5C4C2000000FF00996D68000000
      000000000000000000000000FF00000000004D4D4D00D3D3D300D3D3D300D3D3
      D300D3D3D300D3D3D300D3D3D300A6A6A600A6A6A600A6A6A600D3D3D300D3D3
      D3004D4D4D00D3D3D3004D4D4D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000038302E00AA8E
      8900D3C3BF00F3EFEE000000FF00D9CBC900C2ACA800B98A89000000FF000000
      000000000000000000000000FF00000000004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D00D3D3D300D3D3D3004D4D4D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000046759C0093CBFF000000FF00000000000000000000000000000000000000
      FF0000000000000000000000FF00000000004D4D4D00D3D3D300D3D3D300D3D3
      D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D3004D4D
      4D00D3D3D3004D4D4D00D3D3D3004D4D4D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001925
      30009DD1FF0085C6FF0086C7FF000000FF000000000000000000000000000000
      00000000FF000000FF000000000000000000000000004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D00D3D3
      D3004D4D4D00D3D3D3004D4D4D004D4D4D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003656
      730092CEFF009FD4FF00ABDAFF000000FF000000FF0000000000000000000000
      00000000FF000000FF00000000000000000000000000000000004D4D4D00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004D4D
      4D00D3D3D3004D4D4D00D3D3D3004D4D4D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000B50
      7D00B0DEFF00BBE2FF00B8DBF5005082A60007436A000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000004D4D
      4D00FFFFFF004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D00FFFFFF004D4D
      4D004D4D4D004D4D4D004D4D4D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000962
      9400C9E9FF006896B6000C4D7800226691002975A10000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004D4D
      4D00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF004D4D4D000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000773
      AB0014517C000B558200116393003C88B200032B3F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004D4D4D00FFFFFF004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D00FFFF
      FF004D4D4D000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000A5D8D0009679A002A85B40020729A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004D4D4D00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF004D4D4D0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D0000000000000000000000000000000000000000000000
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
      9900000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      99009999990099999900999999000000000000000000000000003333CC000000
      FF00000099000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005F535100B69C9700C2AA
      A700D0BBB900DAC9C700D9CBC900D0BBB900C2AAA700B59A960087534F000000
      0000000000000000000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000D8E9EC00D8E9
      EC00000000000080800000000000000000000000000099999900CCCCCC00CCCC
      CC00999999009999990099999900999999009999990099999900E5E5E500E5E5
      E50099999900CCCCCC00999999000000000000000000000000003333CC003399
      FF000000FF000000990000000000000000000000000000000000000000000000
      0000000000000000FF00000000000000000000000000996D6800AA8E8900B59A
      9600C2ACA800CDBAB700D5C4C200D9CBC900D5C4C200CDBAB700996D68000000
      0000000000000000000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000D8E9EC00D8E9
      EC00000000000080800000000000000000000000000099999900CCCCCC00CCCC
      CC00999999009999990099999900999999009999990099999900E5E5E500E5E5
      E50099999900CCCCCC0099999900000000000000000000000000000000003333
      CC000066FF000000CC0000000000000000000000000000000000000000000000
      00000000FF00000000000000000000000000000000000000000038302E008753
      4F00C2ACA800DAC9C700FFFFFF00D9CBC900C2ACA800B98A8900D9CBC900D0BB
      B900C2AAA700B59A960087534F00000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000D8E9EC00D8E9
      EC00000000000080800000000000000000000000000099999900CCCCCC00CCCC
      CC00999999009999990099999900999999009999990099999900E5E5E500E5E5
      E50099999900CCCCCC0099999900000000000000000000000000000000000000
      00000000CC000000FF0000009900000000000000000000000000000000000000
      FF00000099000000000000000000000000000000000000000000000000000000
      000046759C0093CBFF007EBBED0000000000C2ACA800CDBAB700D5C4C200D9CB
      C900D5C4C200CDBAB700996D6800000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000000000000000000000000099999900CCCCCC00CCCC
      CC00999999009999990099999900999999009999990099999900999999009999
      990099999900CCCCCC0099999900000000000000000000000000000000000000
      0000000000000000CC000000FF000000990000000000000000000000FF000000
      9900000000000000000000000000000000000000000000000000000000001925
      30009DD1FF0085C6FF0086C7FF00628CB20000000000DAC9C700FFFFFF00D9CB
      C900C2ACA800B98A890000000000000000000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000080
      8000008080000080800000000000000000000000000099999900CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC0099999900000000000000000000000000000000000000
      000000000000000000000000CC000000FF00000099000000FF00000099000000
      0000000000000000000000000000000000000000000000000000000000003656
      730092CEFF009FD4FF00ABDAFF0090CAF6000000000093CBFF007EBBED000000
      0000000000000000000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      0000008080000080800000000000000000000000000099999900CCCCCC00CCCC
      CC00999999009999990099999900999999009999990099999900999999009999
      9900CCCCCC00CCCCCC0099999900000000000000000000000000000000000000
      00000000000000000000000000000000CC000000FF0000009900000000000000
      0000000000000000000000000000000000000000000000000000000000000B50
      7D00B0DEFF00BBE2FF00B8DBF5005082A60007436A0085C6FF0086C7FF00628C
      B200000000000000000000000000000000000000000000000000008080000000
      0000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
      EC00000000000080800000000000000000000000000099999900CCCCCC009999
      9900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0099999900CCCCCC0099999900000000000000000000000000000000000000
      000000000000000000000000CC000000FF00000099000000CC00000099000000
      0000000000000000000000000000000000000000000000000000000000000962
      9400C9E9FF006896B6000C4D7800226691002975A1009FD4FF00ABDAFF0090CA
      F600000000000000000000000000000000000000000000000000008080000000
      0000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
      EC00000000000080800000000000000000000000000099999900CCCCCC009999
      9900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0099999900CCCCCC0099999900000000000000000000000000000000000000
      0000000000000000CC000000FF000000990000000000000000000000CC000000
      9900000000000000000000000000000000000000000000000000000000000773
      AB0014517C000B558200116393003C88B200032B3F00BBE2FF00B8DBF5005082
      A60007436A000000000000000000000000000000000000000000008080000000
      0000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
      EC00000000000080800000000000000000000000000099999900CCCCCC009999
      9900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0099999900CCCCCC0099999900000000000000000000000000000000000000
      CC000000FF000000FF0000009900000000000000000000000000000000000000
      CC00000099000000000000000000000000000000000000000000000000000000
      00000A5D8D0009679A002A85B40020729A00C9E9FF006896B6000C4D78002266
      91002975A1000000000000000000000000000000000000000000008080000000
      0000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
      EC00000000000080800000000000000000000000000099999900CCCCCC009999
      9900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0099999900CCCCCC00999999000000000000000000000000000000CC003399
      FF000000FF000000990000000000000000000000000000000000000000000000
      00000000CC000000990000000000000000000000000000000000000000000000
      00000000000000000000000000000773AB0014517C000B558200116393003C88
      B200032B3F000000000000000000000000000000000000000000008080000000
      0000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
      EC00000000000000000000000000000000000000000099999900CCCCCC009999
      9900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00999999009999990099999900000000000000000000000000666699000000
      CC00666699000000000000000000000000000000000000000000000000000000
      000000000000000000000000CC00000000000000000000000000000000000000
      0000000000000000000000000000000000000A5D8D0009679A002A85B4002072
      9A00000000000000000000000000000000000000000000000000008080000000
      0000D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
      EC0000000000D8E9EC0000000000000000000000000099999900CCCCCC009999
      9900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0099999900E5E5E50099999900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099999900999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      9900999999009999990099999900000000000000000000000000000000000000
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
      000095BB98002E7B3200036A0A0003650800015F05001E622200698C6B000000
      0000000000000000000000000000000000000000000000000000000000000000
      000094BB98002E7B3200036A0A0003650800015F05001E622200688C6B000000
      000000000000000000000000000000000000000000005F535100B69C9700C2AA
      A700D0BBB900DAC9C700D9CBC900D0BBB900C2AAA700B59A960087534F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C2D9C5002F89
      34000D98230012B630000EB426000AB21D0007B0170002AE0C00019108000F65
      140095AE98000000000000000000000000000000000000000000C0D8C5002F89
      34000D98230012B630000EB426000AB21D0007B0170002AE0C00019108000F65
      140094AE980000000000000000000000000000000000996D6800AA8E8900B59A
      9600C2ACA800CDBAB700D5C4C200D9CBC900D5C4C200CDBAB700996D68000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D1E3D300168B23001DB6
      46001CBA450018B83B0013B631003DC353001BB72E0009B21C0005AF120001AD
      0A000168060095AF9800000000000000000000000000CFE2D300168B23001DB6
      46001CBA450018B83B005ECD73007AD588000CB3220009B21C0005AF120001AD
      0A000168060094AE98000000000000000000000000000000000038302E008753
      4F00D3C3BF00F3EFEE00FFFFFF00B98A8900D3C3BF00B98A8900FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003FA1450024B7540025BE
      590022BD52001DBA460070D38800FFFFFF00B5E8BE000FB427000BB21E0008B1
      190003AE0E000F6914000000000000000000000000003FA1450024B7540025BE
      590022BD52001DBA4600D4F2DC00FFFFFF00A6E4B1000FB427000BB21E0008B1
      190003AE0E000F69140000000000000000000000000000000000000000000000
      000046759C0093CBFF007EBBED0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000005F535100B69C9700C2AA
      A700D0BBB900DAC9C700D9CBC900D0BBB900C2ACA8000000000000FFFF00C0C0
      C00000000000000000000000000000000000B3D9B60018A438002FC26C002DC1
      670026BF5B0077D69500FFFFFF00FFFFFF009AE0AB0014B6320012B62F000CB3
      22000AB21D00069713005A885C0000000000B2D8B60018A438002FC26C002DC1
      670026BF5B001DBB480076D69400FFFFFF00FFFFFF00A6E4B10012B62F000CB3
      22000AB21D000697130059885C00000000000000000000000000000000001925
      30009DD1FF0085C6FF0086C7FF00628CB20000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000996D6800AA8E8900B59A
      9600C2ACA800CDBAB700D5C4C200D9CBC900D5C4C200000000000000000000FF
      FF000000000000000000000000000000000069BB6B0029BB5F002FC26C002FC2
      6C007DD9A100FFFFFF00FFFFFF00ACE6BF001DBB48001BBA440016B8390013B6
      310010B52B000BB21E00207926000000000068BB6B0029BB5F002FC26C002FC2
      6C001DBB48001DBB480026BE5A0077D69700FFFFFF00FFFFFF00A6E4B10015B7
      350010B52B000BB21E0020792600000000000000000000000000000000003656
      730092CEFF009FD4FF00ABDAFF0090CAF60000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000038302E00AA8E
      8900D3C3BF00F3EFEE00FFFFFF00D3C3BF00AA8E8900000000000000000000FF
      FF00000000000000000000000000000000003DAE3E002FC26C002FC26C007DD9
      A300FFFFFF00FFFFFF00F1FBF50092DFAC0092DFAC008EDDA3008DDDA2008BDC
      9D0015B7350012B6300006781100000000003CAE3E002FC26C0063D19000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A8E5
      B60015B7350012B6300006781100000000000000000000000000000000000B50
      7D00B0DEFF00BBE2FF00B8DBF5005082A60007436A00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000046759C0093CBFF007EBBED00000000000000000000000000000000000000
      0000808080000000000000000000000000003DB43E002FC26C0049CA7F00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF001CBA450018B83B000B8D1C00000000003CB43E002FC26C0063D19000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D5F3
      DE001CBA450018B83B000B8D1C00000000000000000000000000000000000962
      9400C9E9FF006896B6000C4D7800226691002975A100FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000001925
      30009DD1FF0085C6FF0086C7FF00628CB2000000000000000000000000000000
      0000000080000000800000000000000000003DB73E0034C36F002FC26C007DD9
      A300FFFFFF00FFFFFF00FFFFFF00A4E4BE0097E1B50097E1B50095E0B10092DF
      AC0022BD52001DBA460008801400000000003CB73E0034C36F002FC26C002FC2
      6C002FC26C002FC26C002FC26C0089DDAC00FFFFFF00FFFFFF00D7F3E2002FC2
      6C0022BD52001DBA460008801400000000000000000000000000000000000773
      AB0014517C000B558200116393003C88B200032B3F00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000003656
      730092CEFF009FD4FF00ABDAFF0090CAF6000000000000000000000000000000
      00000000000000000000000000000000000079D0780045C6660040C777002FC2
      6C007DD9A300FFFFFF00FFFFFF00D8F4E3003CC675002FC26C002FC26C002DC1
      670026BF5B0024BE5800319439000000000077D0780045C6660040C777002FC2
      6C002FC26C002FC26C0056CD8700F2FBF600FFFFFF00D8F4E3002FC26C002DC1
      670026BF5B0024BE580030943900000000000000000000000000000000000319
      28000A5D8D0009679A002A85B40020729A00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000B50
      7D00B0DEFF00BBE2FF00B8DBF5005082A60007436A0000000000000000000000
      000000000000000000000000000000000000D4EBD30032BE3D0073D5950053CC
      820036C471007DD9A300FFFFFF00FFFFFF00A4E4BE002FC26C002FC26C002FC2
      6C002EC26B001BA73F0088BE890000000000D2EAD30032BE3D0073D5950053CC
      820036C471002FC26C00BEECD100FFFFFF00D8F4E3002FC26C002FC26C002FC2
      6C002EC26B001BA73F0087BE8900000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000962
      9400C9E9FF006896B6000C4D7800226691002975A10000000000000000000000
      000000000000000000000000000000000000000000006AD16A0076D6830082DA
      A00067D28E0045C87A0080DAA400F2FBF60089DDAC002FC26C002FC26C002FC2
      6C002CBF6500229528000000000000000000000000006AD06A0076D6830082DA
      A00067D28E002FC26C002FC26C0097E1B5002FC26C002FC26C002FC26C002FC2
      6C002CBF65002195280000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000773
      AB0014517C000B558200116393003C88B200032B3F0000000000000000000000
      00000000000000000000000000000000000000000000E2F0E2003AC63B0078D7
      810098E0AD0077D798005BCE86003BC574002FC26C002FC26C002FC26C0029BD
      5F00189E2500C4DFC400000000000000000000000000E2EFE2003AC63B0078D7
      810098E0AD0077D798005BCE86003BC574002FC26C002FC26C002FC26C0029BD
      5F00179E2500C3DFC40000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000A5D8D0009679A002A85B40020729A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E2F0E2006AD1
      6A0048CB4A0084DA91008CDCA6006BD391004FCB80002EBF620018B1370040B1
      4400C4E1C4000000000000000000000000000000000000000000E2EFE20069D1
      6A0048CB4A0084DA91008CDCA6006BD391004FCB80002EBF620018B137003FB1
      4400C3E1C4000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D4ECD30079D578003DC53D003DBF3D003DBE3D006AC86B00B6E0B6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D3ECD30078D578003DC53D003DBF3D003DBE3D006AC86B00B5E0B5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFC00700000000
      FF8F800300000000FE73000100000000801B000100000000801D000100000000
      C01D000000000000F0ED000000000000E0F3800000000000E073C00000000000
      E00FE00100000000E07FE00700000000E07FF00700000000F0FFF00300000000
      FFFFF80300000000FFFFFFFF00000000FFFFFFFFFFFFFFFFEFFDFFFFC001C001
      C7FF801F80018001C3FB801F80018001E3F7C00180018001F1E7F00180018001
      F8CFE00380018001FC1FE00F80018001FE3FE00780018001FC1FE00780018001
      F8CFE00780018001E1E7F00780018001C3F3FE0780018001C7FDFF0F80018001
      FFFFFFFF80018001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF01FF01F801FEABF
      C007C0078003FF9F80038003C003FF8F80038003F003800F00010001E0038007
      00010001E003C04700010001E003F0C300010001E003E06100010001E003E073
      00010001E003E07F00010001E003E07F80038003E007E07F80038003E00FF0FF
      C007C007E01FFFFFF01FF01FFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object alStaff: TActionList
    Images = ilStaff
    OnExecute = alStaffExecute
    Left = 680
    Top = 48
    object actPrev: TAction
      Category = 'Staff'
      Caption = #19978#19968#20010
      ImageIndex = 0
      OnExecute = actPrevExecute
    end
    object actNext: TAction
      Category = 'Staff'
      Caption = #19979#19968#20010
      ImageIndex = 1
      OnExecute = actNextExecute
    end
    object actAdd: TAction
      Category = 'Staff'
      Caption = #28155#21152
      Hint = #28155#21152#19968#26465#35760#24405
      ImageIndex = 2
      ShortCut = 16449
      OnExecute = actAddExecute
    end
    object actEdit: TAction
      Category = 'Staff'
      Caption = #32534#36753
      Hint = #26356#26032#24403#21069#35760#24405
      ImageIndex = 3
      ShortCut = 16453
      OnExecute = actEditExecute
    end
    object actDel: TAction
      Category = 'Staff'
      Caption = #21024#38500
      Hint = #21024#38500#36873#23450#35760#24405'('#25353'Ctrl'#38190#21487#23454#29616#22810#36873')'
      ImageIndex = 4
      ShortCut = 46
      OnExecute = actDelExecute
    end
    object actDulAdd: TAction
      Category = 'Staff'
      Caption = #22797#21046#28155#21152
      ImageIndex = 5
      ShortCut = 16452
      OnExecute = actDulAddExecute
    end
    object actSave: TAction
      Category = 'Staff'
      Caption = #20445#23384
      Hint = #20445#23384#26356#26032
      ImageIndex = 6
      ShortCut = 16467
      OnExecute = actSaveExecute
    end
    object actCancel: TAction
      Category = 'Staff'
      Caption = #21462#28040
      ImageIndex = 8
      OnExecute = actCancelExecute
    end
    object actPrint: TAction
      Category = 'Staff'
      Caption = #25171#21360
      Hint = #25171#21360#24403#21069#21592#24037
      ImageIndex = 9
      ShortCut = 16464
      OnExecute = actPrintExecute
    end
    object actHelp: TAction
      Category = 'Staff'
      Caption = #24110#21161
      ShortCut = 112
      OnExecute = actHelpExecute
    end
  end
  object odImg: TOpenPictureDialog
    Left = 676
    Top = 150
  end
  object aqAP: TADOQuery
    Connection = dmPer.acPer
    CursorType = ctStatic
    DataSource = dmPer.dsStaff
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM [ap] WHERE staffID=id')
    Left = 536
    Top = 368
  end
  object aqTrain: TADOQuery
    Connection = dmPer.acPer
    CursorType = ctStatic
    DataSource = dmPer.dsStaff
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM [train] WHERE staffId=id')
    Left = 576
    Top = 368
  end
  object dsAP: TDataSource
    DataSet = aqAP
    Left = 536
    Top = 400
  end
  object dsTrain: TDataSource
    DataSet = aqTrain
    Left = 576
    Top = 400
  end
  object aqMove: TADOQuery
    Connection = dmPer.acPer
    CursorType = ctStatic
    DataSource = dmPer.dsStaff
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM [move] WHERE staffId=id')
    Left = 616
    Top = 368
  end
  object dsMove: TDataSource
    DataSet = aqMove
    Left = 616
    Top = 400
  end
end
