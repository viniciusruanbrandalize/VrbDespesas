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
    cbPesquisaGenerica: TComboBox;
    dtpData: TDateTimePicker;
    dtpHora: TDateTimePicker;
    dtpInicial: TDateTimePicker;
    dtpFinal: TDateTimePicker;
    edtDescricao: TLabeledEdit;
    edtChaveNfe: TLabeledEdit;
    edtFormaPagamento: TLabeledEdit;
    edtFornecedor: TLabeledEdit;
    edtTotal: TLabeledEdit;
    edtSubtipo: TLabeledEdit;
    edtValor: TLabeledEdit;
    edtDesconto: TLabeledEdit;
    edtFrete: TLabeledEdit;
    edtOutros: TLabeledEdit;
    edtValorFpgto: TLabeledEdit;
    lblInfoPrecisao: TLabel;
    lblNivelPrecisao: TLabel;
    lblPesquisaGenerica: TLabel;
    lbFormaPagamentoNome: TListBox;
    lblObs: TLabel;
    lblData: TLabel;
    lblPeriodoFiltro: TLabel;
    lbSubtipoId: TListBox;
    lbFornecedorId: TListBox;
    lbFormaPagamentoId: TListBox;
    lbSubtipoNome: TListBox;
    lbFornecedorNome: TListBox;
    lbPesquisaGenericaId: TListBox;
    lvPagamento: TListView;
    lvArquivo: TListView;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    mObs: TMemo;
    openDlg: TOpenDialog;
    pnlBotoesArquivo: TPanel;
    pnlBotoesSalvarCancelarPagamento: TPanel;
    pnlIncluiPagamento: TPanel;
    pnlBotoesPagamento: TPanel;
    pgcMaisOpcoes: TPageControl;
    pMenuFpgto: TPopupMenu;
    pMenuArquivo: TPopupMenu;
    saveDlg: TSaveDialog;
    tbsPagamento: TTabSheet;
    tbsArquivo: TTabSheet;
    trbNivelPrecisao: TTrackBar;
    procedure actCancelarExecute(Sender: TObject);
    procedure actCancelarFpgtoExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure actExcluirArquivoExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure actExcluirFpgtoExecute(Sender: TObject);
    procedure actExportarArquivoExecute(Sender: TObject);
    procedure actIncluirArquivoExecute(Sender: TObject);
    procedure actIncluirExecute(Sender: TObject);
    procedure actIncluirFpgtoExecute(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure actSalvarFpgtoExecute(Sender: TObject);
    procedure edtFormaPagamentoExit(Sender: TObject);
    procedure edtFormaPagamentoKeyUp(Sender: TObject; var Key: word;
      Shift: TShiftState);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyUp(Sender: TObject; var Key: word;
      Shift: TShiftState);
    procedure edtSubtipoExit(Sender: TObject);
    procedure edtSubtipoKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure edtValorChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbFormaPagamentoNomeDblClick(Sender: TObject);
    procedure lbFormaPagamentoNomeKeyPress(Sender: TObject; var Key: char);
    procedure lbFormaPagamentoNomeSelectionChange(Sender: TObject; User: boolean);
    procedure lbFornecedorNomeDblClick(Sender: TObject);
    procedure lbFornecedorNomeKeyPress(Sender: TObject; var Key: char);
    procedure lbFornecedorNomeSelectionChange(Sender: TObject; User: boolean);
    procedure lbSubtipoNomeDblClick(Sender: TObject);
    procedure lbSubtipoNomeKeyPress(Sender: TObject; var Key: char);
    procedure lbSubtipoNomeSelectionChange(Sender: TObject; User: boolean);
  private
    Controller: TDespesaController;
    procedure AjustarTelaPagamento(Inserindo: boolean);
    procedure IncluirPagamento();
    procedure IncluirArquivo();
    procedure LimparCamposPagamento();
    procedure HabilitarCampos(Hab: boolean);
    procedure PrepararPesquisaGenerica(i: Integer);
    procedure edtPixChange(Sender: TObject);
    procedure edtCartaoChange(Sender: TObject);
    procedure edtContaBancariaChange(Sender: TObject);
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
  edtValor.OnExit := @NumericoExit;
  edtValor.OnEnter := @NumericoEnter;
  edtValor.OnKeyPress := @NumericoKeyPress;
  edtDesconto.OnExit := @NumericoExit;
  edtDesconto.OnEnter := @NumericoEnter;
  edtDesconto.OnKeyPress := @NumericoKeyPress;
  edtFrete.OnExit := @NumericoExit;
  edtFrete.OnEnter := @NumericoEnter;
  edtFrete.OnKeyPress := @NumericoKeyPress;
  edtOutros.OnExit := @NumericoExit;
  edtOutros.OnEnter := @NumericoEnter;
  edtOutros.OnKeyPress := @NumericoKeyPress;
  edtTotal.OnExit := @NumericoExit;
  edtTotal.OnEnter := @NumericoEnter;
  edtTotal.OnKeyPress := @NumericoKeyPress;
  edtValorFpgto.OnExit := @NumericoExit;
  edtValorFpgto.OnEnter := @NumericoEnter;
  edtValorFpgto.OnKeyPress := @NumericoKeyPress;
end;

procedure TfrmDespesa.actSalvarExecute(Sender: TObject);
var
  erro: string;
  valor: double;
begin
  if TfrmMessage.Mensagem('Deseja salvar ?', 'Aviso', 'Q', [mbNao, mbSim], mbNao) then
  begin
    Controller.Despesa.Descricao := edtDescricao.Text;
    Controller.Despesa.Data := dtpData.Date;
    Controller.Despesa.Hora := dtpHora.Time;
    if not TryStrToFloat(edtValor.Text, valor) then
      valor := 0;
    Controller.Despesa.Valor := valor;
    if not TryStrToFloat(edtDesconto.Text, valor) then
      valor := 0;
    Controller.Despesa.Desconto := valor;
    if not TryStrToFloat(edtFrete.Text, valor) then
      valor := 0;
    Controller.Despesa.Frete := valor;
    if not TryStrToFloat(edtOutros.Text, valor) then
      valor := 0;
    Controller.Despesa.Outros := valor;
    if not TryStrToFloat(edtTotal.Text, valor) then
      valor := 0;
    Controller.Despesa.Total := valor;
    Controller.Despesa.ChaveNFE := edtChaveNfe.Text;
    Controller.Despesa.Observacao := mObs.Lines.Text;
    Controller.Despesa.NivelPrecisao := trbNivelPrecisao.Position;
    Controller.Despesa.Paga := True;
    if Operacao = opInserir then
    begin
      Controller.Despesa.Cadastro := Now;
      if not Controller.Inserir(Controller.Despesa, erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOK]);
    end;
    if Operacao = opEditar then
    begin
      Controller.Despesa.Alteracao := Now;
      if not Controller.Editar(Controller.Despesa, erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOK]);
    end;
    inherited;
  end;
