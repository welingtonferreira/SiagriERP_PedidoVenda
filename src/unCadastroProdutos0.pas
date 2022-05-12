unit unCadastroProdutos0;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TfrmCadastroProdutos0 = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    btnIncluir: TBitBtn;
    btnAlterar: TBitBtn;
    btnRemover: TBitBtn;
    btnFechar: TBitBtn;
    gridProdutos: TDBGrid;
    Panel2: TPanel;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    procedure Pesquisar;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroProdutos0: TfrmCadastroProdutos0;

implementation

{$R *.dfm}

uses
  unModPrincipal, unModCadastros, unCadastroProdutos1;

procedure TfrmCadastroProdutos0.btnAlterarClick(Sender: TObject);
begin
  with dtCadastros do
  begin
    if (Produtos.RecordCount > 0) then
    begin
      Produtos.Edit;
      frmCadastroProdutos1 := TfrmCadastroProdutos1.Create(Self);
      frmCadastroProdutos1.ShowModal;

      Pesquisar;
    end
    else
    begin
      ShowMessage('Nenhum registro selecionado para Alterar.');
    end;
  end;
end;

procedure TfrmCadastroProdutos0.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastroProdutos0.btnIncluirClick(Sender: TObject);
begin
  with dtCadastros do
  begin
    Produtos.Insert;
  end;

  frmCadastroProdutos1 := TfrmCadastroProdutos1.Create(Self);
  frmCadastroProdutos1.ShowModal;

  Pesquisar;
end;

procedure TfrmCadastroProdutos0.btnRemoverClick(Sender: TObject);
begin
  with dtCadastros do
  begin
    if (Produtos.RecordCount > 0) then
    begin
      try
        if Messagedlg('Confirma excluir registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          Produtos.Delete;
          if (Produtos.CachedUpdates) then
          begin
            AplicarDados(Produtos);
          end;
          CommitRFD;
        end;
      except
        on E: Exception do
        begin
          ShowMessage('Não foi possível excluir o registro.' + E.Message);
          RollBackRFD;
          Pesquisar;
        end;
      end;
    end
    else
    begin
      ShowMessage('Nenhum registro selecionado para Excluir.');
    end;
  end;
end;

procedure TfrmCadastroProdutos0.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with dtCadastros do
  begin
    Produtos.Close;
  end;
  Action := caFree;
end;

procedure TfrmCadastroProdutos0.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F5 then
    Pesquisar;
end;

procedure TfrmCadastroProdutos0.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCadastroProdutos0.Pesquisar;
begin
  with dtCadastros do
  begin
    Produtos.Close;
    Produtos.Open;
  end;
end;

end.
