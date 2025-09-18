{
*******************************************************************************
*   VRBDespesas                                                               *
*   Controle e gerenciamento de despesas.                                     *
*                                                                             *
*   Copyright (C) 2025 Vinícius Ruan Brandalize.                              *
*                                                                             *
*   This program is free software: you can redistribute it and/or modify      *
*   it under the terms of the GNU General Public License as published by      *
*   the Free Software Foundation, either version 3 of the License, or         *
*   (at your option) any later version.                                       *
*                                                                             *
*   This program is distributed in the hope that it will be useful,           *
*   but WITHOUT ANY WARRANTY; without even the implied warranty of            *
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             *
*   GNU General Public License for more details.                              *
*                                                                             *
*   You should have received a copy of the GNU General Public License         *
*   along with this program.  If not, see <https://www.gnu.org/licenses/>.    *
*                                                                             *
*   Contact: viniciusbrandalize2@gmail.com.                                   *
*                                                                             *
*******************************************************************************
}

unit view.principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ActnList,
  Menus, StdCtrls, Buttons, controller.principal, view.banco, lib.types,
  view.formapagamento, view.tipodespesa, view.subtipodespesa, view.usuario,
  view.logerro, view.loglogin, view.bandeira, view.contabancaria,
  view.participante, view.despesa, view.relatoriodespesa, view.recebimento,
  view.relatoriorecebimento, view.copiaseguranca, view.configuracao, view.ajuda,
  view.mensagem;

type

  { TfrmPrincipal }

  TfrmPrincipal = class(TForm)
    actCadastro: TAction;
    actAjuda: TAction;
    actDevedor: TAction;
    actFormaPagamento: TAction;
    actBanco: TAction;
    actDespesa: TAction;
    actContasPagar: TAction;
    actConfiguracao: TAction;
    actBackup: TAction;
    actFinanceiro: TAction;
    actBandeira: TAction;
    actContaBancaria: TAction;
    actRelatorioRecebimento: TAction;
    actRecebimentoGeral: TAction;
    actRelatorioDespesa: TAction;
    actVoltarFinanceiro: TAction;
    actLogLogin: TAction;
    actLogErro: TAction;
    actVoltar: TAction;
    actRecebimentoSalario: TAction;
    actSubtipoDespesa: TAction;
    actTipoDespesa: TAction;
    actParticipante: TAction;
    actUsuario: TAction;
    actOperacao: TAction;
    actUtilitario: TAction;
    actRelatorio: TAction;
    actMenu: TActionList;
    AppProperties: TApplicationProperties;
    btnBanco: TSpeedButton;
    btnRecebimentoGeral: TSpeedButton;
    btnRelDespesa: TSpeedButton;
    btnBandeira: TSpeedButton;
    btnConta: TSpeedButton;
    btnContasPagar: TSpeedButton;
    btnConfiguracao: TSpeedButton;
    btnLogErro: TSpeedButton;
    btnDespesa: TSpeedButton;
    btnCopiaSeguranca: TSpeedButton;
    btnLoglogin: TSpeedButton;
    btnRecebimentoSalario: TSpeedButton;
    btnRelRecebimento: TSpeedButton;
    btnSubtipo: TSpeedButton;
    btnOperacao: TSpeedButton;
    btnAjuda: TSpeedButton;
    btnDevedor: TSpeedButton;
    btnParticipante: TSpeedButton;
    btnTipo: TSpeedButton;
    btnUsuario: TSpeedButton;
    btnFinanceiro: TSpeedButton;
    btnVoltar: TSpeedButton;
    btnUtilitario: TSpeedButton;
    btnRelatorio: TSpeedButton;
    btnFormaPagamento: TSpeedButton;
    btnVoltar1: TSpeedButton;
    btnVoltar2: TSpeedButton;
    btnVoltar3: TSpeedButton;
    btnVoltar4: TSpeedButton;
    imgMenu: TImage;
    imgUsuario: TImage;
    imgList: TImageList;
    lblTitulo: TLabel;
    lblNomeUsuario: TLabel;
    lblHora: TLabel;
    pnlAbreForms: TPanel;
    pnlMenuCadastro: TPanel;
    pnlMenuRelatorio: TPanel;
    pnlMenuOperacao: TPanel;
    pnlMenuUtilitario: TPanel;
    pnlMenuFinanceiro: TPanel;
    pnlMenuVazio: TPanel;
    pnlUsuario: TPanel;
    pnlMenuRetair: TPanel;
    pnlCabecalho: TPanel;
    pnlMenu: TPanel;
    pnlFundo: TPanel;
    btnCadastro: TSpeedButton;
    Timer: TTimer;
    procedure actAjudaExecute(Sender: TObject);
    procedure actBackupExecute(Sender: TObject);
    procedure actBancoExecute(Sender: TObject);
    procedure actBandeiraExecute(Sender: TObject);
    procedure actCadastroExecute(Sender: TObject);
    procedure actConfiguracaoExecute(Sender: TObject);
    procedure actContaBancariaExecute(Sender: TObject);
    procedure actDespesaExecute(Sender: TObject);
    procedure actDevedorExecute(Sender: TObject);
    procedure actFinanceiroExecute(Sender: TObject);
    procedure actFormaPagamentoExecute(Sender: TObject);
    procedure actLogErroExecute(Sender: TObject);
    procedure actLogLoginExecute(Sender: TObject);
    procedure actOperacaoExecute(Sender: TObject);
    procedure actParticipanteExecute(Sender: TObject);
    procedure actRecebimentoGeralExecute(Sender: TObject);
    procedure actRecebimentoSalarioExecute(Sender: TObject);
    procedure actRelatorioDespesaExecute(Sender: TObject);
    procedure actRelatorioExecute(Sender: TObject);
    procedure actRelatorioRecebimentoExecute(Sender: TObject);
    procedure actSubtipoDespesaExecute(Sender: TObject);
    procedure actTipoDespesaExecute(Sender: TObject);
    procedure actUsuarioExecute(Sender: TObject);
    procedure actUtilitarioExecute(Sender: TObject);
    procedure actVoltarExecute(Sender: TObject);
    procedure actVoltarFinanceiroExecute(Sender: TObject);
    procedure AppPropertiesException(Sender: TObject; E: Exception);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure imgMenuClick(Sender: TObject);
    procedure pnlMenuRetairClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    Controller: TPrincipalController;
    MenuEstaRetraido: Boolean;
    procedure retairMenu;
    procedure mudarMenu(Index: Integer);
    procedure LiberarBloquearAcessos();
    procedure AtribuirHintMenu();
  public
    procedure BarraLateralVazia(pnlAtivo: TPanel; Ativo: Boolean);
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  controller.usuarioacesso;

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

