object frmMain: TfrmMain
  Left = 302
  Top = 238
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #31179#39118#20154#20107#26723#26696#31649#29702#31995#32479#27880#20876#26426
  ClientHeight = 136
  ClientWidth = 292
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShortCut = FormShortCut
  DesignSize = (
    292
    136)
  PixelsPerInch = 96
  TextHeight = 11
  object bvl: TBevel
    Left = 0
    Top = 100
    Width = 292
    Height = 1
    Anchors = [akLeft, akRight, akBottom]
    Shape = bsTopLine
  end
  object Label1: TLabel
    Left = 12
    Top = 52
    Width = 48
    Height = 12
    Caption = #37038'  '#20214#65306
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 12
    Top = 76
    Width = 48
    Height = 12
    Caption = #27880#20876#30721#65306
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 62
    Top = 16
    Width = 216
    Height = 12
    Caption = #35831#36755#20837'E-Mail'#20197#29983#25104#31179#39118#35797#39064#22823#24072#27880#20876#30721
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object imgReg: TImage
    Left = 12
    Top = 8
    Width = 32
    Height = 32
    AutoSize = True
    Picture.Data = {
      055449636F6E0000010001002020100001000400E80200001600000028000000
      2000000040000000010004000000000000020000000000000000000000000000
      0000000000000000000080000080000000808000800000008000800080800000
      C0C0C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
      FFFFFF0000000000000000000000000000000000000000000000077000000000
      00000000000000000000F7870000000000000000000000077008078700000000
      0000000000000887770087870000000000000000000008F7878F778700000000
      00008000000008F78708F787000000000008B330000000078700078700000000
      0800BB80000000878700878700000000833BB80000008F77878F778700000000
      8BBB8030000008F7878F7787000000800BB80300000000078708F78700000833
      BB803000000000878708F78800008BBBB803000000008F77878F77F800008BBB
      8030000000008F7788F77F778000BBB803000000000008F78F77F000000BBB80
      30000000000008F8F7700888888BB8030000000000008F8F77088BBBBBBB8030
      000000000008F78F708BBBBBBBB7B30000000000008F778F70BBBB7B7B7B7300
      0000000008F77F8F0BBBB0B0B7B7B300000000008F77F78F8BBBBB0B0B7B7300
      000000008F777F788BBBBBB0B0B7B300000000008F77F7008BBB880B0B0B7300
      000000008F77708F8BB00770B0B73000000000008F77F0878BB00070BBB73000
      0000000008F7708808B00800BB73000000000000008F77000788000BB3300000
      000000000008FFF0878077773000000000000000000088808880888800000000
      0000000000000000800080000000000000000000000000000000000000000000
      00000000FFF9FFFFFFF0FFFFFE607FFFFC007FFFF8007FFFF8007FF1F8007FE0
      FC107F80F8007F00F0007F00F8007C01FC007803F8007007F000700FF000201F
      F800003FF800007FF00000FFE00001FFC00001FF800001FF000001FF000001FF
      000001FF000803FF000403FF800207FFC0000FFFE0001FFFF0107FFFFE73FFFF
      FF07FFFF}
  end
  object btnOK: TBitBtn
    Left = 123
    Top = 108
    Width = 75
    Height = 22
    Cursor = crHandPoint
    Anchors = [akRight, akBottom]
    Caption = #29983#25104
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    Left = 204
    Top = 108
    Width = 75
    Height = 22
    Cursor = crHandPoint
    Anchors = [akRight, akBottom]
    Caption = #21462#28040
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = btnCancelClick
    NumGlyphs = 2
  end
  object edtMail: TEdit
    Left = 62
    Top = 48
    Width = 217
    Height = 20
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object edtCode: TEdit
    Left = 62
    Top = 72
    Width = 217
    Height = 20
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
  end
end
