{
*******************************************************************************
*   VRBDespesas                                                               *
*   Controle e gerenciamento de despesas.                                     *
*                                                                             *
*   Copyright (C) 2025 Vinícius Ruan Brandalize.                              *
*                                                                             *
*   This program is free software: you can redistribute it and/or modify      *
*   it under the terms of the GNU General Public License as published by      *
*   the Free Software Foundation, either version 3 of the License, or         *
*   (at your option) any later version.                                       *
*                                                                             *
*   This program is distributed in the hope that it will be useful,           *
*   but WITHOUT ANY WARRANTY; without even the implied warranty of            *
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             *
*   GNU General Public License for more details.                              *
*                                                                             *
*   You should have received a copy of the GNU General Public License         *
*   along with this program.  If not, see <https://www.gnu.org/licenses/>.    *
*                                                                             *
*   Contact: viniciusbrandalize2@gmail.com.                                   *
*                                                                             *
*******************************************************************************
}

unit view.despesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls, Menus, Buttons, ActnList, DateTimePicker, view.cadastropadrao,
  lib.types, controller.despesa, view.mensagem, LCLType, DateUtils;

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
    cbFormaPagamento: TComboBox;
    cbSubtipo: TComboBox;
    cbPesquisaGenerica: TComboBox;
    cbFornecedor: TComboBox;
    dtpData: TDateTimePicker;
    dtpHora: TDateTimePicker;
    dtpInicial: TDateTimePicker;
    dtpFinal: TDateTimePicker;
    edtDescricao: TLabeledEdit;
    edtChaveNfe: TLabeledEdit;
    edtTotal: TLabeledEdit;
    edtValor: TLabeledEdit;
    edtDesconto: TLabeledEdit;
    edtFrete: TLabeledEdit;
    edtOutros: TLabeledEdit;
    edtValorFpgto: TLabeledEdit;
    lblFormaPagamento: TLabel;
    lblSubtipo: TLabel;
    lblInfoPrecisao: TLabel;
    lblNivelPrecisao: TLabel;
    lblPesquisaGenerica: TLabel;
    lblObs: TLabel;
    lblData: TLabel;
    lblPeriodoFiltro: TLabel;
    lblFornecedor: TLabel;
    lbSubtipoId: TListBox;
    lbFornecedorId: TListBox;
    lbFormaPagamentoId: TListBox;
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
    procedure cbFormaPagamentoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbFormaPagamentoSelect(Sender: TObject);
    procedure cbFornecedorKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbFornecedorSelect(Sender: TObject);
    procedure cbSubtipoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbSubtipoSelect(Sender: TObject);
    procedure edtDescricaoChange(Sender: TObject);
    procedure edtValorChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
    procedure AtribuirValorPadraoPesquisa();
    function CamposEstaoPreenchidosPagamento: Boolean;
    function CamposEstaoComTamanhoMinimoPagamento: Boolean;
  public
    procedure CarregarDados; override;
    procedure LimparCampos; override;
    procedure CarregarSelecionado; override;
    function CamposEstaoPreenchidos: Boolean; override;
    function CamposEstaoComTamanhoMinimo: Boolean; override;
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
  if CamposEstaoPreenchidos and CamposEstaoComTamanhoMinimo then
  begin

    if (Operacao = opInserir) and (Controller.Despesa.DespesaFormaPagamento.Count <= 0) then
    begin
      TfrmMessage.Mensagem('Nenhuma forma de pagamento informada!', 'Aviso', 'C', [mbOK]);
      Exit;
    end;

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
end;

procedure TfrmDespesa.actSalvarFpgtoExecute(Sender: TObject);
var
  i: integer;
begin
  if CamposEstaoPreenchidosPagamento and CamposEstaoComTamanhoMinimoPagamento then
  begin
    i := Controller.Despesa.DespesaFormaPagamento.Count - 1;
    AjustarTelaPagamento(False);
    Controller.Despesa.DespesaFormaPagamento[i].Valor := StrToFloat(edtValorFpgto.Text);
    IncluirPagamento();
  end;
end;

procedure TfrmDespesa.cbFormaPagamentoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  qtdReg: Integer;
begin
  qtdReg := 0;
  if not (key in [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT]) then
  begin
    if (Length((Sender as TComboBox).Text) >= 3) then
    begin
      controller.PesquisarFormaPagamento((Sender as TComboBox), lbFormaPagamentoId, (Sender as TComboBox).Text, qtdReg);
      (Sender as TComboBox).DroppedDown := qtdReg > 1;
    end
    else
    begin
      (Sender as TComboBox).Items.Clear;
    end;
  end;
