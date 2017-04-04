object frmAwake: TfrmAwake
  Left = 237
  Top = 214
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #20107#20214#25552#37266
  ClientHeight = 416
  ClientWidth = 592
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnClose = FormClose
  OnShortCut = FormShortCut
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object tbDiary: TRzToolbar
    Left = 0
    Top = 0
    Width = 592
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
      btnExport
      btnPrint
      btnSet
      Spacer0
      btnExit
      Spacer1
      Label5
      edtDay
      udDay
      Label1)
    object btnExport: TRzToolButton
      Left = 1
      Top = 1
      Action = actExport
    end
    object Spacer0: TRzSpacer
      Left = 181
      Top = 1
      Grooved = True
    end
    object btnExit: TRzToolButton
      Left = 189
      Top = 1
      Action = actExit
    end
    object Label5: TLabel
      Left = 257
      Top = 7
      Width = 24
      Height = 12
      Caption = #25552#21069
    end
    object Spacer1: TRzSpacer
      Left = 249
      Top = 1
      Grooved = True
    end
    object Label1: TLabel
      Left = 321
      Top = 7
      Width = 36
      Height = 12
      Caption = #22825#25552#37266
    end
    object btnPrint: TRzToolButton
      Left = 61
      Top = 1
      Action = actPrint
    end
    object btnSet: TRzToolButton
      Left = 121
      Top = 1
      Action = actSet
    end
    object edtDay: TEdit
      Left = 281
      Top = 3
      Width = 24
      Height = 20
      ReadOnly = True
      TabOrder = 0
      Text = '3'
      OnChange = edtDayChange
    end
    object udDay: TUpDown
      Left = 305
      Top = 3
      Width = 16
      Height = 20
      Associate = edtDay
      Position = 3
      TabOrder = 1
    end
  end
  object pc: TPageControl
    Left = 0
    Top = 27
    Width = 592
    Height = 389
    ActivePage = tsBirth
    Align = alClient
    TabOrder = 1
    OnChange = pcChange
    object tsBirth: TTabSheet
      Caption = #36817#26399#29983#26085#21592#24037
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object dgInqu: TDBGridEh
        Left = 0
        Top = 0
        Width = 584
        Height = 362
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
        Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        OnDblClick = dgInquDblClick
        OnDrawColumnCell = dgInquDrawColumnCell
        OnTitleBtnClick = dgInquTitleBtnClick
      end
    end
    object tsContract: TTabSheet
      Caption = #21512#21516#21040#26399#21592#24037
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object tsStaff: TTabSheet
      Caption = #36817#26399#36716#27491#21592#24037
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
  end
  object dsInqu: TDataSource
    DataSet = aqInqu
    Left = 488
  end
  object aqInqu: TADOQuery
    Connection = dmPer.acPer
    CursorType = ctStatic
    OnFilterRecord = aqInquFilterRecord
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM [Inqulist]')
    Left = 520
  end
  object alAddr: TActionList
    Images = dmPer.ilTool
    Left = 552
    object actExport: TAction
      Category = 'awake'
      Caption = #23548#20986
      Hint = #23548#20986'Excel'#25968#25454
      ImageIndex = 8
      OnExecute = actExportExecute
    end
    object actPrint: TAction
      Category = 'awake'
      Caption = #25171#21360
      Hint = #25171#21360#24403#21069#34920#26684
      ImageIndex = 9
      ShortCut = 46
      OnExecute = actPrintExecute
    end
    object actSet: TAction
      Category = 'awake'
      Caption = #35774#32622
      ImageIndex = 6
      OnExecute = actSetExecute
    end
    object actExit: TAction
      Category = 'awake'
      Caption = #36864#20986
      Hint = #36864#20986#20107#20214#25552#37266
      ImageIndex = 7
      OnExecute = actExitExecute
    end
    object actHelp: TAction
      Category = 'awake'
      Caption = #24110#21161
      ShortCut = 112
      OnExecute = actHelpExecute
    end
  end
end
