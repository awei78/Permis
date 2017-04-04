object frmInquBase: TfrmInquBase
  Left = 224
  Top = 168
  ActiveControl = dgInqu
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #26597#35810#22522#31867#31383#20307
  ClientHeight = 462
  ClientWidth = 704
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnCreate = FormCreate
  OnShortCut = FormShortCut
  PixelsPerInch = 96
  TextHeight = 12
  object tbInqu: TRzToolbar
    Left = 0
    Top = 0
    Width = 704
    Height = 27
    AutoStyle = False
    Images = dmPer.ilTool
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
      btnAdd
      btnEdit
      btnDel
      RzSpacer3
      btnExport
      btnPrint
      Spacer3
      btnExit
      RzSpacer1
      Label5
      edtSrh)
    object btnDel: TRzToolButton
      Left = 121
      Top = 1
      Action = actDel
    end
    object btnExport: TRzToolButton
      Left = 189
      Top = 1
      Action = actExport
    end
    object Spacer3: TRzSpacer
      Left = 309
      Top = 1
      Grooved = True
    end
    object btnExit: TRzToolButton
      Left = 317
      Top = 1
      Action = actExit
    end
    object Label5: TLabel
      Left = 385
      Top = 7
      Width = 36
      Height = 12
      Caption = #26597#25214#65306
    end
    object RzSpacer1: TRzSpacer
      Left = 377
      Top = 1
      Grooved = True
    end
    object btnPrint: TRzToolButton
      Left = 249
      Top = 1
      Action = actPrint
    end
    object btnEdit: TRzToolButton
      Left = 61
      Top = 1
      Action = actEdit
    end
    object btnAdd: TRzToolButton
      Left = 1
      Top = 1
      Action = actAdd
    end
    object RzSpacer3: TRzSpacer
      Left = 181
      Top = 1
      Grooved = True
    end
    object edtSrh: TEdit
      Left = 421
      Top = 3
      Width = 121
      Height = 20
      TabOrder = 0
      OnChange = edtSrhChange
    end
  end
  object sbInqu: TStatusBar
    Left = 0
    Top = 443
    Width = 704
    Height = 19
    Panels = <
      item
        Width = 450
      end
      item
        Width = 50
      end>
  end
  object dgInqu: TDBGridEh
    Left = 173
    Top = 35
    Width = 523
    Height = 400
    Align = alClient
    ColumnDefValues.Title.TitleButton = True
    DataSource = dsInqu
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
    PopupMenu = pmInqu
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
    OnDblClick = dgInquDblClick
    OnDrawColumnCell = dgInquDrawColumnCell
    OnTitleBtnClick = dgInquTitleBtnClick
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 35
    Width = 8
    Height = 400
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 4
  end
  object pnlTop: TPanel
    Left = 0
    Top = 27
    Width = 704
    Height = 8
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 5
  end
  object pnlBtm: TPanel
    Left = 0
    Top = 435
    Width = 704
    Height = 8
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
  end
  object tvInqu: TTreeView
    Left = 8
    Top = 35
    Width = 161
    Height = 400
    Align = alLeft
    HideSelection = False
    Images = dmPer.ilTree
    Indent = 19
    ReadOnly = True
    ShowRoot = False
    TabOrder = 1
    OnChange = tvInquChange
    OnGetImageIndex = tvInquGetImageIndex
    OnGetSelectedIndex = tvInquGetSelectedIndex
    Items.NodeData = {
      0101000000210000000A0000000A000000FFFFFFFFFFFFFFFF00000000000000
      00046C51F8530D54F079}
  end
  object pnlLeftT: TPanel
    Left = 169
    Top = 35
    Width = 4
    Height = 400
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 7
  end
  object pnlRight: TPanel
    Left = 696
    Top = 35
    Width = 8
    Height = 400
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 8
  end
  object dsInqu: TDataSource
    DataSet = aqInqu
    OnDataChange = dsInquDataChange
    Left = 568
  end
  object aqInqu: TADOQuery
    Connection = dmPer.acPer
    CursorType = ctStatic
    Parameters = <>
    Left = 600
  end
  object alInqu: TActionList
    Images = dmPer.ilTool
    OnExecute = alInquExecute
    Left = 632
    object actAdd: TAction
      Category = 'Inqu'
      Caption = #28155#21152
      Hint = #28155#21152#19968#26465#26032#35760#24405
      ImageIndex = 0
      ShortCut = 16449
      OnExecute = actAddExecute
    end
    object actEdit: TAction
      Category = 'Inqu'
      Caption = #20462#25913
      Hint = #20462#25913#36873#23450#20449#24687
      ImageIndex = 1
      ShortCut = 16453
      OnExecute = actEditExecute
    end
    object actDel: TAction
      Category = 'Inqu'
      Caption = #21024#38500
      Hint = #21024#38500#36873#23450#35760#24405'('#25353'Ctrl'#38190#21487#23454#29616#22810#36873')'
      ImageIndex = 2
      ShortCut = 46
      OnExecute = actDelExecute
    end
    object actExport: TAction
      Category = 'Inqu'
      Caption = #23548#20986
      Hint = #23548#20986'Excel'#25968#25454
      ImageIndex = 8
      OnExecute = actExportExecute
    end
    object actPrint: TAction
      Category = 'Inqu'
      Caption = #25171#21360
      Hint = #25171#21360#24403#21069#34920#26684#25968#25454
      ImageIndex = 9
      ShortCut = 16464
      OnExecute = actPrintExecute
    end
    object actExit: TAction
      Category = 'Inqu'
      Caption = #36864#20986
      ImageIndex = 7
      OnExecute = actExitExecute
    end
    object actHelp: TAction
      Category = 'Inqu'
      Caption = #24110#21161
      ShortCut = 112
      OnExecute = actHelpExecute
    end
  end
  object pmInqu: TPopupMenu
    AutoHotkeys = maManual
    Images = dmPer.ilTool
    Left = 664
    object pmiAdd: TMenuItem
      Action = actAdd
      Caption = #28155#21152'...'
    end
    object pmiEdit: TMenuItem
      Action = actEdit
      Caption = #20462#25913'...'
    end
    object pmiDel: TMenuItem
      Action = actDel
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object pmiExport: TMenuItem
      Action = actExport
    end
    object pmiPrint: TMenuItem
      Action = actPrint
    end
  end
end