end;

procedure TfrmDespesa.cbFormaPagamentoSelect(Sender: TObject);
var
  i: Integer;
begin
  i := Pred(Controller.Despesa.DespesaFormaPagamento.Count);
  if (Sender as TComboBox).ItemIndex <> -1 then
  begin
    Controller.Despesa.DespesaFormaPagamento[i].FormaPagamento.Id :=
      StrToInt(lbFormaPagamentoId.Items[(Sender as TComboBox).ItemIndex]);
    Controller.Despesa.DespesaFormaPagamento[i].FormaPagamento.Nome := (Sender as TComboBox).Text;
    PrepararPesquisaGenerica(i);
  end;
end;

procedure TfrmDespesa.cbFornecedorKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  qtdReg: Integer;
begin
  qtdReg := 0;
  if not (key in [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT]) then
  begin
    if (Length((Sender as TComboBox).Text) >= 3) then
    begin
      controller.PesquisarFornecedor((Sender as TComboBox), lbFornecedorId, (Sender as TComboBox).Text, qtdReg);
      (Sender as TComboBox).DroppedDown := qtdReg > 1;
    end
    else
    begin
      (Sender as TComboBox).Items.Clear;
    end;
  end;
end;

procedure TfrmDespesa.cbFornecedorSelect(Sender: TObject);
begin
  if (Sender as TComboBox).ItemIndex <> -1 then
    controller.Despesa.Fornecedor.Id :=
      StrToInt(lbFornecedorId.Items[(Sender as TComboBox).ItemIndex]);
end;

procedure TfrmDespesa.cbSubtipoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  qtdReg: Integer;
begin
  qtdReg := 0;
  if not (key in [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT]) then
  begin
    if (Length((Sender as TComboBox).Text) >= 3) then
    begin
      controller.PesquisarSubtipo((Sender as TComboBox), lbSubtipoId, (Sender as TComboBox).Text, qtdReg);
      (Sender as TComboBox).DroppedDown := qtdReg > 1;
    end
    else
    begin
      (Sender as TComboBox).Items.Clear;
    end;
  end;
end;

procedure TfrmDespesa.cbSubtipoSelect(Sender: TObject);
begin
  if (Sender as TComboBox).ItemIndex <> -1 then
    controller.Despesa.SubTipo.Id :=
      StrToInt(lbSubtipoId.Items[(Sender as TComboBox).ItemIndex]);
end;

procedure TfrmDespesa.edtDescricaoChange(Sender: TObject);
begin
  ValidarObrigatorioChange(Sender);
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
  lblObrigatorio.Visible := False;
  lblLimiteCampo.Visible := False;
end;

procedure TfrmDespesa.actExcluirExecute(Sender: TObject);
var
  erro: string;
  id: integer;
begin
  if Assigned(lvPadrao.Selected) then
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
  end
  else
    TfrmMessage.Mensagem('Nenhum registro foi selecionado!', 'Aviso', 'C', [mbOk]);
end;

procedure TfrmDespesa.actExcluirFpgtoExecute(Sender: TObject);
begin
  if Assigned(lvPagamento.Selected) then
  begin
    Controller.ExcluirPagamento(lvPagamento.Selected.Index);
    lvPagamento.Selected.Delete;
  end
  else
    TfrmMessage.Mensagem('Nenhum registro foi selecionado!', 'Aviso', 'C', [mbOk]);
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
  end
  else
    TfrmMessage.Mensagem('Nenhum registro foi selecionado!', 'Aviso', 'C', [mbOk]);
end;

procedure TfrmDespesa.actIncluirArquivoExecute(Sender: TObject);
var
  i: Integer;
begin
  if openDlg.Execute then
  begin
    if ExtractFileExt(openDlg.FileName) = EmptyStr then
    begin
      TfrmMessage.Mensagem('Não é permitido incluir um arquivo sem extensão!', 'Aviso', 'C', [mbOK], mbOK);
      Exit;
    end;
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
  end
  else
    TfrmMessage.Mensagem('Nenhum registro foi selecionado!', 'Aviso', 'C', [mbOk]);
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
    if cbFormaPagamento.CanFocus then
      cbFormaPagamento.SetFocus;
  end
  else
    TfrmMessage.Mensagem('Valor pago já foi alcançado!', 'Aviso', 'C', [mbOK], mbOK);
end;

