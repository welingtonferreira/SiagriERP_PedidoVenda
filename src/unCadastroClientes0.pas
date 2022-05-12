unit unCadastroClientes0;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TfrmCadastroClientes0 = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    btnIncluir: TBitBtn;
    btnAlterar: TBitBtn;
    btnRemover: TBitBtn;
    btnFechar: TBitBtn;
    Panel2: TPanel;
    gridClientes: TDBGrid;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
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
  frmCadastroClientes0: TfrmCadastroClientes0;

implementation

{$R *.dfm}

uses
  unModPrincipal, unModCadastros, unCadastroClientes1;

procedure TfrmCadastroClientes0.btnAlterarClick(Sender: TObject);
begin
  with dtCadastros do
  begin
    if (Clientes.RecordCount > 0) then
    begin
      Clientes.Edit;
      frmCadastroClientes1 := TfrmCadastroClientes1.Create(Self);
      frmCadastroClientes1.ShowModal;

      Pesquisar;
    end
    else
    begin
      ShowMessage('Nenhum registro selecionado para Alterar.');
    end;
  end;
end;

procedure TfrmCadastroClientes0.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastroClientes0.btnIncluirClick(Sender: TObject);
begin
  with dtCadastros do
  begin
    Clientes.Insert;
  end;

  frmCadastroClientes1 := TfrmCadastroClientes1.Create(Self);
  frmCadastroClientes1.ShowModal;

  Pesquisar;
end;

procedure TfrmCadastroClientes0.btnRemoverClick(Sender: TObject);
begin
  with dtCadastros do
  begin
    if (Clientes.RecordCount > 0) then
    begin
      try
        if Messagedlg('Confirma excluir registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          Clientes.Delete;
          if (Clientes.CachedUpdates) then
          begin
            AplicarDados(Clientes);
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

procedure TfrmCadastroClientes0.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with dtCadastros do
  begin
    Clientes.Close;
  end;
  Action := caFree;
end;

procedure TfrmCadastroClientes0.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F5 then
    Pesquisar;
end;

procedure TfrmCadastroClientes0.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCadastroClientes0.Pesquisar;
begin
  with dtCadastros do
  begin
    Clientes.Close;
    Clientes.Open;
  end;
end;

end.
