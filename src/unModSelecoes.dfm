object dtSelecoes: TdtSelecoes
  OldCreateOrder = False
  Height = 256
  Width = 329
  object ConsProdutos: TFDQuery
    Connection = DMPrincipal.FireDacCon
    SQL.Strings = (
      'SELECT CODIGO, DESCRICAO, VALOR, EXIGE_CONTROLE_ESPECIAL'
      '  FROM PRODUTOS'
      'WHERE (CODIGO = :CODIGO OR :CODIGO = -1)')
    Left = 24
    Top = 24
    ParamData = <
      item
        Name = 'CODIGO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object ConsProdutosCODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ConsProdutosDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 200
    end
    object ConsProdutosVALOR: TFMTBCDField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
      Origin = 'VALOR'
      Precision = 18
      Size = 2
    end
    object ConsProdutosEXIGE_CONTROLE_ESPECIAL: TIntegerField
      DisplayLabel = 'Exige Controle Especial'
      FieldName = 'EXIGE_CONTROLE_ESPECIAL'
      Origin = 'EXIGE_CONTROLE_ESPECIAL'
    end
  end
  object dsConsProdutos: TDataSource
    DataSet = ConsProdutos
    Left = 104
    Top = 24
  end
  object ConsClientes: TFDQuery
    Connection = DMPrincipal.FireDacCon
    SQL.Strings = (
      'SELECT CODIGO, CPF, NOME'
      '  FROM CLIENTES'
      'WHERE (CODIGO = :CODIGO OR :CODIGO = -1)')
    Left = 32
    Top = 80
    ParamData = <
      item
        Name = 'CODIGO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object ConsClientesCODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ConsClientesCPF: TStringField
      FieldName = 'CPF'
      Origin = 'CPF'
      Required = True
      Size = 11
    end
    object ConsClientesNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 50
    end
  end
  object dsConsClientes: TDataSource
    DataSet = ConsClientes
    Left = 104
    Top = 88
  end
  object ConsPedidosVenda: TFDQuery
    Connection = DMPrincipal.FireDacCon
    SQL.Strings = (
      
        'SELECT V.CODIGO, V.PRODUTO_ID, V.DT_PEDIDO, V.QTDE_ITEM, V.VALOR' +
        '_TOTAL, V.STATUS, V.CLIENTE_ID,'
      
        '       P.DESCRICAO, P.VALOR, C.CPF, C.NOME, P.EXIGE_CONTROLE_ESP' +
        'ECIAL'
      '  FROM PEDIDOS_VENDA V'
      '  INNER JOIN PRODUTOS P ON P.CODIGO = V.PRODUTO_ID'
      '  INNER JOIN CLIENTES C ON C.CODIGO = V.CLIENTE_ID'
      'WHERE V.DT_PEDIDO >= :DT_INICIAL AND V.DT_PEDIDO <= :DT_FINAL'
      '     AND (STATUS = :STATUS OR :STATUS = '#39'?'#39')'
      'ORDER BY V.CODIGO')
    Left = 200
    Top = 40
    ParamData = <
      item
        Name = 'DT_INICIAL'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DT_FINAL'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'STATUS'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    object ConsPedidosVendaCODIGO: TIntegerField
      DisplayLabel = 'N'#176' Pedido'
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ConsPedidosVendaPRODUTO_ID: TIntegerField
      DisplayLabel = 'C'#243'd. Produto'
      FieldName = 'PRODUTO_ID'
      Origin = 'PRODUTO_ID'
      Required = True
    end
    object ConsPedidosVendaDT_PEDIDO: TDateField
      DisplayLabel = 'Data Pedido'
      FieldName = 'DT_PEDIDO'
      Origin = 'DT_PEDIDO'
      Required = True
    end
    object ConsPedidosVendaQTDE_ITEM: TBCDField
      DisplayLabel = 'Quantidade'
      FieldName = 'QTDE_ITEM'
      Origin = 'QTDE_ITEM'
      DisplayFormat = '#,##0.0000'
      Precision = 18
    end
    object ConsPedidosVendaVALOR_TOTAL: TFMTBCDField
      DisplayLabel = 'Valor Total'
      FieldName = 'VALOR_TOTAL'
      Origin = 'VALOR_TOTAL'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object ConsPedidosVendaSTATUS: TStringField
      DisplayLabel = 'Status'
      FieldName = 'STATUS'
      Origin = 'STATUS'
      Required = True
      FixedChar = True
      Size = 1
    end
    object ConsPedidosVendaCLIENTE_ID: TIntegerField
      FieldName = 'CLIENTE_ID'
      Origin = 'CLIENTE_ID'
      Required = True
    end
    object ConsPedidosVendaDESCRICAO: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 200
    end
    object ConsPedidosVendaVALOR: TFMTBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Valor Produto'
      FieldName = 'VALOR'
      Origin = 'VALOR'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object ConsPedidosVendaCPF: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CPF'
      Origin = 'CPF'
      ProviderFlags = []
      ReadOnly = True
      Size = 11
    end
    object ConsPedidosVendaNOME: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object ConsPedidosVendaEXIGE_CONTROLE_ESPECIAL: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'EXIGE_CONTROLE_ESPECIAL'
      Origin = 'EXIGE_CONTROLE_ESPECIAL'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object dsConsPedidosVenda: TDataSource
    DataSet = ConsPedidosVenda
    Left = 208
    Top = 88
  end
  object ConsTecnicoAgricola: TFDQuery
    Connection = DMPrincipal.FireDacCon
    SQL.Strings = (
      'SELECT NOME, NUMERO_REGISTRO'
      '  FROM TECNICO_AGRICOLA')
    Left = 40
    Top = 184
    object ConsTecnicoAgricolaNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 50
    end
    object ConsTecnicoAgricolaNUMERO_REGISTRO: TStringField
      FieldName = 'NUMERO_REGISTRO'
      Origin = 'NUMERO_REGISTRO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
  end
  object dsConsTecnicoAgricola: TDataSource
    DataSet = ConsTecnicoAgricola
    Left = 160
    Top = 184
  end
end
