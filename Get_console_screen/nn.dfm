object Form1: TForm1
  Left = 225
  Top = 131
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Get console screen'
  ClientHeight = 625
  ClientWidth = 545
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 120
  TextHeight = 16
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 201
    Height = 25
    Caption = #1050#1091#1088#1089#1086#1088
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 40
    Width = 161
    Height = 25
    Caption = #1050#1086#1085#1089#1086#1083#1100#1085#1099#1081' '#1074#1099#1074#1086#1076
    TabOrder = 1
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 328
    Width = 529
    Height = 289
    Lines.Strings = (
      'Programming'
      '  '
      'Gary Bearchell'
      'Andrew Brownsword'
      'Will Chen'
      'Spencer Craske'
      'Greg D'#39'Esposito'
      'Stephen Friesen'
      'Brad Gour'
      'Scott Hansen'
      'Safet Hrbinic'
      'Robinson Huff'
      'Philip Ibis'
      'Nenad Jankovic'
      'Gareth Jones'
      'Mike Kiernan'
      'Cliff Kondratiuk'
      'Jonathan Korol'
      'Paul Ku'
      'David Lam'
      'Peter Lolley'
      'Andrew McPherson')
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object Button3: TButton
    Left = 216
    Top = 8
    Width = 153
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' INI'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 376
    Top = 8
    Width = 161
    Height = 25
    Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' INI'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 8
    Top = 232
    Width = 177
    Height = 25
    Caption = #1055#1088#1086#1074#1077#1088#1082#1072' CRC'
    TabOrder = 5
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 192
    Top = 232
    Width = 169
    Height = 25
    Caption = 'Compress Memo'
    TabOrder = 6
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 368
    Top = 232
    Width = 169
    Height = 25
    Caption = 'Decompress Memo'
    TabOrder = 7
    OnClick = Button7Click
  end
  object CheckBox1: TCheckBox
    Left = 320
    Top = 48
    Width = 217
    Height = 17
    Caption = #1047#1072#1087#1091#1089#1082#1072#1090#1100' '#1073#1077#1079' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074
    TabOrder = 8
  end
  object ComboBox1: TComboBox
    Left = 176
    Top = 40
    Width = 137
    Height = 24
    ItemHeight = 16
    Sorted = True
    TabOrder = 9
    Text = 'ping.exe'
    Items.Strings = (
      'arj.exe'
      'calc.exe'
      'command.com'
      'commander.exe'
      'dir'
      'notepad.exe'
      'ping 127.0.0.1'
      'prolog.exe')
  end
  object Button8: TButton
    Left = 8
    Top = 72
    Width = 529
    Height = 25
    Caption = #1047#1072#1087#1091#1089#1082' '#1082#1086#1085#1089#1086#1083#1100#1086#1075#1086' '#1086#1082#1085#1072' '#1073#1077#1079' '#1086#1078#1080#1076#1072#1085#1080#1103' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1103
    TabOrder = 10
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 8
    Top = 104
    Width = 529
    Height = 25
    Caption = #1047#1072#1087#1091#1089#1082' '#1082#1086#1085#1089#1086#1083#1100#1086#1075#1086' '#1086#1082#1085#1072' '#1089' '#1086#1078#1080#1076#1072#1085#1080#1077#1084' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1103
    TabOrder = 11
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 8
    Top = 136
    Width = 529
    Height = 25
    Caption = #1054#1090#1082#1088#1099#1090#1100' '#1087#1088#1086#1075#1088#1072#1084#1084#1091' '#1089' '#1087#1072#1088#1072#1084#1077#1090#1088#1072#1084#1080' '#1085#1077' '#1076#1086#1078#1080#1076#1072#1103#1089#1100' '#1077#1077' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1103
    TabOrder = 12
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 8
    Top = 168
    Width = 529
    Height = 25
    Caption = #1054#1090#1082#1088#1099#1090#1100' '#1087#1088#1086#1075#1088#1072#1084#1084#1091' '#1089' '#1087#1072#1088#1072#1084#1077#1090#1088#1072#1084#1080' '#1080' '#1076#1086#1078#1076#1072#1090#1100#1089#1103' '#1077#1077' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1103
    TabOrder = 13
    OnClick = Button11Click
  end
  object Button12: TButton
    Left = 8
    Top = 200
    Width = 177
    Height = 25
    Caption = 'Exec and Wait'
    TabOrder = 14
    OnClick = Button12Click
  end
  object Button13: TButton
    Left = 192
    Top = 200
    Width = 345
    Height = 25
    Caption = #1047#1072#1087#1091#1089#1082' '#1082#1086#1085#1089'. '#1087#1088#1080#1083#1086#1078'. '#1080' '#1087#1086#1083#1091#1095'. '#1077#1075#1086' '#1089#1090#1072#1085#1076'. '#1074#1099#1074#1086#1076#1072
    TabOrder = 15
    OnClick = Button13Click
  end
  object Button14: TButton
    Left = 8
    Top = 264
    Width = 257
    Height = 25
    Caption = 'Run DOS in Memo 1'
    TabOrder = 16
    OnClick = Button14Click
  end
  object Button15: TButton
    Left = 280
    Top = 264
    Width = 257
    Height = 25
    Caption = 'Run DOS in Memo 2'
    TabOrder = 17
    OnClick = Button15Click
  end
  object Button16: TButton
    Left = 8
    Top = 296
    Width = 161
    Height = 25
    Caption = 'Exec and Wait 1'
    TabOrder = 18
    OnClick = Button16Click
  end
  object Button17: TButton
    Left = 176
    Top = 296
    Width = 161
    Height = 25
    Caption = 'Exec and Wait 2'
    TabOrder = 19
    OnClick = Button17Click
  end
  object Button18: TButton
    Left = 344
    Top = 296
    Width = 193
    Height = 25
    Caption = #1042#1099#1074#1086#1076' '#1082#1086#1085#1089#1086#1083#1080
    TabOrder = 20
    OnClick = Button18Click
  end
end
