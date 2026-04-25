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

unit migrations.migrationbase;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, migrations.conexao;

type

  { TMigration }

  TMigration = class
  private
    procedure GravarLog(Status, SQL, Erro: String; Tempo: Real);
    procedure AtualizarNumeroVersao;
    procedure ApagarLogAnterior;
  public
    ListaSQL: Array of String;
    function Versao: Integer; virtual; abstract;
    procedure AdicionarSQLNaLista; virtual; abstract;
    procedure ExecutarSQL;
  end;

implementation

{ TMigration }

procedure TMigration.GravarLog(Status, SQL, Erro: String; Tempo: Real);
begin
  dmMigration.SQLTransactionAtualizacao.StartTransaction;
  try
    dmMigration.qryAtualizacao.SQL.Clear;
    dmMigration.qryAtualizacao.SQL.Text :=
      'insert into log_atualizacao ' +
      '(id, versao, data_execucao, status, sql_executado, erro, tempo_execucao) values ' +
      '(:id, :versao, :data_execucao, :status, :sql_executado, :erro, :tempo_execucao)';
    dmMigration.qryAtualizacao.ParamByName('id').AsInteger := 0;
    dmMigration.qryAtualizacao.ParamByName('versao').AsString := Versao.ToString;
    dmMigration.qryAtualizacao.ParamByName('data_execucao').AsDateTime := Now;
    dmMigration.qryAtualizacao.ParamByName('status').AsString := Status;
    dmMigration.qryAtualizacao.ParamByName('sql_executado').AsString := SQL;
    dmMigration.qryAtualizacao.ParamByName('tempo_execucao').AsFloat := Tempo;
    dmMigration.qryAtualizacao.ParamByName('erro').AsString := Erro;
    dmMigration.qryAtualizacao.ExecSQL;
    dmMigration.SQLTransactionAtualizacao.Commit;
  except
    dmMigration.SQLTransactionAtualizacao.Rollback;
  end;
end;

procedure TMigration.AtualizarNumeroVersao;
begin
  dmMigration.SQLTransactionAtualizacao.StartTransaction;
  try
    dmMigration.qryAtualizacao.SQL.Clear;
    dmMigration.qryAtualizacao.SQL.Text :=
      'update configuracao set valor = :valor where nome = :nome';
    dmMigration.qryAtualizacao.ParamByName('valor').AsString := Versao.ToString;
    dmMigration.qryAtualizacao.ParamByName('nome').AsString := 'NUMERO_VERSAO_DB';
    dmMigration.qryAtualizacao.ExecSQL;
    dmMigration.SQLTransactionAtualizacao.Commit;
  except
    dmMigration.SQLTransactionAtualizacao.Rollback;
  end;
end;

procedure TMigration.ApagarLogAnterior;
begin
  dmMigration.SQLTransactionAtualizacao.StartTransaction;
  try
    dmMigration.qryAtualizacao.SQL.Clear;
    dmMigration.qryAtualizacao.SQL.Text :=
      'delete from log_atualizacao where versao = :versao';
    dmMigration.qryAtualizacao.ParamByName('versao').AsString := Versao.ToString;
    dmMigration.qryAtualizacao.ExecSQL;
    dmMigration.SQLTransactionAtualizacao.Commit;
  except
    dmMigration.SQLTransactionAtualizacao.Rollback;
  end;
end;

procedure TMigration.ExecutarSQL;
var
  i: Integer;
begin
  AdicionarSQLNaLista;
  if Versao <> 1 then
    ApagarLogAnterior;
  dmMigration.SQLTransaction.StartTransaction;
  try
    for i := Low(ListaSQL) to High(ListaSQL) do
    begin
      dmMigration.SQLQuery.SQL.Clear;
      dmMigration.SQLQuery.SQL.Text := ListaSQL[i];
      try
        dmMigration.SQLQuery.ExecSQL;
        if Versao <> 1 then
          GravarLog('SUCESSO', ListaSQL[i], '', 0);
      except on ex: Exception do
        begin
          if Versao <> 1 then
            GravarLog('FALHA', ListaSQL[i], ex.Message, 0);
        end;
      end;
    end;
    dmMigration.SQLTransaction.Commit;
    AtualizarNumeroVersao;
  except
    dmMigration.SQLTransaction.Rollback;
  end;
end;

end.

