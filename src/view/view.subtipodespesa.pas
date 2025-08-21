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

unit view.subtipodespesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  view.cadastropadrao, controller.subtipodespesa, view.mensagem, lib.types,
  LCLType, ComCtrls;

type

  { TfrmSubtipoDespesa }

  TfrmSubtipoDespesa = class(TfrmCadastroPadrao)
    cbTipo: TComboBox;
    edtNome: TLabeledEdit;
    lblTipo: TLabel;
    lbTipoId: TListBox;
    procedure actExcluirExecute(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure cbTipoChange(Sender: TObject);
    procedure cbTipoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbTipoSelect(Sender: TObject);
    procedure edtNomeChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Controller: TSubtipoDespesaController;
  public
    procedure CarregarDados; override;
    procedure LimparCampos; override;
    procedure CarregarSelecionado; override;
    function CamposEstaoPreenchidos: Boolean; override;
    function CamposEstaoComTamanhoMinimo: Boolean; override;
  end;

var
  frmSubtipoDespesa: TfrmSubtipoDespesa;

implementation

uses
  view.principal;

{$R *.lfm}

{ TfrmSubtipoDespesa }

procedure TfrmSubtipoDespesa.FormCreate(Sender: TObject);
begin
  inherited;
  Controller := TSubtipoDespesaController.Create;
end;

procedure TfrmSubtipoDespesa.actSalvarExecute(Sender: TObject);
var
  erro: String;
begin
  if CamposEstaoPreenchidos and CamposEstaoComTamanhoMinimo then
  begin
    if TfrmMessage.Mensagem('Deseja salvar ?', 'Aviso', 'Q', [mbNao, mbSim], mbNao) then
    begin
      Controller.SubtipoDespesa.Nome  := edtNome.Text;
      if Operacao = opInserir then
      begin
        if not Controller.Inserir(Controller.SubtipoDespesa, erro) then
          TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
      end;
      if Operacao = opEditar then
      begin
        if not Controller.Editar(Controller.SubtipoDespesa, erro) then
          TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
      end;
      inherited;
    end;
  end;
end;

procedure TfrmSubtipoDespesa.cbTipoChange(Sender: TObject);
begin
  ValidarObrigatorioChange(Sender);
end;

procedure TfrmSubtipoDespesa.cbTipoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  qtdReg: Integer;
begin
  qtdReg := 0;
  if not (key in [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT]) then
  begin
    if (Length((Sender as TComboBox).Text) >= 3) then
    begin
      controller.PesquisarTipoDespesa((Sender as TComboBox), lbTipoId, (Sender as TComboBox).Text, qtdReg);
      (Sender as TComboBox).DroppedDown := qtdReg > 1;
    end
    else
    begin
      (Sender as TComboBox).Items.Clear;
    end;
  end;
end;

procedure TfrmSubtipoDespesa.cbTipoSelect(Sender: TObject);
begin
  if (Sender as TComboBox).ItemIndex <> -1 then
    controller.SubtipoDespesa.TipoDespesa.Id := StrToInt(lbTipoId.Items[(Sender as TComboBox).ItemIndex]);
end;

procedure TfrmSubtipoDespesa.edtNomeChange(Sender: TObject);
begin
  ValidarObrigatorioChange(Self);
end;

procedure TfrmSubtipoDespesa.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  TfrmPrincipal(Owner).BarraLateralVazia(TfrmPrincipal(Owner).pnlMenuCadastro, True);
  CloseAction := caFree;
end;

procedure TfrmSubtipoDespesa.actExcluirExecute(Sender: TObject);
var
  erro: String;
  id: Integer;
begin
  if Assigned(lvPadrao.Selected) then
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
  end
  else
    TfrmMessage.Mensagem('Nenhum registro foi selecionado!', 'Aviso', 'C', [mbOk]);
end;

procedure TfrmSubtipoDespesa.actPesquisarExecute(Sender: TObject);
begin
  lvPadrao.Items.Clear;
  Controller.Pesquisar(lvPadrao, lbPesquisa.Items[cbPesquisa.ItemIndex], edtPesquisa.Text);
end;

procedure TfrmSubtipoDespesa.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmSubtipoDespesa.FormShow(Sender: TObject);
begin
  LiberarBloquearAcessos(Self.actList, Self.Name);
  inherited;
end;

procedure TfrmSubtipoDespesa.CarregarDados;
begin
  lvPadrao.Items.Clear;
  Controller.Listar(lvPadrao);
end;

procedure TfrmSubtipoDespesa.LimparCampos;
begin
  edtNome.Clear;
  cbTipo.Clear;
  cbTipo.Items.Clear;
  lbTipoId.Items.Clear;
end;

procedure TfrmSubtipoDespesa.CarregarSelecionado;
var
  id: Integer;
  erro: String;
begin
  id := StrToInt(lvPadrao.Selected.Caption);
  if Controller.BuscarPorId(controller.SubtipoDespesa, id, erro) then
  begin
    edtNome.Text  := Controller.SubtipoDespesa.Nome;
    cbTipo.Text   := Controller.SubtipoDespesa.TipoDespesa.Nome;
  end
  else
  begin
    TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    Abort;
  end;
end;

function TfrmSubtipoDespesa.CamposEstaoPreenchidos: Boolean;
begin
  Result := False;
  if Trim(edtNome.Text) = EmptyStr then
    ValidarObrigatorioExit(edtNome)
  else
  if cbTipo.ItemIndex = -1 then
    ValidarObrigatorioExit(cbTipo)
  else
    Result := True;
end;

function TfrmSubtipoDespesa.CamposEstaoComTamanhoMinimo: Boolean;
begin
  Result := False;
  if Length(Trim(edtNome.Text)) < 3 then
    ValidarTamanhoMinimoExit(edtNome)
  else
    Result := True;
end;

end.

