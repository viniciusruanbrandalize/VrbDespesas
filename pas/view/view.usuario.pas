unit view.usuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, view.cadastropadrao,
  view.mensagem, lib.types, controller.usuario;

type

  { TfrmUsuario }

  TfrmUsuario = class(TfrmCadastroPadrao)
    procedure actExcluirExecute(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Controller: TUsuarioController;
  public
    procedure CarregarDados; override;
    procedure LimparCampos; override;
    procedure CarregarSelecionado; override;
  end;

var
  frmUsuario: TfrmUsuario;

implementation

uses
  view.principal;

{$R *.lfm}

{ TfrmUsuario }

procedure TfrmUsuario.actExcluirExecute(Sender: TObject);
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

procedure TfrmUsuario.actPesquisarExecute(Sender: TObject);
begin
  lvPadrao.Items.Clear;
  Controller.Pesquisar(lvPadrao, lbPesquisa.Items[cbPesquisa.ItemIndex], edtPesquisa.Text);
end;

procedure TfrmUsuario.actSalvarExecute(Sender: TObject);
var
  erro: String;
begin
  if TfrmMessage.Mensagem('Deseja salvar ?', 'Aviso', 'Q', [mbNao, mbSim], mbNao) then
  begin
    //Controller.Usuario.Nome  := edtNome.Text;
    if Operacao = opInserir then
    begin
      if not Controller.Inserir(Controller.Usuario, erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;
    if Operacao = opEditar then
    begin
      if not Controller.Editar(Controller.Usuario, erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;
    inherited;
  end;
end;

procedure TfrmUsuario.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  TfrmPrincipal(Owner).BarraLateralVazia(TfrmPrincipal(Owner).pnlMenuCadastro, True);
end;

procedure TfrmUsuario.FormCreate(Sender: TObject);
begin
  inherited;
  Controller := TUsuarioController.Create;
end;

procedure TfrmUsuario.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmUsuario.CarregarDados;
begin
  lvPadrao.Items.Clear;
  Controller.Listar(lvPadrao);
end;

procedure TfrmUsuario.LimparCampos;
begin
  //
end;

procedure TfrmUsuario.CarregarSelecionado;
var
  id: Integer;
  erro: String;
begin
  id := StrToInt(lvPadrao.Selected.Caption);
  if Controller.BuscarPorId(controller.Usuario, id, erro) then
  begin
    //edtNome.Text  := Controller.SubtipoDespesa.Nome;
    //edtTipo.Text   := Controller.SubtipoDespesa.TipoDespesa.Nome;
  end
  else
  begin
    TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    Abort;
  end;
end;

end.

