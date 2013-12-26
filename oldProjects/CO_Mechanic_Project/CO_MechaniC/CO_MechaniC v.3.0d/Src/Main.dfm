object FrmMain: TFrmMain
  Left = 191
  Top = 106
  Width = 744
  Height = 480
  Caption = 'CO_MechaniC v3.0c [Designed for Excel 2000]'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SpltMain: TSplitter
    Left = 441
    Top = 0
    Width = 8
    Height = 415
    Cursor = crHSplit
  end
  object lbLog: TListBox
    Left = 449
    Top = 0
    Width = 287
    Height = 415
    Align = alClient
    Color = clWhite
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 14
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
  end
  object sbMAIN: TStatusBar
    Left = 0
    Top = 415
    Width = 736
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object WebB: TWebBrowser
    Left = 0
    Top = 0
    Width = 441
    Height = 415
    Align = alLeft
    TabOrder = 2
    OnDocumentComplete = WebBDocumentComplete
    ControlData = {
      4C000000942D0000E42A00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object MainMenu: TMainMenu
    Left = 72
    Top = 8
    object mFile: TMenuItem
      Caption = '&File'
      object mNewCO: TMenuItem
        Caption = '&New CO'
        OnClick = mNewCOClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mQuit: TMenuItem
        Caption = '&Exit'
        OnClick = mQuitClick
      end
    end
    object mTools: TMenuItem
      Caption = '&Tools'
      object mStop: TMenuItem
        Caption = '&Stop current process'
        Enabled = False
        OnClick = mStopClick
      end
      object mPause: TMenuItem
        AutoCheck = True
        Caption = '&Toggle Pause ON/OFF'
        Enabled = False
        OnClick = mPauseClick
      end
    end
    object mAbout: TMenuItem
      Caption = '&About'
      OnClick = mAboutClick
    end
    object TMenuItem
    end
    object mInfo: TMenuItem
      Caption = 'Adding in :'
    end
    object mSecondsAjout: TMenuItem
      Caption = '0'
    end
  end
  object TimerDelay: TTimer
    Enabled = False
    OnTimer = DelayTimer
    Left = 40
    Top = 8
  end
end
