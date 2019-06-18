object frmAbout: TfrmAbout
  Left = 320
  Top = 243
  BorderStyle = bsDialog
  Caption = #20851#20110'...'
  ClientHeight = 186
  ClientWidth = 304
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = True
  Position = poOwnerFormCenter
  OnShortCut = FormShortCut
  PixelsPerInch = 96
  TextHeight = 12
  object pnlAbout: TPanel
    Left = 8
    Top = 8
    Width = 289
    Height = 137
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 0
    object imgIcon: TImage
      Left = 16
      Top = 16
      Width = 32
      Height = 32
      Center = True
      Stretch = True
      IsControl = True
    end
    object lblPro: TLabel
      Left = 72
      Top = 16
      Width = 48
      Height = 12
      Caption = #20135#21697#21517#65306
      IsControl = True
    end
    object lblVer: TLabel
      Left = 72
      Top = 40
      Width = 48
      Height = 12
      Caption = #29256'  '#26412#65306
      IsControl = True
    end
    object lblRight: TLabel
      Left = 8
      Top = 72
      Width = 144
      Height = 12
      Caption = #29256#26435#25152#26377'(c) 2019 CR-Soft'
      IsControl = True
    end
    object lblInfo: TLabel
      Left = 72
      Top = 105
      Width = 201
      Height = 12
      AutoSize = False
      Caption = #26410#27880#20876#29256#26412
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      WordWrap = True
      IsControl = True
    end
    object rsTop: TRzSeparator
      Left = 8
      Top = 95
      Width = 245
      Height = 1
      HighlightLocation = hlUpperLeft
      ShowGradient = True
      Color = clBtnFace
      ParentColor = False
    end
    object rsBottom: TRzSeparator
      Left = 8
      Top = 125
      Width = 245
      Height = 1
      HighlightLocation = hlUpperLeft
      ShowGradient = True
      Color = clBtnFace
      ParentColor = False
    end
  end
  object btnOk: TButton
    Left = 113
    Top = 155
    Width = 75
    Height = 22
    Caption = #30830#23450
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
end
