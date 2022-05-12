unit unModSelecoes;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdtSelecoes = class(TDataModule)
    ConsProdutos: TFDQuery;
    dsConsProdutos: TDataSource;
    ConsProdutosCODIGO: TIntegerField;
    ConsProdutosDESCRICAO: TStringField;
    ConsProdutosVALOR: TFMTBCDField;
    ConsProdutosEXIGE_CONTROLE_ESPECIAL: TIntegerField;
    ConsClientes: TFDQuery;
    dsConsClientes: TDataSource;
    ConsClientesCODIGO: TIntegerField;
    ConsClientesCPF: TStringField;
    ConsClientesNOME: TStringField;
    ConsPedidosVenda: TFDQuery;
    dsConsPedidosVenda: TDataSource;
    ConsPedidosVendaCODIGO: TIntegerField;
    ConsPedidosVendaPRODUTO_ID: TIntegerField;
    ConsPedidosVendaDT_PEDIDO: TDateField;
    ConsPedidosVendaQTDE_ITEM: TBCDField;
    ConsPedidosVendaVALOR_TOTAL: TFMTBCDField;
    ConsPedidosVendaSTATUS: TStringField;
    ConsPedidosVendaCLIENTE_ID: TIntegerField;
    ConsPedidosVendaDESCRICAO: TStringField;
    ConsPedidosVendaVALOR: TFMTBCDField;
    ConsPedidosVendaCPF: TStringField;
    ConsPedidosVendaNOME: TStringField;
    ConsPedidosVendaEXIGE_CONTROLE_ESPECIAL: TIntegerField;
    ConsTecnicoAgricola: TFDQuery;
    dsConsTecnicoAgricola: TDataSource;
    ConsTecnicoAgricolaNOME: TStringField;
    ConsTecnicoAgricolaNUMERO_REGISTRO: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtSelecoes: TdtSelecoes;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  unModPrincipal;

end.
