unit view.tipocompra;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  view.cadastropadrao, lib.types, controller.tipocompra, view.mensagem;

type

  { TfrmTipoCompra }

  TfrmTipoCompra = class(TfrmCadastroPadrao)
    edtNome: TLabeledEdit;
    procedure actExcluirExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Controller: TTipoCompraController;
  public
    procedure CarregarDados; override;
    procedure LimparCampos; override;
    procedure CarregarSelecionado; override;
  end;

var
  frmTipoCompra: TfrmTipoCompra;

implementation

uses
  view.principal;

{$R *.lfm}

{ TfrmTipoCompra }

procedure TfrmTipoCompra.FormCreate(Sender: TObject);
begin
  inherited;
  Controller := TTipoCompraController.Create;
end;

procedure TfrmTipoCompra.actSalvarExecute(Sender: TObject);
var
  erro: String;
begin
  if TfrmMessage.Mensagem('Deseja salvar ?', 'Aviso', 'Q', [mbNao, mbSim], mbNao) then
  begin
    Controller.TipoCompra.Nome  := edtNome.Text;
    if Operacao = opInserir then
    begin
      if not Controller.Inserir(Controller.TipoCompra, erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;
    if Operacao = opEditar then
    begin
      if not Controller.Editar(Controller.TipoCompra, erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;
    inherited;
  end;
end;

procedure TfrmTipoCompra.actExcluirExecute(Sender: TObject);
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

procedure TfrmTipoCompra.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  TfrmPrincipal(Owner).BarraLateralVazia(TfrmPrincipal(Owner).pnlMenuCadastro, True);
end;

procedure TfrmTipoCompra.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmTipoCompra.CarregarDados;
begin
  lvPadrao.Items.Clear;
  Controller.Listar(lvPadrao);
end;

procedure TfrmTipoCompra.LimparCampos;
begin
  edtNome.Clear;
end;

procedure TfrmTipoCompra.CarregarSelecionado;
var
  id: Integer;
  erro: String;
begin
  id := StrToInt(lvPadrao.Selected.Caption);
  if Controller.BuscarPorId(controller.TipoCompra, id, erro) then
  begin
    edtNome.Text  := Controller.TipoCompra.Nome;
  end
  else
  begin
    TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    Abort;
  end;
end;

end.

