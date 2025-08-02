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

unit controller.tipodespesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, model.entity.tipodespesa,
  model.dao.padrao, model.dao.tipodespesa;

type

  { TTipoDespesaController }

  TTipoDespesaController = class
  private
    TipoDespesaDAO: TTipoDespesaDAO;
  public
    TipoDespesa: TTipoDespesa;
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    function BuscarPorId(objTipoDespesa : TTipoDespesa; Id: Integer; out Erro: String): Boolean;
    function Inserir(objTipoDespesa : TTipoDespesa; out Erro: string): Boolean;
    function Editar(objTipoDespesa : TTipoDespesa; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TTipoDespesaController }

procedure TTipoDespesaController.Listar(lv: TListView);
begin
  TipoDespesaDAO.Listar(lv);
end;

procedure TTipoDespesaController.Pesquisar(lv: TListView; Campo, Busca: String);
begin
  TipoDespesaDAO.Pesquisar(lv, Campo, Busca);
end;

function TTipoDespesaController.BuscarPorId(objTipoDespesa: TTipoDespesa; Id: Integer; out
  Erro: String): Boolean;
begin
  Result := TipoDespesaDAO.BuscarPorId(objTipoDespesa, Id, Erro);
end;

function TTipoDespesaController.Inserir(objTipoDespesa: TTipoDespesa; out Erro: string): Boolean;
begin
  Result := TipoDespesaDAO.Inserir(objTipoDespesa, Erro);
end;

function TTipoDespesaController.Editar(objTipoDespesa: TTipoDespesa; out Erro: string): Boolean;
begin
  Result := TipoDespesaDAO.Editar(objTipoDespesa, Erro);
end;

function TTipoDespesaController.Excluir(Id: Integer; out Erro: string): Boolean;
begin
  Result := TipoDespesaDAO.Excluir(Id, Erro);
end;

constructor TTipoDespesaController.Create;
begin
  TipoDespesa    := TTipoDespesa.Create;
  TipoDespesaDAO := TTipoDespesaDAO.Create;
end;

destructor TTipoDespesaController.Destroy;
begin
  TipoDespesa.Free;
  TipoDespesaDAO.Free;
  inherited Destroy;
end;

end.
