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

unit controller.participante;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, model.entity.participante,
  model.dao.participante, model.dao.padrao, model.connection.conexao1, lib.cep;

type

  { TParticipanteController }

  TParticipanteController = class
  private
    ParticipanteDAO: TParticipanteDAO;
  public
    Participante: TParticipante;
    procedure Listar(lv: TListView; DonoCadastro: Boolean);
    procedure Pesquisar(lv: TListView; Campo, Busca: String; DonoCadastro: Boolean);
    procedure PesquisarCidade(lbNome: TComboBox; lbId: TListBox; busca: String; out QtdRegistro: Integer);
    function BuscarCEP(var objParticipante: TParticipante; out Erro: String): Boolean;
    function BuscarPorId(objParticipante : TParticipante; Id: Integer; DonoCadastro: Boolean; out Erro: String): Boolean;
    function Inserir(objParticipante : TParticipante; out Erro: string): Boolean;
    function Editar(objParticipante : TParticipante; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TParticipanteController }

procedure TParticipanteController.Listar(lv: TListView; DonoCadastro: Boolean);
begin
  ParticipanteDAO.Listar(lv, DonoCadastro);
end;

procedure TParticipanteController.Pesquisar(lv: TListView; Campo, Busca: String;
  DonoCadastro: Boolean);
begin
  ParticipanteDAO.Pesquisar(lv, Campo, Busca, DonoCadastro);
end;

procedure TParticipanteController.PesquisarCidade(lbNome: TComboBox; lbId: TListBox;
  busca: String; out QtdRegistro: Integer);
begin
  ParticipanteDAO.PesquisarCidade(lbNome, lbId, busca, QtdRegistro);
end;

function TParticipanteController.BuscarCEP(var objParticipante: TParticipante;
  out Erro: String): Boolean;
var
  LibCEP: TLibCep;
  consultou: Boolean;
  idCidade, CodIBGE: Integer;
begin
  LibCEP := TLibCep.Create;
  try
    consultou := LibCEP.BuscarPorCep(objParticipante.CEP, Erro);
    if consultou then
    begin
      CodIBGE := StrToIntDef(LibCEP.Endereco[0].IBGE, 0);
      idCidade := ParticipanteDAO.BuscarIdCidadePorIBGE(CodIBGE, Erro);
      if idCidade <> 0 then
      begin
        objParticipante.CEP              := LibCEP.Endereco[0].CEP;
        objParticipante.Rua              := LibCEP.Endereco[0].Logradouro;
        objParticipante.Complemento      := LibCEP.Endereco[0].Complemento;
        objParticipante.Bairro           := LibCEP.Endereco[0].Bairro;
        objParticipante.Cidade.Nome      := LibCEP.Endereco[0].Cidade;
        objParticipante.Cidade.Estado.UF := LibCEP.Endereco[0].UF;
        objParticipante.Cidade.Id        := idCidade;
      end;
    end;
  finally
    Result := consultou;
    FreeAndNil(LibCEP);
  end;
end;

function TParticipanteController.BuscarPorId(objParticipante: TParticipante; Id: Integer;
  DonoCadastro: Boolean; out Erro: String): Boolean;
begin
  Result := ParticipanteDAO.BuscarPorId(objParticipante, Id, DonoCadastro, Erro);
end;

function TParticipanteController.Inserir(objParticipante: TParticipante; out Erro: string): Boolean;
begin
  objParticipante.UsuarioCadastro.Id := dmConexao1.Usuario.Id;
  Result := ParticipanteDAO.Inserir(objParticipante, Erro);
end;

function TParticipanteController.Editar(objParticipante: TParticipante; out Erro: string): Boolean;
begin
  Result := ParticipanteDAO.Editar(objParticipante, Erro);
end;

function TParticipanteController.Excluir(Id: Integer; out Erro: string): Boolean;
begin
  Result := ParticipanteDAO.Excluir(Id, Erro);
end;

constructor TParticipanteController.Create;
begin
  Participante    := TParticipante.Create;
  ParticipanteDAO := TParticipanteDAO.Create;
end;

destructor TParticipanteController.Destroy;
begin
  Participante.Free;
  ParticipanteDAO.Free;
  inherited Destroy;
end;

end.