end;

procedure TfrmDespesa.actSalvarFpgtoExecute(Sender: TObject);
var
  i: integer;
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
      lbFormaPagamentoNome.Visible := False;
  end;
end;

procedure TfrmDespesa.edtFormaPagamentoKeyUp(Sender: TObject;
  var Key: word; Shift: TShiftState);
var
  qtdReg: integer;
begin
  qtdReg := 0;
  if (Length(edtFormaPagamento.Text) > 2) then
  begin
    controller.PesquisarFormaPagamento(lbFormaPagamentoNome,
      lbFormaPagamentoId, edtFormaPagamento.Text, qtdReg);
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
      lbFornecedorNome.Visible := False;
  end;
end;

procedure TfrmDespesa.edtFornecedorKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
var
  qtdReg: integer;
begin
  qtdReg := 0;
  if (Length(edtFornecedor.Text) > 3) then
  begin
    controller.PesquisarFornecedor(lbFornecedorNome, lbFornecedorId,
      edtFornecedor.Text, qtdReg);
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
      lbSubtipoNome.Visible := False;
  end;
end;

procedure TfrmDespesa.edtSubtipoKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
var
  qtdReg: integer;
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

procedure TfrmDespesa.edtValorChange(Sender: TObject);
var
  Valor, Desc, Frete, Outros, Total: double;
