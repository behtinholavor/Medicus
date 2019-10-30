inherited frmUsuarios: TfrmUsuarios
  Caption = 'frmUsuarios'
  ClientWidth = 788
  ExplicitWidth = 804
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlForm: TRzPanel
    Width = 788
    ExplicitWidth = 120
    ExplicitHeight = 0
    inherited pnlInferior: TRzPanel
      Width = 784
      inherited pnlAcoes: TRzPanel
        Width = 263
        Align = alLeft
        ExplicitWidth = 263
      end
    end
    inherited pgcCadastro: TRzPageControl
      Width = 786
      ExplicitWidth = 118
      FixedDimension = 22
      inherited tbsCadastro: TRzTabSheet
        ExplicitWidth = 114
        inherited pnlCadastro: TRzPanel
          Width = 782
          Font.Height = -14
          ParentFont = False
          ExplicitLeft = -16
          ExplicitWidth = 726
          ExplicitHeight = 372
        end
      end
      inherited tbsPesquisa: TRzTabSheet
        ExplicitWidth = 950
        ExplicitHeight = 371
        inherited grdPesquisa: TcxGrid
          Width = 782
          ExplicitWidth = 950
          ExplicitHeight = 371
        end
      end
    end
  end
  inherited aclFuncoes: TActionList
    inherited actInserir: TAction
      Category = 'A'#231#227'o'
    end
    inherited actAlterar: TAction
      Category = 'A'#231#227'o'
    end
    inherited actExcluir: TAction
      Category = 'A'#231#227'o'
    end
    inherited actGravar: TAction
      Category = 'A'#231#227'o'
    end
    inherited actCancelar: TAction
      Category = 'A'#231#227'o'
    end
  end
  inherited dttCadastro: TIBDataSet
    AfterInsert = dttCadastroAfterInsert
    DeleteSQL.Strings = (
      'delete from USUARIOS'
      'where'
      '  CODUSUARIO = :OLD_CODUSUARIO')
    InsertSQL.Strings = (
      'insert into USUARIOS'
      
        '  (ATIVO, CODBINARIO, CODPERFIL, CODUSUARIO, DT_CADAST, DT_MODIF' +
        'I, EMAIL, '
      '   LOGIN, SENHA, US_CADAST, US_MODIFI, USUARIO)'
      'values'
      
        '  (:ATIVO, :CODBINARIO, :CODPERFIL, :CODUSUARIO, :DT_CADAST, :DT' +
        '_MODIFI, '
      '   :EMAIL, :LOGIN, :SENHA, :US_CADAST, :US_MODIFI, :USUARIO)')
    RefreshSQL.Strings = (
      'Select '
      '  CODUSUARIO,'
      '  USUARIO,'
      '  LOGIN,'
      '  SENHA,'
      '  EMAIL,'
      '  ATIVO,'
      '  CODPERFIL,'
      '  CODBINARIO,'
      '  US_CADAST,'
      '  DT_CADAST,'
      '  US_MODIFI,'
      '  DT_MODIFI'
      'from USUARIOS '
      'where'
      '  CODUSUARIO = :CODUSUARIO')
    SelectSQL.Strings = (
      'select'
      '  *'
      'from'
      '  USUARIOS'
      'order by'
      '  USUARIOS.CODUSUARIO')
    ModifySQL.Strings = (
      'update USUARIOS'
      'set'
      '  ATIVO = :ATIVO,'
      '  CODBINARIO = :CODBINARIO,'
      '  CODPERFIL = :CODPERFIL,'
      '  CODUSUARIO = :CODUSUARIO,'
      '  DT_CADAST = :DT_CADAST,'
      '  DT_MODIFI = :DT_MODIFI,'
      '  EMAIL = :EMAIL,'
      '  LOGIN = :LOGIN,'
      '  SENHA = :SENHA,'
      '  US_CADAST = :US_CADAST,'
      '  US_MODIFI = :US_MODIFI,'
      '  USUARIO = :USUARIO'
      'where'
      '  CODUSUARIO = :OLD_CODUSUARIO')
    GeneratorField.Field = 'CODUSUARIO'
    GeneratorField.Generator = 'GEN_USUARIOS'
    GeneratorField.ApplyEvent = gamOnPost
    object dttCadastroCODUSUARIO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODUSUARIO'
      Origin = '"USUARIOS"."CODUSUARIO"'
      ProviderFlags = [pfInKey]
    end
    object dttCadastroUSUARIO: TIBStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'USUARIO'
      Origin = '"USUARIOS"."USUARIO"'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object dttCadastroLOGIN: TIBStringField
      DisplayLabel = 'Login'
      FieldName = 'LOGIN'
      Origin = '"USUARIOS"."LOGIN"'
      Required = True
      Size = 45
    end
    object dttCadastroSENHA: TIBStringField
      DisplayLabel = 'Senha'
      FieldName = 'SENHA'
      Origin = '"USUARIOS"."SENHA"'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 500
    end
    object dttCadastroEMAIL: TIBStringField
      DisplayLabel = 'e-mail'
      FieldName = 'EMAIL'
      Origin = '"USUARIOS"."EMAIL"'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object dttCadastroATIVO: TIBStringField
      DisplayLabel = 'Ativo'
      FieldName = 'ATIVO'
      Origin = '"USUARIOS"."ATIVO"'
      ProviderFlags = [pfInUpdate]
      Size = 3
    end
    object dttCadastroCODPERFIL: TIntegerField
      DisplayLabel = 'Perfil'
      FieldName = 'CODPERFIL'
      Origin = '"USUARIOS"."CODPERFIL"'
      ProviderFlags = []
    end
    object dttCadastroCODBINARIO: TIntegerField
      DisplayLabel = 'Cod. bin'#225'rio'
      FieldName = 'CODBINARIO'
      Origin = '"USUARIOS"."CODBINARIO"'
      ProviderFlags = []
    end
    object dttCadastroUS_CADAST: TIBStringField
      DisplayLabel = 'Inserido por'
      FieldName = 'US_CADAST'
      Origin = '"USUARIOS"."US_CADAST"'
      ProviderFlags = []
      Size = 45
    end
    object dttCadastroDT_CADAST: TDateTimeField
      DisplayLabel = 'Inserido em'
      FieldName = 'DT_CADAST'
      Origin = '"USUARIOS"."DT_CADAST"'
      ProviderFlags = []
    end
    object dttCadastroUS_MODIFI: TIBStringField
      DisplayLabel = 'Alterado por'
      FieldName = 'US_MODIFI'
      Origin = '"USUARIOS"."US_MODIFI"'
      ProviderFlags = []
      Size = 45
    end
    object dttCadastroDT_MODIFI: TDateTimeField
      DisplayLabel = 'Alterado em'
      FieldName = 'DT_MODIFI'
      Origin = '"USUARIOS"."DT_MODIFI"'
      ProviderFlags = []
    end
  end
  inherited imlAcoes: TcxImageList
    FormatVersion = 1
  end
end
