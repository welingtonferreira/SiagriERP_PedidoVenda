unit unPedidosVenda1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.ComCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids;

type
  TfrmPedidosVenda1 = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    GroupBox1: TGroupBox;
    edtCodigo: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    LookupClientes: TDBLookupComboBox;
    edtDataPedido: TDateTimePicker;
    Label4: TLabel;
    Panel2: TPanel;
    Label7: TLabel;
    edtValor: TEdit;
    Label6: TLabel;
    LookupProdutos: TDBLookupComboBox;
    Label5: TLabel;
    edtQuantidade: TEdit;
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    Fechar: Boolean;
    Cancelou: Boolean;
    function ValidarGravar: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPedidosVenda1: TfrmPedidosVenda1;

implementation

{$R *.dfm}

uses
  unModPrincipal, unModCadastros, unModSelecoes;

function TfrmPedidosVenda1.ValidarGravar: Boolean;
begin
  Result := True;

  if Trim(LookupClientes.Text) = EmptyStr then
  begin
    ShowMessage('Cliente do pedido deve ser informado.');
    LookupClientes.SetFocus;
    Result := False;
    Exit;
  end;

  if Trim(LookupProdutos.Text) = EmptyStr then
  begin
    ShowMessage('Produto do pedido deve ser informado.');
    LookupProdutos.SetFocus;
    Result := False;
    Exit;
  end;

  if Trim(edtQuantidade.Text) = EmptyStr then
  begin
    ShowMessage('Quantidade do pedido deve ser informado.');
    LookupProdutos.SetFocus;
    Result := False;
    Exit;
  end;
end;

procedure TfrmPedidosVenda1.btnCancelarClick(Sender: TObject);
begin
  with dtCadastros do
  begin
    PedidosVenda.Cancel;
    PedidosVenda.CancelUpdates;
  end;
  RollBackRFD;
  Self.Cancelou := True;
  Fechar := True;
  Self.Close;
end;

procedure TfrmPedidosVenda1.btnGravarClick(Sender: TObject);
begin
  if (ValidarGravar) then
  begin
    with dtCadastros do
    begin
      try
        PedidosVenda.Edit;
        if PedidosVendaCODIGO.Value = 0 then
          PedidosVendaCODIGO.Value := getCodigoPedidoVenda;

        PedidosVendaCLIENTE_ID.Value := LookupClientes.KeyValue;
        PedidosVendaPRODUTO_ID.Value := LookupProdutos.KeyValue;
        PedidosVendaDT_PEDIDO.Value := edtDataPedido.Date;
        PedidosVendaQTDE_ITEM.Value := StrToFloat(edtQuantidade.Text);
        PedidosVendaVALOR_TOTAL.Value := StringReplace(edtValor.Text,'.','', [rfReplaceAll]);

        if Produtos.Locate('CODIGO', LookupProdutos.KeyValue, []) then
        begin
          if ProdutosEXIGE_CONTROLE_ESPECIAL.Value = 1 then
            PedidosVendaSTATUS.Value := 'R'
          else
            PedidosVendaSTATUS.Value := 'C';
        end;

        PedidosVenda.Post;

        if (PedidosVenda.CachedUpdates) then
        begin
          AplicarDados(PedidosVenda);
        end;
        CommitRFD;

        edtCodigo.Clear;
        edtQuantidade.Clear;
        edtValor.Clear;

        Fechar := True;
        Self.Close;
      except
        on E: Exception do
        begin
          ShowMessage('Não foi possível gravar o registro.' + E.Message);
          RollBackRFD;
        end;
      end;
    end;
  end;
end;

procedure TfrmPedidosVenda1.edtQuantidadeExit(Sender: TObject);
begin
  with dtCadastros do
  begin
    if Produtos.Locate('CODIGO', LookupProdutos.KeyValue, []) then
      edtValor.Text := FormatFloat('#,##0.00', (ProdutosVALOR.AsFloat * StrToFloat(edtQuantidade.Text)));
  end;
end;

procedure TfrmPedidosVenda1.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if not Fechar then
  begin
    btnCancelar.OnClick(Sender);
    CanClose := Fechar;
  end;
end;

procedure TfrmPedidosVenda1.FormShow(Sender: TObject);
begin
  with dtSelecoes do
  begin
    ConsClientes.Close;
    ConsClientes.ParamByName('CODIGO').AsInteger := -1;
    ConsClientes.Open;

    ConsProdutos.Close;
    ConsProdutos.ParamByName('CODIGO').AsInteger := -1;
    ConsProdutos.Open;
  end;

  with dtCadastros do
  begin
    Produtos.Open;
    Clientes.Open;

    if PedidosVenda.State = dsInsert then
    begin
      PedidosVendaCODIGO.Value := 0;
      edtDataPedido.Date := Date;
    end;

    if PedidosVenda.State = dsEdit then
    begin
      edtCodigo.Text := IntToStr(PedidosVendaCODIGO.Value);
      edtDataPedido.Date := PedidosVendaDT_PEDIDO.Value;
      edtValor.Text := FormatFloat('#,##0.00', PedidosVendaVALOR_TOTAL.AsFloat);
      edtQuantidade.Text := FormatFloat('#,##0.0000', PedidosVendaQTDE_ITEM.AsFloat);
      LookupClientes.KeyValue := PedidosVendaCLIENTE_ID.Value;
      LookupProdutos.KeyValue := PedidosVendaPRODUTO_ID.Value;
    end;
  end;

  LookupClientes.SetFocus;
end;

end.