begin
  if not TryStrToFloat(edtValor.Text, Valor) then
    Valor := 0;
  if not TryStrToFloat(edtDesconto.Text, Desc) then
    Desc := 0;
  if not TryStrToFloat(edtFrete.Text, Frete) then
    Frete := 0;
  if not TryStrToFloat(edtOutros.Text, Outros) then
    Outros := 0;
  Total := Controller.CalcularValorTotal(valor, desc, frete, outros);
  edtTotal.Text := FormatFloat(',#0.00', Total);
end;

procedure TfrmDespesa.actExcluirExecute(Sender: TObject);
var
  erro: string;
  id: integer;
begin
  if TfrmMessage.Mensagem('Deseja excluir o item selecionado ?',
    'Aviso', 'D', [mbNao, mbSim], mbNao) then
  begin
    id := StrToInt(lvPadrao.Selected.Caption);
    if Controller.Excluir(id, erro) then
      inherited
    else
      TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOK]);
    Operacao := opNenhum;
  end;
end;

procedure TfrmDespesa.actExcluirFpgtoExecute(Sender: TObject);
begin
  if Assigned(lvPagamento.Selected) then
  begin
    Controller.ExcluirPagamento(lvPagamento.Selected.Index);
    lvPagamento.Selected.Delete;
  end;
end;

procedure TfrmDespesa.actExportarArquivoExecute(Sender: TObject);
var
  i: Integer;
begin
  if Assigned(lvArquivo.Selected) then
  begin
    i := lvArquivo.Selected.Index;
    saveDlg.FileName := Controller.Despesa.Arquivo[i].Nome +
                        Controller.Despesa.Arquivo[i].Extensao;
    saveDlg.Filter   := Controller.Despesa.Arquivo[i].Extensao;
    if saveDlg.Execute then
    begin
      Controller.Despesa.Arquivo[i].Binario.SaveToFile(saveDlg.FileName);
    end;
  end;
end;

procedure TfrmDespesa.actIncluirArquivoExecute(Sender: TObject);
var
  i: Integer;
begin
  if openDlg.Execute then
  begin
    Controller.AdicionarArquivo(Controller.Despesa);
    i := Controller.Despesa.Arquivo.Count - 1;
    Controller.Despesa.Arquivo[i].Nome           := ChangeFileExt(ExtractFileName(openDlg.FileName), EmptyStr);
    Controller.Despesa.Arquivo[i].Extensao       := ExtractFileExt(openDlg.FileName);
    Controller.Despesa.Arquivo[i].DataHoraUpload := Now;
    Controller.Despesa.Arquivo[i].Binario.LoadFromFile(openDlg.FileName);
    IncluirArquivo();
  end;
end;

procedure TfrmDespesa.actIncluirExecute(Sender: TObject);
begin
  inherited;
  HabilitarCampos(True);
  lvPagamento.Items.Clear;
  lvArquivo.Items.Clear;
  Controller.Despesa.Arquivo.Clear;
  Controller.Despesa.DespesaFormaPagamento.Clear;
  pgcMaisOpcoes.ActivePageIndex := 0;
end;

procedure TfrmDespesa.actCancelarFpgtoExecute(Sender: TObject);
begin
  Controller.DeletarUltimoPagamento();
  AjustarTelaPagamento(False);
end;

procedure TfrmDespesa.actCancelarExecute(Sender: TObject);
begin
  if TfrmMessage.Mensagem('Deseja cancelar ?', 'Aviso', 'Q', [mbNao, mbSim], mbNao) then
  begin
    pgcPadrao.ActivePage := tbsLista;
    Operacao := opNenhum;
    Controller.CancelarAtualizacaoArquivo();
  end;
end;

procedure TfrmDespesa.actEditarExecute(Sender: TObject);
begin
  inherited;
  HabilitarCampos(False);
  pgcMaisOpcoes.ActivePageIndex := 0;
end;

procedure TfrmDespesa.actExcluirArquivoExecute(Sender: TObject);
var
  id, idx: Integer;
  Erro: String;
