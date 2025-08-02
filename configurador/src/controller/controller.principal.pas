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

unit controller.principal;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.ini.conexao;

type

  { TPrincipalController }

  TPrincipalController = class
  private
    FINI: TConexaoINI;
  public
    property INI: TConexaoINI read FINI write FINI;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TPrincipalController }

constructor TPrincipalController.Create;
begin
  FINI := TConexaoINI.Create;
end;

destructor TPrincipalController.Destroy;
begin
  inherited Destroy;
  FreeAndNil(FINI);
end;

end.

