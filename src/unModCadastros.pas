unit unModCadastros;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdtCadastros = class(TDataModule)
    Produtos: TFDQuery;
    dsProdutos: TDataSource;
    Clientes: TFDQuery;
    dsClientes: TDataSource;
    upProdutos: TFDUpdateSQL;
    upClientes: TFDUpdateSQL;
    TecnicoAgricola: TFDQuery;
    upTecnicoAgricola: TFDUpdateSQL;
    dsTecnicoAgricola: TDataSource;
    ClientesCODIGO: TIntegerField;
    ClientesCPF: TStringField;
    ClientesNOME: TStringField;
    ProdutosCODIGO: TIntegerField;
    ProdutosDESCRICAO: TStringField;
    ProdutosVALOR: TFMTBCDField;
    ProdutosEXIGE_CONTROLE_ESPECIAL: TIntegerField;
    TecnicoAgricolaCPF: TStringField;
    TecnicoAgricolaNOME: TStringField;
    TecnicoAgricolaNUMERO_REGISTRO: TStringField;
    PedidosVenda: TFDQuery;
    dsPedidosVenda: TDataSource;
    upPedidosVenda: TFDUpdateSQL;
    PedidosVendaCODIGO: TIntegerField;
    PedidosVendaPRODUTO_ID: TIntegerField;
    PedidosVendaDT_PEDIDO: TDateField;
    PedidosVendaQTDE_ITEM: TBCDField;
    PedidosVendaVALOR_TOTAL: TFMTBCDField;
    PedidosVendaSTATUS: TStringField;
    PedidosVendaCLIENTE_ID: TIntegerField;
  private
    { Private declarations }
  public
    function getCodigoProduto: Integer;
    function getCodigoCliente: Integer;
    function getCodigoPedidoVenda: Integer;
    { Public declarations }
  end;

var
  dtCadastros: TdtCadastros;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  unModPrincipal;

function TdtCadastros.getCodigoProduto: Integer;
begin
  Result := GetIDGen('GEN_CODIGOPRODUTO');
end;

function TdtCadastros.getCodigoCliente: Integer;
begin
  Result := GetIDGen('GEN_CODIGOCLIENTE');
end;

function TdtCadastros.getCodigoPedidoVenda: Integer;
begin
  Result := GetIDGen('GEN_PEDIDOSVENDA');
end;

end.
