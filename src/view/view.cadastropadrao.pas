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

unit view.cadastropadrao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  ComCtrls, ActnList, StdCtrls, Menus, lib.types, view.mensagem, DateTimePicker,
  lib.visual;

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
    lblLimiteCampo: TLabel;
    lblObrigatorio: TLabel;
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
    procedure SetarFocoPrimeiroCampo();
  public
    Operacao: TOperacaoCRUD;
    procedure CarregarDados; virtual; abstract;
    procedure CarregarSelecionado; virtual; abstract;
    procedure LimparCampos; virtual; abstract;
    function CamposEstaoPreenchidos: Boolean; virtual; abstract;
    function CamposEstaoComTamanhoMinimo: Boolean; virtual; abstract;
    procedure NumericoExit(Sender: TObject);
    procedure NumericoEnter(Sender: TObject);
    procedure NumericoKeyPress(Sender: TObject; var Key: char);
    procedure ValidarObrigatorioExit(Sender: TObject);
    procedure ValidarObrigatorioChange(Sender: TObject);
    procedure ValidarTamanhoMinimoExit(Sender: TObject);
    procedure ValidarMaiorQueZeroExit(Sender: TObject);
    procedure LiberarBloquearAcessos(var ListaDeAcoes: TActionList; Tela: String);
    procedure AddIdxComboBoxPesquisa(var pnl: TPanel);
  end;

var
  frmCadastroPadrao: TfrmCadastroPadrao;

implementation

uses
  controller.usuarioacesso;

{$R *.lfm}

{ TfrmCadastroPadrao }

procedure TfrmCadastroPadrao.actFecharExecute(Sender: TObject);
begin
  if Operacao = opNenhum then
    Close;
end;

procedure TfrmCadastroPadrao.actEditarExecute(Sender: TObject);
begin
  if Assigned(lvPadrao.Selected) then
  begin
    LimparCampos;
    CarregarSelecionado;
    Operacao := opEditar;
    pgcPadrao.ActivePage := tbsCadastro;
    SetarFocoPrimeiroCampo();
    AddIdxComboBoxPesquisa(pnlFundoCadastro);
  end
  else
  begin
    TfrmMessage.Mensagem('Nenhum registro foi selecionado!', 'Aviso', 'C', [mbOk]);
    Exit;
  end;
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
  SetarFocoPrimeiroCampo();
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
  SetarFocoPrimeiroCampo();
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

procedure TfrmCadastroPadrao.SetarFocoPrimeiroCampo();
var
  i: Integer;
  Ctrl: TControl;
begin
  for i := 0 to pnlFundoCadastro.ControlCount-1 do
  begin
    Ctrl := pnlFundoCadastro.Controls[i];
    if (Ctrl is TLabeledEdit) then
    begin
      if (TLabeledEdit(Ctrl).TabOrder = 0) and
           (TLabeledEdit(Ctrl).CanFocus) then
      begin
        TLabeledEdit(Ctrl).SetFocus;
        Break;
      end;
    end
    else
    if (Ctrl is TEdit) then
    begin
      if (TEdit(Ctrl).TabOrder = 0) and
           (TEdit(Ctrl).CanFocus) then
      begin
        TEdit(Ctrl).SetFocus;
        Break;
      end;
    end
    else
    if (Ctrl is TDateTimePicker) then
    begin
      if (TDateTimePicker(Ctrl).TabOrder = 0) and
           (TDateTimePicker(Ctrl).CanFocus) then
      begin
        TDateTimePicker(Ctrl).SetFocus;
        Break;
      end;
    end
    else
    if (Ctrl is TMemo) then
    begin
      if (TMemo(Ctrl).TabOrder = 0) and
           (TMemo(Ctrl).CanFocus) then
      begin
        TMemo(Ctrl).SetFocus;
        Break;
      end;
    end;
  end;
end;

procedure TfrmCadastroPadrao.NumericoExit(Sender: TObject);
begin
  CampoNumericoExit(Sender);
end;

procedure TfrmCadastroPadrao.NumericoEnter(Sender: TObject);
begin
  CampoNumericoEnter(Sender);
end;

