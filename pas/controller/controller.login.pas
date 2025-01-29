unit controller.login;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, model.dao.login, model.entity.login,
  model.entity.usuario, lib.bcrypt, model.connection.conexao1;

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
    lib.bcrypt.compareHashBCrypt(PChar(Senha), PChar(objUsuario.Senha), valida);
    if not valida then
      erro := 'Senha incorreta!'
    else
    begin
      dmConexao1.IdUsuario   := objUsuario.Id;
      dmConexao1.NomeUsuario := objUsuario.Nome;
    end;
  end;
  Result := Valida;
end;

function TLoginController.Inserir(objLogin: TLogin; out Erro: String
  ): Boolean;
begin
  objLogin.Id := LoginDAO.GerarId('gen_id_login');
  Result := LoginDAO.Inserir(objLogin, Erro);
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
