unit view.principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ActnList,
  Menus, StdCtrls, Buttons, controller.principal, view.banco,
  view.formapagamento, view.tipodespesa, view.subtipodespesa, view.usuario;

type

  { TfrmPrincipal }

  TfrmPrincipal = class(TForm)
    actCadastro: TAction;
    actAjuda: TAction;
    actDevedor: TAction;
    actFormaPagamento: TAction;
    actBanco: TAction;
    actCompra: TAction;
    actContasPagar: TAction;
    actConfiguracaoGlobal: TAction;
    actBackup: TAction;
    actHistoricoLogin: TAction;
    actVoltar: TAction;
    actRecebimento: TAction;
    actSubtipoCompra: TAction;
    actTipoCompra: TAction;
    actLoja: TAction;
    actUsuario: TAction;
    actOperacao: TAction;
    actUtilitario: TAction;
    actRelatorio: TAction;
    actMenu: TActionList;
    AppProperties: TApplicationProperties;
    btnContasPagar: TSpeedButton;
    btnConfiguracao: TSpeedButton;
    btnDespesa: TSpeedButton;
    btnCopiaSeguranca: TSpeedButton;
    btnRecebimento: TSpeedButton;
    btnSubtipo: TSpeedButton;
    btnBanco: TSpeedButton;
    btnOperacao: TSpeedButton;
    btnAjuda: TSpeedButton;
    btnDevedor: TSpeedButton;
    btnLoja: TSpeedButton;
    btnTipo: TSpeedButton;
    btnUsuario: TSpeedButton;
    btnVoltar: TSpeedButton;
    btnUtilitario: TSpeedButton;
    btnRelatorio: TSpeedButton;
    btnFormaPagamento: TSpeedButton;
    btnVoltar1: TSpeedButton;
    btnVoltar2: TSpeedButton;
    imgMenu: TImage;
    imgUsuario: TImage;
    imgList: TImageList;
    lblTitulo: TLabel;
    lblNomeUsuario: TLabel;
    lblHora: TLabel;
    pnlAbreForms: TPanel;
    pnlMenuCadastro: TPanel;
    pnlMenuOperacao: TPanel;
    pnlMenuUtilitario: TPanel;
    pnlMenuVazio: TPanel;
    pnlUsuario: TPanel;
    pnlMenuRetair: TPanel;
    pnlCabecalho: TPanel;
    pnlMenu: TPanel;
    pnlFundo: TPanel;
    btnCadastro: TSpeedButton;
    Timer: TTimer;
    procedure actAjudaExecute(Sender: TObject);
    procedure actBancoExecute(Sender: TObject);
    procedure actCadastroExecute(Sender: TObject);
    procedure actFormaPagamentoExecute(Sender: TObject);
    procedure actOperacaoExecute(Sender: TObject);
    procedure actRelatorioExecute(Sender: TObject);
    procedure actSubtipoCompraExecute(Sender: TObject);
    procedure actTipoCompraExecute(Sender: TObject);
    procedure actUsuarioExecute(Sender: TObject);
    procedure actUtilitarioExecute(Sender: TObject);
    procedure actVoltarExecute(Sender: TObject);
    procedure AppPropertiesException(Sender: TObject; E: Exception);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgMenuClick(Sender: TObject);
    procedure pnlMenuRetairClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    Controller: TPrincipalController;
    MenuEstaRetraido: Boolean;
    procedure retairMenu;
    procedure mudarMenu(Index: Integer);
  public
    procedure BarraLateralVazia(pnlAtivo: TPanel; Ativo: Boolean);
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.lfm}

{ TfrmPrincipal }

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  Controller := TPrincipalController.Create;
  lblHora.Caption := FormatDateTime('dddddd', Now)+#13+FormatDateTime('tt', Now);
  MenuEstaRetraido := True;
  retairMenu;
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  pnlAbreForms.Align := alClient;
  pnlAbreForms.Caption := '';
end;

procedure TfrmPrincipal.imgMenuClick(Sender: TObject);
begin
  retairMenu;
end;

procedure TfrmPrincipal.pnlMenuRetairClick(Sender: TObject);
begin
  retairMenu;
end;

