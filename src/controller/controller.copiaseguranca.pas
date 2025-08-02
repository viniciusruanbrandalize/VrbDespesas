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

unit controller.copiaseguranca;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, model.dao.copiaseguranca, lib.types;

type

  { TCopiaSegurancaController }

  TCopiaSegurancaController = class
  private
    DAO: TCopiaSegurancaDAO;
  public
    function IniciarBackup(Destino: String; var pgb: TProgressBar; var lblStatus: TLabel; var mLog: TMemo): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TCopiaSegurancaController }

function TCopiaSegurancaController.IniciarBackup(Destino: String;
  var pgb: TProgressBar; var lblStatus: TLabel; var mLog: TMemo): Boolean;
begin
  Result := DAO.FazerBackup(Destino, pgb, lblStatus, mLog, bkpDump);
end;

constructor TCopiaSegurancaController.Create;
begin
  DAO := TCopiaSegurancaDAO.Create;
end;

destructor TCopiaSegurancaController.Destroy;
begin
  FreeAndNil(DAO);
  inherited Destroy;
end;

end.
