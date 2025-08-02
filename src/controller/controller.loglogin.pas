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

unit controller.loglogin;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, model.dao.login, model.entity.login;

type

  { TLogLoginController }

  TLogLoginController = class
  private
    LoginDAO: TLoginDAO;
  public
    Login: TLogin;
    procedure Listar(lv: TListView);
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TLogLoginController }

procedure TLogLoginController.Listar(lv: TListView);
begin
  LoginDAO.Listar(lv);
end;

constructor TLogLoginController.Create;
begin
  LoginDAO := TLoginDAO.Create;
end;

destructor TLogLoginController.Destroy;
begin
  LoginDAO.Free;
  inherited Destroy;
end;

end.
