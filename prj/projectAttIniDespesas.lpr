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

program projectAttIniDespesas;

{$mode objfpc}{$H+}

uses
  Classes, SysUtils, controller.principal;

var
  Ctrl: TPrincipalController;

  ParDriver1:   String;
  ParServidor1: String;
  ParPorta1:    Integer;
  ParBanco1:    String;
  ParUsuario1:  String;
  ParSenha1:    String;
  ParNomeDLL1:  String;

  ParDriver2:   String;
  ParServidor2: String;
  ParPorta2:    Integer;
  ParBanco2:    String;
  ParUsuario2:  String;
  ParSenha2:    String;
  ParNomeDLL2:  String;

begin

  ParDriver1      := ParamStr(1);
  ParServidor1    := ParamStr(2);
  ParPorta1       := StrToIntDef(ParamStr(3), 0);
  ParBanco1       := ParamStr(4);
  ParUsuario1     := ParamStr(5);
  ParSenha1       := ParamStr(6);
  ParNomeDLL1     := ParamStr(7);

  ParDriver2      := ParamStr(8);
  ParServidor2    := ParamStr(9);
  ParPorta2       := StrToIntDef(ParamStr(10), 0);
  ParBanco2       := ParamStr(11);
  ParUsuario2     := ParamStr(12);
  ParSenha2       := ParamStr(13);
  ParNomeDLL2     := ParamStr(14);

  Ctrl := TPrincipalController.Create;
  try
    if ParDriver1 <> '' then
    begin

      Ctrl.INI.Driver1   := ParDriver1;
      Ctrl.INI.Servidor1 := ParServidor1;
      Ctrl.INI.Porta1    := ParPorta1;
      Ctrl.INI.Banco1    := ParBanco1;
      Ctrl.INI.Usuario1  := ParUsuario1;
      Ctrl.INI.Senha1    := ParSenha1;
      Ctrl.INI.NomeDLL1  := ParNomeDLL1;

      Ctrl.INI.Driver2   := ParDriver2;
      Ctrl.INI.Servidor2 := ParServidor2;
      Ctrl.INI.Porta2    := ParPorta2;
      Ctrl.INI.Banco2    := ParBanco2;
      Ctrl.INI.Usuario2  := ParUsuario2;
      Ctrl.INI.Senha2    := ParSenha2;
      Ctrl.INI.NomeDLL2  := ParNomeDLL2;

      Ctrl.INI.Escrever;

    end;
  finally
    Ctrl.Free;
  end;

end.

