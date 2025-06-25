unit view.bandeira;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  view.cadastropadrao, controller.bandeira, lib.types, view.mensagem;

type

  { TfrmBandeira }

  TfrmBandeira = class(TfrmCadastroPadrao)
    edtNome: TLabeledEdit;
    procedure actExcluirExecute(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Controller: TBandeiraController;
  public
    procedure CarregarDados; override;
    procedure LimparCampos; override;
    procedure CarregarSelecionado; override;
  end;

var
  frmBandeira: TfrmBandeira;

implementation

uses
  view.principal;

{$R *.lfm}

{ TfrmBandeira }

procedure TfrmBandeira.FormCreate(Sender: TObject);
begin
  inherited;
  Controller := TBandeiraController.Create;
end;

procedure TfrmBandeira.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmBandeira.FormShow(Sender: TObject);
begin
  LiberarBloquearAcessos(Self.actList, Self.Name);
  inherited;
end;

procedure TfrmBandeira.actSalvarExecute(Sender: TObject);
var
  erro: String;
begin
  if TfrmMessage.Mensagem('Deseja salvar ?', 'Aviso', 'Q', [mbNao, mbSim], mbNao) then
  begin
    Controller.Bandeira.Nome   := edtNome.Text;

    if Operacao = opInserir then
    begin
      if not Controller.Inserir(Controller.Bandeira, erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;
    if Operacao = opEditar then
    begin
      if not Controller.Editar(Controller.Bandeira, erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;
    inherited;
  end;
end;

procedure TfrmBandeira.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  TfrmPrincipal(Owner).BarraLateralVazia(TfrmPrincipal(Owner).pnlMenuFinanceiro, True);
  CloseAction := caFree;
end;

procedure TfrmBandeira.actExcluirExecute(Sender: TObject);
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

procedure TfrmBandeira.actPesquisarExecute(Sender: TObject);
begin
  lvPadrao.Items.Clear;
  Controller.Pesquisar(lvPadrao, lbPesquisa.Items[cbPesquisa.ItemIndex], edtPesquisa.Text);
end;

procedure TfrmBandeira.CarregarDados;
begin
  lvPadrao.Items.Clear;
  Controller.Listar(lvPadrao);
end;

procedure TfrmBandeira.LimparCampos;
begin
  edtNome.Clear;
end;

procedure TfrmBandeira.CarregarSelecionado;
var
  id: Integer;
  erro: String;
begin
  id := StrToInt(lvPadrao.Selected.Caption);
  if Controller.BuscarPorId(controller.Bandeira, id, erro) then
  begin
    edtNome.Text   := Controller.Bandeira.Nome;
  end
  else
  begin
    TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    Abort;
  end;
end;

end.

