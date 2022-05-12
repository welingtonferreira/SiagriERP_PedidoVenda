unit unModPrincipal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Phys.IBBase, Vcl.Dialogs, Vcl.Forms,
  Winapi.Windows, Winapi.Messages, Vcl.Graphics, Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.ComCtrls;

  procedure AplicarDados(Query: TFDQuery);
  procedure CommitRFD;
  procedure CommitFD;
  procedure RollBackRFD;
  function GetIDGen(Gen: String): Integer;
  function consultarDbFD(Sql: String; Params: Array of Variant): TFDQuery;
  function pesquisarQueryFD(Base: TFDConnection; Sql: String; Params: Array of Variant): TFDQuery;
  function getComAspas (Texto : String) : String;
  function executarSqlFD(Sql: String; Params: Array of Variant): Boolean;
  function InputCombo(const ACaption, APrompt: string; const AList: TStrings): String;

type
  TDMPrincipal = class(TDataModule)
    FireDacCon: TFDConnection;
    FireTransCon: TFDTransaction;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMPrincipal: TDMPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function getComAspas (Texto : String) : String;
begin
  Result := #39 + Texto + #39;
end;

procedure CommitRFD;
begin
  DMPrincipal.FireTransCon.CommitRetaining;
end;

procedure CommitFD;
begin
  DMPrincipal.FireTransCon.Commit;
end;

procedure RollBackRFD;
begin
  DMPrincipal.FireTransCon.RollbackRetaining;
end;

function GetIDGen(Gen: String): Integer;
begin
  with consultarDbFD('select gen_id(' + Gen + ',1) as ID from rdb$database', []) do
  begin
    Result := FieldByName('ID').AsInteger;
    Free;
  end;
end;

function consultarDbFD(Sql: String; Params: Array of Variant): TFDQuery;
begin
  try
    Result := pesquisarQueryFD(DMPrincipal.FireDacCon, Sql, Params);
  except
    on E: Exception do
    begin
      ShowMessage('Problemas ao executar consulta.' + E.Message);
      if Result <> nil then
        FreeAndNil(Result);
    end;
  end;
end;

procedure executarQueryFD(aBase: TFDConnection; aSql: String; aParams: Array of Variant);
var
  Query : TFDQuery;
  X : Integer;
begin
  Query := TFDQuery.Create(Application);
  with Query do
  begin
    Query.Connection := aBase;
    Query.Transaction := aBase.Transaction;

    SQL.Clear;
    SQL.Text := aSql;
    for X := 0 to Length(aParams)-1 do
    begin
      Params[X].Value := aParams[X];
    end;
    ExecSQL;
  end;
  Query.Free;
end;

function executarSqlFD(Sql: String; Params: Array of Variant): Boolean;
begin
  Result := True;
  try
    executarQueryFD(DMPrincipal.FireDacCon, Sql, Params);
  except
    on ex: Exception do
    begin
      Result := False;
      raise Exception.Create('Erro: ' + ex.Message + '[' + Sql + ']');
    end;
  end;
end;

function pesquisarQueryFD(Base: TFDConnection; Sql: String; Params: Array of Variant): TFDQuery;
var
  Query: TFDQuery;
  I: Integer;
begin
  Query := TFDQuery.Create(Application);
  Query.Connection := Base;
  Query.Transaction := Base.Transaction;
  Query.SQL.Clear;
  Query.SQL.Add(Sql);
  for I := 0 to Length(Params) -1 do
  begin
    Query.Params[I].Value := Params[I];
  end;
  Query.Open;
  Result := Query;
end;

procedure AplicarDados(Query: TFDQuery);
var
  oErr: EFDException;
begin
  if Query.ApplyUpdates > 0 then
  begin
    //Query.FilterChanges := [rtModified, rtInserted, rtDeleted];
    try
      Query.First;
      while not Query.Eof do
      begin
        oErr := Query.RowError;
        if oErr <> nil then
        begin
          raise Exception.Create(oErr.Message);
        end;
        Query.Next;
      end;
    finally
      //Query.FilterChanges := [rtUnmodified, rtModified, rtInserted];
    end;
  end;
end;

function InputCombo(const ACaption, APrompt: string; const AList: TStrings): String;

  function GetCharSize(Canvas: TCanvas): TPoint;
  var
    I: Integer;
    Buffer: array[0..51] of Char;
  begin
    for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
    for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
    GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
    Result.X := Result.X div 52;
  end;

var
  Form: TForm;
  Prompt: TLabel;
  Combo: TComboBox;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
begin
  Result := '';
  Form   := TForm.Create(Application);
  with Form do
    try
      Canvas.Font := Font;
      DialogUnits := GetCharSize(Canvas);
      BorderStyle := bsDialog;
      Caption     := ACaption;
      ClientWidth := MulDiv(180, DialogUnits.X, 4);
      Position    := poScreenCenter;
      Prompt      := TLabel.Create(Form);
      with Prompt do
      begin
        Parent   := Form;
        Caption  := APrompt;
        Left     := MulDiv(8, DialogUnits.X, 4);
        Top      := MulDiv(8, DialogUnits.Y, 8);
        Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
        WordWrap := True;
      end;
      Combo := TComboBox.Create(Form);
      with Combo do
      begin
        Parent := Form;
        Style  := csDropDownList; // Caso o item possa ser digitado, altere aqui para csDropDowns
        Items.Assign(AList);
        ItemIndex := 0;
        Left      := Prompt.Left;
        Top       := Prompt.Top + Prompt.Height + 5;
        Width     := MulDiv(164, DialogUnits.X, 4);
      end;
      ButtonTop    := Combo.Top + Combo.Height + 15;
      ButtonWidth  := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
      with TButton.Create(Form) do
      begin
        Parent      := Form;
        Caption     := 'OK';
        ModalResult := mrOk;
        default     := True;
        SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      end;
      with TButton.Create(Form) do
      begin
        Parent      := Form;
        Caption     := 'Cancelar';
        ModalResult := mrCancel;
        Cancel      := True;
        SetBounds(MulDiv(92, DialogUnits.X, 4), Combo.Top + Combo.Height + 15,
          ButtonWidth, ButtonHeight);
        Form.ClientHeight := Top + Height + 13;
      end;
      if ShowModal = mrOk then
      begin
        Result := Combo.Text;
      end;
    finally
      Form.Free;
    end;
end;

end.
