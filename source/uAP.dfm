inherited frmAP: TfrmAP
  ActiveControl = nil
  Caption = #22870#24809#35760#24405
  OldCreateOrder = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 12
  inherited dgInqu: TDBGridEh [0]
    Columns = <
      item
        EditButtons = <>
        FieldName = 'apDate'
        Footers = <>
        Title.Caption = #26085#26399
        Width = 72
      end
      item
        EditButtons = <>
        FieldName = 'apType'
        Footers = <>
        Title.Caption = #31867#21035
        Width = 50
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
        Width = 100
      end
      item
        EditButtons = <>
        FieldName = 'reason'
        Footers = <>
        Title.Caption = #21407#22240
        Width = 175
      end
      item
        EditButtons = <>
        FieldName = 'result'
        Footers = <>
        Title.Caption = #32467#26524
        Width = 175
      end
      item
        EditButtons = <>
        FieldName = 'operDept'
        Footers = <>
        Title.Caption = #22788#29702#37096#38376
        Width = 100
      end
      item
        EditButtons = <>
        FieldName = 'des'
        Footers = <>
        Title.Caption = #22791#27880
        Width = 125
      end>
  end
  inherited tbInqu: TRzToolbar [1]
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
  end
  inherited sbInqu: TStatusBar [2]
  end
  inherited aqInqu: TADOQuery
    AfterPost = aqInquAfterPost
    AfterDelete = aqInquAfterDelete
    SQL.Strings = (
      'SELECT * FROM [ap]')
  end
end
