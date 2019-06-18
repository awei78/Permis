inherited frmDlgBase: TfrmDlgBase
  Left = 290
  Top = 250
  Caption = #23545#35805#26694#22522#26412#31383#20307
  ClientHeight = 237
  ClientWidth = 382
  OldCreateOrder = True
  DesignSize = (
    382
    237)
  PixelsPerInch = 96
  TextHeight = 12
  inherited bvl: TBevel
    Top = 201
    Width = 382
    ExplicitTop = 201
    ExplicitWidth = 382
  end
  inherited imgHelp: TImage
    Top = 210
    ExplicitTop = 210
  end
  object Label1: TLabel [2]
    Left = 8
    Top = 36
    Width = 36
    Height = 12
    Caption = #24037#21495#65306
  end
  object Label2: TLabel [3]
    Left = 226
    Top = 36
    Width = 36
    Height = 12
    Caption = #22995#21517#65306
  end
  inherited btnOk: TBitBtn
    Left = 215
    Top = 209
    Caption = #20445#23384'(&S)'
    TabOrder = 2
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
    ExplicitLeft = 215
    ExplicitTop = 209
  end
  inherited btnCancel: TBitBtn
    Left = 296
    Top = 209
    Caption = #20851#38381'(&C)'
    TabOrder = 3
    ExplicitLeft = 296
    ExplicitTop = 209
  end
  object edtStaNo: TRzButtonEdit
    Left = 46
    Top = 32
    Width = 112
    Height = 20
    Hint = #24377#20986#21015#34920#25903#25345#24037#21495#12289#22995#21517#12289#25340#38899#27169#31946#26597#35810
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnChange = edtStaNoChange
    OnEnter = edtStaNoEnter
    OnExit = edtStaNoExit
    OnKeyDown = edtStaNoKeyDown
    ButtonKind = bkDropDown
    AltBtnWidth = 15
    ButtonWidth = 15
    OnButtonClick = edtStaNoButtonClick
  end
  object edtStaName: TEdit
    Left = 264
    Top = 32
    Width = 104
    Height = 20
    TabOrder = 1
  end
  object pnlStaff: TRzPanel
    Left = 375
    Top = 51
    Width = 275
    Height = 142
    BorderOuter = fsNone
    BorderColor = 12164479
    TabOrder = 4
    object dg_staff: TDBGridEh
      Left = 0
      Top = 0
      Width = 275
      Height = 142
      Align = alClient
      ColumnDefValues.Title.TitleButton = True
      DataSource = ds_staff
      Flat = False
      FooterColor = clWindow
      FooterFont.Charset = ANSI_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -12
      FooterFont.Name = #23435#20307
      FooterFont.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
      OnDblClick = dg_staffDblClick
      OnDrawColumnCell = dg_staffDrawColumnCell
      OnExit = dg_staffExit
      OnTitleBtnClick = dg_staffTitleBtnClick
      Columns = <
        item
          EditButtons = <>
          FieldName = 'staffNo'
          Footers = <>
          Title.Caption = #24037#21495
          Width = 62
        end
        item
          EditButtons = <>
          FieldName = 'staffName'
          Footers = <>
          Title.Caption = #22995#21517
          Width = 58
        end
        item
          EditButtons = <>
          FieldName = 'deptName'
          Footers = <>
          Title.Caption = #37096#38376
          Width = 120
        end>
    end
  end
  object ds_staff: TDataSource
    DataSet = aq_staff
    Left = 334
    Top = 163
  end
  object aq_staff: TADOQuery
    Connection = dmPer.acPer
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM [staffs] ORDER BY staffNo')
    Left = 303
    Top = 162
  end
end