procedure TfrmCadastroPadrao.NumericoKeyPress(Sender: TObject; var Key: char);
begin
  CampoNumericoKeyPress(Sender, Key);
end;

procedure TfrmCadastroPadrao.ValidarObrigatorioExit(Sender: TObject);
begin
  if (Sender is TLabeledEdit) and (Trim((Sender as TLabeledEdit).Text) = EmptyStr) then
  begin
    if (Sender as TLabeledEdit).CanFocus then
      (Sender as TLabeledEdit).SetFocus;
    lblObrigatorio.Left := (Sender as TLabeledEdit).Left;
    lblObrigatorio.Top  := (Sender as TLabeledEdit).Top + (Sender as TLabeledEdit).Height;
    lblObrigatorio.Parent := (Sender as TLabeledEdit).Parent;
    lblObrigatorio.Visible := True;
  end
  else
  if (Sender is TComboBox) and ((Sender as TComboBox).ItemIndex = -1) then
  begin
    if (Sender as TComboBox).CanFocus then
      (Sender as TComboBox).SetFocus;
    lblObrigatorio.Left := (Sender as TComboBox).Left;
    lblObrigatorio.Top  := (Sender as TComboBox).Top + (Sender as TComboBox).Height;
    lblObrigatorio.Parent := (Sender as TComboBox).Parent;
    lblObrigatorio.Visible := True;
  end;
end;

procedure TfrmCadastroPadrao.ValidarObrigatorioChange(Sender: TObject);
begin
  lblObrigatorio.Visible := False;
  lblLimiteCampo.Visible := False;
end;

procedure TfrmCadastroPadrao.ValidarTamanhoMinimoExit(Sender: TObject);
begin
  if (Sender is TLabeledEdit) and (Length(Trim((Sender as TLabeledEdit).Text)) < 3 ) then
  begin
    if (Sender as TLabeledEdit).CanFocus then
      (Sender as TLabeledEdit).SetFocus;
    lblLimiteCampo.Left := (Sender as TLabeledEdit).Left;
    lblLimiteCampo.Top  := (Sender as TLabeledEdit).Top + (Sender as TLabeledEdit).Height;
    lblLimiteCampo.Parent := (Sender as TLabeledEdit).Parent;
    lblLimiteCampo.Caption := '* Informe no mínimo 3 caracteres!';
    lblLimiteCampo.Visible := True;
  end;
end;

procedure TfrmCadastroPadrao.ValidarMaiorQueZeroExit(Sender: TObject);
begin
  if (Sender is TLabeledEdit) and (StrToFloatDef((Sender as TLabeledEdit).Text, 0) <= 0) then
  begin
    if (Sender as TLabeledEdit).CanFocus then
      (Sender as TLabeledEdit).SetFocus;
    lblLimiteCampo.Left := (Sender as TLabeledEdit).Left;
    lblLimiteCampo.Top  := (Sender as TLabeledEdit).Top + (Sender as TLabeledEdit).Height;
    lblLimiteCampo.Parent := (Sender as TLabeledEdit).Parent;
    lblLimiteCampo.Caption := '* Informe um valor maior que zero!';
    lblLimiteCampo.Visible := True;
  end;
end;

procedure TfrmCadastroPadrao.LiberarBloquearAcessos(var ListaDeAcoes: TActionList;
  Tela: String);
var
  ControleAcesso: TUsuarioAcessoController;
begin
  ControleAcesso := TUsuarioAcessoController.Create;
  try
    ControleAcesso.LiberarBloquearAcessos(ListaDeAcoes, Tela);
  finally
    FreeAndNil(ControleAcesso);
  end;
end;

procedure TfrmCadastroPadrao.AddIdxComboBoxPesquisa(var pnl: TPanel);
var
  i: Integer;
  cb: TComboBox;
begin
  for i := 0 to Pred(pnl.ControlCount) do
  begin
    if pnl.Controls[i] is TComboBox then
    begin
      cb := TComboBox( pnl.Controls[i] );
      if (Trim(cb.Text) <> EmptyStr) and (cb.Style <> csDropDownList) then
      begin
        cb.Items.Add(cb.Text);
        cb.ItemIndex := cb.Items.IndexOf(cb.Text);
      end;
    end;
  end;
end;

end.