begin
  if Assigned(lvArquivo.Selected) then
  begin
    if not TryStrToInt(lvArquivo.Selected.Caption, id) then
      id := 0;
    idx := lvArquivo.Selected.Index;
    if not Controller.ExcluirArquivo(Controller.Despesa, id, idx, erro) then
      TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOK], mbOK);
    lvArquivo.Items.Clear;
    Controller.ListarArquivos(lvArquivo, Controller.Despesa);
  end;
end;

procedure TfrmDespesa.actIncluirFpgtoExecute(Sender: TObject);
var
  total: double;
begin
  if not TryStrToFloat(edtTotal.Text, total) then
    total := 0;

  if Controller.ValorPagoEhValido(total) then
  begin
    AjustarTelaPagamento(True);
    LimparCamposPagamento();
    Controller.AdicionarPagamento();
  end
  else
    TfrmMessage.Mensagem('Valor pago já foi alcançado!', 'Aviso', 'C', [mbOK], mbOK);
end;

procedure TfrmDespesa.actPesquisarExecute(Sender: TObject);
begin
  lvPadrao.Items.Clear;
  Controller.Pesquisar(lvPadrao, lbPesquisa.Items[cbPesquisa.ItemIndex],
    edtPesquisa.Text);
end;

procedure TfrmDespesa.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  TfrmPrincipal(Owner).BarraLateralVazia(TfrmPrincipal(Owner).pnlMenuOperacao, True);
  CloseAction := caFree;
end;

procedure TfrmDespesa.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmDespesa.FormShow(Sender: TObject);
begin
  LiberarBloquearAcessos(Self.actList, Self.Name);
  inherited;
end;

procedure TfrmDespesa.lbFormaPagamentoNomeDblClick(Sender: TObject);
var
  i: integer;
begin
  i := Controller.Despesa.DespesaFormaPagamento.Count - 1;
  if lbFormaPagamentoNome.ItemIndex <> -1 then
  begin
    edtFormaPagamento.Text := lbFormaPagamentoNome.Items[lbFormaPagamentoNome.ItemIndex];
    Controller.Despesa.DespesaFormaPagamento[i].FormaPagamento.Id :=
      StrToInt(lbFormaPagamentoId.Items[lbFormaPagamentoNome.ItemIndex]);
    Controller.Despesa.DespesaFormaPagamento[i].FormaPagamento.Nome :=
      edtFormaPagamento.Text;
    PrepararPesquisaGenerica(i);
    lbFormaPagamentoNome.Visible := False;
  end
  else
  begin
    edtFormaPagamento.Text := '';
    Controller.Despesa.DespesaFormaPagamento[i].FormaPagamento.Id := 0;
  end;
end;

procedure TfrmDespesa.lbFormaPagamentoNomeKeyPress(Sender: TObject; var Key: char);
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
    controller.Despesa.Fornecedor.Id :=
      StrToInt(lbFornecedorId.Items[lbFornecedorNome.ItemIndex]);
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

procedure TfrmDespesa.lbFornecedorNomeSelectionChange(Sender: TObject; User: boolean);
begin
  edtFornecedor.Text := lbFornecedorNome.Items[lbFornecedorNome.ItemIndex];
end;

procedure TfrmDespesa.lbSubtipoNomeDblClick(Sender: TObject);
begin
  if lbSubtipoNome.ItemIndex <> -1 then
  begin
    edtSubtipo.Text := lbSubtipoNome.Items[lbSubtipoNome.ItemIndex];
    controller.Despesa.SubTipo.Id :=
      StrToInt(lbSubtipoId.Items[lbSubtipoNome.ItemIndex]);
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

procedure TfrmDespesa.lbSubtipoNomeSelectionChange(Sender: TObject; User: boolean);
begin
  edtSubtipo.Text := lbSubtipoNome.Items[lbSubtipoNome.ItemIndex];
end;

procedure TfrmDespesa.AjustarTelaPagamento(Inserindo: boolean);
begin
  pnlIncluiPagamento.Visible := inserindo;
  pnlBotoesSalvarCancelarPagamento.Visible := Inserindo;
  pnlBotoesPagamento.Visible := not Inserindo;
  lvPagamento.Visible := not Inserindo;
  if Inserindo then
  begin
    pnlIncluiPagamento.Align := alClient;
    pnlBotoesSalvarCancelarPagamento.Align := alBottom;
  end
  else
  begin
    lvPagamento.Align := alClient;
    pnlBotoesPagamento.Align := alBottom;
  end;
