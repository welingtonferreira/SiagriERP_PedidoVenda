unit unPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmPrincipal = class(TForm)
    GroupBox1: TGroupBox;
    btnClientes: TBitBtn;
    btnProdutos: TBitBtn;
    btnPedidosVenda: TBitBtn;
    btnFinalizar: TBitBtn;
    procedure btnClientesClick(Sender: TObject);
    procedure btnProdutosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnFinalizarClick(Sender: TObject);
    procedure btnPedidosVendaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses
  unModPrincipal, unModCadastros, unModSelecoes, unCadastroClientes0, unCadastroProdutos0, unPedidosVenda0;

procedure TfrmPrincipal.btnProdutosClick(Sender: TObject);
begin
  dtCadastros := TdtCadastros.Create(Self);

  frmCadastroProdutos0 := TfrmCadastroProdutos0.Create(Self);
  frmCadastroProdutos0.ShowModal;

  FreeAndNil(dtCadastros);
end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmPrincipal.btnFinalizarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.btnPedidosVendaClick(Sender: TObject);
begin
  dtCadastros := TdtCadastros.Create(Self);
  dtSelecoes := TdtSelecoes.Create(Self);

  frmPedidosVenda0 := TfrmPedidosVenda0.Create(Self);
  frmPedidosVenda0.ShowModal;

  FreeAndNil(dtCadastros);
  FreeAndNil(dtSelecoes);
end;

procedure TfrmPrincipal.btnClientesClick(Sender: TObject);
begin
  dtCadastros := TdtCadastros.Create(Self);

  frmCadastroClientes0 := TfrmCadastroClientes0.Create(Self);
  frmCadastroClientes0.ShowModal;

  FreeAndNil(dtCadastros);
end;

end.
