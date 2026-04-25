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

unit migrations.migration002;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, migrations.migrationbase, migrations.conexao;

type

  { TMigration002 }

  TMigration002 = class(TMigration)
  public
    function Versao: Integer; override;
    procedure AdicionarSQLNaLista; override;
  end;

implementation

function TMigration002.Versao: Integer;
begin
  Result := 2;
end;

procedure TMigration002.AdicionarSQLNaLista;
begin
  if dmMigration.Driver = 'FIREBIRD' then
  begin

  end;
end;

end.