end;

procedure TfrmDespesa.IncluirPagamento();
var
  item: TListItem;
  i: integer;
begin
  i := Controller.Despesa.DespesaFormaPagamento.Count - 1;
  item := lvPagamento.Items.Add;
  item.Caption := '0';
  item.SubItems.Add(controller.Despesa.DespesaFormaPagamento[i].FormaPagamento.Nome);
  item.SubItems.Add(FormatFloat(',#0.00',
    controller.Despesa.DespesaFormaPagamento[i].Valor));
end;

procedure TfrmDespesa.IncluirArquivo();
var
  item: TListItem;
  i: integer;
begin
  i := Controller.Despesa.Arquivo.Count - 1;
  item := lvArquivo.Items.Add;
  item.Caption := controller.Despesa.Arquivo[i].Id.ToString;
  item.SubItems.Add(controller.Despesa.Arquivo[i].Nome);
  item.SubItems.Add(controller.Despesa.Arquivo[i].Extensao);
  item.SubItems.Add(DateTimeToStr(controller.Despesa.Arquivo[i].DataHoraUpload));
end;

procedure TfrmDespesa.LimparCamposPagamento();
begin
  edtValorFpgto.Text := '0,00';
  edtFormaPagamento.Clear;
  cbPesquisaGenerica.Items.Clear;
  lbPesquisaGenericaId.Items.Clear;
  cbPesquisaGenerica.Visible  := False;
  lblPesquisaGenerica.Visible := False;
end;

procedure TfrmDespesa.HabilitarCampos(Hab: boolean);
begin
  tbsPagamento.Enabled := Hab;
  edtValor.Enabled := Hab;
  edtDesconto.Enabled := Hab;
  edtFrete.Enabled := Hab;
  edtOutros.Enabled := Hab;
  edtTotal.Enabled := Hab;
end;

procedure TfrmDespesa.PrepararPesquisaGenerica(i: Integer);
var
  idFpgto,
  qtdReg: Integer;
begin

  {
   1  - DINHEIRO
   2  - CARTAO DEBITO
   3  - CARTAO CREDITO
   4  - PIX
   5  - TRANSFERENCIA BANCARIA
   6  - BOLETO
   7  - DEPOSITO
   8  - VALE
   9  - CHEQUE
  }

  idFpgto := Controller.Despesa.DespesaFormaPagamento[i].FormaPagamento.Id;

  Controller.Despesa.DespesaFormaPagamento[i].Pix.Chave := '-1';

  case idFpgto of
    2, 3:
    begin
      lblPesquisaGenerica.Caption := 'Cartão: *';
      Controller.PesquisarCartao(cbPesquisaGenerica, lbPesquisaGenericaId, qtdReg);
      cbPesquisaGenerica.OnChange := @edtCartaoChange;
      if qtdReg = 0 then
        TfrmMessage.Mensagem('Nenhum cartão cadastrado!', 'Aviso', 'C', [mbOK]);
    end;
    4:
    begin
      lblPesquisaGenerica.Caption := 'Chave PIX: *';
      Controller.PesquisarPix(cbPesquisaGenerica, lbPesquisaGenericaId, qtdReg);
      cbPesquisaGenerica.OnChange := @edtPixChange;
      if qtdReg = 0 then
        TfrmMessage.Mensagem('Nenhuma chave pix cadastrada!', 'Aviso', 'C', [mbOK]);
    end;
    5, 6:
    begin
      lblPesquisaGenerica.Caption := 'Conta Bancária: *';
      Controller.PesquisarContaBancaria(cbPesquisaGenerica, lbPesquisaGenericaId, qtdReg);
      cbPesquisaGenerica.OnChange := @edtContaBancariaChange;
      if qtdReg = 0 then
        TfrmMessage.Mensagem('Nenhuma conta bancária cadastrada!', 'Aviso', 'C', [mbOK]);
    end;
  end;

  cbPesquisaGenerica.Visible  := ( idFpgto in  [2, 3, 4, 5, 6] );
  lblPesquisaGenerica.Visible := ( idFpgto in  [2, 3, 4, 5, 6] );

