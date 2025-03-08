unit view.recebimento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, view.cadastropadrao,
  controller.recebimento, lib.types, view.mensagem;

type

  { TfrmRecebimento }

  TfrmRecebimento = class(TfrmCadastroPadrao)
    procedure actPesquisarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Controller: TRecebimentoController;
    FTipo: TTelaRecebimento;
  public
    procedure CarregarDados; override;
    procedure LimparCampos; override;
    procedure CarregarSelecionado; override;
    property Tipo: TTelaRecebimento read FTipo write FTipo;
  end;

var
  frmRecebimento: TfrmRecebimento;

implementation

uses
  view.principal;

{$R *.lfm}

{ TfrmRecebimento }

procedure TfrmRecebimento.actPesquisarExecute(Sender: TObject);
begin
  lvPadrao.Items.Clear;
  Controller.Pesquisar(lvPadrao, lbPesquisa.Items[cbPesquisa.ItemIndex], edtPesquisa.Text);
end;

procedure TfrmRecebimento.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  TfrmPrincipal(Owner).BarraLateralVazia(TfrmPrincipal(Owner).pnlMenuOperacao, True);
end;

procedure TfrmRecebimento.FormCreate(Sender: TObject);
begin
  inherited;
  Controller := TRecebimentoController.Create;
end;

procedure TfrmRecebimento.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmRecebimento.CarregarDados;
begin
  lvPadrao.Items.Clear;
  case FTipo of
    telaSalario: Controller.Listar(lvPadrao, 0);
    telaGeral:   Controller.Listar(lvPadrao, 1);
  end;
end;

procedure TfrmRecebimento.LimparCampos;
begin
  //
end;

procedure TfrmRecebimento.CarregarSelecionado;
begin
  //
end;

end.

