object frmBase: TfrmBase
  Left = 196
  Top = 149
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #27169#24335#31383#20307#22522#31867
  ClientHeight = 258
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShortCut = FormShortCut
  DesignSize = (
    384
    258)
  PixelsPerInch = 96
  TextHeight = 12
  object bvl: TBevel
    Left = 0
    Top = 222
    Width = 384
    Height = 1
    Anchors = [akLeft, akRight, akBottom]
    Shape = bsTopLine
  end
  object imgHelp: TImage
    Left = 16
    Top = 232
    Width = 16
    Height = 16
    Cursor = crHandPoint
    Hint = #24110#21161
    Anchors = [akLeft, akBottom]
    AutoSize = True
    Picture.Data = {
      07544269746D617036030000424D360300000000000036000000280000001000
      0000100000000100180000000000000300000000000000000000000000000000
      0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FF000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00000000FFFF00FFFF000000
      000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FF00000000FFFF00FFFF000000000000FF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000FF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FF00000000FFFF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00000000FFFF000000000000
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FF00000000FFFF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00000000FFFF00FFFF000000
      000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000
      00000000D8E9EC00000000FFFF00FFFF000000000000FF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FF00000000FFFF000000000000D8E9EC00000000FFFF
      00FFFF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00000000FF
      FF000000000000D8E9ECD8E9EC00000000FFFF000000000000FF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FF00000000FFFF00FFFF00000000000000000000FFFF
      00FFFF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000
      0000FFFF00FFFF00FFFF00FFFF00FFFF000000000000FF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000000000000000000000
      000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FF}
    Transparent = True
    OnClick = imgHelpClick
  end
  object btnOk: TBitBtn
    Left = 217
    Top = 230
    Width = 75
    Height = 22
    Anchors = [akRight, akBottom]
    Default = True
    TabOrder = 0
    OnClick = btnOkClick
  end
  object btnCancel: TBitBtn
    Left = 298
    Top = 230
    Width = 75
    Height = 22
    Anchors = [akRight, akBottom]
    ModalResult = 2
    TabOrder = 1
  end
end