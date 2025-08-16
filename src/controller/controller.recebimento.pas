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

unit controller.recebimento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, model.entity.recebimento,
  model.dao.recebimento, model.dao.padrao, model.connection.conexao1;

type

  { TRecebimentoController }

  TRecebimentoController = class
  private
    RecebimentoDao: TRecebimentoDAO;
  public
    Recebimento: TRecebimento;
    procedure Listar(lv: TListView; Tipo: Integer);
    procedure Pesquisar(lv: TListView; Campo, Busca: String; DataInicial, DataFinal: TDateTime; Tipo: Integer);
    procedure PesquisarPagador(lbNome: TComboBox; lbId: TListBox; busca: String; out QtdRegistro: Integer);
    procedure PesquisarFormaPagamento(lbNome: TComboBox; lbId: TListBox; busca: String; out QtdRegistro: Integer);
    procedure PesquisarContaBancaria(CbNome: TComboBox; lbId: TListBox; out QtdRegistro: Integer);
    function BuscarPorId(objRecebimento : TRecebimento; Id: Integer; out Erro: String): Boolean;
    function Inserir(objRecebimento: TRecebimento; out Erro: string): Boolean;
    function Editar(objRecebimento: TRecebimento; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    function CalcularValorTotal(INSS, IR, HE, Outros, ValorBase: Currency): Currency;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TRecebimentoController }

procedure TRecebimentoController.Listar(lv: TListView; Tipo: Integer);
begin
  RecebimentoDao.Listar(lv, Tipo);
end;

procedure TRecebimentoController.Pesquisar(lv: TListView; Campo, Busca: String; DataInicial, DataFinal: TDateTime; Tipo: Integer);
begin
  RecebimentoDao.Pesquisar(lv, campo, busca, DataInicial, DataFinal, Tipo);
end;

procedure TRecebimentoController.PesquisarPagador(lbNome: TComboBox; lbId: TListBox;
  busca: String; out QtdRegistro: Integer);
begin
  RecebimentoDao.PesquisaGenerica(TB_PARTICIPANTE, lbNome, lbId, busca, 10, QtdRegistro);
end;

procedure TRecebimentoController.PesquisarFormaPagamento(lbNome: TComboBox;
  lbId: TListBox; busca: String; out QtdRegistro: Integer);
begin
  RecebimentoDao.PesquisaGenerica(TB_FORMA_PGTO, lbNome, lbId, busca, 10, QtdRegistro);
end;

procedure TRecebimentoController.PesquisarContaBancaria(CbNome: TComboBox;
  lbId: TListBox; out QtdRegistro: Integer);
begin
  RecebimentoDao.PesquisarContaBancaria(CbNome, lbId, '', -1, QtdRegistro);
end;

function TRecebimentoController.BuscarPorId(objRecebimento: TRecebimento; Id: Integer; out
  Erro: String): Boolean;
begin
  Result := RecebimentoDao.BuscarPorId(objRecebimento, Id, Erro);
end;

function TRecebimentoController.Inserir(objRecebimento: TRecebimento; out Erro: string): Boolean;
begin
  objRecebimento.UsuarioCadastro.Id := dmConexao1.Usuario.Id;
  objRecebimento.DonoCadastro.Id    := dmConexao1.DonoCadastro.Id;
  Result := RecebimentoDao.Inserir(objRecebimento, Erro);
end;

function TRecebimentoController.Editar(objRecebimento: TRecebimento; out Erro: string): Boolean;
begin
  Result := RecebimentoDao.Editar(objRecebimento, Erro);
end;

function TRecebimentoController.Excluir(Id: Integer; out Erro: string): Boolean;
begin
  Result := RecebimentoDao.Excluir(Id, Erro);
end;

function TRecebimentoController.CalcularValorTotal(INSS, IR, HE, Outros,
  ValorBase: Currency): Currency;
begin
  Result := (ValorBase + HE + Outros) - (INSS + IR);
end;

constructor TRecebimentoController.Create;
begin
  Recebimento    := TRecebimento.Create;
  RecebimentoDao := TRecebimentoDAO.Create;
end;

destructor TRecebimentoController.Destroy;
begin
  Recebimento.Free;
  RecebimentoDao.Free;
  inherited Destroy;
end;

end.

