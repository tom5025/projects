object Form1: TForm1
  Left = 196
  Top = 105
  Width = 901
  Height = 643
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 893
    Height = 616
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object btExecute13000: TButton
    Left = 24
    Top = 552
    Width = 225
    Height = 25
    Caption = 'btExecute13000'
    TabOrder = 1
    OnClick = btExecute13000Click
  end
  object SocketA: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Host = 'www.cotations.com'
    Port = 80
    OnDisconnect = SocketADisconnect
    Left = 32
    Top = 128
  end
  object HttpCli1: THttpCli
    LocalAddr = '0.0.0.0'
    ProxyPort = '80'
    Agent = 'Mozilla/3.0 (compatible)'
    Accept = 'image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, */*'
    NoCache = False
    ContentTypePost = 'application/x-www-form-urlencoded'
    MultiThreaded = False
    Left = 64
    Top = 128
  end
end
