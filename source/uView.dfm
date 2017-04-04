inherited frmView: TfrmView
  Caption = #31867#21035#26174#31034#35774#32622
  ClientHeight = 227
  ClientWidth = 197
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  inherited bvl: TBevel
    Top = 191
    Width = 197
  end
  inherited imgHelp: TImage
    Top = 200
  end
  inherited btnOk: TBitBtn
    Left = 30
    Top = 199
    Caption = #30830#23450
    TabOrder = 2
  end
  inherited btnCancel: TBitBtn
    Left = 111
    Top = 199
    Caption = #21462#28040
    TabOrder = 3
  end
  object cbView: TCheckListBox
    Left = 8
    Top = 8
    Width = 121
    Height = 175
    OnClickCheck = cbViewClickCheck
    Flat = False
    ItemHeight = 17
    Items.Strings = (
      #37096#38376
      #32844#21153
      #24037#31181
      #32844#31216
      #24615#21035
      #27665#26063
      #23130#23035#29366#20917
      #25919#27835#38754#35980
      #23398#21382
      #19987#19994)
    Style = lbOwnerDrawFixed
    TabOrder = 0
  end
  object cbSelAll: TCheckBox
    Left = 140
    Top = 8
    Width = 49
    Height = 17
    Caption = #20840#36873
    TabOrder = 1
    OnClick = cbSelAllClick
  end
end
