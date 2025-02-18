unit view.despesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls, Menus, Buttons, ActnList, DateTimePicker, view.cadastropadrao,
  lib.types, controller.despesa, view.mensagem, LCLType;

type

  { TfrmDespesa }

  TfrmDespesa = class(TfrmCadastroPadrao)
    actIncluirFpgto: TAction;
    actExcluirFpgto: TAction;
    actIncluirArquivo: TAction;
    actExcluirArquivo: TAction;
    actExportarArquivo: TAction;
    actSalvarFpgto: TAction;
    actCancelarFpgto: TAction;
    btnExportarArquivo: TSpeedButton;
    btnExcluirFormaPgto: TSpeedButton;
    btnCancelarFormaPgto: TSpeedButton;
    btnExcluirArquivo: TSpeedButton;
    btnIncluirFormaPgto: TSpeedButton;
    btnIncluirArquivo: TSpeedButton;
    btnSalvarFormaPgto: TSpeedButton;
    ComboBox1: TComboBox;
    dtpData: TDateTimePicker;
    dtpHora: TDateTimePicker;
    dtpInicial: TDateTimePicker;
    dtpFinal: TDateTimePicker;
    edtDescricao: TLabeledEdit;
    edtChaveNfe: TLabeledEdit;
    edtFormaPagamento: TLabeledEdit;
    edtFornecedor: TLabeledEdit;
    edtPesquisaGenericaFpgto: TLabeledEdit;
    edtTotal: TLabeledEdit;
    edtSubtipo: TLabeledEdit;
    edtValor: TLabeledEdit;
    edtDesconto: TLabeledEdit;
    edtFrete: TLabeledEdit;
    edtOutros: TLabeledEdit;
    edtValorFpgto: TLabeledEdit;
    lbFormaPagamentoNome: TListBox;
    lblObs: TLabel;
    lblData: TLabel;
    lblPeriodoFiltro: TLabel;
    lbSubtipoId: TListBox;
    lbFornecedorId: TListBox;
    lbFormaPagamentoId: TListBox;
    lbSubtipoNome: TListBox;
    lbFornecedorNome: TListBox;
    lvPagamento: TListView;
    lvArquivo: TListView;
    MenuItem4: TMenuItem;
    mObs: TMemo;
    pnlBotoesArquivo: TPanel;
    pnlBotoesSalvarCancelarPagamento: TPanel;
    pnlIncluiPagamento: TPanel;
    pnlBotoesPagamento: TPanel;
    pgcMaisOpcoes: TPageControl;
    pMenuFpgto: TPopupMenu;
    tbsPagamento: TTabSheet;
    tbsArquivo: TTabSheet;
    procedure actCancelarFpgtoExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure actExcluirFpgtoExecute(Sender: TObject);
    procedure actIncluirFpgtoExecute(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure actSalvarFpgtoExecute(Sender: TObject);
    procedure edtFormaPagamentoExit(Sender: TObject);
    procedure edtFormaPagamentoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSubtipoExit(Sender: TObject);
    procedure edtSubtipoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbFormaPagamentoNomeDblClick(Sender: TObject);
    procedure lbFormaPagamentoNomeKeyPress(Sender: TObject; var Key: char);
    procedure lbFormaPagamentoNomeSelectionChange(Sender: TObject; User: boolean
      );
    procedure lbFornecedorNomeDblClick(Sender: TObject);
    procedure lbFornecedorNomeKeyPress(Sender: TObject; var Key: char);
    procedure lbFornecedorNomeSelectionChange(Sender: TObject; User: boolean);
    procedure lbSubtipoNomeDblClick(Sender: TObject);
    procedure lbSubtipoNomeKeyPress(Sender: TObject; var Key: char);
    procedure lbSubtipoNomeSelectionChange(Sender: TObject; User: boolean);
  private
    Controller: TDespesaController;
    procedure AjustarTelaPagamento(Inserindo: Boolean);
    procedure IncluirPagamento();
    procedure LimparCamposPagamento();
  public
    procedure CarregarDados; override;
    procedure LimparCampos; override;
    procedure CarregarSelecionado; override;
  end;

var
  frmDespesa: TfrmDespesa;

implementation

uses
  view.principal;

{$R *.lfm}

{ TfrmDespesa }

procedure TfrmDespesa.FormCreate(Sender: TObject);
begin
  inherited;
  Controller := TDespesaController.Create;
  edtValor.OnExit         := @NumericoExit;
  edtValor.OnEnter        := @NumericoEnter;
  edtValor.OnKeyPress     := @NumericoKeyPress;
  edtDesconto.OnExit      := @NumericoExit;
  edtDesconto.OnEnter     := @NumericoEnter;
  edtDesconto.OnKeyPress  := @NumericoKeyPress;
  edtFrete.OnExit         := @NumericoExit;
  edtFrete.OnEnter        := @NumericoEnter;
  edtFrete.OnKeyPress     := @NumericoKeyPress;
  edtOutros.OnExit        := @NumericoExit;
  edtOutros.OnEnter       := @NumericoEnter;
  edtOutros.OnKeyPress    := @NumericoKeyPress;
  edtTotal.OnExit         := @NumericoExit;
  edtTotal.OnEnter        := @NumericoEnter;
  edtTotal.OnKeyPress     := @NumericoKeyPress;
  edtValorFpgto.OnExit    := @NumericoExit;
  edtValorFpgto.OnEnter   := @NumericoEnter;
  edtValorFpgto.OnKeyPress:= @NumericoKeyPress;
end;

procedure TfrmDespesa.actSalvarExecute(Sender: TObject);
var
  erro: String;
begin
  if TfrmMessage.Mensagem('Deseja salvar ?', 'Aviso', 'Q', [mbNao, mbSim], mbNao) then
  begin
    Controller.Despesa.Descricao  := edtDescricao.Text;
    Controller.Despesa.Data       := dtpData.Date;
    Controller.Despesa.Hora       := dtpHora.Time;
    Controller.Despesa.Valor      := StrToFloat(edtValor.Text);
    Controller.Despesa.Desconto   := StrToFloat(edtDesconto.Text);
    Controller.Despesa.Frete      := StrToFloat(edtFrete.Text);
    Controller.Despesa.Outros     := StrToFloat(edtOutros.Text);
    Controller.Despesa.Total      := StrToFloat(edtTotal.Text);
    Controller.Despesa.ChaveNFE   := edtChaveNfe.Text;
    Controller.Despesa.Observacao := mObs.Lines.Text;
    Controller.Despesa.Paga       := True;
    if Operacao = opInserir then
    begin
      Controller.Despesa.Cadastro := Now;
      if not Controller.Inserir(Controller.Despesa, erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;
    if Operacao = opEditar then
    begin
      Controller.Despesa.Alteracao := Now;
      if not Controller.Editar(Controller.Despesa, erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;
    inherited;
  end;
end;

procedure TfrmDespesa.actSalvarFpgtoExecute(Sender: TObject);
var
  i: Integer;
begin
  i := Controller.Despesa.DespesaFormaPagamento.Count - 1;
  AjustarTelaPagamento(False);
  Controller.Despesa.DespesaFormaPagamento[i].Valor := StrToFloat(edtValorFpgto.Text);
  IncluirPagamento();
end;

procedure TfrmDespesa.edtFormaPagamentoExit(Sender: TObject);
begin
  if not lbFormaPagamentoNome.Focused then
  begin
    if lbFormaPagamentoNome.Visible then
      lbFormaPagamentoNome.Visible := false;
  end;
end;

procedure TfrmDespesa.edtFormaPagamentoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  qtdReg: Integer;
begin
  qtdReg := 0;
  if (Length(edtFormaPagamento.Text) > 3) then
  begin
    controller.PesquisarFormaPagamento(lbFormaPagamentoNome, lbFormaPagamentoId, edtFormaPagamento.Text, qtdReg);
    lbFormaPagamentoNome.Visible := qtdReg > 0;
    if Key = VK_DOWN then
    begin
      if lbFormaPagamentoNome.CanFocus then
        lbFormaPagamentoNome.SetFocus;
    end;
  end
  else
  begin
    lbFormaPagamentoNome.Items.Clear;
    lbFormaPagamentoNome.Visible := False;
  end;
end;

procedure TfrmDespesa.edtFornecedorExit(Sender: TObject);
begin
  if not lbFornecedorNome.Focused then
  begin
    if lbFornecedorNome.Visible then
      lbFornecedorNome.Visible := false;
  end;
end;

procedure TfrmDespesa.edtFornecedorKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  qtdReg: Integer;
begin
  qtdReg := 0;
  if (Length(edtFornecedor.Text) > 3) then
  begin
    controller.PesquisarFornecedor(lbFornecedorNome, lbFornecedorId, edtFornecedor.Text, qtdReg);
    lbFornecedorNome.Visible := qtdReg > 0;
    if Key = VK_DOWN then
    begin
      if lbFornecedorNome.CanFocus then
        lbFornecedorNome.SetFocus;
    end;
  end
  else
  begin
    lbFornecedorNome.Items.Clear;
    lbFornecedorNome.Visible := False;
  end;
end;

procedure TfrmDespesa.edtSubtipoExit(Sender: TObject);
begin
  if not lbSubtipoNome.Focused then
  begin
    if lbSubtipoNome.Visible then
      lbSubtipoNome.Visible := false;
  end;
end;

procedure TfrmDespesa.edtSubtipoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  qtdReg: Integer;
begin
  qtdReg := 0;
  if (Length(edtSubtipo.Text) > 3) then
  begin
    controller.PesquisarSubtipo(lbSubtipoNome, lbSubtipoId, edtSubtipo.Text, qtdReg);
    lbSubtipoNome.Visible := qtdReg > 0;
    if Key = VK_DOWN then
    begin
      if lbSubtipoNome.CanFocus then
        lbSubtipoNome.SetFocus;
    end;
  end
  else
  begin
    lbSubtipoNome.Items.Clear;
    lbSubtipoNome.Visible := False;
  end;
end;

procedure TfrmDespesa.actExcluirExecute(Sender: TObject);
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

procedure TfrmDespesa.actExcluirFpgtoExecute(Sender: TObject);
begin
  Controller.ExcluirPagamento(lvPagamento.Selected.Index);
  lvPagamento.Selected.Delete;
end;

procedure TfrmDespesa.actCancelarFpgtoExecute(Sender: TObject);
begin
  Controller.DestruirUltimoPagamento();
  AjustarTelaPagamento(False);
end;

procedure TfrmDespesa.actEditarExecute(Sender: TObject);
begin
  inherited;
  tbsPagamento.Enabled := False;
  edtValor.Enabled     := False;
  edtDesconto.Enabled  := False;
  edtFrete.Enabled     := False;
  edtOutros.Enabled    := False;
  edtTotal.Enabled     := False;
end;

procedure TfrmDespesa.actIncluirFpgtoExecute(Sender: TObject);
begin
  AjustarTelaPagamento(True);
  LimparCamposPagamento();
  Controller.CriarPagamento();
end;

procedure TfrmDespesa.actPesquisarExecute(Sender: TObject);
begin
  lvPadrao.Items.Clear;
  Controller.Pesquisar(lvPadrao, lbPesquisa.Items[cbPesquisa.ItemIndex], edtPesquisa.Text);
end;

procedure TfrmDespesa.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  TfrmPrincipal(Owner).BarraLateralVazia(TfrmPrincipal(Owner).pnlMenuOperacao, True);
end;

procedure TfrmDespesa.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmDespesa.lbFormaPagamentoNomeDblClick(Sender: TObject);
var
  i: Integer;
begin
  i := Controller.Despesa.DespesaFormaPagamento.Count - 1;
  if lbFormaPagamentoNome.ItemIndex <> -1 then
  begin
    edtFormaPagamento.Text := lbFormaPagamentoNome.Items[lbFormaPagamentoNome.ItemIndex];
    Controller.Despesa.DespesaFormaPagamento[i].FormaPagamento.Id := StrToInt(lbFormaPagamentoId.Items[lbFormaPagamentoNome.ItemIndex]);
    Controller.Despesa.DespesaFormaPagamento[i].FormaPagamento.Nome := edtFormaPagamento.Text;
    lbFormaPagamentoNome.Visible := False;
  end
  else
  begin
    edtFormaPagamento.Text := '';
    Controller.Despesa.DespesaFormaPagamento[i].FormaPagamento.Id := 0;
  end;
end;

procedure TfrmDespesa.lbFormaPagamentoNomeKeyPress(Sender: TObject;
  var Key: char);
begin
  if key = #13 then
  begin
    lbFormaPagamentoNome.OnDblClick(nil);
  end;
end;

procedure TfrmDespesa.lbFormaPagamentoNomeSelectionChange(Sender: TObject;
  User: boolean);
begin
  edtFormaPagamento.Text := lbFormaPagamentoNome.Items[lbFormaPagamentoNome.ItemIndex];
end;

procedure TfrmDespesa.lbFornecedorNomeDblClick(Sender: TObject);
begin
  if lbFornecedorNome.ItemIndex <> -1 then
  begin
    edtFornecedor.Text := lbFornecedorNome.Items[lbFornecedorNome.ItemIndex];
    controller.Despesa.Fornecedor.Id := StrToInt(lbFornecedorId.Items[lbFornecedorNome.ItemIndex]);
    lbFornecedorNome.Visible := False;
  end
  else
  begin
    edtFornecedor.Text := '';
    controller.Despesa.Fornecedor.Id := 0;
  end;
end;

procedure TfrmDespesa.lbFornecedorNomeKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
  begin
    lbFornecedorNome.OnDblClick(nil);
  end;
end;

procedure TfrmDespesa.lbFornecedorNomeSelectionChange(Sender: TObject;
  User: boolean);
begin
  edtFornecedor.Text := lbFornecedorNome.Items[lbFornecedorNome.ItemIndex];
end;

procedure TfrmDespesa.lbSubtipoNomeDblClick(Sender: TObject);
begin
  if lbSubtipoNome.ItemIndex <> -1 then
  begin
    edtSubtipo.Text := lbSubtipoNome.Items[lbSubtipoNome.ItemIndex];
    controller.Despesa.SubTipo.Id := StrToInt(lbSubtipoId.Items[lbSubtipoNome.ItemIndex]);
    lbSubtipoNome.Visible := False;
  end
  else
  begin
    edtSubtipo.Text := '';
    controller.Despesa.SubTipo.Id := 0;
  end;
end;

procedure TfrmDespesa.lbSubtipoNomeKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
  begin
    lbSubtipoNome.OnDblClick(nil);
  end;
end;

procedure TfrmDespesa.lbSubtipoNomeSelectionChange(Sender: TObject;
  User: boolean);
begin
  edtSubtipo.Text := lbSubtipoNome.Items[lbSubtipoNome.ItemIndex];
end;

procedure TfrmDespesa.AjustarTelaPagamento(Inserindo: Boolean);
begin
  pnlIncluiPagamento.Visible := inserindo;
  pnlBotoesSalvarCancelarPagamento.Visible := Inserindo;
  pnlBotoesPagamento.Visible := not Inserindo;
  lvPagamento.Visible        := not Inserindo;
  if Inserindo then
  begin
    pnlIncluiPagamento.Align := alClient;
    pnlBotoesSalvarCancelarPagamento.Align := alBottom;
  end
  else
  begin
    lvPagamento.Align        := alClient;
    pnlBotoesPagamento.Align := alBottom;
  end;
end;

procedure TfrmDespesa.IncluirPagamento();
var
  item: TListItem;
  i: Integer;
begin
  i := Controller.Despesa.DespesaFormaPagamento.Count - 1;
  item := lvPagamento.Items.Add;
  item.Caption := '0';
  item.SubItems.Add(controller.Despesa.DespesaFormaPagamento[i].FormaPagamento.Nome);
  item.SubItems.Add(FormatFloat(',#0.00', controller.Despesa.DespesaFormaPagamento[i].Valor));
end;

procedure TfrmDespesa.LimparCamposPagamento();
begin
  edtValorFpgto.Text     := '0,00';
  edtFormaPagamento.Clear;
end;

procedure TfrmDespesa.CarregarDados;
begin
  lvPadrao.Items.Clear;
  Controller.Listar(lvPadrao);
  AjustarTelaPagamento(False);
end;

procedure TfrmDespesa.LimparCampos;
begin
  edtDescricao.Clear;
  dtpData.Date := Now;
  dtpHora.Time := Now;
  edtFornecedor.Clear;
  edtSubtipo.Clear;
  edtValor.Text    := FormatFloat(',#0.00', 0);
  edtDesconto.Text := FormatFloat(',#0.00', 0);
  edtFrete.Text    := FormatFloat(',#0.00', 0);
  edtOutros.Text   := FormatFloat(',#0.00', 0);
  edtTotal.Text    := FormatFloat(',#0.00', 0);
  edtChaveNfe.Clear;
  mObs.Lines.Clear;
  edtFormaPagamento.Clear;
  edtValorFpgto.Text := FormatFloat(',#0.00', 0);
  edtPesquisaGenericaFpgto.Clear;
end;

procedure TfrmDespesa.CarregarSelecionado;
var
  id: Integer;
  erro: String;
begin
  id := StrToInt(lvPadrao.Selected.Caption);
  if Controller.BuscarPorId(controller.Despesa, id, erro) then
  begin
    dtpData.Date       := Controller.Despesa.Data;
    dtpHora.Time       := Controller.Despesa.Hora;
    edtDescricao.Text  := Controller.Despesa.Descricao;
    edtFornecedor.Text := Controller.Despesa.Fornecedor.Nome;
    edtSubtipo.Text    := Controller.Despesa.SubTipo.Nome;
    edtValor.Text      := FormatFloat(',#0.00', Controller.Despesa.Valor);
    edtDesconto.Text   := FormatFloat(',#0.00', Controller.Despesa.Desconto);
    edtFrete.Text      := FormatFloat(',#0.00', Controller.Despesa.Frete);
    edtOutros.Text     := FormatFloat(',#0.00', Controller.Despesa.Outros);
    edtTotal.Text      := FormatFloat(',#0.00', Controller.Despesa.Total);
    edtChaveNfe.Text   := Controller.Despesa.ChaveNFE;
    mObs.Lines.Text    := Controller.Despesa.Observacao;
    lvPagamento.Items.Clear;
    Controller.ListarPagamento(lvPagamento, id);
  end
  else
  begin
    TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    Abort;
  end;
end;

end.

