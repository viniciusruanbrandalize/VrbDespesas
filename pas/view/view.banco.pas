unit view.banco;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  view.cadastropadrao, controller.banco, lib.types, view.mensagem;

type

  { TfrmBanco }

  TfrmBanco = class(TfrmCadastroPadrao)
    edtNome: TLabeledEdit;
    edtNumero: TLabeledEdit;
    procedure actExcluirExecute(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Controller: TBancoController;
  public
    procedure CarregarDados; override;
    procedure LimparCampos; override;
    procedure CarregarSelecionado; override;
  end;

var
  frmBanco: TfrmBanco;

implementation

uses
  view.principal;

{$R *.lfm}

{ TfrmBanco }

procedure TfrmBanco.FormCreate(Sender: TObject);
begin
  inherited;
  Controller := TBancoController.Create;
end;

procedure TfrmBanco.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmBanco.FormShow(Sender: TObject);
begin
  LiberarBloquearAcessos(Self.actList, Self.Name);
  inherited;
end;

procedure TfrmBanco.actSalvarExecute(Sender: TObject);
var
  erro: String;
begin
  if TfrmMessage.Mensagem('Deseja salvar ?', 'Aviso', 'Q', [mbNao, mbSim], mbNao) then
  begin
    Controller.Banco.Nome   := edtNome.Text;

    if edtNumero.Text <> '' then
      Controller.Banco.Numero := StrToInt(edtNumero.Text)
    else
      Controller.Banco.Numero := 0;

    if Operacao = opInserir then
    begin
      if not Controller.Inserir(Controller.Banco, erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;
    if Operacao = opEditar then
    begin
      if not Controller.Editar(Controller.Banco, erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;
    inherited;
  end;
end;

procedure TfrmBanco.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  TfrmPrincipal(Owner).BarraLateralVazia(TfrmPrincipal(Owner).pnlMenuFinanceiro, True);
  CloseAction := caFree;
end;

procedure TfrmBanco.actExcluirExecute(Sender: TObject);
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

procedure TfrmBanco.actPesquisarExecute(Sender: TObject);
begin
  lvPadrao.Items.Clear;
  Controller.Pesquisar(lvPadrao, lbPesquisa.Items[cbPesquisa.ItemIndex], edtPesquisa.Text);
end;

procedure TfrmBanco.CarregarDados;
begin
  lvPadrao.Items.Clear;
  Controller.Listar(lvPadrao);
end;

procedure TfrmBanco.LimparCampos;
begin
  edtNome.Clear;
  edtNumero.Clear;
end;

procedure TfrmBanco.CarregarSelecionado;
var
  id: Integer;
  erro: String;
begin
  id := StrToInt(lvPadrao.Selected.Caption);
  if Controller.BuscarPorId(controller.Banco, id, erro) then
  begin
    edtNome.Text   := Controller.Banco.Nome;
    edtNumero.Text := Controller.Banco.Numero.ToString;
  end
  else
  begin
    TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    Abort;
  end;
end;

end.

