unit view.tipodespesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  view.cadastropadrao, lib.types, controller.tipodespesa, view.mensagem;

type

  { TfrmTipoDespesa }

  TfrmTipoDespesa = class(TfrmCadastroPadrao)
    edtNome: TLabeledEdit;
    procedure actExcluirExecute(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure edtNomeChange(Sender: TObject);
    procedure edtNomeExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Controller: TTipoDespesaController;
  public
    procedure CarregarDados; override;
    procedure LimparCampos; override;
    procedure CarregarSelecionado; override;
    function CamposEstaoPreenchidos: Boolean; override;
  end;

var
  frmTipoDespesa: TfrmTipoDespesa;

implementation

uses
  view.principal;

{$R *.lfm}

{ TfrmTipoDespesa }

procedure TfrmTipoDespesa.FormCreate(Sender: TObject);
begin
  inherited;
  Controller := TTipoDespesaController.Create;
end;

procedure TfrmTipoDespesa.actSalvarExecute(Sender: TObject);
var
  erro: String;
begin
  if TfrmMessage.Mensagem('Deseja salvar ?', 'Aviso', 'Q', [mbNao, mbSim], mbNao) then
  begin
    Controller.TipoDespesa.Nome  := edtNome.Text;
    if Operacao = opInserir then
    begin
      if not Controller.Inserir(Controller.TipoDespesa, erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;
    if Operacao = opEditar then
    begin
      if not Controller.Editar(Controller.TipoDespesa, erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;
    inherited;
  end;
end;

procedure TfrmTipoDespesa.edtNomeChange(Sender: TObject);
begin
  ValidarObrigatorioChange(Sender);
end;

procedure TfrmTipoDespesa.edtNomeExit(Sender: TObject);
begin
  ValidarObrigatorioExit(Sender);
end;

procedure TfrmTipoDespesa.actExcluirExecute(Sender: TObject);
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

procedure TfrmTipoDespesa.actPesquisarExecute(Sender: TObject);
begin
  lvPadrao.Items.Clear;
  Controller.Pesquisar(lvPadrao, lbPesquisa.Items[cbPesquisa.ItemIndex], edtPesquisa.Text);
end;

procedure TfrmTipoDespesa.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  TfrmPrincipal(Owner).BarraLateralVazia(TfrmPrincipal(Owner).pnlMenuCadastro, True);
  CloseAction := caFree;
end;

procedure TfrmTipoDespesa.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmTipoDespesa.FormShow(Sender: TObject);
begin
  LiberarBloquearAcessos(Self.actList, Self.Name);
  inherited;
end;

procedure TfrmTipoDespesa.CarregarDados;
begin
  lvPadrao.Items.Clear;
  Controller.Listar(lvPadrao);
end;

procedure TfrmTipoDespesa.LimparCampos;
begin
  edtNome.Clear;
end;

procedure TfrmTipoDespesa.CarregarSelecionado;
var
  id: Integer;
  erro: String;
begin
  id := StrToInt(lvPadrao.Selected.Caption);
  if Controller.BuscarPorId(controller.TipoDespesa, id, erro) then
  begin
    edtNome.Text  := Controller.TipoDespesa.Nome;
  end
  else
  begin
    TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    Abort;
  end;
end;

function TfrmTipoDespesa.CamposEstaoPreenchidos: Boolean;
begin
  Result := False;
  if Trim(edtNome.Text) = EmptyStr then
    ValidarObrigatorioExit(edtNome)
  else
    Result := True;
end;

end.

