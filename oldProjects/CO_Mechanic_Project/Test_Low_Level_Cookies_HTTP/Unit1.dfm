object FrmMain: TFrmMain
  Left = 200
  Top = 112
  Width = 954
  Height = 626
  Caption = 'FrmMain'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblkos: TLabel
    Left = 472
    Top = 24
    Width = 22
    Height = 13
    Caption = 'ko/s'
  end
  object lblko: TLabel
    Left = 352
    Top = 24
    Width = 12
    Height = 13
    Caption = 'ko'
  end
  object Label1: TLabel
    Left = 592
    Top = 24
    Width = 129
    Height = 13
    Caption = 'Label1'
  end
  object btGet13000: TButton
    Left = 8
    Top = 16
    Width = 169
    Height = 25
    Caption = 'btGet13000'
    TabOrder = 0
    OnClick = btGet13000Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 48
    Width = 937
    Height = 257
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object btRefresh13000: TButton
    Left = 184
    Top = 16
    Width = 137
    Height = 25
    Caption = 'btRefresh13000'
    TabOrder = 2
  end
  object Memo2: TMemo
    Left = 8
    Top = 312
    Width = 937
    Height = 273
    Lines.Strings = (
      'Memo2')
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object Timer1: TTimer
    Interval = 500
    OnTimer = Timer1Timer
    Left = 552
    Top = 16
  end
end