end;

procedure TfrmDespesa.edtPixChange(Sender: TObject);
var
  i: Integer;
begin
  i := Controller.Despesa.DespesaFormaPagamento.Count - 1;
  Controller.Despesa.DespesaFormaPagamento[i].Pix.Chave :=
                       lbPesquisaGenericaId.Items[cbPesquisaGenerica.ItemIndex];
  Controller.Despesa.DespesaFormaPagamento[i].Cartao.Id := -1;
  Controller.Despesa.DespesaFormaPagamento[i].ContaBancaria.Id := -1;
end;

procedure TfrmDespesa.edtCartaoChange(Sender: TObject);
var
  i, id: Integer;
begin
  i := Controller.Despesa.DespesaFormaPagamento.Count - 1;
  if not TryStrToInt(lbPesquisaGenericaId.Items[cbPesquisaGenerica.ItemIndex], id) then
    id := 0;
  Controller.Despesa.DespesaFormaPagamento[i].Cartao.Id := id;
  Controller.Despesa.DespesaFormaPagamento[i].Pix.Chave := '-1';
  Controller.Despesa.DespesaFormaPagamento[i].ContaBancaria.Id := -1;
end;

procedure TfrmDespesa.edtContaBancariaChange(Sender: TObject);
var
  i, id: Integer;
begin
  i := Controller.Despesa.DespesaFormaPagamento.Count - 1;
  if not TryStrToInt(lbPesquisaGenericaId.Items[cbPesquisaGenerica.ItemIndex], id) then
    id := 0;
  Controller.Despesa.DespesaFormaPagamento[i].ContaBancaria.Id := id;
  Controller.Despesa.DespesaFormaPagamento[i].Cartao.Id := -1;
  Controller.Despesa.DespesaFormaPagamento[i].Pix.Chave := '-1';
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
  edtValor.Text := FormatFloat(',#0.00', 0);
  edtDesconto.Text := FormatFloat(',#0.00', 0);
  edtFrete.Text := FormatFloat(',#0.00', 0);
  edtOutros.Text := FormatFloat(',#0.00', 0);
  edtTotal.Text := FormatFloat(',#0.00', 0);
  edtChaveNfe.Clear;
  mObs.Lines.Clear;
  edtFormaPagamento.Clear;
  edtValorFpgto.Text := FormatFloat(',#0.00', 0);
  trbNivelPrecisao.Position := 0;
end;

procedure TfrmDespesa.CarregarSelecionado;
var
  id: integer;
  erro: string;
begin
  if Assigned(lvPadrao.Selected) then
  begin
    id := StrToInt(lvPadrao.Selected.Caption);
    if Controller.BuscarPorId(controller.Despesa, id, erro) then
    begin
      dtpData.Date := Controller.Despesa.Data;
      dtpHora.Time := Controller.Despesa.Hora;
      edtDescricao.Text := Controller.Despesa.Descricao;
      edtFornecedor.Text := Controller.Despesa.Fornecedor.Nome;
      edtSubtipo.Text := Controller.Despesa.SubTipo.Nome;
      edtValor.Text := FormatFloat(',#0.00', Controller.Despesa.Valor);
      edtDesconto.Text := FormatFloat(',#0.00', Controller.Despesa.Desconto);
      edtFrete.Text := FormatFloat(',#0.00', Controller.Despesa.Frete);
      edtOutros.Text := FormatFloat(',#0.00', Controller.Despesa.Outros);
      edtTotal.Text := FormatFloat(',#0.00', Controller.Despesa.Total);
      edtChaveNfe.Text := Controller.Despesa.ChaveNFE;
      mObs.Lines.Text := Controller.Despesa.Observacao;
      trbNivelPrecisao.Position := Controller.Despesa.NivelPrecisao;
      lvPagamento.Items.Clear;
      lvArquivo.Items.Clear;
      Controller.ListarPagamento(lvPagamento, id);
      Controller.ListarArquivos(lvArquivo, Controller.Despesa);
    end
    else
    begin
      TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOK]);
      Abort;
    end;
  end;
end;

end.
