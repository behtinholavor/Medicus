object frmForm: TfrmForm
  Left = 0
  Top = 0
  Caption = 'frmForm'
  ClientHeight = 267
  ClientWidth = 498
  Color = clWindow
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Visible = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object pnlForm: TRzPanel
    Left = 0
    Top = 0
    Width = 498
    Height = 267
    Align = alClient
    BorderOuter = fsFlat
    Color = clWhite
    TabOrder = 0
  end
  object aclFuncoes: TActionList
    Left = 16
    Top = 16
    object actSair: TAction
      Caption = 'Sair'
      ImageIndex = 42
      ShortCut = 27
      OnExecute = actSairExecute
    end
  end
end
