unit controller.usuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, model.entity.usuario,
  model.dao.usuario;

type

  { TUsuarioController }

  TUsuarioController = class
  private
    UsuarioDAO: TUsuarioDAO;
  public
    Usuario: TUsuario;
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    function BuscarPorId(objUsuario : TUsuario; Id: Integer; out Erro: String): Boolean;
    function Inserir(objUsuario : TUsuario; out Erro: string): Boolean;
    function Editar(objUsuario : TUsuario; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
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
  objUsuario.Id := UsuarioDAO.GerarId('gen_id_usuario');
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

constructor TUsuarioController.Create;
begin
  Usuario    := TUsuario.Create;
  UsuarioDAO := TUsuarioDAO.Create;
end;

destructor TUsuarioController.Destroy;
begin
  Usuario.Free;
  UsuarioDAO.Free;
  inherited Destroy;
end;

end.
