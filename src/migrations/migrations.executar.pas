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

unit migrations.executar;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils, SQLDB, migrations.conexao, migrations.migrationbase,
  migrations.migration001;

  procedure ExecutarAtualizacaoBanco(SQLConnector: TSQLConnector; Conexao: Integer = 1);
  function getVersaoAtual: Integer;

implementation

function getVersaoAtual: Integer;
begin
  try
    dmMigration.SQLQuery.SQL.Text := 'SELECT valor AS versao FROM configuracao ' +
                                     'WHERE nome = ''NUMERO_VERSAO_DB''';
    dmMigration.SQLQuery.Open;
    Result := dmMigration.SQLQuery.FieldByName('versao').AsInteger;
    dmMigration.SQLQuery.Close;
  except
    Result := 0;
  end;
end;

procedure ExecutarAtualizacaoBanco(SQLConnector: TSQLConnector; Conexao: Integer = 1);
var
  VersaoAtual: Integer;
  Migrations: array of TMigration;
  I: Integer;
begin
  dmMigration := TdmMigration.Create(nil, SQLConnector);
  try

    VersaoAtual := getVersaoAtual;

    SetLength(Migrations, 2);
    Migrations[0] := TMigration001.Create;
    //Migrations[1] := TMigration002.Create;

    for I := 0 to High(Migrations) do
    begin
      if Migrations[I].Versao > VersaoAtual then
        Migrations[I].ExecutarSQL;
    end;

    for I := 0 to High(Migrations) do
      Migrations[I].Free;

  finally
    dmMigration.Free;
  end;
end;

end.

