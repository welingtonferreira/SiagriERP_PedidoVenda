unit unCadastroProdutos1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Data.DB;

type
  TfrmCadastroProdutos1 = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    edtCodigo: TEdit;
    edtDescricao: TEdit;
    Valor: TLabel;
    chkExigeControleEspecial: TCheckBox;
    edtValor: TEdit;
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure edtValorExit(Sender: TObject);
  private
    Fechar: Boolean;
    Cancelou: Boolean;
    function ValidarGravar: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroProdutos1: TfrmCadastroProdutos1;

implementation

{$R *.dfm}

uses
  unModPrincipal, unModCadastros;

procedure TfrmCadastroProdutos1.btnCancelarClick(Sender: TObject);
begin
  with dtCadastros do
  begin
    Produtos.Cancel;
    Produtos.CancelUpdates;
  end;
  RollBackRFD;
  Self.Cancelou := True;
  Fechar := True;
  Self.Close;
end;

procedure TfrmCadastroProdutos1.btnGravarClick(Sender: TObject);
begin
  if (ValidarGravar) then
  begin
    with dtCadastros do
    begin
      try
        Produtos.Edit;
        if ProdutosCODIGO.Value = 0 then
          ProdutosCODIGO.Value := getCodigoProduto;

        ProdutosDESCRICAO.Value := edtDescricao.Text;
        ProdutosVALOR.AsFloat := StrToFloat(edtValor.Text);

        if chkExigeControleEspecial.Checked then
          ProdutosEXIGE_CONTROLE_ESPECIAL.Value := 1
        else
          ProdutosEXIGE_CONTROLE_ESPECIAL.Value := 0;

        Produtos.Post;

        if (Produtos.CachedUpdates) then
        begin
          AplicarDados(Produtos);
        end;

        edtCodigo.Clear;
        edtDescricao.Clear;
        edtValor.Clear;
        chkExigeControleEspecial.Checked := False;

        CommitRFD;
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

procedure TfrmCadastroProdutos1.edtValorExit(Sender: TObject);
begin
  edtValor.Text := CurrToStrF(StrToCurrDef(Trim(edtValor.Text), 0), ffNumber, 2);
end;

procedure TfrmCadastroProdutos1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not Fechar then
  begin
    btnCancelar.OnClick(Sender);
    CanClose := Fechar;
  end;
end;

procedure TfrmCadastroProdutos1.FormShow(Sender: TObject);
begin
  with dtCadastros do
  begin
    if Produtos.State = dsInsert then
    begin
      ProdutosCODIGO.Value := 0;
    end;

    if Produtos.State = dsEdit then
    begin
      edtCodigo.Text := IntToStr(ProdutosCODIGO.Value);
      edtDescricao.Text := ProdutosDESCRICAO.Value;
      edtValor.Text := FormatFloat('#,##0.00', ProdutosVALOR.AsFloat);

      if ProdutosEXIGE_CONTROLE_ESPECIAL.Value = 1 then
        chkExigeControleEspecial.Checked := True
      else
        chkExigeControleEspecial.Checked := False;

    end;
  end;

  edtDescricao.SetFocus;
end;

function TfrmCadastroProdutos1.ValidarGravar: Boolean;
begin
  Result := True;

  if Trim(edtDescricao.Text) = EmptyStr then
  begin
    ShowMessage('Descrição do produto deve ser informado.');
    edtDescricao.SetFocus;
    Result := False;
    Exit;
  end;

  if Trim(edtValor.Text) = EmptyStr then
  begin
    ShowMessage('Valor do produto deve ser informado.');
    edtValor.SetFocus;
    Result := False;
    Exit;
  end;
end;

end.
