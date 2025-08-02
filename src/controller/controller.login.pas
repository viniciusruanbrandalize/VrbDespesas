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

unit controller.login;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, model.dao.padrao, model.dao.login,
  model.entity.login, model.entity.usuario, lib.bcrypt,
  model.connection.conexao1, model.entity.usuariodonocadastro;

type

  { TLoginController }

  TLoginController = class
  private
    LoginDAO: TLoginDAO;
  public
    Login: TLogin;
    Usuario: TUsuario;
    function FazerLogin(objUsuario: TUsuario; Nome, Senha: String; out Erro: String): Boolean;
    function Inserir(objLogin: TLogin; out Erro: String): Boolean;
    function ListarDonoCadastro(DonoCadastro: TUsuarioDonoCadastroLista; IdUsuario: Integer; out Erro: String): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TLoginController }

function TLoginController.FazerLogin(objUsuario: TUsuario; Nome, Senha: String;
  out Erro: String): Boolean;
var
  Valida: Boolean;
begin
  valida := false;
  if LoginDAO.EncontrarUsuario(objUsuario, Nome, Erro) then
  begin
    valida := lib.bcrypt.compareHashBCrypt(PChar(Senha), PChar(objUsuario.Senha));
    if not valida then
      erro := 'Senha incorreta!'
    else
    begin
      dmConexao1.Usuario.id   := objUsuario.Id;
      dmConexao1.Usuario.Nome := objUsuario.Nome;
      valida := ListarDonoCadastro(dmConexao1.UsuarioDC, objUsuario.Id, Erro);
    end;
  end;
  Result := Valida;
end;

function TLoginController.Inserir(objLogin: TLogin; out Erro: String
  ): Boolean;
begin
  Result := LoginDAO.Inserir(objLogin, Erro);
end;

function TLoginController.ListarDonoCadastro(
  DonoCadastro: TUsuarioDonoCadastroLista; IdUsuario: Integer; out Erro: String
  ): Boolean;
begin
  Result := LoginDAO.ListarDonoCadastro(DonoCadastro, IdUsuario, Erro);
end;

constructor TLoginController.Create;
begin
  Login    := TLogin.Create;
  LoginDAO := TLoginDAO.Create;
  Usuario  := TUsuario.Create;
end;

destructor TLoginController.Destroy;
begin
  LoginDAO.Free;
  Login.Free;
  Usuario.Free;
  inherited Destroy;
end;

end.
