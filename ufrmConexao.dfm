inherited frmConexao: TfrmConexao
  BorderStyle = bsDialog
  Caption = 'Conex'#227'o'
  ClientHeight = 250
  ClientWidth = 400
  FormStyle = fsNormal
  Position = poScreenCenter
  Visible = False
  OnDeactivate = FormDeactivate
  ExplicitWidth = 406
  ExplicitHeight = 279
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlForm: TRzPanel
    Width = 400
    Height = 250
    ExplicitWidth = 400
    ExplicitHeight = 250
    object pnlConexao: TRzPanel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 392
      Height = 242
      Align = alClient
      BorderOuter = fsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      object rdgConexoes: TRzRadioGroup
        AlignWithMargins = True
        Left = 1
        Top = 1
        Width = 390
        Height = 197
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        BorderColor = clWhite
        BorderSides = []
        Caption = ' Selecione a base '
        FlatColor = clWhite
        FlatColorAdjustment = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        SpaceEvenly = True
        TabOrder = 0
      end
      object pnlInferior: TRzPanel
        Left = 0
        Top = 199
        Width = 392
        Height = 43
        Align = alBottom
        BorderOuter = fsNone
        ParentColor = True
        TabOrder = 1
        object btnConectar: TcxButton
          AlignWithMargins = True
          Left = 1
          Top = 1
          Width = 170
          Height = 41
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alLeft
          Action = actConectar
          LookAndFeel.Kind = lfOffice11
          LookAndFeel.NativeStyle = False
          TabOrder = 0
        end
        object btnSair: TcxButton
          AlignWithMargins = True
          Left = 221
          Top = 1
          Width = 170
          Height = 41
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alRight
          Action = actSair
          LookAndFeel.Kind = lfOffice11
          TabOrder = 1
        end
      end
    end
  end
  object rifConexao: TRzRegIniFile [1]
    FileEncoding = feUTF8
    Left = 16
    Top = 62
  end
  inherited aclFuncoes: TActionList
    object actConectar: TAction
      Caption = 'Conectar'
      ImageIndex = 43
      OnExecute = actConectarExecute
    end
  end
end
