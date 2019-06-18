inherited frmInquMove: TfrmInquMove
  Caption = #24322#21160#26597#35810
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  inherited tbInqu: TRzToolbar
    ToolbarControls = (
      btnAdd
      btnEdit
      btnDel
      RzSpacer3
      btnExport
      btnPrint
      btnBack
      Spacer3
      btnExit
      RzSpacer1
      Label5
      edtSrh)
    inherited Spacer3: TRzSpacer
      Left = 369
    end
    inherited btnExit: TRzToolButton
      Left = 377
    end
    inherited Label5: TLabel
      Left = 445
    end
    inherited RzSpacer1: TRzSpacer
      Left = 437
    end
    object btnBack: TRzToolButton [10]
      Left = 309
      Top = 1
      Action = actBack
    end
    inherited edtSrh: TEdit
      Left = 481
    end
  end
  inherited dgInqu: TDBGridEh
    TabOrder = 1
  end
  inherited tvInqu: TTreeView
    TabOrder = 3
  end
  inherited alInqu: TActionList
    object actBack: TAction [5]
      Category = 'Inqu'
      Caption = #22797#32844
      ImageIndex = 12
      ShortCut = 16450
      OnExecute = actBackExecute
    end
  end
  inherited pmInqu: TPopupMenu
    object pmiBack: TMenuItem [3]
      Action = actBack
    end
  end
end
