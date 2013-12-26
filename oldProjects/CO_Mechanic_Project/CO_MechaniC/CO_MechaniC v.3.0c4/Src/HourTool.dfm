object FrmHour: TFrmHour
  Left = 192
  Top = 107
  Width = 291
  Height = 113
  Caption = 'FrmHour'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblHour: TLabel
    Left = 80
    Top = 24
    Width = 33
    Height = 13
    Caption = 'lblHour'
  end
  object NMHTTP: TNMHTTP
    Port = 0
    ReportLevel = 0
    Body = 'Default.htm'
    Header = 'Head.txt'
    InputFileMode = False
    OutputFileMode = False
    ProxyPort = 0
    Left = 32
    Top = 24
  end
  object NMTime1: TNMTime
    Host = 'tock.usask.ca'
    Port = 37
    TimeOut = 1000
    ReportLevel = 0
    Left = 32
    Top = 56
  end
end
