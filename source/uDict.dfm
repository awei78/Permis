inherited frmDict: TfrmDict
  Left = 290
  Top = 183
  Caption = #20998#31867#20449#24687
  ClientHeight = 317
  ClientWidth = 317
  OldCreateOrder = True
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  inherited bvl: TBevel
    Top = 281
    Width = 317
  end
  inherited imgHelp: TImage
    Top = 290
  end
  object lblTips: TLabel [2]
    Left = 233
    Top = 134
    Width = 72
    Height = 48
    Caption = #25552#31034#65306#13#24744#25152#20570#30340#19968#20999#26356#26032#65292#20445#23384#21518#25165#33021#29983#25928
    Font.Charset = ANSI_CHARSET
    Font.Color = clGreen
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  inherited btnCancel: TBitBtn [3]
    Left = 231
    Top = 289
    Caption = #21462#28040'(&C)'
    TabOrder = 5
    NumGlyphs = 2
  end
  inherited btnOk: TBitBtn [4]
    Left = 150
    Top = 289
    Caption = #20445#23384'(&S)'
    TabOrder = 4
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FF00000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF00FFFF00FF000000
      008080008080000000000000000000000000000000000000D8E9ECD8E9EC0000
      00008080000000FF00FFFF00FF00000000808000808000000000000000000000
      0000000000000000D8E9ECD8E9EC000000008080000000FF00FFFF00FF000000
      008080008080000000000000000000000000000000000000D8E9ECD8E9EC0000
      00008080000000FF00FFFF00FF00000000808000808000000000000000000000
      0000000000000000000000000000000000008080000000FF00FFFF00FF000000
      0080800080800080800080800080800080800080800080800080800080800080
      80008080000000FF00FFFF00FF00000000808000808000000000000000000000
      0000000000000000000000000000008080008080000000FF00FFFF00FF000000
      008080000000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000
      00008080000000FF00FFFF00FF000000008080000000D8E9ECD8E9ECD8E9ECD8
      E9ECD8E9ECD8E9ECD8E9ECD8E9EC000000008080000000FF00FFFF00FF000000
      008080000000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000
      00008080000000FF00FFFF00FF000000008080000000D8E9ECD8E9ECD8E9ECD8
      E9ECD8E9ECD8E9ECD8E9ECD8E9EC000000008080000000FF00FFFF00FF000000
      008080000000D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC0000
      00000000000000FF00FFFF00FF000000008080000000D8E9ECD8E9ECD8E9ECD8
      E9ECD8E9ECD8E9ECD8E9ECD8E9EC000000D8E9EC000000FF00FFFF00FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
  end
  object btnAdd: TBitBtn
    Left = 231
    Top = 48
    Width = 75
    Height = 22
    Caption = #28155#21152'(&A)'
    TabOrder = 1
    OnClick = btnAddClick
  end
  object btnEdit: TBitBtn
    Left = 231
    Top = 74
    Width = 75
    Height = 22
    Caption = #32534#36753'(&E)'
    TabOrder = 2
    OnClick = btnEditClick
  end
  object btnDel: TBitBtn
    Left = 231
    Top = 100
    Width = 75
    Height = 22
    Caption = #21024#38500'(&D)'
    TabOrder = 3
    OnClick = btnDelClick
    Glyph.Data = {
      36060000424D3606000000000000360400002800000020000000100000000100
      08000000000000020000630E0000630E00000001000000010000000000003300
      00006600000099000000CC000000FF0000000033000033330000663300009933
      0000CC330000FF33000000660000336600006666000099660000CC660000FF66
      000000990000339900006699000099990000CC990000FF99000000CC000033CC
      000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
      0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
      330000333300333333006633330099333300CC333300FF333300006633003366
      33006666330099663300CC663300FF6633000099330033993300669933009999
      3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
      330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
      66006600660099006600CC006600FF0066000033660033336600663366009933
      6600CC336600FF33660000666600336666006666660099666600CC666600FF66
      660000996600339966006699660099996600CC996600FF99660000CC660033CC
      660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
      6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
      990000339900333399006633990099339900CC339900FF339900006699003366
      99006666990099669900CC669900FF6699000099990033999900669999009999
      9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
      990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
      CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
      CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
      CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
      CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
      CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
      FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
      FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
      FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
      FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
      000000808000800000008000800080800000C0C0C00080808000191919004C4C
      4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
      6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E86CE8E8
      E8E8E8E8E8E8E8E8B4E8E8E8E881E8E8E8E8E8E8E8E8E8E8ACE8E8E897B46CE8
      E8E8E8E8E8E8E8E8E8E8E8E881AC81E8E8E8E8E8E8E8E8E8E8E8E8E897C7B46C
      E8E8E8E8E8E8E8B4E8E8E8E881E3AC81E8E8E8E8E8E8E8ACE8E8E8E8E897C090
      E8E8E8E8E8E8B4E8E8E8E8E8E881E381E8E8E8E8E8E8ACE8E8E8E8E8E8E890B4
      6CE8E8E8E8B46CE8E8E8E8E8E8E881AC81E8E8E8E8AC81E8E8E8E8E8E8E8E890
      B46CE8E8B46CE8E8E8E8E8E8E8E8E881AC81E8E8AC81E8E8E8E8E8E8E8E8E8E8
      90B46CB46CE8E8E8E8E8E8E8E8E8E8E881AC81AC81E8E8E8E8E8E8E8E8E8E8E8
      E890B46CE8E8E8E8E8E8E8E8E8E8E8E8E881AC81E8E8E8E8E8E8E8E8E8E8E8E8
      90B46C906CE8E8E8E8E8E8E8E8E8E8E881AC818181E8E8E8E8E8E8E8E8E8E890
      B46CE8E8906CE8E8E8E8E8E8E8E8E881AC81E8E88181E8E8E8E8E8E8E890B4B4
      6CE8E8E8E8906CE8E8E8E8E8E881ACAC81E8E8E8E88181E8E8E8E8E890C7B46C
      E8E8E8E8E8E8906CE8E8E8E881E3AC81E8E8E8E8E8E88181E8E8E8E87A907AE8
      E8E8E8E8E8E8E8E890E8E8E8AC81ACE8E8E8E8E8E8E8E8E881E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
    NumGlyphs = 2
  end
  object tvDict: TTreeView
    Left = 8
    Top = 8
    Width = 210
    Height = 265
    HideSelection = False
    Images = dmPer.ilTree
    Indent = 19
    ReadOnly = True
    ShowRoot = False
    TabOrder = 0
    OnChange = tvDictChange
    OnDblClick = tvDictDblClick
    OnEdited = tvDictEdited
    OnEditing = tvDictEditing
    OnGetImageIndex = tvDictGetImageIndex
    OnGetSelectedIndex = tvDictGetSelectedIndex
    OnKeyPress = tvDictKeyPress
    Items.Data = {
      01000000210000000000000000000000FFFFFFFFFFFFFFFF000000000B000000
      08B9ABCBBEC3FBB3C61D0000000100000001000000FFFFFFFFFFFFFFFF000000
      000000000004D6B0CEF11D0000000100000001000000FFFFFFFFFFFFFFFF0000
      00000000000004B9A4D6D61D0000000100000001000000FFFFFFFFFFFFFFFF00
      0000000000000004D6B0B3C61D0000000100000001000000FFFFFFFFFFFFFFFF
      000000000000000004C3F1D7E5210000000100000001000000FFFFFFFFFFFFFF
      FF000000000000000008BBE9D2F6D7B4BFF6210000000100000001000000FFFF
      FFFFFFFFFFFF000000000000000008D5FED6CEC3E6C3B21D0000000100000001
      000000FFFFFFFFFFFFFFFF000000000000000004D1A7C0FA1D00000001000000
      01000000FFFFFFFFFFFFFFFF000000000000000004D7A8D2B521000000010000
      0001000000FFFFFFFFFFFFFFFF000000000000000008C0EBD6B0D4ADD2F22100
      00000100000001000000FFFFFFFFFFFFFFFF000000000000000008B7A2BFA8D2
      F8D0D0210000000100000001000000FFFFFFFFFFFFFFFF000000000000000008
      BACFCDACC0E0D0CD}
  end
  object btnUp: TBitBtn
    Left = 231
    Top = 8
    Width = 25
    Height = 25
    Hint = #19978#31227#36873#20013#30340#31867#21035
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = btnUpClick
    Glyph.Data = {
      36060000424D3606000000000000360400002800000020000000100000000100
      08000000000000020000530B0000530B00000001000000000000000000003300
      00006600000099000000CC000000FF0000000033000033330000663300009933
      0000CC330000FF33000000660000336600006666000099660000CC660000FF66
      000000990000339900006699000099990000CC990000FF99000000CC000033CC
      000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
      0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
      330000333300333333006633330099333300CC333300FF333300006633003366
      33006666330099663300CC663300FF6633000099330033993300669933009999
      3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
      330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
      66006600660099006600CC006600FF0066000033660033336600663366009933
      6600CC336600FF33660000666600336666006666660099666600CC666600FF66
      660000996600339966006699660099996600CC996600FF99660000CC660033CC
      660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
      6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
      990000339900333399006633990099339900CC339900FF339900006699003366
      99006666990099669900CC669900FF6699000099990033999900669999009999
      9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
      990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
      CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
      CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
      CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
      CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
      CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
      FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
      FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
      FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
      FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
      000000808000800000008000800080800000C0C0C00080808000191919004C4C
      4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
      6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B9B9B9B9B9B9
      B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B90C
      0C0C0C0CB9B9B9B9B9B9B9B9B9B9B98181818181B9B9B9B9B9B9B9B9B9B9B90C
      1212120CB9B9B9B9B9B9B9B9B9B9B981ACACAC81B9B9B9B9B9B9B9B9B9B9B90C
      1212120CB9B9B9B9B9B9B9B9B9B9B981ACACAC81B9B9B9B9B9B9B9B9B9B9B90C
      1212120CB9B9B9B9B9B9B9B9B9B9B981ACACAC81B9B9B9B9B9B9B9B9B9B9B90C
      1212120CB9B9B9B9B9B9B9B9B9B9B981ACACAC81B9B9B9B9B9B9B9B9B9B9B90C
      1212120CB9B9B9B9B9B9B9B9B9B9B981ACACAC81B9B9B9B9B9B9B9B90C0C0C0C
      1212120C0C0C0CB9B9B9B9B981818181ACACAC81818181B9B9B9B9B90C121212
      1212121212120CB9B9B9B9B981ACACACACACACACACAC81B9B9B9B9B90C121212
      1212121212180CB9B9B9B9B981ACACACACACACACACD781B9B9B9B9B9B90C1212
      12121212180CB9B9B9B9B9B9B981ACACACACACACD781B9B9B9B9B9B9B9B90C12
      121212180CB9B9B9B9B9B9B9B9B981ACACACACD781B9B9B9B9B9B9B9B9B9B90C
      1212180CB9B9B9B9B9B9B9B9B9B9B981ACACD781B9B9B9B9B9B9B9B9B9B9B9B9
      0C180CB9B9B9B9B9B9B9B9B9B9B9B9B981D781B9B9B9B9B9B9B9B9B9B9B9B9B9
      B90CB9B9B9B9B9B9B9B9B9B9B9B9B9B9B981B9B9B9B9B9B9B9B9B9B9B9B9B9B9
      B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9}
    NumGlyphs = 2
  end
  object btnDown: TBitBtn
    Left = 262
    Top = 8
    Width = 25
    Height = 25
    Hint = #19979#31227#36873#20013#30340#31867#21035
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = btnDownClick
    Glyph.Data = {
      36060000424D3606000000000000360400002800000020000000100000000100
      08000000000000020000530B0000530B00000001000000000000000000003300
      00006600000099000000CC000000FF0000000033000033330000663300009933
      0000CC330000FF33000000660000336600006666000099660000CC660000FF66
      000000990000339900006699000099990000CC990000FF99000000CC000033CC
      000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
      0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
      330000333300333333006633330099333300CC333300FF333300006633003366
      33006666330099663300CC663300FF6633000099330033993300669933009999
      3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
      330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
      66006600660099006600CC006600FF0066000033660033336600663366009933
      6600CC336600FF33660000666600336666006666660099666600CC666600FF66
      660000996600339966006699660099996600CC996600FF99660000CC660033CC
      660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
      6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
      990000339900333399006633990099339900CC339900FF339900006699003366
      99006666990099669900CC669900FF6699000099990033999900669999009999
      9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
      990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
      CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
      CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
      CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
      CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
      CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
      FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
      FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
      FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
      FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
      000000808000800000008000800080800000C0C0C00080808000191919004C4C
      4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
      6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B9B9B9B9B9B9
      B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9
      B90CB9B9B9B9B9B9B9B9B9B9B9B9B9B9B981B9B9B9B9B9B9B9B9B9B9B9B9B9B9
      0C180CB9B9B9B9B9B9B9B9B9B9B9B9B981E881B9B9B9B9B9B9B9B9B9B9B9B90C
      1212180CB9B9B9B9B9B9B9B9B9B9B981ACACE881B9B9B9B9B9B9B9B9B9B90C12
      121212180CB9B9B9B9B9B9B9B9B981ACACACACE881B9B9B9B9B9B9B9B90C1212
      12121212180CB9B9B9B9B9B9B981ACACACACACACE881B9B9B9B9B9B90C121212
      1212121212180CB9B9B9B9B981ACACACACACACACACE881B9B9B9B9B90C121212
      1212121212120CB9B9B9B9B981ACACACACACACACACAC81B9B9B9B9B90C0C0C0C
      1212120C0C0C0CB9B9B9B9B981818181ACACAC81818181B9B9B9B9B9B9B9B90C
      1212120CB9B9B9B9B9B9B9B9B9B9B981ACACAC81B9B9B9B9B9B9B9B9B9B9B90C
      1212120CB9B9B9B9B9B9B9B9B9B9B981ACACAC81B9B9B9B9B9B9B9B9B9B9B90C
      1212120CB9B9B9B9B9B9B9B9B9B9B981ACACAC81B9B9B9B9B9B9B9B9B9B9B90C
      1212120CB9B9B9B9B9B9B9B9B9B9B981ACACAC81B9B9B9B9B9B9B9B9B9B9B90C
      1212120CB9B9B9B9B9B9B9B9B9B9B981ACACAC81B9B9B9B9B9B9B9B9B9B9B90C
      0C0C0C0CB9B9B9B9B9B9B9B9B9B9B98181818181B9B9B9B9B9B9B9B9B9B9B9B9
      B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9}
    NumGlyphs = 2
  end
end