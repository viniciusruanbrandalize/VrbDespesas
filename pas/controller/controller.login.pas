unit controller.login;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, model.dao.login, model.entity.login,
  model.entity.usuario;

type

  { TLoginController }

  TLoginController = class
  private
    LoginDAO: TLoginDAO;
  public
    Login: TLogin;
    Usuario: TUsuario;
    function EncontrarUsuario(objUsuario: TUsuario; Nome: String; out Erro: String): Boolean;
    function VerificarUsuarioSenha(objUsuario: TUsuario; Senha: String; out Erro: String): Boolean;
    function InserirLogin(objLogin: TLogin; out Erro: String): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TLoginController }

constructor TLoginController.Create;
begin
  LoginDAO := TLoginDAO.Create;
end;

destructor TLoginController.Destroy;
begin
  LoginDAO.Free;
  inherited Destroy;
end;

end.
