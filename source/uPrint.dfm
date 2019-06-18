inherited frmPrint: TfrmPrint
  Left = 338
  Top = 205
  Caption = #25171#21360#23383#27573#35774#32622
  ClientHeight = 229
  ClientWidth = 207
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  inherited bvl: TBevel
    Top = 193
    Width = 207
  end
  inherited imgHelp: TImage
    Top = 202
  end
  inherited btnOk: TBitBtn
    Left = 40
    Top = 201
    Caption = #30830#23450
    TabOrder = 2
  end
  inherited btnCancel: TBitBtn
    Left = 121
    Top = 201
    Caption = #21462#28040
    TabOrder = 3
  end
  object cbPrint: TCheckListBox
    Left = 8
    Top = 8
    Width = 131
    Height = 177
    OnClickCheck = cbPrintClickCheck
    Flat = False
    ItemHeight = 17
    Items.Strings = (
      #22522#26412#20449#24687
      #21333#20301#20449#24687
      #32852#31995#26041#27861
      #20010#20154#31616#21382
      #23478#24237#25104#21592'&'#31038#20250#20851#31995
      #24037#20316#32463#21382
      #22870#24809#35760#24405
      #22521#35757#35760#24405
      #35843#21160#35760#24405
      #20854#23427#20449#24687)
    Style = lbOwnerDrawFixed
    TabOrder = 0
  end
  object cbSelAll: TCheckBox
    Left = 150
    Top = 8
    Width = 49
    Height = 17
    Caption = #20840#36873
    TabOrder = 1
    OnClick = cbSelAllClick
  end
end
