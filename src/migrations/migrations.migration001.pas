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

unit migrations.migration001;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, migrations.migrationbase, migrations.conexao;

type

  { TMigration001 }

  TMigration001 = class(TMigration)
  public
    function Versao: Integer; override;
    procedure AdicionarSQLNaLista; override;
  end;

implementation

function TMigration001.Versao: Integer;
begin
  Result := 1;
end;

procedure TMigration001.AdicionarSQLNaLista;
begin
  if dmMigration.Driver = 'FIREBIRD' then
  begin

    SetLength(ListaSQL, 3);

    ListaSQL[0] := 'INSERT INTO CONFIGURACAO (ID,NOME,DESCRICAO,USO,VALOR,EXCLUIDO) VALUES ' +
                    '(5, ''NUMERO_VERSAO_DB'', ''Número da versão do banco de dados'', ' +
                    '''Número da versão do banco de dados'', ''0'', false)';

    ListaSQL[1] := 'CREATE GENERATOR GEN_ID_LOG_ATUALIZACAO';

    ListaSQL[2] := 'CREATE TABLE LOG_ATUALIZACAO ( ' +
	            'ID INTEGER NOT NULL, ' +
	            'VERSAO VARCHAR(20) NOT NULL, ' +
	            'DATA_EXECUCAO TIMESTAMP NOT NULL, ' +
	            'STATUS VARCHAR(20) NOT NULL, ' +
	            'SQL_EXECUTADO VARCHAR(5000) NOT NULL, ' +
                    'ERRO VARCHAR(500), ' +
	            'TEMPO_EXECUCAO DECIMAL(10,4) NOT NULL ' +
                    ')';

  end
  else
  if dmMigration.Driver = 'POSTGRESQL' then
  begin

    SetLength(ListaSQL, 3);

    ListaSQL[0] := 'insert into public.configuracao (id,nome,descricao,uso,valor,excluido) values ' +
                    '(5, ''NUMERO_VERSAO_DB'', ''Número da versão do banco de dados'', ' +
                    '''Número da versão do banco de dados'', ''0'', false)';

    ListaSQL[1] := 'create sequence public.seq_id_log_atualizacao ' +
	            'increment by 1 ' +
	            'minvalue 1 ' +
	            'maxvalue 9223372036854775807 ' +
	            'start 1 ' +
	            'cache 1 ' +
	            'no cycle';

    ListaSQL[2] := 'create table public.log_atualizacao ( ' +
	            'id integer not null, ' +
	            'versao varchar(20) not null, ' +
	            'data_execucao timestamp not null, ' +
	            'status varchar(20) not null, ' +
	            'sql_executado varchar(5000) not null, ' +
	            'erro varchar(500), ' +
	            'tempo_execucao decimal(10,4) not null ' +
                    ')';

  end
  else
  if Pos('MYSQL', UpperCase(dmMigration.Driver)) <> 0 then
  begin

    SetLength(ListaSQL, 2);

    ListaSQL[0] := 'insert into configuracao (id,nome,descricao,uso,valor,excluido) values ' +
                    '(5, ''NUMERO_VERSAO_DB'', ''Número da versão do banco de dados'', ' +
                    '''Número da versão do banco de dados'', ''0'', 0)';

    ListaSQL[1] := 'create table log_atualizacao ( ' +
	            'id integer not null, '+
	            'versao varchar(20) not null, ' +
	            'data_execucao timestamp not null, ' +
	            'status varchar(20) not null, ' +
	            'sql_executado varchar(5000) not null, ' +
	            'erro varchar(500), ' +
	            'tempo_execucao decimal(10,4) not null ' +
                    ')';

  end
  else
  if dmMigration.Driver = 'SQLITE3' then
  begin
    SetLength(ListaSQL, 2);

    ListaSQL[0] := 'insert into configuracao (id,nome,descricao,uso,valor,excluido) values ' +
                    '(5, ''NUMERO_VERSAO_DB'', ''Número da versão do banco de dados'', ' +
                    '''Número da versão do banco de dados'', ''0'', false)';

    ListaSQL[1] := 'create table log_atualizacao ( ' +
	            'id integer not null, '+
	            'versao varchar(20) not null, ' +
	            'data_execucao datetime not null, ' +
	            'status varchar(20) not null, ' +
	            'sql_executado varchar(5000) not null, ' +
	            'erro varchar(500), ' +
	            'tempo_execucao decimal(10,4) not null ' +
                    ')';

  end;
end;

end.

