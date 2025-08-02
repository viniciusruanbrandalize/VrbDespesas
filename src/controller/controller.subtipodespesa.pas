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

unit controller.subtipodespesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, model.entity.subtipodespesa,
  model.dao.padrao, model.dao.subtipodespesa;

type

  { TSubtipoDespesaController }

  TSubtipoDespesaController = class
  private
    SubtipoDespesaDAO: TSubtipoDespesaDAO;
  public
    SubtipoDespesa: TSubtipoDespesa;
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    procedure PesquisarTipoDespesa(lbNome: TComboBox; lbId: TListBox; busca: String; out QtdRegistro: Integer);
    function BuscarPorId(objSubtipoDespesa : TSubtipoDespesa; Id: Integer; out Erro: String): Boolean;
    function Inserir(objSubtipoDespesa : TSubtipoDespesa; out Erro: string): Boolean;
    function Editar(objSubtipoDespesa : TSubtipoDespesa; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TSubtipoDespesaController }

procedure TSubtipoDespesaController.Listar(lv: TListView);
begin
  SubtipoDespesaDAO.Listar(lv);
end;

procedure TSubtipoDespesaController.Pesquisar(lv: TListView; Campo, Busca: String);
begin
  SubtipoDespesaDAO.Pesquisar(lv, Campo, Busca);
end;

procedure TSubtipoDespesaController.PesquisarTipoDespesa(lbNome: TComboBox; lbId: TListBox; busca: String;
  out QtdRegistro: Integer);
begin
  SubtipoDespesaDAO.PesquisaGenerica(TB_TIPO_DESPESA, lbNome, lbId, busca, 10, QtdRegistro);
end;

function TSubtipoDespesaController.BuscarPorId(objSubtipoDespesa: TSubtipoDespesa; Id: Integer; out
  Erro: String): Boolean;
begin
  Result := SubtipoDespesaDAO.BuscarPorId(objSubtipoDespesa, Id, Erro);
end;

function TSubtipoDespesaController.Inserir(objSubtipoDespesa: TSubtipoDespesa; out Erro: string): Boolean;
begin
  Result := SubtipoDespesaDAO.Inserir(objSubtipoDespesa, Erro);
end;

function TSubtipoDespesaController.Editar(objSubtipoDespesa: TSubtipoDespesa; out Erro: string): Boolean;
begin
  Result := SubtipoDespesaDAO.Editar(objSubtipoDespesa, Erro);
end;

function TSubtipoDespesaController.Excluir(Id: Integer; out Erro: string): Boolean;
begin
  Result := SubtipoDespesaDAO.Excluir(Id, Erro);
end;

constructor TSubtipoDespesaController.Create;
begin
  SubtipoDespesa    := TSubTipoDespesa.Create;
  SubtipoDespesaDAO := TSubTipoDespesaDAO.Create;
end;

destructor TSubtipoDespesaController.Destroy;
begin
  SubtipoDespesa.Free;
  SubtipoDespesaDAO.Free;
  inherited Destroy;
end;

end.
