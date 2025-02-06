unit view.contabancaria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  view.cadastropadrao, controller.contabancaria, lib.types, view.mensagem,
  LCLType, Menus, ActnList, ComCtrls, Buttons, DateTimePicker;

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
    actVoltar: TAction;
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
    btnVoltar: TSpeedButton;
    btnIncluirPix: TToolButton;
    btnIncluirCartao: TToolButton;
    btnSalvarPix: TToolButton;
    btnSalvarCartao: TToolButton;
    btnVisualizarPix: TToolButton;
    btnVisualizarCartao: TToolButton;
    cbTipo: TComboBox;
    cbTipoChave: TComboBox;
    ckbAproximacao: TCheckBox;
    cbTipoCartao: TComboBox;
    dtpValidade: TDateTimePicker;
    edtAgencia: TLabeledEdit;
    edtChave: TLabeledEdit;
    edtNumero: TLabeledEdit;
    edtBanco: TLabeledEdit;
    lbTipoCartaoValues: TListBox;
    lblTipoCartao: TLabel;
    lblValidade: TLabel;
    edtNumeroCartao: TLabeledEdit;
    edtBandeira: TLabeledEdit;
    lblTipoChavePix: TLabel;
    lblTipoConta: TLabel;
    lbBancoId: TListBox;
    lbBancoNome: TListBox;
    lbBandeiraId: TListBox;
    lbBandeiraNome: TListBox;
    lvPix: TListView;
    lvCartao: TListView;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    pnlInfoContaPix: TPanel;
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
    pnlInfoContaCartao: TPanel;
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
    procedure actCancelarCartaoExecute(Sender: TObject);
    procedure actCancelarPixExecute(Sender: TObject);
    procedure actCartaoExecute(Sender: TObject);
    procedure actEditarCartaoExecute(Sender: TObject);
    procedure actEditarPixExecute(Sender: TObject);
    procedure actExcluirCartaoExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure actExcluirPixExecute(Sender: TObject);
    procedure actIncluirCartaoExecute(Sender: TObject);
    procedure actIncluirPixExecute(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actPixExecute(Sender: TObject);
    procedure actSalvarCartaoExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure actSalvarPixExecute(Sender: TObject);
    procedure actVoltarExecute(Sender: TObject);
    procedure edtBancoExit(Sender: TObject);
    procedure edtBancoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtBandeiraExit(Sender: TObject);
    procedure edtBandeiraKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbBancoNomeDblClick(Sender: TObject);
    procedure lbBancoNomeKeyPress(Sender: TObject; var Key: char);
    procedure lbBancoNomeSelectionChange(Sender: TObject; User: boolean);
    procedure lbBandeiraNomeDblClick(Sender: TObject);
    procedure lbBandeiraNomeKeyPress(Sender: TObject; var Key: char);
    procedure lbBandeiraNomeSelectionChange(Sender: TObject; User: boolean);
  private
    Controller: TContaBancariaController;
    procedure CarregarDadosPix;
    procedure LimparCamposPix;
    procedure CarregarSelecionadoPix;
    procedure CarregarDadosCartao;
    procedure LimparCamposCartao;
    procedure CarregarSelecionadoCartao;
    procedure ExibirInformacoesConta;
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

procedure TfrmContaBancaria.lbBandeiraNomeDblClick(Sender: TObject);
begin
  if lbBandeiraNome.ItemIndex <> -1 then
  begin
    edtBandeira.Text := lbBandeiraNome.Items[lbBandeiraNome.ItemIndex];
    controller.Cartao.Bandeira.Id := StrToInt(lbBandeiraId.Items[lbBandeiraNome.ItemIndex]);
    lbBandeiraNome.Visible := False;
  end
  else
  begin
    edtBandeira.Text := '';
    controller.Cartao.Bandeira.Id := 0;
  end;
end;

procedure TfrmContaBancaria.lbBandeiraNomeKeyPress(Sender: TObject;
  var Key: char);
begin
  if key = #13 then
  begin
    lbBandeiraNome.OnDblClick(nil);
  end;
end;

procedure TfrmContaBancaria.lbBandeiraNomeSelectionChange(Sender: TObject;
  User: boolean);
begin
  edtBandeira.Text := lbBandeiraNome.Items[lbBandeiraNome.ItemIndex];
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
var
  erro, chave: String;
begin
  chave := lvPix.Selected.Caption;
  if Controller.BuscarPixPorId(controller.Pix, chave, Erro) then
  begin
    edtChave.Text := Controller.Pix.Chave;
    cbTipoChave.ItemIndex := cbTipoChave.Items.IndexOf(Controller.Pix.Tipo);
  end
  else
    TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
end;

procedure TfrmContaBancaria.CarregarDadosCartao;
begin
  lvCartao.Items.Clear;
  Controller.ListarCartao(lvCartao, controller.ContaBancaria.Id);
end;

procedure TfrmContaBancaria.LimparCamposCartao;
begin
  edtNumeroCartao.Clear;
  cbTipoCartao.ItemIndex := -1;
  edtBandeira.Clear;
  dtpValidade.Date := Now;
  ckbAproximacao.Checked := False;
end;

procedure TfrmContaBancaria.CarregarSelecionadoCartao;
var
  id: Integer;
  erro: String;
begin
  id := StrToInt(lvCartao.Selected.Caption);
  if Controller.BuscarCartaoPorId(controller.Cartao, id, erro) then
  begin
    edtNumeroCartao.Text   := Controller.Cartao.Numero;
    dtpValidade.Date       := Controller.Cartao.Validade;
    ckbAproximacao.Checked := Controller.Cartao.Aproximacao;
    cbTipoCartao.ItemIndex := lbTipoCartaoValues.Items.IndexOf(Controller.Cartao.Tipo);
    edtBandeira.Text       := Controller.Cartao.Bandeira.Nome;
  end
  else
  begin
    TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    Abort;
  end;
end;

procedure TfrmContaBancaria.ExibirInformacoesConta;
var
  texto: String;
begin
  Texto := 'Informações da conta selecionada: Nº. '+Controller.ContaBancaria.Numero+
           ' Agência: '+Controller.ContaBancaria.Agencia+' Banco: '+
           Controller.ContaBancaria.Banco.Nome;
  pnlInfoContaCartao.Caption := texto;
  pnlInfoContaPix.Caption    := texto;
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

procedure TfrmContaBancaria.actSalvarPixExecute(Sender: TObject);
var
  Erro: String;
begin
  if TfrmMessage.Mensagem('Deseja salvar ?', 'Aviso', 'Q', [mbNao, mbSim], mbNao) then
  begin
    Controller.Pix.Chave := edtChave.Text;
    Controller.Pix.Tipo  := cbTipoChave.Items[cbTipoChave.ItemIndex];
    Controller.Pix.ContaBancaria.Id := controller.ContaBancaria.Id;
    if Operacao = opInserir then
    begin
      Controller.Pix.Cadastro := Now;
      if not Controller.InserirPix(Controller.Pix, Erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;

    if Operacao = opEditar then
    begin
      Controller.Pix.Alteracao := Now;
      if not Controller.EditarPix(Controller.Pix, Erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;

    pgcPix.ActivePage := tbsListaPix;
    Operacao := opNenhum;
    CarregarDadosPix;

  end;
end;

procedure TfrmContaBancaria.actVoltarExecute(Sender: TObject);
begin
  if Operacao = opNenhum then
  begin
    pgcPadrao.ActivePage := tbsLista;
    btnVoltar.Visible := False;
    btnFechar.Visible := True;
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

procedure TfrmContaBancaria.edtBandeiraExit(Sender: TObject);
begin
  if not lbBandeiraNome.Focused then
  begin
    if lbBandeiraNome.Visible then
      lbBandeiraNome.Visible := false;
  end;
end;

procedure TfrmContaBancaria.edtBandeiraKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  qtdReg: Integer;
begin
  qtdReg := 0;
  if (Length(edtBandeira.Text) > 3) then
  begin
    controller.PesquisarBandeira(lbBandeiraNome, lbBandeiraId, edtBandeira.Text, qtdReg);
    lbBandeiraNome.Visible := qtdReg > 0;
    if Key = VK_DOWN then
    begin
      if lbBandeiraNome.CanFocus then
        lbBandeiraNome.SetFocus;
    end;
  end
  else
  begin
    lbBandeiraNome.Items.Clear;
    lbBandeiraNome.Visible := False;
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

procedure TfrmContaBancaria.actExcluirPixExecute(Sender: TObject);
var
  erro: String;
  id: String;
begin
  if TfrmMessage.Mensagem('Deseja excluir o item selecionado ?', 'Aviso', 'D',
                           [mbNao, mbSim], mbNao) then
  begin
    id := lvPix.Selected.Caption;
    if Controller.ExcluirPix(id, erro) then
    begin
      Operacao := opExcluir;
      CarregarDadosPix;
    end
    else
      TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    Operacao := opNenhum;
  end;
end;

procedure TfrmContaBancaria.actIncluirCartaoExecute(Sender: TObject);
begin
  LimparCamposCartao;
  Operacao := opInserir;
  pgcCartao.ActivePage := tbsCadastroCartao;
end;

procedure TfrmContaBancaria.actCancelarPixExecute(Sender: TObject);
begin
  if TfrmMessage.Mensagem('Deseja cancelar ?', 'Aviso', 'Q', [mbNao, mbSim], mbNao) then
  begin
    pgcPix.ActivePage := tbsListaPix;
    Operacao := opNenhum;
  end;
end;

procedure TfrmContaBancaria.actCancelarCartaoExecute(Sender: TObject);
begin
  if TfrmMessage.Mensagem('Deseja cancelar ?', 'Aviso', 'Q', [mbNao, mbSim], mbNao) then
  begin
    pgcCartao.ActivePage := tbsListaCartao;
    Operacao := opNenhum;
  end;
end;

procedure TfrmContaBancaria.actCartaoExecute(Sender: TObject);
begin
  CarregarSelecionado;
  CarregarDadosCartao;
  ExibirInformacoesConta;
  pgcPadrao.ActivePage := tbsCartao;
  btnVoltar.Visible := True;
  btnFechar.Visible := False;
end;

procedure TfrmContaBancaria.actEditarCartaoExecute(Sender: TObject);
begin
  LimparCamposCartao;
  CarregarSelecionadoCartao;
  Operacao := opEditar;
  pgcCartao.ActivePage := tbsCadastroCartao;
end;

procedure TfrmContaBancaria.actEditarPixExecute(Sender: TObject);
begin
  LimparCamposPix;
  CarregarSelecionadoPix;
  Operacao := opEditar;
  pgcPix.ActivePage := tbsCadastroPix;
end;

procedure TfrmContaBancaria.actExcluirCartaoExecute(Sender: TObject);
var
  erro: String;
  id: Integer;
begin
  if TfrmMessage.Mensagem('Deseja excluir o item selecionado ?', 'Aviso', 'D',
                           [mbNao, mbSim], mbNao) then
  begin
    id := StrToInt(lvCartao.Selected.Caption);
    if Controller.ExcluirCartao(id, erro) then
    begin
      Operacao := opExcluir;
      CarregarDadosCartao;
    end
    else
      TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    Operacao := opNenhum;
  end;
end;

procedure TfrmContaBancaria.actIncluirPixExecute(Sender: TObject);
begin
  LimparCamposPix;
  Operacao := opInserir;
  pgcPix.ActivePage := tbsCadastroPix;
end;

procedure TfrmContaBancaria.actPesquisarExecute(Sender: TObject);
begin
  lvPadrao.Items.Clear;
  Controller.Pesquisar(lvPadrao, lbPesquisa.Items[cbPesquisa.ItemIndex], edtPesquisa.Text);
end;

procedure TfrmContaBancaria.actPixExecute(Sender: TObject);
begin
  CarregarSelecionado;
  CarregarDadosPix;
  ExibirInformacoesConta;
  pgcPadrao.ActivePage := tbsPix;
  btnVoltar.Visible := True;
  btnFechar.Visible := False;
end;

procedure TfrmContaBancaria.actSalvarCartaoExecute(Sender: TObject);
var
  Erro: String;
begin
  if TfrmMessage.Mensagem('Deseja salvar ?', 'Aviso', 'Q', [mbNao, mbSim], mbNao) then
  begin
    Controller.Cartao.Numero   := edtNumeroCartao.Text;
    Controller.Cartao.Tipo     := lbTipoCartaoValues.Items[cbTipoCartao.ItemIndex];
    Controller.Cartao.Validade := dtpValidade.Date;
    Controller.Cartao.Aproximacao := ckbAproximacao.Checked;
    Controller.Cartao.ContaBancaria.Id := Controller.ContaBancaria.Id;
    if Operacao = opInserir then
    begin
      Controller.Cartao.Cadastro := Now;
      if not Controller.InserirCartao(Controller.Cartao, Erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;
    if Operacao = opEditar then
    begin
      Controller.Cartao.Alteracao := Now;
      if not Controller.EditarCartao(Controller.Cartao, Erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;

    pgcCartao.ActivePage := tbsListaCartao;
    Operacao := opNenhum;
    CarregarDadosCartao;
  end;
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