procedure TfrmPrincipal.FormKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
  begin
    SelectNext(ActiveControl,True,True);
    key := #0;
  end;
  if key = #27 then
  begin
    //
  end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  LiberarBloquearAcessos();
  pnlAbreForms.Align := alClient;
  pnlAbreForms.Caption := '';
  lblNomeUsuario.Caption := Controller.RetornarNomeUsuario;
  self.Caption := 'VrbDespesas by Vinícius Ruan Brandalize v' +
                   Controller.RetornarVersao;
  AtribuirHintMenu();
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

procedure TfrmPrincipal.actConfiguracaoExecute(Sender: TObject);
begin
  Controller.AbrirTela(frmConfiguracao, TfrmConfiguracao, True, nil, Self);
end;

procedure TfrmPrincipal.actContaBancariaExecute(Sender: TObject);
begin
  Controller.AbrirTela(frmContaBancaria, TfrmContaBancaria, false, pnlAbreForms, Self);
  BarraLateralVazia(pnlMenuFinanceiro, false);
end;

procedure TfrmPrincipal.actDespesaExecute(Sender: TObject);
begin
  Controller.AbrirTela(frmDespesa, TfrmDespesa, false, pnlAbreForms, Self);
  BarraLateralVazia(pnlMenuOperacao, false);
end;

procedure TfrmPrincipal.actDevedorExecute(Sender: TObject);
begin
  Controller.AbrirTelaParticipante(frmParticipante, pnlAbreForms, Self, True);
  BarraLateralVazia(pnlMenuCadastro, false);
end;

procedure TfrmPrincipal.actFinanceiroExecute(Sender: TObject);
begin
  mudarMenu(20);
end;

procedure TfrmPrincipal.actFormaPagamentoExecute(Sender: TObject);
begin
  Controller.AbrirTela(frmFormaPagamento, TfrmFormaPagamento, false, pnlAbreForms, Self);
  BarraLateralVazia(pnlMenuCadastro, false);
end;

procedure TfrmPrincipal.actLogErroExecute(Sender: TObject);
begin
  Controller.AbrirTela(frmLogErro, TfrmLogErro, True, nil, Self);
end;

procedure TfrmPrincipal.actLogLoginExecute(Sender: TObject);
begin
  Controller.AbrirTela(frmLogLogin, TfrmLogLogin, True, nil, Self);
end;

procedure TfrmPrincipal.actAjudaExecute(Sender: TObject);
begin
  Controller.AbrirTela(frmAjuda, TfrmAjuda, True, nil, Self);
end;

procedure TfrmPrincipal.actBackupExecute(Sender: TObject);
begin
  Controller.AbrirTela(frmCopiaSeguranca, TfrmCopiaSeguranca, True, nil, Self);
end;

procedure TfrmPrincipal.actBancoExecute(Sender: TObject);
begin
  Controller.AbrirTela(frmBanco, TfrmBanco, false, pnlAbreForms, Self);
  BarraLateralVazia(pnlMenuFinanceiro, false);
