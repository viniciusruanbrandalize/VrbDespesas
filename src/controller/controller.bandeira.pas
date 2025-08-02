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

unit controller.bandeira;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, model.entity.bandeira, model.dao.bandeira,
  model.dao.padrao;

type

  { TBandeiraController }

  TBandeiraController = class
  private
    BandeiraDAO: TBandeiraDAO;
  public
    Bandeira: TBandeira;
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    function BuscarPorId(objBandeira : TBandeira; Id: Integer; out Erro: String): Boolean;
    function Inserir(objBandeira: TBandeira; out Erro: string): Boolean;
    function Editar(objBandeira: TBandeira; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TBandeiraController }

procedure TBandeiraController.Listar(lv: TListView);
begin
  BandeiraDAO.Listar(lv);
end;

procedure TBandeiraController.Pesquisar(lv: TListView; Campo, Busca: String);
begin
  BandeiraDAO.Pesquisar(lv, campo, busca);
end;

function TBandeiraController.BuscarPorId(objBandeira: TBandeira; Id: Integer; out
  Erro: String): Boolean;
begin
  Result := BandeiraDAO.BuscarPorId(objBandeira, Id, Erro);
end;

function TBandeiraController.Inserir(objBandeira: TBandeira; out Erro: string): Boolean;
begin
  Result := BandeiraDAO.Inserir(objBandeira, Erro);
end;

function TBandeiraController.Editar(objBandeira: TBandeira; out Erro: string): Boolean;
begin
  Result := BandeiraDAO.Editar(objBandeira, Erro);
end;

function TBandeiraController.Excluir(Id: Integer; out Erro: string): Boolean;
begin
  Result := BandeiraDAO.Excluir(Id, Erro);
end;

constructor TBandeiraController.Create;
begin
  Bandeira    := TBandeira.Create;
  BandeiraDAO := TBandeiraDAO.Create;
end;

destructor TBandeiraController.Destroy;
begin
  Bandeira.Free;
  BandeiraDAO.Free;
  inherited Destroy;
end;

end.