procedure TfrmPrincipal.actCadastroExecute(Sender: TObject);
begin
  mudarMenu(1);
end;

procedure TfrmPrincipal.actFormaPagamentoExecute(Sender: TObject);
begin
  Controller.AbrirTela(frmFormaPagamento, TfrmFormaPagamento, false, pnlAbreForms, Self);
  BarraLateralVazia(pnlMenuCadastro, false);
end;

procedure TfrmPrincipal.actAjudaExecute(Sender: TObject);
begin
  //
end;

procedure TfrmPrincipal.actBancoExecute(Sender: TObject);
begin
  Controller.AbrirTela(frmBanco, TfrmBanco, false, pnlAbreForms, Self);
  BarraLateralVazia(pnlMenuCadastro, false);
end;

procedure TfrmPrincipal.actOperacaoExecute(Sender: TObject);
begin
  mudarMenu(2);
end;

procedure TfrmPrincipal.actRelatorioExecute(Sender: TObject);
begin
  mudarMenu(4);
end;

procedure TfrmPrincipal.actSubtipoCompraExecute(Sender: TObject);
begin
  Controller.AbrirTela(frmSubtipoDespesa, TfrmSubtipoDespesa, false, pnlAbreForms, Self);
  BarraLateralVazia(pnlMenuCadastro, false);
end;

procedure TfrmPrincipal.actTipoCompraExecute(Sender: TObject);
begin
  Controller.AbrirTela(frmTipoDespesa, TfrmTipoDespesa, false, pnlAbreForms, Self);
  BarraLateralVazia(pnlMenuCadastro, false);
end;

procedure TfrmPrincipal.actUsuarioExecute(Sender: TObject);
begin
  Controller.AbrirTela(frmUsuario, TfrmUsuario, false, pnlAbreForms, Self);
  BarraLateralVazia(pnlMenuCadastro, false);
end;

procedure TfrmPrincipal.actUtilitarioExecute(Sender: TObject);
begin
  mudarMenu(3);
end;

procedure TfrmPrincipal.actVoltarExecute(Sender: TObject);
begin
  mudarMenu(0);
end;

procedure TfrmPrincipal.AppPropertiesException(Sender: TObject; E: Exception);
begin
  Controller.TratarErros(Sender, E);
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  if not pnlMenu.Visible then
    Abort;
end;

procedure TfrmPrincipal.TimerTimer(Sender: TObject);
begin
  lblHora.Caption := FormatDateTime('dddddd', Now)+#13+FormatDateTime('tt', Now);
end;

procedure TfrmPrincipal.retairMenu;
begin
  if MenuEstaRetraido then
  begin
    pnlMenu.Width           := 215;
    pnlMenuRetair.Width     := 215;
    pnlMenuCadastro.Width   := 215;
    pnlMenuOperacao.Width   := 215;
    pnlMenuUtilitario.Width := 215;
    //pnlMenuVazio.Width      := 215;
    pnlMenuRetair.Caption := 'MENU';
  end
  else
  begin
    pnlMenu.Width           := 50;
    pnlMenuRetair.Width     := 50;
    pnlMenuCadastro.Width   := 50;
    pnlMenuOperacao.Width   := 50;
    pnlMenuUtilitario.Width := 50;
    //pnlMenuVazio.Width      := 50;
    pnlMenuRetair.Caption := '';
  end;
  MenuEstaRetraido := not MenuEstaRetraido;
end;

procedure TfrmPrincipal.mudarMenu(Index: Integer);
begin

  {
    0 - Menu Principal
    1 - Menu de Cadastro
    2 - Menu de Operações
    3 - Menu de Utilitarios
    4 - Menu de Relatórios
  }

  pnlMenu.Visible           := Index = 0;
  pnlMenuCadastro.Visible   := index = 1;
  pnlMenuOperacao.Visible   := Index = 2;
  pnlMenuUtilitario.Visible := Index = 3;
end;

procedure TfrmPrincipal.BarraLateralVazia(pnlAtivo: TPanel; Ativo: Boolean);
begin
  pnlAtivo.Visible := Ativo;
  pnlMenuVazio.Visible := not Ativo;
end;

end.