end;

procedure TfrmPrincipal.actBandeiraExecute(Sender: TObject);
begin
  Controller.AbrirTela(frmBandeira, TfrmBandeira, false, pnlAbreForms, Self);
  BarraLateralVazia(pnlMenuFinanceiro, false);
end;

procedure TfrmPrincipal.actOperacaoExecute(Sender: TObject);
begin
  mudarMenu(2);
end;

procedure TfrmPrincipal.actParticipanteExecute(Sender: TObject);
begin
  Controller.AbrirTelaParticipante(frmParticipante, pnlAbreForms, Self, False);
  BarraLateralVazia(pnlMenuCadastro, false);
end;

procedure TfrmPrincipal.actRecebimentoGeralExecute(Sender: TObject);
begin
  Controller.AbrirTelaRecebimento(frmRecebimento, pnlAbreForms, Self, telaGeral);
  BarraLateralVazia(pnlMenuOperacao , false);
end;

procedure TfrmPrincipal.actRecebimentoSalarioExecute(Sender: TObject);
begin
  Controller.AbrirTelaRecebimento(frmRecebimento, pnlAbreForms, Self, telaSalario);
  BarraLateralVazia(pnlMenuOperacao , false);
end;

procedure TfrmPrincipal.actRelatorioDespesaExecute(Sender: TObject);
begin
  Controller.AbrirTela(frmRelatorioDespesa, TfrmRelatorioDespesa, false, pnlAbreForms, Self);
  BarraLateralVazia(pnlMenuRelatorio, false);
end;

procedure TfrmPrincipal.actRelatorioExecute(Sender: TObject);
begin
  mudarMenu(4);
end;

procedure TfrmPrincipal.actRelatorioRecebimentoExecute(Sender: TObject);
begin
  Controller.AbrirTela(frmRelatorioRecebimento, TfrmRelatorioRecebimento, false, pnlAbreForms, Self);
  BarraLateralVazia(pnlMenuRelatorio, false);
end;

procedure TfrmPrincipal.actSubtipoDespesaExecute(Sender: TObject);
begin
  Controller.AbrirTela(frmSubtipoDespesa, TfrmSubtipoDespesa, false, pnlAbreForms, Self);
  BarraLateralVazia(pnlMenuCadastro, false);
end;

procedure TfrmPrincipal.actTipoDespesaExecute(Sender: TObject);
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

procedure TfrmPrincipal.actVoltarFinanceiroExecute(Sender: TObject);
begin
  mudarMenu(1);
end;

procedure TfrmPrincipal.AppPropertiesException(Sender: TObject; E: Exception);
begin
  Controller.TratarErros(Sender, E);
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if not pnlMenu.Visible then
    Abort;
  {$IFOPT D+}
  {$ELSE}
  if not TfrmMessage.Mensagem('Deseja fechar o VrbDespesas ?', 'Aviso', 'Q', [mbNao, mbSim], mbNao) then
    Abort;
  {$ENDIF}
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
    pnlMenuFinanceiro.Width := 215;
    pnlMenuRelatorio.Width  := 215;
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
    pnlMenuFinanceiro.Width := 50;
    pnlMenuRelatorio.Width  := 50;
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
        20 - Menu de Cadastros Financeiros
    2 - Menu de Operações
    3 - Menu de Utilitarios
    4 - Menu de Relatórios
  }

  pnlMenu.Visible           := Index = 0;
  pnlMenuCadastro.Visible   := index = 1;
  pnlMenuOperacao.Visible   := Index = 2;
  pnlMenuUtilitario.Visible := Index = 3;
  pnlMenuRelatorio.Visible  := Index = 4;
  pnlMenuFinanceiro.Visible := Index = 20;
end;

procedure TfrmPrincipal.LiberarBloquearAcessos();
var
  ControleAcesso: TUsuarioAcessoController;
begin
  ControleAcesso := TUsuarioAcessoController.Create;
  try
    ControleAcesso.LiberarBloquearAcessos(actMenu, Self.Name);
  finally
    FreeAndNil(ControleAcesso);
  end;
end;

procedure TfrmPrincipal.AtribuirHintMenu();
var
  i: Integer;
begin
  for i := 0 to Pred(actMenu.ActionCount) do
  begin
    if Trim(TAction(actMenu.Actions[i]).Hint) = EmptyStr then
      TAction(actMenu.Actions[i]).Hint := TAction(actMenu.Actions[i]).Caption;
  end;
end;

procedure TfrmPrincipal.BarraLateralVazia(pnlAtivo: TPanel; Ativo: Boolean);
begin
  pnlAtivo.Visible := Ativo;
  pnlMenuVazio.Visible := not Ativo;
  pnlMenuRetair.Visible := Ativo;
end;

end.

