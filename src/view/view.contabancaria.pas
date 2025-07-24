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
    cbBandeira: TComboBox;
    cbTipo: TComboBox;
    cbBanco: TComboBox;
    cbTipoChave: TComboBox;
    ckbAproximacao: TCheckBox;
    cbTipoCartao: TComboBox;
    dtpValidade: TDateTimePicker;
    edtAgencia: TLabeledEdit;
    edtChave: TLabeledEdit;
    edtNumero: TLabeledEdit;
    lblBanco: TLabel;
    lblBandeira: TLabel;
    lbTipoCartaoValues: TListBox;
    lblTipoCartao: TLabel;
    lblValidade: TLabel;
    edtNumeroCartao: TLabeledEdit;
    lblTipoChavePix: TLabel;
    lblTipoConta: TLabel;
    lbBancoId: TListBox;
    lbBandeiraId: TListBox;
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
    procedure cbBancoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbBancoSelect(Sender: TObject);
    procedure cbBandeiraKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure cbBandeiraSelect(Sender: TObject);
    procedure edtNumeroChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Controller: TContaBancariaController;
    procedure CarregarDadosPix;
    procedure LimparCamposPix;
    procedure CarregarSelecionadoPix;
    procedure CarregarDadosCartao;
    procedure LimparCamposCartao;
    procedure CarregarSelecionadoCartao;
    procedure ExibirInformacoesConta;
    function CamposEstaoPreenchidosCartao: Boolean;
    function CamposEstaoPreenchidosPix: Boolean;
    function CamposEstaoComTamanhoMinimoPix: Boolean;
  public
    procedure CarregarDados; override;
    procedure LimparCampos; override;
    procedure CarregarSelecionado; override;
    function CamposEstaoPreenchidos: Boolean; override;
    function CamposEstaoComTamanhoMinimo: Boolean; override;
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

procedure TfrmContaBancaria.FormShow(Sender: TObject);
begin
  LiberarBloquearAcessos(Self.actList, Self.Name);
  inherited;
end;

procedure TfrmContaBancaria.CarregarDadosPix;
begin
  lvPix.Items.Clear;
  Controller.ListarPix(lvPix, Controller.ContaBancaria.Id);
end;

procedure TfrmContaBancaria.LimparCamposPix;
begin
  edtChave.Text := '';
  cbTipoChave.ItemIndex := 0;
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
  cbTipoCartao.ItemIndex := 0;
  cbBandeira.Clear;
  cbBandeira.Items.Clear;
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
    cbBandeira.Text       := Controller.Cartao.Bandeira.Nome;
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

function TfrmContaBancaria.CamposEstaoPreenchidosCartao: Boolean;
begin
  Result := False;
  if Trim(edtNumeroCartao.Text) = EmptyStr then
    ValidarObrigatorioExit(edtNumeroCartao)
  else
  if cbBandeira.ItemIndex = -1 then
    ValidarObrigatorioExit(cbBandeira)
  else
    Result := True;
end;

function TfrmContaBancaria.CamposEstaoPreenchidosPix: Boolean;
begin
  Result := False;
  if Trim(edtChave.Text) = EmptyStr then
    ValidarObrigatorioExit(edtChave)
  else
    Result := True;
end;

function TfrmContaBancaria.CamposEstaoComTamanhoMinimoPix: Boolean;
begin
  Result := false;
  Result := False;
  if Length(Trim(edtChave.Text)) < 3 then
    ValidarTamanhoMinimoExit(edtChave)
  else
    Result := True;
end;

procedure TfrmContaBancaria.actSalvarExecute(Sender: TObject);
var
  erro: String;
begin
  if CamposEstaoPreenchidos and CamposEstaoComTamanhoMinimo then
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
end;

procedure TfrmContaBancaria.actSalvarPixExecute(Sender: TObject);
var
  Erro: String;
begin
  if CamposEstaoPreenchidosPix and CamposEstaoComTamanhoMinimoPix then
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

procedure TfrmContaBancaria.cbBancoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  qtdReg: Integer;
begin
  qtdReg := 0;
  if not (key in [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT]) then
  begin
    if (Length((Sender as TComboBox).Text) >= 3) then
    begin
      controller.PesquisarBanco((Sender as TComboBox), lbBancoId, (Sender as TComboBox).Text, qtdReg);
      (Sender as TComboBox).DroppedDown := qtdReg > 1;
    end
    else
    begin
      (Sender as TComboBox).Items.Clear;
    end;
  end;
end;

procedure TfrmContaBancaria.cbBancoSelect(Sender: TObject);
begin
  if (Sender as TComboBox).ItemIndex <> -1 then
    controller.ContaBancaria.Banco.Id := StrToInt(lbBancoId.Items[(Sender as TComboBox).ItemIndex]);
end;

procedure TfrmContaBancaria.cbBandeiraKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  qtdReg: Integer;
begin
  qtdReg := 0;
  if not (key in [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT]) then
  begin
    if (Length((Sender as TComboBox).Text) >= 3) then
    begin
      controller.PesquisarBandeira((Sender as TComboBox), lbBandeiraId, (Sender as TComboBox).Text, qtdReg);
      (Sender as TComboBox).DroppedDown := qtdReg > 1;
    end
    else
    begin
      (Sender as TComboBox).Items.Clear;
    end;
  end;
end;

procedure TfrmContaBancaria.cbBandeiraSelect(Sender: TObject);
begin
  if (Sender as TComboBox).ItemIndex <> -1 then
    controller.Cartao.Bandeira.Id := StrToInt(lbBandeiraId.Items[(Sender as TComboBox).ItemIndex]);
end;

procedure TfrmContaBancaria.edtNumeroChange(Sender: TObject);
begin
  ValidarObrigatorioChange(Sender);
end;

procedure TfrmContaBancaria.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  TfrmPrincipal(Owner).BarraLateralVazia(TfrmPrincipal(Owner).pnlMenuFinanceiro, True);
  CloseAction := caFree;
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
  AddIdxComboBoxPesquisa(pnlFundoCadCartao);
end;

procedure TfrmContaBancaria.actEditarPixExecute(Sender: TObject);
begin
  LimparCamposPix;
  CarregarSelecionadoPix;
  Operacao := opEditar;
  pgcPix.ActivePage := tbsCadastroPix;
  AddIdxComboBoxPesquisa(pnlFundoCadPix);
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
  if CamposEstaoPreenchidosCartao then
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
  cbBanco.Clear;
  cbBanco.Items.Clear;
  cbTipo.ItemIndex := 0;
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
    cbBanco.Text      := Controller.ContaBancaria.Banco.Nome;
    cbTipo.ItemIndex  := cbTipo.Items.IndexOf(Controller.ContaBancaria.Tipo);
  end
  else
  begin
    TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    Abort;
  end;
end;

function TfrmContaBancaria.CamposEstaoPreenchidos: Boolean;
begin
  Result := False;
  if Trim(edtNumero.Text) = EmptyStr then
    ValidarObrigatorioExit(edtNumero)
  else
  if Trim(edtAgencia.Text) = EmptyStr then
    ValidarObrigatorioExit(edtAgencia)
  else
  if cbBanco.ItemIndex = -1 then
    ValidarObrigatorioExit(cbBanco)
  else
    Result := True;
end;

function TfrmContaBancaria.CamposEstaoComTamanhoMinimo: Boolean;
begin
  Result := True;
end;

end.

