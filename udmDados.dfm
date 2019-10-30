object dmDados: TdmDados
  OldCreateOrder = False
  Height = 296
  Width = 550
  object dtbDados: TIBDatabase
    DatabaseName = 'localhost/3060:medicus'
    Params.Strings = (
      'lc_ctype=ISO8859_1'
      'password=medset'
      'user_name=SYSMED')
    LoginPrompt = False
    DefaultTransaction = trnDados
    AllowStreamedConnected = False
    Left = 24
    Top = 16
  end
  object trnDados: TIBTransaction
    DefaultDatabase = dtbDados
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 24
    Top = 64
  end
  object iniDados: TRzRegIniFile
    FileEncoding = feUTF8
    Left = 24
    Top = 114
  end
end