procedure TfrmDespesa.actPesquisarExecute(Sender: TObject);
begin
  lvPadrao.Items.Clear;
  Controller.Pesquisar(lvPadrao, lbPesquisa.Items[cbPesquisa.ItemIndex],
    edtPesquisa.Text, dtpInicial.Date, dtpFinal.Date);
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
  AtribuirValorPadraoPesquisa();
  inherited;
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
  cbFormaPagamento.Clear;
  cbFormaPagamento.Items.Clear;
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
  Erro, Valor : String;
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

  Valor := '0';
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
    8:
    begin
      Valor := Controller.BuscarConfiguracaoPorNome('USAR_CARTAO_VALE', Erro);
      if Trim(Valor) = '1' then
      begin
        lblPesquisaGenerica.Caption := 'Cartão: *';
        Controller.PesquisarCartao(cbPesquisaGenerica, lbPesquisaGenericaId, qtdReg);
        cbPesquisaGenerica.OnChange := @edtCartaoChange;
        if qtdReg = 0 then
          TfrmMessage.Mensagem('Nenhum cartão cadastrado!', 'Aviso', 'C', [mbOK]);
      end
      else
      if Trim(Valor) = '' then
      begin
        TfrmMessage.Mensagem(Erro, 'Erro', 'E', [mbOK]);
        Valor := '0';
      end;
    end;
  end;

  cbPesquisaGenerica.Visible  :=  (idFpgto in  [2, 3, 4, 5, 6]) or (Trim(Valor) = '1');
  lblPesquisaGenerica.Visible :=  (idFpgto in  [2, 3, 4, 5, 6]) or (Trim(Valor) = '1');

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

procedure TfrmDespesa.AtribuirValorPadraoPesquisa();
begin
  dtpInicial.Date      := StartOfTheMonth(Now);
  dtpFinal.Date        := EndOfTheMonth(Now);
  edtPesquisa.Text     := '';
  cbPesquisa.ItemIndex := 0;
end;

function TfrmDespesa.CamposEstaoPreenchidosPagamento: Boolean;
begin
  Result := False;
  if cbFormaPagamento.ItemIndex = -1 then
    ValidarObrigatorioExit(cbFormaPagamento)
  else
    Result := True;
end;

function TfrmDespesa.CamposEstaoComTamanhoMinimoPagamento: Boolean;
begin
  Result := False;
  if StrToFloatDef(edtValorFpgto.Text, 0) <= 0 then
    ValidarMaiorQueZeroExit(edtValorFpgto)
  else
    Result := True;
end;

procedure TfrmDespesa.CarregarDados;
begin
  lvPadrao.Items.Clear;
  Controller.Listar(lvPadrao);
  AjustarTelaPagamento(False);
  AtribuirValorPadraoPesquisa();
end;

procedure TfrmDespesa.LimparCampos;
begin
  edtDescricao.Clear;
  dtpData.Date := Now;
  dtpHora.Time := Now;
  cbFornecedor.Clear;
  cbFornecedor.Items.Clear;
  cbSubtipo.Clear;
  cbSubtipo.Items.Clear;
  edtValor.Text := FormatFloat(',#0.00', 0);
  edtDesconto.Text := FormatFloat(',#0.00', 0);
  edtFrete.Text := FormatFloat(',#0.00', 0);
  edtOutros.Text := FormatFloat(',#0.00', 0);
  edtTotal.Text := FormatFloat(',#0.00', 0);
  edtChaveNfe.Clear;
  mObs.Lines.Clear;
  cbFormaPagamento.Clear;
  cbFormaPagamento.Items.Clear;
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
      cbFornecedor.Text := Controller.Despesa.Fornecedor.Nome;
      cbSubtipo.Text := Controller.Despesa.SubTipo.Nome;
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

function TfrmDespesa.CamposEstaoPreenchidos: Boolean;
begin
  Result := False;
  if Trim(edtDescricao.Text) = EmptyStr then
    ValidarObrigatorioExit(edtDescricao)
  else
  if cbFornecedor.ItemIndex = -1 then
    ValidarObrigatorioExit(cbFornecedor)
  else
  if cbSubtipo.ItemIndex = -1 then
    ValidarObrigatorioExit(cbSubtipo)
  else
    Result := True;
end;

function TfrmDespesa.CamposEstaoComTamanhoMinimo: Boolean;
begin
  Result := False;
  if Length(Trim(edtDescricao.Text)) < 3 then
    ValidarTamanhoMinimoExit(edtDescricao)
  else
  if StrToFloatDef(edtValor.Text, 0) <= 0 then
    ValidarMaiorQueZeroExit(edtValor)
  else
  if StrToFloatDef(edtTotal.Text, 0) <= 0 then
    ValidarMaiorQueZeroExit(edtTotal)
  else
    Result := True;
end;

end.
