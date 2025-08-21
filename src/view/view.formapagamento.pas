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

unit view.formapagamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  view.cadastropadrao, controller.formapagamento, view.mensagem, lib.types;

type

  { TfrmFormaPagamento }

  TfrmFormaPagamento = class(TfrmCadastroPadrao)
    edtNome: TLabeledEdit;
    edtSigla: TLabeledEdit;
    procedure actExcluirExecute(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure edtNomeChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Controller: TFormaPagamentoController;
  public
    procedure CarregarDados; override;
    procedure LimparCampos; override;
    procedure CarregarSelecionado; override;
    function CamposEstaoPreenchidos: Boolean; override;
    function CamposEstaoComTamanhoMinimo: Boolean; override;
  end;

var
  frmFormaPagamento: TfrmFormaPagamento;

implementation

uses
  view.principal;

{$R *.lfm}

{ TfrmFormaPagamento }

procedure TfrmFormaPagamento.FormCreate(Sender: TObject);
begin
  inherited;
  Controller := TFormaPagamentoController.Create;
end;

procedure TfrmFormaPagamento.actExcluirExecute(Sender: TObject);
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

procedure TfrmFormaPagamento.actPesquisarExecute(Sender: TObject);
begin
  lvPadrao.Items.Clear;
  Controller.Pesquisar(lvPadrao, lbPesquisa.Items[cbPesquisa.ItemIndex], edtPesquisa.Text);
end;

procedure TfrmFormaPagamento.actSalvarExecute(Sender: TObject);
var
  erro: String;
begin
  if CamposEstaoPreenchidos and CamposEstaoComTamanhoMinimo then
  begin
    if TfrmMessage.Mensagem('Deseja salvar ?', 'Aviso', 'Q', [mbNao, mbSim], mbNao) then
    begin
      Controller.FormaPagamento.Nome  := edtNome.Text;
      Controller.FormaPagamento.Sigla := edtSigla.Text;
      if Operacao = opInserir then
      begin
        if not Controller.Inserir(Controller.FormaPagamento, erro) then
          TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
      end;
      if Operacao = opEditar then
      begin
        if not Controller.Editar(Controller.FormaPagamento, erro) then
          TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
      end;
      inherited;
    end;
  end;
end;

procedure TfrmFormaPagamento.edtNomeChange(Sender: TObject);
begin
  ValidarObrigatorioChange(Sender);
end;

procedure TfrmFormaPagamento.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  TfrmPrincipal(Owner).BarraLateralVazia(TfrmPrincipal(Owner).pnlMenuCadastro, True);
  CloseAction := caFree;
end;

procedure TfrmFormaPagamento.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmFormaPagamento.FormShow(Sender: TObject);
begin
  LiberarBloquearAcessos(Self.actList, Self.Name);
  inherited;
end;

procedure TfrmFormaPagamento.CarregarDados;
begin
  lvPadrao.Items.Clear;
  Controller.Listar(lvPadrao);
end;

procedure TfrmFormaPagamento.LimparCampos;
begin
  edtNome.Clear;
  edtSigla.Clear;
end;

procedure TfrmFormaPagamento.CarregarSelecionado;
var
  id: Integer;
  erro: String;
begin
  id := StrToInt(lvPadrao.Selected.Caption);
  if Controller.BuscarPorId(controller.FormaPagamento, id, erro) then
  begin
    edtNome.Text  := Controller.FormaPagamento.Nome;
    edtSigla.Text := Controller.FormaPagamento.Sigla;
  end
  else
  begin
    TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    Abort;
  end;
end;

function TfrmFormaPagamento.CamposEstaoPreenchidos: Boolean;
begin
  Result := False;
  if Trim(edtNome.Text) = EmptyStr then
    ValidarObrigatorioExit(edtNome)
  else
    Result := True;
end;

function TfrmFormaPagamento.CamposEstaoComTamanhoMinimo: Boolean;
begin
  Result := False;
  if Length(Trim(edtNome.Text)) < 3 then
    ValidarTamanhoMinimoExit(edtNome)
  else
    Result := True;
end;

end.

