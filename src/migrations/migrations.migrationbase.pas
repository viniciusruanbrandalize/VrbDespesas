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
  Classes, SysUtils, migrations.conexao;

type

  { TMigration }

  TMigration = class
  public
    ListaSQL: Array of String;
    function Versao: Integer; virtual; abstract;
    procedure AdicionarSQLNaLista; virtual; abstract;
    procedure ExecutarSQL;
  end;

implementation

{ TMigration }

procedure TMigration.ExecutarSQL;
var
  i: Integer;
begin
  AdicionarSQLNaLista;
  dmMigration.SQLTransaction.StartTransaction;
  try
    for i := Low(ListaSQL) to High(ListaSQL) do
    begin
      dmMigration.SQLQuery.SQL.Clear;
      dmMigration.SQLQuery.SQL.Text := ListaSQL[i];
      dmMigration.SQLQuery.ExecSQL;
    end;
    dmMigration.SQLTransaction.Commit;
  except
    dmMigration.SQLTransaction.Rollback;
  end;
end;

end.

