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

unit controller.contabancaria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, model.entity.contabancaria,
  model.entity.cartao, model.entity.pix, model.dao.contabancaria,
  model.dao.padrao, model.connection.conexao1;

type

  { TContaBancariaController }

  TContaBancariaController = class
  private
    ContaBancariaDAO: TContaBancariaDAO;
  public
    ContaBancaria: TContaBancaria;
    Pix: TPix;
    Cartao: TCartao;
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    procedure PesquisarBanco(lbNome: TComboBox; lbId: TListBox; busca: String; out QtdRegistro: Integer);
    function BuscarPorId(objContaBancaria : TContaBancaria; Id: Integer; out Erro: String): Boolean;
    function Inserir(objContaBancaria : TContaBancaria; out Erro: string): Boolean;
    function Editar(objContaBancaria : TContaBancaria; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;

    {$Region 'PIX'}
    procedure ListarPix(lv: TListView; IdConta: Integer);
    function BuscarPixPorId(objPix : TPix; Id: String; out Erro: String): Boolean;
    function InserirPix(objPix : TPix; out Erro: string): Boolean;
    function EditarPix(objPix : TPix; out Erro: string): Boolean;
    function ExcluirPix(Id: String; out Erro: string): Boolean;
    {$EndRegion}

    {$Region 'CARTAO'}
    procedure ListarCartao(lv: TListView; IdConta: Integer);
    procedure PesquisarBandeira(lbNome: TComboBox; lbId: TListBox; busca: String; out QtdRegistro: Integer);
    function BuscarCartaoPorId(objCartao : TCartao; Id: Integer; out Erro: String): Boolean;
    function InserirCartao(objCartao : TCartao; out Erro: string): Boolean;
    function EditarCartao(objCartao : TCartao; out Erro: string): Boolean;
    function ExcluirCartao(Id: Integer; out Erro: string): Boolean;
    {$EndRegion}

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TContaBancariaController }

procedure TContaBancariaController.Listar(lv: TListView);
begin
  ContaBancariaDAO.Listar(lv);
end;

procedure TContaBancariaController.Pesquisar(lv: TListView; Campo, Busca: String);
begin
  ContaBancariaDAO.Pesquisar(lv, Campo, Busca);
end;

procedure TContaBancariaController.PesquisarBanco(lbNome: TComboBox; lbId: TListBox;
  busca: String; out QtdRegistro: Integer);
begin
  ContaBancariaDAO.PesquisaGenerica(TB_BANCO, lbNome, lbId, busca, 10, QtdRegistro);
end;

function TContaBancariaController.BuscarPorId(objContaBancaria: TContaBancaria; Id: Integer; out
  Erro: String): Boolean;
begin
  Result := ContaBancariaDAO.BuscarPorId(objContaBancaria, Id, Erro);
end;

function TContaBancariaController.Inserir(objContaBancaria: TContaBancaria; out Erro: string): Boolean;
begin
  objContaBancaria.UsuarioCadastro.Id := dmConexao1.Usuario.Id;
  objContaBancaria.DonoCadastro.Id    := dmConexao1.DonoCadastro.Id;
  Result := ContaBancariaDAO.Inserir(objContaBancaria, Erro);
end;

function TContaBancariaController.Editar(objContaBancaria: TContaBancaria; out Erro: string): Boolean;
begin
  Result := ContaBancariaDAO.Editar(objContaBancaria, Erro);
end;

function TContaBancariaController.Excluir(Id: Integer; out Erro: string): Boolean;
begin
  Result := ContaBancariaDAO.Excluir(Id, Erro);
end;

procedure TContaBancariaController.ListarPix(lv: TListView; IdConta: Integer);
begin
  ContaBancariaDAO.ListarPix(lv, IdConta);
end;

function TContaBancariaController.BuscarPixPorId(objPix: TPix; Id: String; out
  Erro: String): Boolean;
begin
  Result := ContaBancariaDAO.BuscarPixPorId(objPix, id, erro);
end;

function TContaBancariaController.InserirPix(objPix: TPix; out Erro: string
  ): Boolean;
begin
  objPix.UsuarioCadastro.Id := dmConexao1.Usuario.Id;
  objPix.DonoCadastro.Id    := dmConexao1.DonoCadastro.Id;
  Result := ContaBancariaDAO.InserirPix(objPix, Erro);
end;

function TContaBancariaController.EditarPix(objPix: TPix; out Erro: string
  ): Boolean;
begin
  Result := ContaBancariaDAO.EditarPix(objPix, Erro);
end;

function TContaBancariaController.ExcluirPix(Id: String; out Erro: string
  ): Boolean;
begin
  Result := ContaBancariaDAO.ExcluirPix(id, erro);
end;

procedure TContaBancariaController.ListarCartao(lv: TListView; IdConta: Integer
  );
begin
  ContaBancariaDAO.ListarCartao(lv, IdConta);
end;

procedure TContaBancariaController.PesquisarBandeira(lbNome: TComboBox; lbId: TListBox;
  busca: String; out QtdRegistro: Integer);
begin
  ContaBancariaDAO.PesquisaGenerica(TB_BANDEIRA, lbNome, lbId, busca, 10, QtdRegistro);
end;

function TContaBancariaController.BuscarCartaoPorId(objCartao: TCartao;
  Id: Integer; out Erro: String): Boolean;
begin
  Result := ContaBancariaDAO.BuscarCartaoPorId(objCartao, id, Erro);
end;

function TContaBancariaController.InserirCartao(objCartao: TCartao; out
  Erro: string): Boolean;
begin
  objCartao.UsuarioCadastro.Id := dmConexao1.Usuario.Id;
  objCartao.DonoCadastro.Id    := dmConexao1.DonoCadastro.Id;
  Result := ContaBancariaDAO.InserirCartao(objCartao, erro);
end;

function TContaBancariaController.EditarCartao(objCartao: TCartao; out
  Erro: string): Boolean;
begin
  Result := ContaBancariaDAO.EditarCartao(objCartao, Erro);
end;

function TContaBancariaController.ExcluirCartao(Id: Integer; out Erro: string
  ): Boolean;
begin
  Result := ContaBancariaDAO.ExcluirCartao(id, Erro);
end;

constructor TContaBancariaController.Create;
begin
  ContaBancaria    := TContaBancaria.Create;
  ContaBancariaDAO := TContaBancariaDAO.Create;
  Pix              := TPix.Create;
  Cartao           := TCartao.Create;
end;

destructor TContaBancariaController.Destroy;
begin
  ContaBancaria.Free;
  ContaBancariaDAO.Free;
  Pix.Free;
  Cartao.Free;
  inherited Destroy;
end;

end.
