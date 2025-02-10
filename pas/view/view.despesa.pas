unit view.despesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls, Menus, Buttons, ActnList, DateTimePicker, view.cadastropadrao,
  lib.types, controller.despesa, view.mensagem;

type

  { TfrmDespesa }

  TfrmDespesa = class(TfrmCadastroPadrao)
    actIncluirFpgto: TAction;
    actExcluirFpgto: TAction;
    actSalvarFpgto: TAction;
    actCancelarFpgto: TAction;
    btnExcluirFormaPgto: TSpeedButton;
    dtpData: TDateTimePicker;
    dtpHora: TDateTimePicker;
    dtpInicial: TDateTimePicker;
    dtpFinal: TDateTimePicker;
    edtFormaPagamento: TLabeledEdit;
    edtDescricao: TLabeledEdit;
    edtChaveNfe: TLabeledEdit;
    edtFornecedor: TLabeledEdit;
    edtTotal: TLabeledEdit;
    edtSubtipo: TLabeledEdit;
    edtValor: TLabeledEdit;
    edtDesconto: TLabeledEdit;
    edtFrete: TLabeledEdit;
    edtOutros: TLabeledEdit;
    edtValorFpgto: TLabeledEdit;
    edtPesquisaGenericaFpgto: TLabeledEdit;
    lblObs: TLabel;
    lblData: TLabel;
    lblPeriodoFiltro: TLabel;
    lvPagamento: TListView;
    MenuItem4: TMenuItem;
    mObs: TMemo;
    pgcMaisOpcoes: TPageControl;
    pMenuFpgto: TPopupMenu;
    btnIncluirFormaPgto: TSpeedButton;
    tbsPagamento: TTabSheet;
    tbsArquivo: TTabSheet;
    procedure actExcluirExecute(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Controller: TDespesaController;
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

procedure TfrmDespesa.CarregarDados;
begin
  lvPadrao.Items.Clear;
  Controller.Listar(lvPadrao);
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
  end
  else
  begin
    TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    Abort;
  end;
end;

end.

