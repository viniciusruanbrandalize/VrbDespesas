unit view.subtipodespesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  view.cadastropadrao, controller.subtipodespesa, view.mensagem, lib.types,
  LCLType, ComCtrls, Grids;

type

  { TfrmSubtipoDespesa }

  TfrmSubtipoDespesa = class(TfrmCadastroPadrao)
    edtNome: TLabeledEdit;
    edtTipo: TLabeledEdit;
    lbTipoNome: TListBox;
    lbTipoId: TListBox;
    procedure actExcluirExecute(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure edtTipoExit(Sender: TObject);
    procedure edtTipoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbTipoNomeDblClick(Sender: TObject);
    procedure lbTipoNomeKeyPress(Sender: TObject; var Key: char);
    procedure lbTipoNomeSelectionChange(Sender: TObject; User: boolean);
  private
    Controller: TSubtipoDespesaController;
  public
    procedure CarregarDados; override;
    procedure LimparCampos; override;
    procedure CarregarSelecionado; override;
  end;

var
  frmSubtipoDespesa: TfrmSubtipoDespesa;

implementation

uses
  view.principal;

{$R *.lfm}

{ TfrmSubtipoDespesa }

procedure TfrmSubtipoDespesa.FormCreate(Sender: TObject);
begin
  inherited;
  Controller := TSubtipoDespesaController.Create;
end;

procedure TfrmSubtipoDespesa.actSalvarExecute(Sender: TObject);
var
  erro: String;
begin
  if TfrmMessage.Mensagem('Deseja salvar ?', 'Aviso', 'Q', [mbNao, mbSim], mbNao) then
  begin
    Controller.SubtipoDespesa.Nome  := edtNome.Text;
    if Operacao = opInserir then
    begin
      if not Controller.Inserir(Controller.SubtipoDespesa, erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;
    if Operacao = opEditar then
    begin
      if not Controller.Editar(Controller.SubtipoDespesa, erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;
    inherited;
  end;
end;

procedure TfrmSubtipoDespesa.edtTipoExit(Sender: TObject);
begin
  if not lbTipoNome.Focused then
  begin
    if lbTipoNome.Visible then
      lbTipoNome.Visible := false;
  end;
end;

procedure TfrmSubtipoDespesa.edtTipoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  qtdReg: Integer;
begin
  qtdReg := 0;
  if (Length(edtTipo.Text) > 3) then
  begin
    controller.PesquisarTipoDespesa(lbTipoNome, lbTipoId, edtTipo.Text, qtdReg);
    lbTipoNome.Visible := qtdReg > 0;
    if Key = VK_DOWN then
    begin
      if lbTipoNome.CanFocus then
        lbTipoNome.SetFocus;
    end;
  end
  else
  begin
    lbTipoNome.Items.Clear;
    lbTipoNome.Visible := False;
  end;
end;

procedure TfrmSubtipoDespesa.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  TfrmPrincipal(Owner).BarraLateralVazia(TfrmPrincipal(Owner).pnlMenuCadastro, True);
end;

procedure TfrmSubtipoDespesa.actExcluirExecute(Sender: TObject);
var
  erro: String;
  id: Integer;
begin
  if TfrmMessage.Mensagem('Deseja excluir o item selecionado ?', 'Aviso', 'D',
                           [mbNao, mbSim], mbNao) then
  begin
    id := StrToInt(lvPadrao.Selected.Caption);
    if Controller.Excluir(id, erro) then
      inherited
    else
      TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    Operacao := opNenhum;
  end;
end;

procedure TfrmSubtipoDespesa.actPesquisarExecute(Sender: TObject);
begin
  lvPadrao.Items.Clear;
  Controller.Pesquisar(lvPadrao, lbPesquisa.Items[cbPesquisa.ItemIndex], edtPesquisa.Text);
end;

procedure TfrmSubtipoDespesa.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmSubtipoDespesa.lbTipoNomeDblClick(Sender: TObject);
begin
  if lbTipoNome.ItemIndex <> -1 then
  begin
    edtTipo.Text := lbTipoNome.Items[lbTipoNome.ItemIndex];
    controller.SubtipoDespesa.TipoDespesa.Id := StrToInt(lbTipoId.Items[lbTipoNome.ItemIndex]);
    lbTipoNome.Visible := False;
  end
  else
  begin
    edtTipo.Text := '';
    controller.SubtipoDespesa.TipoDespesa.Id := 0;
  end;
end;

procedure TfrmSubtipoDespesa.lbTipoNomeKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
  begin
    lbTipoNome.OnDblClick(nil);
  end;
end;

procedure TfrmSubtipoDespesa.lbTipoNomeSelectionChange(Sender: TObject;
  User: boolean);
begin
  edtTipo.Text := lbTipoNome.Items[lbTipoNome.ItemIndex];
end;

procedure TfrmSubtipoDespesa.CarregarDados;
begin
  lvPadrao.Items.Clear;
  Controller.Listar(lvPadrao);
end;

procedure TfrmSubtipoDespesa.LimparCampos;
begin
  edtNome.Clear;
  edtTipo.Clear;
  lbTipoNome.Items.Clear;
  lbTipoId.Items.Clear;
end;

procedure TfrmSubtipoDespesa.CarregarSelecionado;
var
  id: Integer;
  erro: String;
begin
  id := StrToInt(lvPadrao.Selected.Caption);
  if Controller.BuscarPorId(controller.SubtipoDespesa, id, erro) then
  begin
    edtNome.Text  := Controller.SubtipoDespesa.Nome;
    edtTipo.Text   := Controller.SubtipoDespesa.TipoDespesa.Nome;
  end
  else
  begin
    TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    Abort;
  end;
end;

end.

