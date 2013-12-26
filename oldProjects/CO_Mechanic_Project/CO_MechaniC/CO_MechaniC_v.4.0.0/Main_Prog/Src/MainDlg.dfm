object FrmMain: TFrmMain
  Left = 296
  Top = 185
  Width = 555
  Height = 429
  Caption = 'CO_Mechanic v.4.0.0'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu: TMainMenu
    object mFile: TMenuItem
      Caption = '&Fichier'
      object mQuit: TMenuItem
        Caption = '&Quitter'
        OnClick = mQuitClick
      end
    end
    object mConsult: TMenuItem
      Caption = '&Consulter'
    end
    object mSearch: TMenuItem
      Caption = '&Rechercher'
    end
    object mCapturer: TMenuItem
      Caption = '&Capturer'
      OnClick = mCapturerClick
    end
  end
end
