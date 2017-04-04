inherited frmTrain: TfrmTrain
  ActiveControl = nil
  Caption = #22521#35757#35760#24405
  OldCreateOrder = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 12
  inherited dgInqu: TDBGridEh [0]
    Columns = <
      item
        EditButtons = <>
        FieldName = 'trName'
        Footers = <>
        Title.Caption = #22521#35757#21517#31216
        Width = 125
      end
      item
        EditButtons = <>
        FieldName = 'trDate'
        Footers = <>
        Title.Caption = #22521#35757#26085#26399
        Width = 72
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
        FieldName = 'trSite'
        Footers = <>
        Title.Caption = #22521#35757#22320#28857
        Width = 72
      end
      item
        EditButtons = <>
        FieldName = 'trainer'
        Footers = <>
        Title.Caption = #35762#24072
        Width = 60
      end
      item
        EditButtons = <>
        FieldName = 'content'
        Footers = <>
        Title.Caption = #22521#35757#20869#23481
        Width = 125
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
      'SELECT * FROM [train]')
  end
end
