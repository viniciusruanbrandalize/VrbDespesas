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

unit view.participante;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, view.cadastropadrao, lib.types, controller.participante,
  view.mensagem, LCLType, ActnList;

type

  { TfrmParticipante }

  TfrmParticipante = class(TfrmCadastroPadrao)
    actBuscarCep: TAction;
    cbPessoa: TComboBox;
    cbCidade: TComboBox;
    edtUf: TLabeledEdit;
    edtIe: TLabeledEdit;
    edtTelefone: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtFantasia: TLabeledEdit;
    edtCnpj: TLabeledEdit;
    edtCelular: TLabeledEdit;
    edtEmail: TLabeledEdit;
    edtCep: TLabeledEdit;
    edtRua: TLabeledEdit;
    edtNumero: TLabeledEdit;
    edtComplemento: TLabeledEdit;
    edtBairro: TLabeledEdit;
    lblObs: TLabel;
    lblPessoa: TLabel;
    btnBuscaCep: TSpeedButton;
    lblCidade: TLabel;
    lbPessoaValues: TListBox;
    lbCidadeId: TListBox;
    mObs: TMemo;
    procedure actBuscarCepExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure actIncluirExecute(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure cbCidadeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbCidadeSelect(Sender: TObject);
    procedure cbPessoaChange(Sender: TObject);
    procedure edtNomeChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FEhDonoCadastro: Boolean;  {Abrir form de devedor/participantes}
    Controller: TParticipanteController;
    procedure SetEhDonoCadastro(AValue: Boolean);
    procedure MudarCamposPorPessoa(Pessoa: Char);
  public
    procedure CarregarDados; override;
    procedure LimparCampos; override;
    procedure CarregarSelecionado; override;
    function CamposEstaoPreenchidos: Boolean; override;
    function CamposEstaoComTamanhoMinimo: Boolean; override;
    property EhDonoCadastro: Boolean read FEhDonoCadastro write SetEhDonoCadastro;
  end;

var
  frmParticipante: TfrmParticipante;

implementation

uses
  view.principal;

{$R *.lfm}

{ TfrmParticipante }

procedure TfrmParticipante.FormCreate(Sender: TObject);
begin
  inherited;
  Controller := TParticipanteController.Create;
end;

procedure TfrmParticipante.actSalvarExecute(Sender: TObject);
var
  erro: String;
begin
  if CamposEstaoPreenchidos and CamposEstaoComTamanhoMinimo then
  begin
    if TfrmMessage.Mensagem('Deseja salvar ?', 'Aviso', 'Q', [mbNao, mbSim], mbNao) then
    begin

      Controller.Participante.Nome  := edtNome.Text;
      Controller.Participante.Pessoa := lbPessoaValues.Items[cbPessoa.ItemIndex];
      Controller.Participante.CNPJ   := edtCnpj.Text;
      if Trim( edtIe.Text ) <> EmptyStr then
        Controller.Participante.IE     := StrToInt(edtIe.Text)
      else
        Controller.Participante.IE     := 0;
      Controller.Participante.Fantasia := edtFantasia.Text;
      Controller.Participante.Telefone := edtTelefone.Text;
      Controller.Participante.Celular  := edtCelular.Text;
      Controller.Participante.Email    := edtEmail.Text;
      Controller.Participante.CEP      := edtCep.Text;
      Controller.Participante.Rua      := edtRua.Text;
      if Trim( edtNumero.Text ) <> EmptyStr then
        Controller.Participante.Numero   := StrToInt(edtNumero.Text)
      else
        Controller.Participante.Numero   := 0;
      Controller.Participante.Complemento := edtComplemento.Text;
      Controller.Participante.Bairro   := edtBairro.Text;
      Controller.Participante.Obs      := mObs.Lines.Text;
      Controller.Participante.EhDonoCadastro := FEhDonoCadastro;

      if Operacao = opInserir then
      begin
        Controller.Participante.Cadastro := Now;
        if not Controller.Inserir(Controller.Participante, erro) then
          TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
      end;
      if Operacao = opEditar then
      begin
        Controller.Participante.Alteracao := Now;
        if not Controller.Editar(Controller.Participante, erro) then
          TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
      end;
      inherited;
    end;
  end;
end;

procedure TfrmParticipante.cbCidadeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  qtdReg: Integer;
begin
  qtdReg := 0;
  if not (key in [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT]) then
  begin
    if (Length((Sender as TComboBox).Text) >= 3) then
    begin
      controller.PesquisarCidade((Sender as TComboBox), lbCidadeId, (Sender as TComboBox).Text, qtdReg);
      (Sender as TComboBox).DroppedDown := qtdReg > 1;
    end
    else
    begin
      (Sender as TComboBox).Items.Clear;
    end;
  end;
end;

procedure TfrmParticipante.cbCidadeSelect(Sender: TObject);
begin
  if (Sender as TComboBox).ItemIndex <> -1 then
    controller.Participante.Cidade.Id := StrToInt(lbCidadeId.Items[(Sender as TComboBox).ItemIndex]);
end;

procedure TfrmParticipante.cbPessoaChange(Sender: TObject);
begin
  MudarCamposPorPessoa(lbPessoaValues.Items[cbPessoa.ItemIndex][1]);
end;

procedure TfrmParticipante.edtNomeChange(Sender: TObject);
begin
  ValidarObrigatorioChange(Sender);
end;

procedure TfrmParticipante.actExcluirExecute(Sender: TObject);
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

procedure TfrmParticipante.actIncluirExecute(Sender: TObject);
begin
  inherited;
  MudarCamposPorPessoa(lbPessoaValues.Items[cbPessoa.ItemIndex][1]);
end;

procedure TfrmParticipante.actBuscarCepExecute(Sender: TObject);
var
  Erro: string;
begin
  if Trim( edtCep.Text ) <> EmptyStr then
  begin
    Controller.Participante.CEP := edtCep.Text;
    if Controller.BuscarCEP(Controller.Participante, Erro) then
    begin
      edtCep.Text         := Controller.Participante.CEP;
      edtBairro.Text      := Controller.Participante.Bairro;
      edtRua.Text         := Controller.Participante.Rua;
      edtComplemento.Text := Controller.Participante.Complemento;
      cbCidade.Text       := Controller.Participante.Cidade.Nome;
      edtUf.Text          := Controller.Participante.Cidade.Estado.UF;
    end
    else
      TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
  end;
end;

procedure TfrmParticipante.actPesquisarExecute(Sender: TObject);
begin
  lvPadrao.Items.Clear;
  Controller.Pesquisar(lvPadrao, lbPesquisa.Items[cbPesquisa.ItemIndex],
                        edtPesquisa.Text, FEhDonoCadastro);
end;

procedure TfrmParticipante.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  TfrmPrincipal(Owner).BarraLateralVazia(TfrmPrincipal(Owner).pnlMenuCadastro, True);
  CloseAction := caFree;
end;

procedure TfrmParticipante.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmParticipante.FormShow(Sender: TObject);
begin
  LiberarBloquearAcessos(Self.actList, Self.Name);
  inherited;
end;

procedure TfrmParticipante.SetEhDonoCadastro(AValue: Boolean);
begin
  if FEhDonoCadastro = AValue then
    Exit;
  FEhDonoCadastro := AValue;
end;

procedure TfrmParticipante.MudarCamposPorPessoa(Pessoa: Char);
begin
  if UpperCase(Pessoa) = 'F' then
  begin
    edtCnpj.EditLabel.Caption := 'CPF:';
    edtCnpj.MaxLength         := 11;
    edtFantasia.Visible       := False;
    edtFantasia.Clear;
  end
  else
  if UpperCase(Pessoa) = 'J' then
  begin
    edtCnpj.EditLabel.Caption := 'CNPJ:';
    edtCnpj.MaxLength         := 14;
    edtFantasia.Visible       := True;
  end;
end;

procedure TfrmParticipante.CarregarDados;
begin
  lvPadrao.Items.Clear;
  Controller.Listar(lvPadrao, FEhDonoCadastro);
end;

procedure TfrmParticipante.LimparCampos;
begin
  cbPessoa.ItemIndex := 0;
  edtCnpj.Clear;
  edtIe.Clear;
  edtNome.Clear;
  edtFantasia.Clear;
  edtTelefone.Clear;
  edtCelular.Clear;
  edtEmail.Clear;
  edtCep.Clear;
  edtRua.Clear;
  edtNumero.Clear;
  edtComplemento.Clear;
  edtBairro.Clear;
  cbCidade.Clear;
  cbCidade.Items.Clear;
  edtUf.Clear;
  mObs.Lines.Clear;
end;

procedure TfrmParticipante.CarregarSelecionado;
var
  id: Integer;
  erro: String;
begin
  id := StrToInt(lvPadrao.Selected.Caption);
  if Controller.BuscarPorId(controller.Participante, id, FEhDonoCadastro, erro) then
  begin
    cbPessoa.ItemIndex := lbPessoaValues.Items.IndexOf(Controller.Participante.Pessoa);
    edtCnpj.Text       := Controller.Participante.CNPJ;
    edtIe.Text         := Controller.Participante.IE.ToString;
    edtNome.Text       := Controller.Participante.Nome;
    edtFantasia.Text   := Controller.Participante.Fantasia;
    edtTelefone.Text   := Controller.Participante.Telefone;
    edtCelular.Text    := Controller.Participante.Celular;
    edtEmail.Text      := Controller.Participante.Email;
    edtCep.Text        := Controller.Participante.CEP;
    edtRua.Text        := Controller.Participante.Rua;
    edtNumero.Text     := Controller.Participante.Numero.ToString;
    edtComplemento.Text := Controller.Participante.Complemento;
    edtBairro.Text     := Controller.Participante.Bairro;
    cbCidade.Text      := Controller.Participante.Cidade.Nome;
    edtUf.Text         := Controller.Participante.Cidade.Estado.UF;
    mObs.Lines.Text    := Controller.Participante.Obs;
    MudarCamposPorPessoa(lbPessoaValues.Items[cbPessoa.ItemIndex][1]);
  end
  else
  begin
    TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    Abort;
  end;
end;

function TfrmParticipante.CamposEstaoPreenchidos: Boolean;
begin
  Result := False;
  if Trim(edtNome.Text) = EmptyStr then
    ValidarObrigatorioExit(edtNome)
  else
    Result := True;
end;

function TfrmParticipante.CamposEstaoComTamanhoMinimo: Boolean;
begin
  Result := False;
  if Length(Trim(edtNome.Text)) < 3 then
    ValidarTamanhoMinimoExit(edtNome)
  else
    Result := True;
end;

end.

