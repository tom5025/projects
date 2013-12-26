object FrmParamsDlg: TFrmParamsDlg
  Left = 460
  Top = 107
  BorderStyle = bsNone
  Caption = 'Parametres'
  ClientHeight = 86
  ClientWidth = 199
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = pmParams
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblCode: TLabel
    Left = 17
    Top = 17
    Width = 57
    Height = 13
    Caption = 'RGA Code :'
  end
  object lblRefresh: TLabel
    Left = 5
    Top = 34
    Width = 69
    Height = 13
    Caption = 'Refresh Rate :'
  end
  object tbRGACode: TEdit
    Left = 76
    Top = 15
    Width = 121
    Height = 19
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    Text = '13000'
  end
  object btGO: TButton
    Left = 77
    Top = 53
    Width = 119
    Height = 16
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btGOClick
  end
  object tbRefreshRate: TEdit
    Left = 76
    Top = 32
    Width = 121
    Height = 19
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    Text = '30'
  end
  object pnCaption: TPanel
    Left = 0
    Top = 0
    Width = 199
    Height = 13
    Align = alTop
    Caption = 'Parametres'
    PopupMenu = pmParams
    TabOrder = 5
  end
  object btPause: TButton
    Left = 0
    Top = 53
    Width = 76
    Height = 17
    Caption = 'Pause'
    Enabled = False
    TabOrder = 3
    OnClick = btPauseClick
  end
  object btStop: TButton
    Left = 0
    Top = 70
    Width = 76
    Height = 16
    Caption = 'Stop'
    Enabled = False
    TabOrder = 4
    OnClick = btStopClick
  end
  object pmParams: TPopupMenu
    Left = 160
    Top = 72
    object mFermer: TMenuItem
      Caption = '&Fermer'
      ShortCut = 16499
      OnClick = mFermerClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mStop: TMenuItem
      Caption = '&Stopper la capture'
      Enabled = False
      ShortCut = 49235
      OnClick = mStopClick
    end
    object mPause: TMenuItem
      AutoCheck = True
      Caption = '&Pause'
      Enabled = False
      ShortCut = 16467
      OnClick = mPauseClick
    end
  end
end
