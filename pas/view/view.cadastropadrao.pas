unit view.cadastropadrao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  ComCtrls, ActnList, StdCtrls, Menus, lib.types, view.mensagem;

type

  { TfrmCadastroPadrao }

  TfrmCadastroPadrao = class(TForm)
    actFechar: TAction;
    actIncluir: TAction;
    actEditar: TAction;
    actExcluir: TAction;
    actCancelar: TAction;
    actSalvar: TAction;
    actPesquisar: TAction;
    actVisualizar: TAction;
    actList: TActionList;
    cbPesquisa: TComboBox;
    edtPesquisa: TEdit;
    img: TImageList;
    lbPesquisa: TListBox;
    lvPadrao: TListView;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    pnlPesquisa: TPanel;
    pnlBotaoLista: TPanel;
    pnlBotaoCad: TPanel;
    pnlFundoLista: TPanel;
    pnlFundoCadastro: TPanel;
    pgcPadrao: TPageControl;
    pnlTitulo: TPanel;
    pnlPrincipal: TPanel;
    pnlFundo: TPanel;
    btnFechar: TSpeedButton;
    btnPesquisar: TSpeedButton;
    pMenuPadrao: TPopupMenu;
    tbsLista: TTabSheet;
    tbsCadastro: TTabSheet;
    ToolBarLista: TToolBar;
    ToolBarCadastro: TToolBar;
    btnIncluir: TToolButton;
    btnEditar: TToolButton;
    btnExcluir: TToolButton;
    btnVisualizar: TToolButton;
    btnSalvar: TToolButton;
    btnCancelar: TToolButton;
    procedure actCancelarExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure actFecharExecute(Sender: TObject);
    procedure actIncluirExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure actVisualizarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public
    Operacao: TOperacaoCRUD;
    procedure CarregarDados; virtual; abstract;
    procedure CarregarSelecionado; virtual; abstract;
    procedure LimparCampos; virtual; abstract;
  end;

var
  frmCadastroPadrao: TfrmCadastroPadrao;

implementation

{$R *.lfm}

{ TfrmCadastroPadrao }

procedure TfrmCadastroPadrao.actFecharExecute(Sender: TObject);
begin
  if Operacao = opNenhum then
    Close;
end;

procedure TfrmCadastroPadrao.actEditarExecute(Sender: TObject);
begin
  LimparCampos;
  CarregarSelecionado;
  Operacao := opEditar;
  pgcPadrao.ActivePage := tbsCadastro;
end;

procedure TfrmCadastroPadrao.actCancelarExecute(Sender: TObject);
begin
  if TfrmMessage.Mensagem('Deseja cancelar ?', 'Aviso', 'Q', [mbNao, mbSim], mbNao) then
  begin
    pgcPadrao.ActivePage := tbsLista;
    Operacao := opNenhum;
  end;
end;

procedure TfrmCadastroPadrao.actExcluirExecute(Sender: TObject);
begin
  Operacao := opExcluir;
  CarregarDados;
end;

procedure TfrmCadastroPadrao.actIncluirExecute(Sender: TObject);
begin
  LimparCampos;
  Operacao := opInserir;
  pgcPadrao.ActivePage := tbsCadastro;
end;

procedure TfrmCadastroPadrao.actSalvarExecute(Sender: TObject);
begin
  pgcPadrao.ActivePage := tbsLista;
  Operacao := opNenhum;
  CarregarDados;
end;

procedure TfrmCadastroPadrao.actVisualizarExecute(Sender: TObject);
begin
  Operacao := opVisualizar;
  pgcPadrao.ActivePage := tbsCadastro;
end;

procedure TfrmCadastroPadrao.FormCreate(Sender: TObject);
begin
  pgcPadrao.ShowTabs := False;
  pgcPadrao.Style    := tsButtons;
  pgcPadrao.ActivePageIndex := 0;
  Operacao := opNenhum;
end;

procedure TfrmCadastroPadrao.FormShow(Sender: TObject);
begin
  pnlTitulo.Caption := Self.Caption;
  CarregarDados;
end;

end.

