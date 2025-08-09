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

unit controller.configuracao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, model.dao.configuracao,
  model.entity.configuracao, model.ini.configuracao;

type

  { TConfiguracaoController }

  TConfiguracaoController = class
  private
    DAO: TConfiguracaoDAO;
  public
    ListaConfiguracao: TListaConfiguracao;
    Configuracao:    TConfiguracao;
    ConfiguracaoINI: TConfiguracaoINI;
    function BuscarTodos(Lista: TListaConfiguracao; out Erro: String): Boolean;
    function Editar(objConfiguracao: TConfiguracao; out Erro: String): Boolean;
    function BuscarPorId(objConfiguracao: TConfiguracao; Id: Integer; out Erro: String): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TConfiguracaoController }

function TConfiguracaoController.BuscarTodos(
  Lista: TListaConfiguracao; out Erro: String): Boolean;
begin
  Result := DAO.BuscarTodos(Lista, Erro);
end;

function TConfiguracaoController.Editar(objConfiguracao: TConfiguracao; out
  Erro: String): Boolean;
begin
  Result := DAO.Editar(objConfiguracao, Erro);
end;

function TConfiguracaoController.BuscarPorId(objConfiguracao: TConfiguracao;
  Id: Integer; out Erro: String): Boolean;
begin
  Result := DAO.BuscarPorId(objConfiguracao, Id, Erro);
end;

constructor TConfiguracaoController.Create;
begin
  Configuracao := TConfiguracao.Create;
  ListaConfiguracao := TListaConfiguracao.Create;
  DAO := TConfiguracaoDAO.Create;
  ConfiguracaoINI := TConfiguracaoINI.Create;
end;

destructor TConfiguracaoController.Destroy;
begin
  FreeAndNil(Configuracao);
  FreeAndNil(ListaConfiguracao);
  FreeAndNil(DAO);
  FreeAndNil(ConfiguracaoINI);
  inherited Destroy;
end;

end.
