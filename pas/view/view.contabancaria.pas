unit view.contabancaria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  view.cadastropadrao, controller.contabancaria, lib.types, view.mensagem,
  LCLType, Menus, ActnList, ComCtrls;

type

  { TfrmContaBancaria }

  TfrmContaBancaria = class(TfrmCadastroPadrao)
    actCartao: TAction;
    actIncluirPix: TAction;
    actEditarPix: TAction;
    actExcluirPix: TAction;
    actIncluirCartao: TAction;
    actEditarCartao: TAction;
    actExcluirCartao: TAction;
    actVisualizarCartao: TAction;
    actVisualizarPix: TAction;
    actSalvarCartao: TAction;
    actCancelarCartao: TAction;
    actSalvarPix: TAction;
    actCancelarPix: TAction;
    actPix: TAction;
    btnCancelarPix: TToolButton;
    btnCancelarCartao: TToolButton;
    btnEditarPix: TToolButton;
    btnEditarCartao: TToolButton;
    btnExcluirPix: TToolButton;
    btnExcluirCartao: TToolButton;
    btnIncluirPix: TToolButton;
    btnIncluirCartao: TToolButton;
    btnSalvarPix: TToolButton;
    btnSalvarCartao: TToolButton;
    btnVisualizarPix: TToolButton;
    btnVisualizarCartao: TToolButton;
    cbTipo: TComboBox;
    cbTipoChave: TComboBox;
    edtAgencia: TLabeledEdit;
    edtChave: TLabeledEdit;
    edtNumero: TLabeledEdit;
    edtBanco: TLabeledEdit;
    lblTipoChavePix: TLabel;
    lblTipoConta: TLabel;
    lbBancoId: TListBox;
    lbBancoNome: TListBox;
    lvPix: TListView;
    lvCartao: TListView;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    pgcCartao: TPageControl;
    pnlBotaoCadCartao: TPanel;
    pnlBotaoListaPix: TPanel;
    pnlBotaoListaCartao: TPanel;
    pnlFundoCadCartao: TPanel;
    pnlFundoListaPix: TPanel;
    pgcPix: TPageControl;
    pnlBotaoCadPix: TPanel;
    pnlFundoCadPix: TPanel;
    pnlFundoListaCartao: TPanel;
    pnlFundoPix: TPanel;
    pnlFundoCartao: TPanel;
    pMenuPix: TPopupMenu;
    pMenuCartao: TPopupMenu;
    tbsCadastroCartao: TTabSheet;
    tbsListaPix: TTabSheet;
    tbsCadastroPix: TTabSheet;
    tbsCartao: TTabSheet;
    tbsListaCartao: TTabSheet;
    tbsPix: TTabSheet;
    ToolBarCadastroPix: TToolBar;
    ToolBarCadastroCartao: TToolBar;
    ToolBarListaPix: TToolBar;
    ToolBarListaCartao: TToolBar;
    procedure actExcluirExecute(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure edtBancoExit(Sender: TObject);
    procedure edtBancoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbBancoNomeDblClick(Sender: TObject);
    procedure lbBancoNomeKeyPress(Sender: TObject; var Key: char);
    procedure lbBancoNomeSelectionChange(Sender: TObject; User: boolean);
  private
    Controller: TContaBancariaController;
    procedure CarregarDadosPix;
    procedure LimparCamposPix;
    procedure CarregarSelecionadoPix;
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

  pgcPix.ShowTabs        := False;
  pgcPix.Style           := tsButtons;
  pgcPix.ActivePageIndex := 0;

  pgcCartao.ShowTabs        := False;
  pgcCartao.Style           := tsButtons;
  pgcCartao.ActivePageIndex := 0;

end;

procedure TfrmContaBancaria.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmContaBancaria.lbBancoNomeDblClick(Sender: TObject);
begin
  if lbBancoNome.ItemIndex <> -1 then
  begin
    edtBanco.Text := lbBancoNome.Items[lbBancoNome.ItemIndex];
    controller.ContaBancaria.Banco.Id := StrToInt(lbBancoId.Items[lbBancoNome.ItemIndex]);
    lbBancoNome.Visible := False;
  end
  else
  begin
    edtBanco.Text := '';
    controller.ContaBancaria.Banco.Id := 0;
  end;
end;

procedure TfrmContaBancaria.lbBancoNomeKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
  begin
    lbBancoNome.OnDblClick(nil);
  end;
end;

procedure TfrmContaBancaria.lbBancoNomeSelectionChange(Sender: TObject;
  User: boolean);
begin
  edtBanco.Text := lbBancoNome.Items[lbBancoNome.ItemIndex];
end;

procedure TfrmContaBancaria.CarregarDadosPix;
begin
  lvPix.Items.Clear;
  Controller.ListarPix(lvPix, Controller.ContaBancaria.Id);
end;

procedure TfrmContaBancaria.LimparCamposPix;
begin
  edtChave.Text := '';
  cbTipoChave.ItemIndex := -1;
end;

procedure TfrmContaBancaria.CarregarSelecionadoPix;
begin
  //
end;

procedure TfrmContaBancaria.actSalvarExecute(Sender: TObject);
var
  erro: String;
begin
  if TfrmMessage.Mensagem('Deseja salvar ?', 'Aviso', 'Q', [mbNao, mbSim], mbNao) then
  begin
    Controller.ContaBancaria.Agencia  := edtAgencia.Text;
    Controller.ContaBancaria.Numero   := edtNumero.Text;
    Controller.ContaBancaria.Tipo     := cbTipo.Items[cbTipo.ItemIndex];
    if Operacao = opInserir then
    begin
      Controller.ContaBancaria.Cadastro := Now;
      if not Controller.Inserir(Controller.ContaBancaria, erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;
    if Operacao = opEditar then
    begin
      Controller.ContaBancaria.Alteracao := Now;
      if not Controller.Editar(Controller.ContaBancaria, erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;
    inherited;
  end;
end;

procedure TfrmContaBancaria.edtBancoExit(Sender: TObject);
begin
  if not lbBancoNome.Focused then
  begin
    if lbBancoNome.Visible then
      lbBancoNome.Visible := false;
  end;
end;

procedure TfrmContaBancaria.edtBancoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  qtdReg: Integer;
begin
  qtdReg := 0;
  if (Length(edtBanco.Text) > 3) then
  begin
    controller.PesquisarBanco(lbBancoNome, lbBancoId, edtBanco.Text, qtdReg);
    lbBancoNome.Visible := qtdReg > 0;
    if Key = VK_DOWN then
    begin
      if lbBancoNome.CanFocus then
        lbBancoNome.SetFocus;
    end;
  end
  else
  begin
    lbBancoNome.Items.Clear;
    lbBancoNome.Visible := False;
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
  edtBanco.Clear;
  cbTipo.ItemIndex := -1;
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
    edtNumero.Text    := Controller.ContaBancaria.Numero;
    edtBanco.Text     := Controller.ContaBancaria.Banco.Nome;
    cbTipo.ItemIndex  := cbTipo.Items.IndexOf(Controller.ContaBancaria.Tipo);
  end
  else
  begin
    TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    Abort;
  end;
end;

end.

