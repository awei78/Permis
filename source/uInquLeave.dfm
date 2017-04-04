inherited frmInquLeave: TfrmInquLeave
  ActiveControl = nil
  Caption = #35831#20551#26597#35810
  OldCreateOrder = True
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 12
  inherited dgInqu: TDBGridEh [0]
    Columns = <
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
        Width = 100
      end
      item
        EditButtons = <>
        FieldName = 'leaveDate'
        Footers = <>
        Title.Caption = #35831#20551#26085#26399
        Width = 65
      end
      item
        EditButtons = <>
        FieldName = 'leaveDay'
        Footers = <>
        Title.Caption = #35831#20551#22825#25968
        Width = 55
      end
      item
        EditButtons = <>
        FieldName = 'leaveReason'
        Footers = <>
        Title.Caption = #35831#20551#20107#30001
        Width = 175
      end
      item
        EditButtons = <>
        FieldName = 'unLeaveDate'
        Footers = <>
        Title.Caption = #38144#20551#26085#26399
        Width = 65
      end
      item
        Checkboxes = False
        EditButtons = <>
        FieldName = 'isLeave'
        Footers = <>
        Title.Caption = #29366#24577
        Width = 45
      end
      item
        EditButtons = <>
        FieldName = 'reger'
        Footers = <>
        Title.Caption = #30331#35760#20154
        Width = 50
      end
      item
        EditButtons = <>
        FieldName = 'des'
        Footers = <>
        Title.Caption = #22791#27880
        Width = 200
      end>
  end
  inherited tbInqu: TRzToolbar [1]
    ToolbarControls = (
      btnAdd
      btnEdit
      btnDel
      btnUnLeave
      RzSpacer3
      btnExport
      btnPrint
      Spacer3
      btnExit
      RzSpacer1
      Label5
      edtSrh)
    inherited btnExport: TRzToolButton
      Left = 249
      ExplicitLeft = 249
    end
    inherited Spacer3: TRzSpacer
      Left = 369
      ExplicitLeft = 369
    end
    inherited btnExit: TRzToolButton
      Left = 377
      ExplicitLeft = 377
    end
    inherited Label5: TLabel
      Left = 445
      ExplicitLeft = 445
    end
    inherited RzSpacer1: TRzSpacer
      Left = 437
      ExplicitLeft = 437
    end
    inherited btnPrint: TRzToolButton
      Left = 309
      ExplicitLeft = 309
    end
    inherited RzSpacer3: TRzSpacer
      Left = 241
      ExplicitLeft = 241
    end
    object btnUnLeave: TRzToolButton [10]
      Left = 181
      Top = 1
      Action = actUnLeave
    end
    inherited edtSrh: TEdit
      Left = 481
      ExplicitLeft = 481
    end
  end
  inherited sbInqu: TStatusBar [2]
  end
  inherited aqInqu: TADOQuery
    SQL.Strings = (
      'SELECT * FROM [leave]')
    object aqInquid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object aqInqustaffId: TIntegerField
      FieldName = 'staffId'
    end
    object aqInqustaffNo: TWideStringField
      FieldName = 'staffNo'
      Size = 50
    end
    object aqInqustaffName: TWideStringField
      FieldName = 'staffName'
      Size = 50
    end
    object aqInqustaffPY: TWideStringField
      FieldName = 'staffPY'
      Size = 50
    end
    object aqInqusex: TWideStringField
      FieldName = 'sex'
      Size = 6
    end
    object aqInqudeptName: TWideStringField
      FieldName = 'deptName'
      Size = 80
    end
    object aqInquleaveDate: TDateTimeField
      FieldName = 'leaveDate'
    end
    object aqInquleaveDay: TFloatField
      FieldName = 'leaveDay'
    end
    object aqInquleaveReason: TWideStringField
      FieldName = 'leaveReason'
      Size = 255
    end
    object aqInqudes: TWideStringField
      FieldName = 'des'
      Size = 255
    end
    object aqInquunLeaveDate: TDateTimeField
      FieldName = 'unLeaveDate'
    end
    object aqInqureger: TWideStringField
      FieldName = 'reger'
      Size = 50
    end
    object aqInquisLeave: TBooleanField
      FieldName = 'isLeave'
      OnGetText = aqInquisLeaveGetText
    end
    object aqInquoperDate: TDateTimeField
      FieldName = 'operDate'
    end
  end
  inherited alInqu: TActionList
    inherited actAdd: TAction
      Caption = #35831#20551
    end
    object actUnLeave: TAction
      Category = 'Inqu'
      Caption = #38144#20551
      ImageIndex = 12
      ShortCut = 16469
      OnExecute = actUnLeaveExecute
    end
    object actPrintBand: TAction
      Category = 'Inqu'
      Caption = #25171#21360#35831#20551#26465
      ImageIndex = 9
      OnExecute = actPrintBandExecute
    end
  end
  inherited pmInqu: TPopupMenu
    OnPopup = pmInquPopup
    object pmiUnLeave: TMenuItem [2]
      Action = actUnLeave
    end
    inherited pmiPrint: TMenuItem
      Action = actPrintBand
    end
  end
end
