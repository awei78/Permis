inherited frmContract: TfrmContract
  ActiveControl = nil
  Caption = #21512#21516#31649#29702
  OldCreateOrder = True
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 12
  inherited dgInqu: TDBGridEh [0]
    Top = 60
    Height = 375
    Columns = <
      item
        EditButtons = <>
        FieldName = 'contNo'
        Footers = <>
        Title.Caption = #21512#21516#32534#21495
        Width = 60
      end
      item
        EditButtons = <>
        FieldName = 'contName'
        Footers = <>
        Title.Caption = #21512#21516#21517#31216
        Width = 90
      end
      item
        EditButtons = <>
        FieldName = 'staffNo'
        Footers = <>
        Title.Caption = #24037#21495
        Width = 60
      end
      item
        EditButtons = <>
        FieldName = 'staffName'
        Footers = <>
        Title.Caption = #22995#21517
        Width = 60
      end
      item
        EditButtons = <>
        FieldName = 'deptName'
        Footers = <>
        Title.Caption = #37096#38376
        Width = 99
      end
      item
        EditButtons = <>
        FieldName = 'contType'
        Footers = <>
        Title.Caption = #21512#21516#31867#22411
        Width = 70
      end
      item
        EditButtons = <>
        FieldName = 'contProp'
        Footers = <>
        Title.Caption = #21512#21516#23646#24615
        Width = 55
      end
      item
        EditButtons = <>
        FieldName = 'contMonth'
        Footers = <>
        Title.Caption = #21512#21516#26399'('#26376')'
        Width = 75
      end
      item
        EditButtons = <>
        FieldName = 'startDate'
        Footers = <>
        Title.Caption = #29983#25928#26085#26399
        Width = 60
      end
      item
        EditButtons = <>
        FieldName = 'endDate'
        Footers = <>
        Title.Caption = #32456#27490#26085#26399
        Width = 60
      end
      item
        EditButtons = <>
        FieldName = 'recDate'
        Footers = <>
        Title.Caption = #31614#35746#26085#26399
        Width = 60
      end
      item
        EditButtons = <>
        FieldName = 'contState'
        Footers = <>
        Title.Caption = #29366#24577
        Width = 50
      end>
  end
  inherited tbInqu: TRzToolbar [1]
    Height = 52
    ExplicitHeight = 52
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
      edtSrh
      RzSpacer2
      cbDate
      dpStart
      Label4
      dpEnd
      btnFind
      btnAll)
    inherited Label5: TLabel
      Width = 60
      Caption = #24555#36895#26597#25214#65306
      ExplicitWidth = 60
    end
    inherited btnAdd: TRzToolButton
      Caption = #26032#31614
    end
    object RzSpacer2: TRzSpacer [10]
      Left = 542
      Top = 1
      Grooved = True
    end
    object Label4: TLabel [11]
      Left = 91
      Top = 32
      Width = 6
      Height = 12
      Caption = '-'
    end
    object btnAll: TRzToolButton [12]
      Left = 247
      Top = 26
      Action = actAll
    end
    object btnFind: TRzToolButton [13]
      Left = 187
      Top = 26
      Action = actFind
    end
    inherited edtSrh: TEdit
      Left = 445
      Width = 97
      ExplicitLeft = 445
      ExplicitWidth = 97
    end
    object cbDate: TComboBox
      Left = 550
      Top = 3
      Width = 79
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      ItemIndex = 0
      TabOrder = 1
      Text = #29983#25928#26085#26399
      Items.Strings = (
        #29983#25928#26085#26399
        #32456#27490#26085#26399
        #31614#35746#26085#26399)
    end
    object dpStart: TDateTimePicker
      Left = 1
      Top = 28
      Width = 90
      Height = 20
      Date = 39751.511497210660000000
      Format = 'yyyy-MM-dd'
      Time = 39751.511497210660000000
      TabOrder = 2
    end
    object dpEnd: TDateTimePicker
      Left = 97
      Top = 28
      Width = 90
      Height = 20
      Date = 39751.511497210660000000
      Format = 'yyyy-MM-dd'
      Time = 39751.511497210660000000
      TabOrder = 3
    end
  end
  inherited sbInqu: TStatusBar [2]
  end
  inherited pnlLeft: TPanel
    Top = 60
    Height = 375
    ExplicitTop = 60
    ExplicitHeight = 379
  end
  inherited pnlTop: TPanel
    Top = 52
    ExplicitTop = 52
  end
  inherited tvInqu: TTreeView
    Top = 60
    Height = 375
    ExplicitTop = 60
    ExplicitHeight = 379
  end
  inherited pnlLeftT: TPanel
    Top = 60
    Height = 375
    ExplicitTop = 60
    ExplicitHeight = 379
  end
  inherited pnlRight: TPanel
    Top = 60
    Height = 375
    ExplicitTop = 60
    ExplicitHeight = 379
  end
  inherited dsInqu: TDataSource
    Left = 176
    Top = 72
  end
  inherited aqInqu: TADOQuery
    SQL.Strings = (
      'SELECT * FROM [contract]')
    Left = 208
    Top = 72
  end
  inherited alInqu: TActionList
    Left = 240
    Top = 72
    object actFind: TAction
      Category = 'Inqu'
      Caption = #26597#25214
      ImageIndex = 15
      OnExecute = actFindExecute
    end
    object actAll: TAction
      Category = 'Inqu'
      Caption = #20840#37096
      ImageIndex = 16
      OnExecute = actAllExecute
    end
  end
  inherited pmInqu: TPopupMenu
    Left = 272
    Top = 72
  end
end
