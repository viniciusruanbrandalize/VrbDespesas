unit view.usuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ActnList, Menus, ComCtrls, CheckLst, view.cadastropadrao, view.mensagem,
  lib.types, controller.usuario;

type

  { TfrmUsuario }

  TfrmUsuario = class(TfrmCadastroPadrao)
    actAcesso: TAction;
    actSalvarAcesso: TAction;
    actCancelarAcesso: TAction;
    btnCancelar1: TToolButton;
    btnSalvar1: TToolButton;
    cklbTituloAcesso: TCheckListBox;
    Label1: TLabel;
    lbl1: TLabel;
    lblCadastroAlteracao: TLabel;
    edtNome: TLabeledEdit;
    edtEmail: TLabeledEdit;
    edtSenha1: TLabeledEdit;
    edtSenha2: TLabeledEdit;
    lbTelaNome: TListBox;
    lbTelaTitulo: TListBox;
    lbNomeAcesso: TListBox;
    MenuItem4: TMenuItem;
    pnlAcessoAcesso: TPanel;
    pnlTelaAcesso: TPanel;
    pnlTituloAcesso: TPanel;
    pnlFundoAcesso: TPanel;
    tbsAcesso: TTabSheet;
    ToolBarCadastro1: TToolBar;
    procedure actAcessoExecute(Sender: TObject);
    procedure actCancelarAcessoExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure actIncluirExecute(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actSalvarAcessoExecute(Sender: TObject);
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

procedure TfrmUsuario.actAcessoExecute(Sender: TObject);
var
  id: Integer;
  erro: String;
begin
  id := StrToInt(lvPadrao.Selected.Caption);
  if Controller.BuscarPorId(controller.Usuario, id, erro) then
  begin
    pgcPadrao.ActivePage := tbsAcesso;
    pnlTituloAcesso.Caption := 'Gerenciar acessos do usuário '+
                                Controller.Usuario.Nome;
  end;
end;

procedure TfrmUsuario.actCancelarAcessoExecute(Sender: TObject);
begin
  if TfrmMessage.Mensagem('Deseja cancelar ?', 'Aviso', 'Q', [mbNao, mbSim], mbNao) then
  begin
    pgcPadrao.ActivePage := tbsLista;
  end;
end;

procedure TfrmUsuario.actIncluirExecute(Sender: TObject);
begin
  inherited;
  edtSenha1.EditLabel.Caption := 'Senha:';
  edtSenha2.EditLabel.Caption := 'Confirmação de Senha:';
end;

procedure TfrmUsuario.actPesquisarExecute(Sender: TObject);
begin
  lvPadrao.Items.Clear;
  Controller.Pesquisar(lvPadrao, lbPesquisa.Items[cbPesquisa.ItemIndex], edtPesquisa.Text);
end;

procedure TfrmUsuario.actSalvarAcessoExecute(Sender: TObject);
begin
  if TfrmMessage.Mensagem('Deseja salvar ?', 'Aviso', 'Q', [mbNao, mbSim], mbNao) then
  begin
    pgcPadrao.ActivePage := tbsLista;
  end;
end;

procedure TfrmUsuario.actSalvarExecute(Sender: TObject);
var
  erro: String;
begin
  if Controller.ValidarSenha(edtSenha1.Text, edtSenha2.Text, Operacao, erro) then
  begin
    if TfrmMessage.Mensagem('Deseja salvar ?', 'Aviso', 'Q', [mbNao, mbSim], mbNao) then
    begin
      Controller.Usuario.Nome      := edtNome.Text;
      Controller.Usuario.Email     := edtEmail.Text;
      Controller.Usuario.Senha     := Controller.CriptografarSenha(edtSenha2.Text);
      if Operacao = opInserir then
      begin
        Controller.Usuario.Cadastro := Now;
        if not Controller.Inserir(Controller.Usuario, erro) then
          TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
      end;
      if Operacao = opEditar then
      begin
        Controller.Usuario.Alteracao := Now;
        if not Controller.Editar(Controller.Usuario, erro) then
          TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
      end;
      inherited;
    end;
  end
  else
  begin
    TfrmMessage.Mensagem(erro, 'Aviso', 'C', [mbOk])
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
  edtNome.Clear;
  edtEmail.Clear;
  edtSenha1.Clear;
  edtSenha2.Clear;
  lblCadastroAlteracao.Caption := '';
end;

procedure TfrmUsuario.CarregarSelecionado;
var
  id: Integer;
  erro: String;
begin
  id := StrToInt(lvPadrao.Selected.Caption);
  if Controller.BuscarPorId(controller.Usuario, id, erro) then
  begin
    edtNome.Text  := Controller.Usuario.Nome;
    edtEmail.Text := Controller.Usuario.Email;
    edtSenha1.EditLabel.Caption := 'Senha Atual:';
    edtSenha2.EditLabel.Caption := 'Nova Senha:';

    if Controller.Usuario.Alteracao <> 0 then
    begin
      lblCadastroAlteracao.Caption := 'Cadastrado em '+
                                     DateToStr(Controller.Usuario.Cadastro)+
                                     ' às '+TimeToStr(Controller.Usuario.Cadastro)+
                                     ', '+
                                     'Atualizado em '+
                                     DateToStr(Controller.Usuario.Alteracao)+
                                     ' às '+TimeToStr(Controller.Usuario.Alteracao);
    end
    else
    begin
      lblCadastroAlteracao.Caption := 'Cadastrado em '+
                                     DateToStr(Controller.Usuario.Cadastro)+
                                     ' às '+TimeToStr(Controller.Usuario.Cadastro);
    end;
  end
  else
  begin
    TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    Abort;
  end;
end;

end.

