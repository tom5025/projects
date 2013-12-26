object FrmAbout: TFrmAbout
  Left = 442
  Top = 488
  BorderStyle = bsToolWindow
  Caption = 'About CO MechaniC...'
  ClientHeight = 128
  ClientWidth = 227
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblLogiciel: TLabel
    Left = 57
    Top = 3
    Width = 90
    Height = 15
    Caption = 'CO MechaniC 3.0b'
  end
  object Memo1: TMemo
    Left = 1
    Top = 23
    Width = 225
    Height = 74
    Lines.Strings = (
      '- Designed for Excel'
      '- Using Internet Explorer Components'
      ''
      'Developped with Borland Delphi 6 by ToM50')
    TabOrder = 0
  end
  object btOK: TButton
    Left = 1
    Top = 102
    Width = 225
    Height = 25
    Caption = '&Fermer'
    Default = True
    TabOrder = 1
    OnClick = btOKClick
  end
end
