unit controller.usuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, model.entity.usuario, lib.bcrypt, lib.types,
  model.dao.padrao, model.dao.usuario, controller.usuarioacesso;

type

  { TUsuarioController }

  TUsuarioController = class
  private
    UsuarioDAO: TUsuarioDAO;
  public
    Usuario: TUsuario;
    ControleAcesso: TUsuarioAcessoController;
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    function BuscarPorId(objUsuario : TUsuario; Id: Integer; out Erro: String): Boolean;
    function Inserir(objUsuario : TUsuario; out Erro: string): Boolean;
    function Editar(objUsuario : TUsuario; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    function ValidarSenha(Senha1, Senha2 : String; Operacao: TOperacaoCRUD; out Erro: String): Boolean;
    function CriptografarSenha(Senha: String): String;
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
            lib.bcrypt.compareHashBCrypt(Pchar(Senha1),
                                       Pchar(UsuarioBusca.Senha),
                                       SenhaValida);
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
var
  SenhaCriptografada: PChar;
begin
  lib.bcrypt.encryptBCrypt(PChar(Senha), SenhaCriptografada);
  Result := SenhaCriptografada;
end;

constructor TUsuarioController.Create;
begin
  Usuario    := TUsuario.Create;
  UsuarioDAO := TUsuarioDAO.Create;
  ControleAcesso := TUsuarioAcessoController.Create;
end;

destructor TUsuarioController.Destroy;
begin
  Usuario.Free;
  UsuarioDAO.Free;
  ControleAcesso.Free;
  inherited Destroy;
end;

end.
