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

unit controller.banco;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, model.entity.banco, model.dao.banco,
  model.dao.padrao;

type

  { TBancoController }

  TBancoController = class
  private
    BancoDao: TBancoDAO;
  public
    Banco: TBanco;
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    function BuscarPorId(objBanco : TBanco; Id: Integer; out Erro: String): Boolean;
    function Inserir(objBanco: TBanco; out Erro: string): Boolean;
    function Editar(objBanco: TBanco; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TBancoController }

procedure TBancoController.Listar(lv: TListView);
begin
  BancoDao.Listar(lv);
end;

procedure TBancoController.Pesquisar(lv: TListView; Campo, Busca: String);
begin
  BancoDao.Pesquisar(lv, campo, busca);
end;

function TBancoController.BuscarPorId(objBanco: TBanco; Id: Integer; out
  Erro: String): Boolean;
begin
  Result := BancoDao.BuscarPorId(objBanco, Id, Erro);
end;

function TBancoController.Inserir(objBanco: TBanco; out Erro: string): Boolean;
begin
  Result := BancoDao.Inserir(objBanco, Erro);
end;

function TBancoController.Editar(objBanco: TBanco; out Erro: string): Boolean;
begin
  Result := BancoDao.Editar(objBanco, Erro);
end;

function TBancoController.Excluir(Id: Integer; out Erro: string): Boolean;
begin
  Result := BancoDao.Excluir(Id, Erro);
end;

constructor TBancoController.Create;
begin
  Banco    := TBanco.Create;
  BancoDao := TBancoDAO.Create;
end;

destructor TBancoController.Destroy;
begin
  Banco.Free;
  BancoDao.Free;
  inherited Destroy;
end;

end.

