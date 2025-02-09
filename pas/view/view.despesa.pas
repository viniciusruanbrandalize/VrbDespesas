unit view.despesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls, DateTimePicker, view.cadastropadrao, lib.types, controller.despesa,
  view.mensagem;

type

  { TfrmDespesa }

  TfrmDespesa = class(TfrmCadastroPadrao)
    dtpData: TDateTimePicker;
    dtpHora: TDateTimePicker;
    dtpInicial: TDateTimePicker;
    dtpFinal: TDateTimePicker;
    edtDescricao: TLabeledEdit;
    edtChaveNfe: TLabeledEdit;
    edtFornecedor: TLabeledEdit;
    edtTotal: TLabeledEdit;
    edtSubtipo: TLabeledEdit;
    edtValor: TLabeledEdit;
    edtDesconto: TLabeledEdit;
    edtFrete: TLabeledEdit;
    edtOutros: TLabeledEdit;
    edtValor1: TLabeledEdit;
    lblObs: TLabel;
    lblData: TLabel;
    lblPeriodoFiltro: TLabel;
    ListView1: TListView;
    mObs: TMemo;
    pgcMaisOpcoes: TPageControl;
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
    if Operacao = opInserir then
    begin
      if not Controller.Inserir(Controller.Despesa, erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;
    if Operacao = opEditar then
    begin
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
end;

procedure TfrmDespesa.CarregarSelecionado;
var
  id: Integer;
  erro: String;
begin
  id := StrToInt(lvPadrao.Selected.Caption);
  if Controller.BuscarPorId(controller.Despesa, id, erro) then
  begin
    edtDescricao.Text  := Controller.Despesa.Descricao;
  end
  else
  begin
    TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    Abort;
  end;
end;

end.

