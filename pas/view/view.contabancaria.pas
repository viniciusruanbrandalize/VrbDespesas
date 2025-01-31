unit view.contabancaria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  view.cadastropadrao, controller.contabancaria, lib.types, view.mensagem;

type

  { TfrmContaBancaria }

  TfrmContaBancaria = class(TfrmCadastroPadrao)
    edtAgencia: TLabeledEdit;
    edtNumero: TLabeledEdit;
    procedure actExcluirExecute(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Controller: TContaBancariaController;
  public
    procedure CarregarDados; override;
    procedure LimparCampos; override;
    procedure CarregarSelecionado; override;
  end;

var
  frmContaBancaria: TfrmContaBancaria;

implementation

uses
  view.principal;

{$R *.lfm}

{ TfrmContaBancaria }

procedure TfrmContaBancaria.FormCreate(Sender: TObject);
begin
  inherited;
  Controller := TContaBancariaController.Create;
end;

procedure TfrmContaBancaria.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmContaBancaria.actSalvarExecute(Sender: TObject);
var
  erro: String;
begin
  if TfrmMessage.Mensagem('Deseja salvar ?', 'Aviso', 'Q', [mbNao, mbSim], mbNao) then
  begin
    Controller.ContaBancaria.Agencia  := edtAgencia.Text;
    Controller.ContaBancaria.Numero   := edtNumero.Text;

    if Operacao = opInserir then
    begin
      if not Controller.Inserir(Controller.ContaBancaria, erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;
    if Operacao = opEditar then
    begin
      if not Controller.Editar(Controller.ContaBancaria, erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;
    inherited;
  end;
end;

procedure TfrmContaBancaria.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  TfrmPrincipal(Owner).BarraLateralVazia(TfrmPrincipal(Owner).pnlMenuFinanceiro, True);
end;

procedure TfrmContaBancaria.actExcluirExecute(Sender: TObject);
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

procedure TfrmContaBancaria.actPesquisarExecute(Sender: TObject);
begin
  lvPadrao.Items.Clear;
  Controller.Pesquisar(lvPadrao, lbPesquisa.Items[cbPesquisa.ItemIndex], edtPesquisa.Text);
end;

procedure TfrmContaBancaria.CarregarDados;
begin
  lvPadrao.Items.Clear;
  Controller.Listar(lvPadrao);
end;

procedure TfrmContaBancaria.LimparCampos;
begin
  edtAgencia.Clear;
  edtNumero.Clear;
end;

procedure TfrmContaBancaria.CarregarSelecionado;
var
  id: Integer;
  erro: String;
begin
  id := StrToInt(lvPadrao.Selected.Caption);
  if Controller.BuscarPorId(controller.ContaBancaria, id, erro) then
  begin
    edtAgencia.Text   := Controller.ContaBancaria.Agencia;
    edtNumero.Text := Controller.ContaBancaria.Numero;
  end
  else
  begin
    TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    Abort;
  end;
end;

end.

