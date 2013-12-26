object FrmConsult: TFrmConsult
  Left = 190
  Top = 292
  Width = 805
  Height = 540
  Caption = 'Consulter la base...'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object gbConsult: TGroupBox
    Left = 0
    Top = 0
    Width = 797
    Height = 494
    Align = alClient
    TabOrder = 0
    object lsvJours: TListView
      Left = 2
      Top = 15
      Width = 793
      Height = 477
      Align = alClient
      Columns = <>
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object sbConsult: TStatusBar
    Left = 0
    Top = 494
    Width = 797
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object PopupMenu: TPopupMenu
    Left = 160
    Top = 112
    object mDeleteSel: TMenuItem
      Caption = 'Supprimer entree selectionnee'
    end
    object N1: TMenuItem
      Caption = '-'
    end
  end
end
