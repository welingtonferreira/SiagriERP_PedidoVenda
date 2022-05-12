object DMPrincipal: TDMPrincipal
  OldCreateOrder = False
  Height = 358
  Width = 417
  object FireDacCon: TFDConnection
    Params.Strings = (
      'Database=D:\BACKUP\Testes\desafio_delphi_02\data\SIAGRIERP.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    TxOptions.Isolation = xiReadCommitted
    TxOptions.StopOptions = [xoIfAutoStarted]
    Connected = True
    LoginPrompt = False
    Transaction = FireTransCon
    UpdateTransaction = FireTransCon
    Left = 40
    Top = 16
  end
  object FireTransCon: TFDTransaction
    Options.Isolation = xiReadCommitted
    Options.AutoStop = False
    Options.StopOptions = [xoIfAutoStarted]
    Connection = FireDacCon
    Left = 40
    Top = 72
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 128
    Top = 24
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 128
    Top = 88
  end
end
