unit unPedidosVenda0;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, DateUtils, Vcl.ComCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids;

type
  TfrmPedidosVenda0 = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    btnIncluir: TBitBtn;
    btnAlterar: TBitBtn;
    btnFechar: TBitBtn;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnSolicitacaoReceita: TBitBtn;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    dtInicial: TDateTimePicker;
    Label5: TLabel;
    dtFinal: TDateTimePicker;
    LookupTiposPedido: TComboBox;
    Label6: TLabel;
    chkTodos: TCheckBox;
    gridVendas: TDBGrid;
    btnPesquisar: TBitBtn;
    btnReabrir: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure chkTodosClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridVendasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnSolicitacaoReceitaClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnReabrirClick(Sender: TObject);
  private
    sqlPadrao : TStringList;
    procedure Pesquisar;
    function ValidarPesquisa: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPedidosVenda0: TfrmPedidosVenda0;

implementation

{$R *.dfm}

uses
  unModPrincipal, unModSelecoes, unModCadastros, unPedidosVenda1, unSolicitacaoReceita0;

procedure TfrmPedidosVenda0.btnPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmPedidosVenda0.btnReabrirClick(Sender: TObject);
begin
  with dtSelecoes do
  begin
    with ConsPedidosVenda do
    begin
      if (RecordCount > 0) then
      begin
        if Messagedlg('Deseja reabrir o pedido ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          executarSqlFD('UPDATE PEDIDOS_VENDA SET STATUS = ''A'' WHERE CODIGO = :CODIGO', [ConsPedidosVendaCODIGO.Value]);
          CommitRFD;
        end;
      end;
    end;
  end;

  Pesquisar;
end;

procedure TfrmPedidosVenda0.btnAlterarClick(Sender: TObject);
begin
  with dtCadastros do
  begin
    with PedidosVenda do
    begin
      if RecordCount > 0 then
      begin
        if PedidosVenda.Locate('CODIGO', dtSelecoes.ConsPedidosVendaCODIGO.Value, []) then
        begin
          if PedidosVendaSTATUS.Value = 'C' then
          begin
            ShowMessage('Não é possivel Alterar, o pedido está como concluído.');
            Exit;
          end;
          Edit;
          frmPedidosVenda1 := TfrmPedidosVenda1.Create(Self);
          frmPedidosVenda1.ShowModal;
          frmPedidosVenda1.Free;
        end;
      end
      else
      begin
        ShowMessage('Nenhum registro selecionado para Alterar.');
      end;
    end;
  end;

  Pesquisar;
end;

procedure TfrmPedidosVenda0.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPedidosVenda0.btnIncluirClick(Sender: TObject);
begin
  with dtCadastros do
  begin
    PedidosVenda.CancelUpdates;
    PedidosVenda.Insert;
  end;
  frmPedidosVenda1 := TfrmPedidosVenda1.Create(Self);
  frmPedidosVenda1.Tag := Self.Tag;
  frmPedidosVenda1.ShowModal;
  frmPedidosVenda1.Free;
  Pesquisar;
end;

procedure TfrmPedidosVenda0.btnSolicitacaoReceitaClick(Sender: TObject);
begin
  frmSolicitacaoReceita0 := TfrmSolicitacaoReceita0.Create(Self);
  frmSolicitacaoReceita0.ShowModal;
  frmSolicitacaoReceita0.Free;

  Pesquisar;
end;

procedure TfrmPedidosVenda0.chkTodosClick(Sender: TObject);
begin
  LookupTiposPedido.Enabled := not chkTodos.Checked;
end;

procedure TfrmPedidosVenda0.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  with dtSelecoes do
  begin
    ConsPedidosVenda.Close;
    ConsPedidosVenda.SQL.Text := sqlPadrao.Text;
  end;

  sqlPadrao.Free;
  CommitRFD;
  Action := caFree;
end;

procedure TfrmPedidosVenda0.FormCreate(Sender: TObject);
begin
  sqlPadrao := TStringList.Create;
end;

procedure TfrmPedidosVenda0.FormShow(Sender: TObject);
begin
  dtInicial.Date := Date - 30;
  dtFinal.Date := Date;

  with dtSelecoes do
  begin
    with ConsPedidosVenda do
    begin
      Close;
      ParamByName('STATUS').AsString := '?';
      ParamByName('DT_INICIAL').AsDate := dtInicial.Date;
      ParamByName('DT_FINAL').AsDate := dtFinal.Date;
      Open;
    end;

    sqlPadrao.AddStrings(ConsPedidosVenda.SQL);
  end;

  with dtCadastros do
  begin
    PedidosVenda.Open;
  end;

  chkTodos.Checked := True;
  LookupTiposPedido.Enabled := False;
end;

procedure TfrmPedidosVenda0.gridVendasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with gridVendas do
  begin
    with dtSelecoes do
    begin
      if Column.Index = 0 then
      begin
        if ConsPedidosVendaSTATUS.AsString = 'A' then
        begin
          gridVendas.Canvas.Brush.Color := clGreen;
          gridVendas.Canvas.Font.Color := clGreen;
        end;

        if ConsPedidosVendaSTATUS.AsString = 'R' then
        begin
          gridVendas.Canvas.Brush.Color := clPurple;
          gridVendas.Canvas.Font.Color := clPurple;
        end;

        if ConsPedidosVendaSTATUS.AsString = 'C' then
        begin
          gridVendas.Canvas.Brush.Color := clRed;
          gridVendas.Canvas.Font.Color := clRed;
        end;
      end;

      gridVendas.Canvas.FillRect(Rect);
      gridVendas.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
  end;
end;

procedure TfrmPedidosVenda0.Pesquisar;
var
  TipoPeriodo: String;
  Pos: Integer;
begin
  if ValidarPesquisa then
  begin
    with dtCadastros do
    begin
      PedidosVenda.Close;
      PedidosVenda.Open;
    end;

    with dtSelecoes do
    begin
      Pos := ConsPedidosVenda.RecNo;

      ConsPedidosVenda.Close;
      with ConsPedidosVenda do
      begin
        ParamByName('DT_INICIAL').AsDate := dtInicial.Date;
        ParamByName('DT_FINAL').AsDate := dtFinal.Date;

        if chkTodos.Checked then
          ParamByName('STATUS').AsString := '?'
        else
        begin
          if LookupTiposPedido.ItemIndex = 0 then
            ParamByName('STATUS').AsString := 'A';

          if LookupTiposPedido.ItemIndex = 1 then
            ParamByName('STATUS').AsString := 'R';

          if LookupTiposPedido.ItemIndex = 2 then
            ParamByName('STATUS').AsString := 'C';
        end;

        ConsPedidosVenda.Open;
      end;
      ConsPedidosVenda.RecNo := Pos;
    end;
    gridVendas.SetFocus;
  end;
end;

function TfrmPedidosVenda0.ValidarPesquisa: Boolean;
begin
  Result := True;
end;

end.
