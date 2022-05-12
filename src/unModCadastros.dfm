object dtCadastros: TdtCadastros
  OldCreateOrder = False
  Height = 346
  Width = 485
  object Produtos: TFDQuery
    CachedUpdates = True
    Connection = DMPrincipal.FireDacCon
    Transaction = DMPrincipal.FireTransCon
    UpdateTransaction = DMPrincipal.FireTransCon
    UpdateObject = upProdutos
    SQL.Strings = (
      '  SELECT CODIGO, DESCRICAO, VALOR, EXIGE_CONTROLE_ESPECIAL'
      '    FROM PRODUTOS')
    Left = 392
    Top = 8
    object ProdutosCODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ProdutosDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 200
    end
    object ProdutosVALOR: TFMTBCDField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
      Origin = 'VALOR'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object ProdutosEXIGE_CONTROLE_ESPECIAL: TIntegerField
      FieldName = 'EXIGE_CONTROLE_ESPECIAL'
      Origin = 'EXIGE_CONTROLE_ESPECIAL'
    end
  end
  object dsProdutos: TDataSource
    DataSet = Produtos
    Left = 392
    Top = 56
  end
  object Clientes: TFDQuery
    CachedUpdates = True
    Connection = DMPrincipal.FireDacCon
    Transaction = DMPrincipal.FireTransCon
    UpdateTransaction = DMPrincipal.FireTransCon
    UpdateObject = upClientes
    SQL.Strings = (
      'SELECT CODIGO, CPF, NOME'
      '  FROM CLIENTES')
    Left = 40
    Top = 8
    object ClientesCODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ClientesCPF: TStringField
      FieldName = 'CPF'
      Origin = 'CPF'
      Required = True
      Size = 11
    end
    object ClientesNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 50
    end
  end
  object dsClientes: TDataSource
    DataSet = Clientes
    Left = 40
    Top = 56
  end
  object upProdutos: TFDUpdateSQL
    Connection = DMPrincipal.FireDacCon
    InsertSQL.Strings = (
      'INSERT INTO PRODUTOS'
      '(CODIGO, DESCRICAO, VALOR, EXIGE_CONTROLE_ESPECIAL)'
      
        'VALUES (:NEW_CODIGO, :NEW_DESCRICAO, :NEW_VALOR, :NEW_EXIGE_CONT' +
        'ROLE_ESPECIAL)')
    ModifySQL.Strings = (
      'UPDATE PRODUTOS'
      
        'SET CODIGO = :NEW_CODIGO, DESCRICAO = :NEW_DESCRICAO, VALOR = :N' +
        'EW_VALOR, '
      '  EXIGE_CONTROLE_ESPECIAL = :NEW_EXIGE_CONTROLE_ESPECIAL'
      'WHERE CODIGO = :OLD_CODIGO')
    DeleteSQL.Strings = (
      'DELETE FROM PRODUTOS'
      'WHERE CODIGO = :OLD_CODIGO')
    FetchRowSQL.Strings = (
      'SELECT CODIGO, DESCRICAO, VALOR, EXIGE_CONTROLE_ESPECIAL'
      'FROM PRODUTOS'
      'WHERE CODIGO = :OLD_CODIGO')
    Left = 392
    Top = 104
  end
  object upClientes: TFDUpdateSQL
    Connection = DMPrincipal.FireDacCon
    InsertSQL.Strings = (
      'INSERT INTO CLIENTES'
      '(CODIGO, CPF, NOME)'
      'VALUES (:NEW_CODIGO, :NEW_CPF, :NEW_NOME)')
    ModifySQL.Strings = (
      'UPDATE CLIENTES'
      'SET CODIGO = :NEW_CODIGO, CPF = :NEW_CPF, NOME = :NEW_NOME'
      'WHERE CODIGO = :OLD_CODIGO')
    DeleteSQL.Strings = (
      'DELETE FROM CLIENTES'
      'WHERE CODIGO = :OLD_CODIGO')
    FetchRowSQL.Strings = (
      'SELECT CODIGO, CPF, NOME'
      'FROM CLIENTES'
      'WHERE CODIGO = :OLD_CODIGO')
    Left = 43
    Top = 104
  end
  object TecnicoAgricola: TFDQuery
    CachedUpdates = True
    Connection = DMPrincipal.FireDacCon
    SQL.Strings = (
      'SELECT CPF, NOME, NUMERO_REGISTRO'
      '  FROM TECNICO_AGRICOLA')
    Left = 40
    Top = 192
    object TecnicoAgricolaCPF: TStringField
      FieldName = 'CPF'
      Origin = 'CPF'
      Required = True
      Size = 11
    end
    object TecnicoAgricolaNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 50
    end
    object TecnicoAgricolaNUMERO_REGISTRO: TStringField
      DisplayLabel = 'N'#176' Registro'
      FieldName = 'NUMERO_REGISTRO'
      Origin = 'NUMERO_REGISTRO'
      Required = True
    end
  end
  object upTecnicoAgricola: TFDUpdateSQL
    Connection = DMPrincipal.FireDacCon
    Left = 48
    Top = 288
  end
  object dsTecnicoAgricola: TDataSource
    DataSet = TecnicoAgricola
    Left = 48
    Top = 240
  end
  object PedidosVenda: TFDQuery
    Active = True
    CachedUpdates = True
    Connection = DMPrincipal.FireDacCon
    Transaction = DMPrincipal.FireTransCon
    UpdateTransaction = DMPrincipal.FireTransCon
    UpdateObject = upPedidosVenda
    SQL.Strings = (
      
        'SELECT CODIGO, PRODUTO_ID, DT_PEDIDO, QTDE_ITEM, VALOR_TOTAL, ST' +
        'ATUS, CLIENTE_ID, REGISTRO_ID'
      '  FROM PEDIDOS_VENDA')
    Left = 264
    Top = 192
    object PedidosVendaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object PedidosVendaPRODUTO_ID: TIntegerField
      FieldName = 'PRODUTO_ID'
      Origin = 'PRODUTO_ID'
      Required = True
    end
    object PedidosVendaDT_PEDIDO: TDateField
      FieldName = 'DT_PEDIDO'
      Origin = 'DT_PEDIDO'
      Required = True
    end
    object PedidosVendaQTDE_ITEM: TBCDField
      FieldName = 'QTDE_ITEM'
      Origin = 'QTDE_ITEM'
      DisplayFormat = '#,##0.0000'
      Precision = 18
    end
    object PedidosVendaVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Origin = 'VALOR_TOTAL'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object PedidosVendaSTATUS: TStringField
      FieldName = 'STATUS'
      Origin = 'STATUS'
      Required = True
      FixedChar = True
      Size = 1
    end
    object PedidosVendaCLIENTE_ID: TIntegerField
      FieldName = 'CLIENTE_ID'
      Origin = 'CLIENTE_ID'
      Required = True
    end
    object PedidosVendaREGISTRO_ID: TStringField
      FieldName = 'REGISTRO_ID'
      Origin = 'REGISTRO_ID'
    end
  end
  object dsPedidosVenda: TDataSource
    DataSet = PedidosVenda
    Left = 264
    Top = 240
  end
  object upPedidosVenda: TFDUpdateSQL
    Connection = DMPrincipal.FireDacCon
    InsertSQL.Strings = (
      'INSERT INTO PEDIDOS_VENDA'
      '(CODIGO, CLIENTE_ID, PRODUTO_ID, DT_PEDIDO, '
      '  QTDE_ITEM, VALOR_TOTAL, STATUS, REGISTRO_ID)'
      
        'VALUES (:NEW_CODIGO, :NEW_CLIENTE_ID, :NEW_PRODUTO_ID, :NEW_DT_P' +
        'EDIDO, '
      
        '  :NEW_QTDE_ITEM, :NEW_VALOR_TOTAL, :NEW_STATUS, :NEW_REGISTRO_I' +
        'D)')
    ModifySQL.Strings = (
      'UPDATE PEDIDOS_VENDA'
      
        'SET CODIGO = :NEW_CODIGO, CLIENTE_ID = :NEW_CLIENTE_ID, PRODUTO_' +
        'ID = :NEW_PRODUTO_ID, '
      '  DT_PEDIDO = :NEW_DT_PEDIDO, QTDE_ITEM = :NEW_QTDE_ITEM, '
      
        '  VALOR_TOTAL = :NEW_VALOR_TOTAL, STATUS = :NEW_STATUS, REGISTRO' +
        '_ID = :NEW_REGISTRO_ID'
      'WHERE CODIGO = :OLD_CODIGO')
    DeleteSQL.Strings = (
      'DELETE FROM PEDIDOS_VENDA'
      'WHERE CODIGO = :OLD_CODIGO')
    FetchRowSQL.Strings = (
      
        'SELECT CODIGO, CLIENTE_ID, PRODUTO_ID, DT_PEDIDO, QTDE_ITEM, VAL' +
        'OR_TOTAL, '
      '  STATUS, REGISTRO_ID'
      'FROM PEDIDOS_VENDA'
      'WHERE CODIGO = :OLD_CODIGO')
    Left = 264
    Top = 294
  end
end
