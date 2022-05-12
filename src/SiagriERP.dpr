program SiagriERP;

uses
  Vcl.Forms,
  unPrincipal in 'unPrincipal.pas' {frmPrincipal},
  unModPrincipal in 'unModPrincipal.pas' {DMPrincipal: TDataModule},
  unModCadastros in 'unModCadastros.pas' {dtCadastros: TDataModule},
  unCadastroClientes0 in 'unCadastroClientes0.pas' {frmCadastroClientes0},
  unCadastroProdutos0 in 'unCadastroProdutos0.pas' {frmCadastroProdutos0},
  unCadastroClientes1 in 'unCadastroClientes1.pas' {frmCadastroClientes1},
  unCadastroProdutos1 in 'unCadastroProdutos1.pas' {frmCadastroProdutos1},
  unModSelecoes in 'unModSelecoes.pas' {dtSelecoes: TDataModule},
  unPedidosVenda0 in 'unPedidosVenda0.pas' {frmPedidosVenda0},
  unPedidosVenda1 in 'unPedidosVenda1.pas' {frmPedidosVenda1},
  unSolicitacaoReceita0 in 'unSolicitacaoReceita0.pas' {frmSolicitacaoReceita0};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDMPrincipal, DMPrincipal);
  Application.Run;
end.
