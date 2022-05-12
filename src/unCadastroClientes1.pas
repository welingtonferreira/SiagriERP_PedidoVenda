unit unCadastroClientes1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, MaskUtils, Data.DB;

type
  TfrmCadastroClientes1 = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    GroupBox1: TGroupBox;
    edtCodigo: TEdit;
    edtNome: TEdit;
    edtCPF: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure edtCPFExit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    Fechar: Boolean;
    Cancelou: Boolean;
    function ValidarGravar: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroClientes1: TfrmCadastroClientes1;

implementation

{$R *.dfm}

uses
  unModPrincipal, unModCadastros;

function TfrmCadastroClientes1.ValidarGravar: Boolean;
begin
  Result := True;

  if Trim(edtNome.Text) = EmptyStr then
  begin
    ShowMessage('Nome do cliente deve ser informado.');
    edtNome.SetFocus;
    Result := False;
    Exit;
  end;

  if Trim(edtCPF.Text) = EmptyStr then
  begin
    ShowMessage('CPF do cliente deve ser informado.');
    edtCPF.SetFocus;
    Result := False;
    Exit;
  end;

end;

procedure TfrmCadastroClientes1.btnCancelarClick(Sender: TObject);
begin
  with dtCadastros do
  begin
    Clientes.Cancel;
    Clientes.CancelUpdates;
  end;
  RollBackRFD;
  Self.Cancelou := True;
  Fechar := True;
  Self.Close;
end;

procedure TfrmCadastroClientes1.btnGravarClick(Sender: TObject);
var
  str: String;
begin
  if (ValidarGravar) then
  begin
    with dtCadastros do
    begin
      try
        Clientes.Edit;
        if ClientesCODIGO.Value = 0 then
          ClientesCODIGO.Value := getCodigoCliente;

        ClientesNOME.Value := edtNome.Text;
        str := StringReplace(edtCPF.Text,'.','', [rfReplaceAll]);
        ClientesCPF.Value := StringReplace(str,'-','', [rfReplaceAll]);
        Clientes.Post;

        if (Clientes.CachedUpdates) then
        begin
          AplicarDados(Clientes);
        end;

        edtCodigo.Clear;
        edtNome.Clear;
        edtCPF.Clear;

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

procedure TfrmCadastroClientes1.edtCPFExit(Sender: TObject);
begin
  edtCPF.Text := FormatMaskText('000\.000\.000\-00;0;', edtCPF.Text);
end;

procedure TfrmCadastroClientes1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not Fechar then
  begin
    btnCancelar.OnClick(Sender);
    CanClose := Fechar;
  end;
end;

procedure TfrmCadastroClientes1.FormShow(Sender: TObject);
begin
  with dtCadastros do
  begin
    if Clientes.State = dsInsert then
    begin
      ClientesCODIGO.Value := 0;
    end;

    if Clientes.State = dsEdit then
    begin
      edtCodigo.Text := IntToStr(ClientesCODIGO.Value);
      edtNome.Text := ClientesNOME.Value;
      edtCPF.Text := FormatMaskText('000\.000\.000\-00;0;', ClientesCPF.Value);
    end;
  end;

  edtNome.SetFocus;
end;

end.
