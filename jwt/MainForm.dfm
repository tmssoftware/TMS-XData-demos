object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'TMS XData - JWT Demo'
  ClientHeight = 164
  ClientWidth = 215
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    215
    164)
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 201
    Height = 150
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    ExplicitWidth = 225
    ExplicitHeight = 161
    object TabSheet1: TTabSheet
      Caption = 'Login'
      ExplicitLeft = -28
      ExplicitTop = 16
      ExplicitWidth = 281
      ExplicitHeight = 165
      DesignSize = (
        193
        122)
      object Label1: TLabel
        Left = 20
        Top = 27
        Width = 56
        Height = 13
        Caption = 'User Name:'
      end
      object Label2: TLabel
        Left = 26
        Top = 51
        Width = 50
        Height = 13
        Caption = 'Password:'
      end
      object edUserName: TEdit
        Left = 85
        Top = 24
        Width = 88
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        Text = 'Jack'
        ExplicitWidth = 92
      end
      object edPassword: TEdit
        Left = 85
        Top = 48
        Width = 88
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
        Text = 'Jack'
        ExplicitWidth = 92
      end
      object btLogin: TButton
        Left = 60
        Top = 83
        Width = 75
        Height = 25
        Anchors = []
        Caption = 'Login'
        TabOrder = 2
        OnClick = btLoginClick
        ExplicitTop = 88
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Application'
      ImageIndex = 1
      ExplicitWidth = 345
      ExplicitHeight = 213
      DesignSize = (
        193
        122)
      object btHello: TButton
        Left = 60
        Top = 34
        Width = 75
        Height = 25
        Anchors = []
        Caption = 'Hello'
        TabOrder = 0
        OnClick = btHelloClick
        ExplicitLeft = 68
        ExplicitTop = 40
      end
      object btLogout: TButton
        Left = 60
        Top = 62
        Width = 75
        Height = 25
        Anchors = []
        Caption = 'Logout'
        TabOrder = 1
        OnClick = btLogoutClick
        ExplicitLeft = 68
        ExplicitTop = 71
      end
    end
  end
end
