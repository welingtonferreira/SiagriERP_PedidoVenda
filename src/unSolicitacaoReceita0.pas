unit unSolicitacaoReceita0;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TfrmSolicitacaoReceita0 = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    btnFechar: TBitBtn;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    btnPesquisar: TBitBtn;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    dtInicial: TDateTimePicker;
    dtFinal: TDateTimePicker;
    btnAssinatura: TBitBtn;
    DBGrid1: TDBGrid;
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnAssinaturaClick(Sender: TObject);
  private
    procedure Pesquisar;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSolicitacaoReceita0: TfrmSolicitacaoReceita0;

implementation

{$R *.dfm}

uses
  unModPrincipal, unModSelecoes, unModCadastros;

procedure TfrmSolicitacaoReceita0.btnAssinaturaClick(Sender: TObject);
var
  List: TStringList;
  vResult, indice : String;
begin
  with dtSelecoes do
  begin
    with ConsPedidosVenda do
    begin
      if (RecordCount > 0) then
      begin
        try
          if Messagedlg('Confirma Assinar Receita do pedido?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
          begin
            try
              List := TStringList.Create;

              ConsTecnicoAgricola.Close;
              ConsTecnicoAgricola.Open;

              ConsTecnicoAgricola.First;
              while not ConsTecnicoAgricola.Eof do
              begin
                List.Add(ConsTecnicoAgricolaNOME.Value);

                ConsTecnicoAgricola.Next;
              end;

              vResult := InputCombo('Selecione o técnico responsável', 'Nome:', List);
            finally
              List.Free;
            end;

            with consultarDbFD('SELECT NUMERO_REGISTRO FROM TECNICO_AGRICOLA ' +
                               ' WHERE NOME = :NOME', [vResult]) do
            begin
              executarSqlFD('UPDATE PEDIDOS_VENDA SET STATUS = ''C'', REGISTRO_ID = :REG WHERE CODIGO = :CODIGO',
                [FieldByName('NUMERO_REGISTRO').AsString, ConsPedidosVendaCODIGO.Value]);
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

  Pesquisar;
end;

procedure TfrmSolicitacaoReceita0.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSolicitacaoReceita0.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  with dtSelecoes do
  begin
    ConsPedidosVenda.Close;
  end;

  Action := caFree;
end;

procedure TfrmSolicitacaoReceita0.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F5 then
    Pesquisar;
end;

procedure TfrmSolicitacaoReceita0.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmSolicitacaoReceita0.Pesquisar;
begin
  dtInicial.Date := Date - 30;
  dtFinal.Date := Date;
  with dtSelecoes do
  begin
    with ConsPedidosVenda do
    begin
      Close;
      ParamByName('STATUS').AsString := 'R';
      ParamByName('DT_INICIAL').AsDate := dtInicial.Date;
      ParamByName('DT_FINAL').AsDate := dtFinal.Date;
      Open;
    end;
  end;
end;

end.
