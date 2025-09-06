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

unit controller.usuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, model.entity.usuario, lib.bcrypt, lib.types,
  model.dao.padrao, model.dao.usuario, controller.usuarioacesso, StdCtrls,
  CheckLst, model.entity.usuariodonocadastro;

type

  { TUsuarioController }

  TUsuarioController = class
  private
    UsuarioDAO: TUsuarioDAO;
  public
    Usuario: TUsuario;
    UsuarioDevedor: TUsuarioDonoCadastro;
    ControleAcesso: TUsuarioAcessoController;
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    function BuscarPorId(objUsuario : TUsuario; Id: Integer; out Erro: String): Boolean;
    function Inserir(objUsuario : TUsuario; out Erro: string): Boolean;
    function Editar(objUsuario : TUsuario; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    function ValidarSenha(Senha1, Senha2 : String; Operacao: TOperacaoCRUD; out Erro: String): Boolean;
    function CriptografarSenha(Senha: String): String;
    procedure BuscarDevedorPorUsuario(var lbNome: TListBox; var lbTitulo: TCheckListBox; IdUsuario: Integer);
    procedure ListarDevedores(var lbNome: TListBox; var lbTitulo: TCheckListBox);
    function InserirDevedor(objUsuarioDevedor : TUsuarioDonoCadastro; out Erro: string): Boolean;
    function ExcluirDevedor(objUsuarioDevedor : TUsuarioDonoCadastro; out Erro: string): Boolean;
    function UsuarioDevedorJaExiste(objUsuarioDevedor : TUsuarioDonoCadastro): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TUsuarioController }

procedure TUsuarioController.Listar(lv: TListView);
begin
  UsuarioDAO.Listar(lv);
end;

procedure TUsuarioController.Pesquisar(lv: TListView; Campo, Busca: String);
begin
  UsuarioDAO.Pesquisar(lv, Campo, Busca);
end;

function TUsuarioController.BuscarPorId(objUsuario: TUsuario; Id: Integer; out
  Erro: String): Boolean;
begin
  Result := UsuarioDAO.BuscarPorId(objUsuario, Id, Erro);
end;

function TUsuarioController.Inserir(objUsuario: TUsuario; out Erro: string): Boolean;
begin
  Result := UsuarioDAO.Inserir(objUsuario, Erro);
end;

function TUsuarioController.Editar(objUsuario: TUsuario; out Erro: string): Boolean;
begin
  Result := UsuarioDAO.Editar(objUsuario, Erro);
end;

function TUsuarioController.Excluir(Id: Integer; out Erro: string): Boolean;
begin
  Result := UsuarioDAO.Excluir(Id, Erro);
end;

function TUsuarioController.ValidarSenha(Senha1, Senha2: String; Operacao: TOperacaoCRUD;
  out Erro: String): Boolean;
var
  UsuarioBusca: TUsuario;
  SenhaValida: Boolean;
begin
  UsuarioBusca := TUsuario.Create;
  SenhaValida := False;
  try
    if (Trim(Senha1) <> '') and (Trim(Senha2) <> '') then
    begin
      case Operacao of
        opInserir:
        begin
          SenhaValida := (Senha1 = Senha2);
          if not SenhaValida then
            Erro := 'Senha difere da confirmação de senha!';
        end;
        opEditar:
        begin
          if BuscarPorId(UsuarioBusca, Usuario.Id, Erro) then
          begin
            SenhaValida := lib.bcrypt.compareHashBCrypt(Pchar(Senha1),
                                                        Pchar(UsuarioBusca.Senha));
            if not SenhaValida then
              Erro := 'Nova Senha difere da senha atual!';
          end;
        end;
      end;
    end
    else
    begin
      Erro := 'Verifique se os campos de senhas estão preenchidos!';
      SenhaValida := False;
    end;
    Result := SenhaValida;
  finally
    UsuarioBusca.Free;
  end;
end;

function TUsuarioController.CriptografarSenha(Senha: String): String;
begin
  Result := lib.bcrypt.encryptBCrypt(PChar(Senha));
end;

procedure TUsuarioController.BuscarDevedorPorUsuario(var lbNome: TListBox;
  var lbTitulo: TCheckListBox; IdUsuario: Integer);
begin
  UsuarioDAO.BuscarDevedorPorUsuario(lbNome, lbTitulo, IdUsuario);
end;

procedure TUsuarioController.ListarDevedores(var lbNome: TListBox;
  var lbTitulo: TCheckListBox);
begin
  UsuarioDAO.ListarDevedores(lbNome, lbTitulo);
end;

function TUsuarioController.InserirDevedor(
  objUsuarioDevedor: TUsuarioDonoCadastro; out Erro: string): Boolean;
begin
  Result := UsuarioDAO.InserirDevedor(objUsuarioDevedor, Erro);
end;

function TUsuarioController.ExcluirDevedor(
  objUsuarioDevedor: TUsuarioDonoCadastro; out Erro: string): Boolean;
begin
  Result := UsuarioDAO.ExcluirDevedor(objUsuarioDevedor, Erro);
end;

function TUsuarioController.UsuarioDevedorJaExiste(
  objUsuarioDevedor: TUsuarioDonoCadastro): Boolean;
begin
  Result := UsuarioDAO.UsuarioDevedorJaExiste(objUsuarioDevedor);
end;

constructor TUsuarioController.Create;
begin
  Usuario    := TUsuario.Create;
  UsuarioDevedor := TUsuarioDonoCadastro.Create;
  UsuarioDAO := TUsuarioDAO.Create;
  ControleAcesso := TUsuarioAcessoController.Create;
end;

destructor TUsuarioController.Destroy;
begin
  Usuario.Free;
  UsuarioDevedor.Free;
  UsuarioDAO.Free;
  ControleAcesso.Free;
  inherited Destroy;
end;

end.
