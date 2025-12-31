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

unit model.dao.usuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, SQLDB, model.entity.usuario,
  model.dao.padrao, model.connection.conexao1, CheckLst, StdCtrls,
  model.entity.uctela, model.entity.ucacao, model.entity.usuariodonocadastro;

type

  { TUsuarioDAO }

  TUsuarioDAO = class(TPadraoDAO)
  private

  public
    procedure Listar(lv: TListView); override;
    procedure Pesquisar(lv: TListView; Campo, Busca: String); override;
    procedure ListarDevedores(var lbNome: TListBox; var lbTitulo: TCheckListBox);
    procedure BuscarDevedorPorUsuario(var lbNome: TListBox; var lbTitulo: TCheckListBox; IdUsuario: Integer);
    function BuscarPorId(Usuario : TUsuario; Id: Integer; out Erro: String): Boolean;
    function Inserir(Usuario : TUsuario; out Erro: string): Boolean;
    function Editar(Usuario : TUsuario; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    function InserirDevedor(UsuarioDevedor : TUsuarioDonoCadastro; out Erro: string): Boolean;
    function ExcluirDevedor(UsuarioDevedor : TUsuarioDonoCadastro; out Erro: string): Boolean;
    function UsuarioDevedorJaExiste(UsuarioDevedor : TUsuarioDonoCadastro): Boolean;
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

{ TUsuarioDAO }

procedure TUsuarioDAO.Listar(lv: TListView);
var
  sql: String;
  item : TListItem;
begin
  try

    sql := 'select * from usuario ' +
           'where excluido = false ' +
           'order by nome '+Collate();

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.Open;

    Qry.First;

    while not Qry.EOF do
    begin
      item := lv.Items.Add;
      item.Caption := Qry.FieldByName('id').AsString;
      item.SubItems.Add(qry.FieldByName('nome').AsString);
      item.SubItems.Add(qry.FieldByName('cadastro').AsString);
      Qry.Next;
    end;

  finally
    Qry.Close;
  end;
end;

procedure TUsuarioDAO.Pesquisar(lv: TListView; Campo, Busca: String);
var
  sql: String;
  item : TListItem;
  valor: Double;
begin
  try

    if TryStrToFloat(Busca, valor) then
    begin
      sql := 'select * from usuario ' +
             'where '+campo+' = :busca and excluido = :excluido '+
             'order by nome '+Collate();
    end
    else
    begin
      sql := 'select * from usuario ' +
             'where '+ILikeSQL(Campo, 'busca')+' and excluido = :excluido '+
             'order by nome '+Collate();
    end;

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('busca').AsString := '%'+UpperCase(Busca)+'%';
    Qry.Open;

    Qry.First;

    while not Qry.EOF do
    begin
      item := lv.Items.Add;
      item.Caption := Qry.FieldByName('id').AsString;
      item.SubItems.Add(qry.FieldByName('nome').AsString);
      item.SubItems.Add(qry.FieldByName('cadastro').AsString);
      Qry.Next;
    end;

  finally
    qry.Close;
  end;
end;

procedure TUsuarioDAO.ListarDevedores(var lbNome: TListBox;
  var lbTitulo: TCheckListBox);
var
  sql: String;
begin
  try

    sql := 'select id, nome, fantasia from participante ' +
           'where excluido = false and dono_cadastro ' +
           'order by nome '+Collate();

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.Open;

    lbTitulo.Items.Clear;
    lbNome.Items.Clear;

    Qry.First;

    while not Qry.EOF do
    begin
      lbTitulo.Items.Add(qry.FieldByName('nome').AsString);
      lbNome.Items.Add(qry.FieldByName('id').AsString);
      Qry.Next;
    end;

  finally
    Qry.Close;
  end;
end;

procedure TUsuarioDAO.BuscarDevedorPorUsuario(var lbNome: TListBox;
  var lbTitulo: TCheckListBox; IdUsuario: Integer);
var
  sql: String;
begin
  try

    sql := 'select p.id, p.nome, p.fantasia from participante p ' +
           'left join usuario_dono_cadastro usd on usd.id_dono_cadastro = p.id ' +
           'where usd.id_usuario = :id_usuario and p.excluido = false and ' +
           'p.dono_cadastro ' +
           'order by p.nome '+Collate();

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id_usuario').AsInteger := IdUsuario;
    Qry.Open;

    lbTitulo.Items.Clear;
    lbNome.Items.Clear;

    Qry.First;

    while not Qry.EOF do
    begin
      lbTitulo.Items.Add(qry.FieldByName('nome').AsString);
      lbNome.Items.Add(qry.FieldByName('id').AsString);
      Qry.Next;
    end;

  finally
    Qry.Close;
  end;
end;

function TUsuarioDAO.BuscarPorId(Usuario : TUsuario; Id: Integer; out Erro: String): Boolean;
var
  sql: String;
begin
  try

    sql := 'select * from usuario ' +
           'where id = :id and excluido = :excluido ' +
           'order by id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger := id;
    Qry.ParamByName('excluido').AsBoolean := false;
    Qry.Open;

    if Qry.RecordCount = 1 then
    begin
      Usuario.Id       := Qry.FieldByName('id').AsInteger;
      Usuario.Nome     := Qry.FieldByName('nome').AsString;
      Usuario.Senha    := Qry.FieldByName('senha').AsString;
      Usuario.Email    := Qry.FieldByName('email').AsString;
      Usuario.Cadastro := Qry.FieldByName('cadastro').AsDateTime;
      Usuario.Alteracao := Qry.FieldByName('alteracao').AsDateTime;
      Result := True;
    end
    else
    if Qry.RecordCount > 1 then
    begin
      Erro := 'Mais de um objeto foi retornado na busca por código!';
      Result := False;
    end
    else
    begin
      Erro := 'Nenhum objeto foi encontrado!';
      Result := False;
    end;

  finally
    Qry.Close;
  end;
end;

function TUsuarioDAO.Inserir(Usuario : TUsuario; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'insert into usuario(id, nome, senha, email, cadastro, excluido) values ' +
           '(:id, :nome, :senha, :email, :cadastro, :excluido)';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);

    if not AutoInc then
    begin
      Usuario.Id := GerarId(SEQ_ID_USUARIO);
      Qry.ParamByName('id').AsInteger := Usuario.Id;
    end;

    Qry.ParamByName('nome').AsString       := Usuario.Nome;
    Qry.ParamByName('senha').AsString      := Usuario.Senha;
    Qry.ParamByName('email').AsString      := Usuario.Email;
    Qry.ParamByName('cadastro').AsDateTime := Usuario.Cadastro;
    Qry.ParamByName('excluido').AsBoolean  := Usuario.Excluido;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao inserir usuário: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TUsuarioDAO.Editar(Usuario : TUsuario; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'update usuario set nome = :nome, ' +
           'email = :email, senha = :senha, alteracao = :alteracao ' +
           'where id = :id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger         := Usuario.Id;
    Qry.ParamByName('nome').AsString        := Usuario.Nome;
    Qry.ParamByName('senha').AsString       := Usuario.Senha;
    Qry.ParamByName('email').AsString       := Usuario.Email;
    Qry.ParamByName('alteracao').AsDateTime := Usuario.Alteracao;   //Now

    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      dmConexao1.SQLTransaction.Rollback;
      Erro := 'Ocorreu um erro ao alterar usuário: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TUsuarioDAO.Excluir(Id: Integer; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'delete from usuario where id = :id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger  := Id;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      try

        sql := 'update usuario set excluido = true where id = :id';

        Qry.Close;
        Qry.SQL.Clear;
        Qry.SQL.Add(sql);
        Qry.ParamByName('id').AsInteger  := Id;
        Qry.ExecSQL;
        dmConexao1.SQLTransaction.Commit;

        Result := True;

      except on E: Exception do
        begin
          Erro := 'Ocorreu um erro ao excluir usuário: ' + sLineBreak + E.Message;
          Result := False;
        end;
      end;
    end;
  end;
end;

function TUsuarioDAO.InserirDevedor(UsuarioDevedor: TUsuarioDonoCadastro;
  out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'insert into usuario_dono_cadastro(id, id_usuario, id_dono_cadastro, ' +
           'cadastro) values (:id, :id_usuario, :id_dono_cadastro, :cadastro)';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);

    if not AutoInc then
    begin
      UsuarioDevedor.Id := GerarId(SEQ_ID_USUARIO_DONO_CADASTRO);
      Qry.ParamByName('id').AsInteger := UsuarioDevedor.Id;
    end;

    Qry.ParamByName('id_usuario').AsInteger       := UsuarioDevedor.Usuario.Id;
    Qry.ParamByName('id_dono_cadastro').AsInteger := UsuarioDevedor.DonoCadastro.Id;
    Qry.ParamByName('cadastro').AsDateTime        := UsuarioDevedor.Cadastro;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao inserir acessos ao devedor: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TUsuarioDAO.ExcluirDevedor(UsuarioDevedor : TUsuarioDonoCadastro; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'delete from usuario_dono_cadastro ' +
           'where id_dono_cadastro = :id_dono_cadastro and id_usuario = :id_usuario';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id_dono_cadastro').AsInteger  := UsuarioDevedor.DonoCadastro.Id;
    Qry.ParamByName('id_usuario').AsInteger        := UsuarioDevedor.Usuario.Id;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao excluir acesso ao devedor: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TUsuarioDAO.UsuarioDevedorJaExiste(UsuarioDevedor: TUsuarioDonoCadastro): Boolean;
var
  sql: String;
begin
  try

    sql := 'select id from usuario_dono_cadastro ' +
           'where id_dono_cadastro = :id_dono_cadastro and ' +
           'id_usuario = :id_usuario ' +
           'order by id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id_usuario').AsInteger       := UsuarioDevedor.Usuario.Id;
    Qry.ParamByName('id_dono_cadastro').AsInteger := UsuarioDevedor.DonoCadastro.Id;
    Qry.Open;

    Result := Qry.RecordCount > 0;

  finally
    Qry.Close;
  end;
end;

constructor TUsuarioDAO.Create;
begin
  inherited;
end;

destructor TUsuarioDAO.Destroy;
begin
  inherited Destroy;
end;

end.

