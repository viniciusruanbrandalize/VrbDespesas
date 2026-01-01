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

unit model.dao.login;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, SQLDB, model.entity.login, model.entity.usuario,
  model.entity.usuariodonocadastro, model.connection.conexao1, model.dao.padrao;

type

  { TLoginDAO }

  TLoginDAO = class(TPadraoDAO)
  private

  public
    procedure Listar(lv: TListView); override;
    function Inserir(Login : TLogin; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    function EncontrarUsuario(Usuario: TUsuario; Nome: String; out Erro: String): Boolean;
    function ListarDonoCadastro(DonoCadastro: TUsuarioDonoCadastroLista; IdUsuario: Integer; out Erro: String): Boolean;
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

{ TLoginDAO }

procedure TLoginDAO.Listar(lv: TListView);
var
  sql: String;
  item : TListItem;
begin
  try

    if Driver = DRV_FIREBIRD then
    begin
      sql := 'select first 20 l.*, u.nome as nome_usuario from login l ' +
             'left join usuario u on l.id_usuario = u.id ' +
             'order by data desc, hora desc';
    end
    else
    if Driver in [DRV_MYSQL, DRV_MARIADB, DRV_POSTGRESQL, DRV_SQLITE3] then
    begin
      sql := 'select l.*, u.nome as nome_usuario from login l ' +
             'left join usuario u on l.id_usuario = u.id ' +
             'order by data desc, hora desc ' +
             'limit 20 ';
    end;

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.Open;

    Qry.First;

    while not Qry.EOF do
    begin
      item := lv.Items.Add;
      item.Caption := Qry.FieldByName('id').AsString;
      item.SubItems.Add(qry.FieldByName('data').AsString);
      item.SubItems.Add(qry.FieldByName('hora').AsString);
      item.SubItems.Add(qry.FieldByName('nome_pc').AsString);
      item.SubItems.Add(qry.FieldByName('ip_pc').AsString);
      item.SubItems.Add(qry.FieldByName('nome_usuario').AsString);
      Qry.Next;
    end;

  finally
    Qry.Close;
  end;
end;

function TLoginDAO.Inserir(Login : TLogin; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'insert into login(id, nome_pc, ip_pc, data, hora, id_usuario) values ' +
           '(:id, :nome_pc, :ip_pc, :data, :hora, :id_usuario)';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);

    if not AutoInc then
    begin
      Login.Id := GerarId(SEQ_ID_LOGIN);
      Qry.ParamByName('id').AsInteger := Login.Id;
    end;

    Qry.ParamByName('nome_pc').AsString     := Login.NomePC;
    Qry.ParamByName('ip_pc').AsString       := Login.IPPC;
    Qry.ParamByName('data').AsDateTime      := Login.Data;
    Qry.ParamByName('hora').AsDateTime      := Login.Hora;
    Qry.ParamByName('id_usuario').AsInteger := Login.Usuario.Id;
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

function TLoginDAO.Excluir(Id: Integer; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'delete from login where id = :id';

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

function TLoginDAO.EncontrarUsuario(Usuario: TUsuario; Nome: String; out
  Erro: String): Boolean;
var
  sql: String;
begin
  try

    sql := 'select * from usuario ' +
           'where nome = :busca and excluido = false ' +
           'order by id asc';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('busca').AsString := Nome;
    Qry.Open;

    Qry.First;

    if qry.RecordCount > 0 then
    begin
      Usuario.Id        := Qry.FieldByName('id').AsInteger;
      Usuario.Nome      := Qry.FieldByName('nome').AsString;
      Usuario.Senha     := Qry.FieldByName('senha').AsString;
      Usuario.Email     := Qry.FieldByName('email').AsString;
      Usuario.Cadastro  := Qry.FieldByName('cadastro').AsDateTime;
      Usuario.Alteracao := Qry.FieldByName('alteracao').AsDateTime;
      Result := True;
    end
    else
    begin
      Erro := 'Usuário não encontrado!';
      Result := False;
    end;

  finally
    Qry.Close;
  end;
end;

function TLoginDAO.ListarDonoCadastro(DonoCadastro: TUsuarioDonoCadastroLista;
  IdUsuario: Integer; out Erro: String): Boolean;
var
  sql: String;
begin
  try

    sql := 'select udc.*, u.nome as nome_usuario, dc.nome as nome_dono_cadastro ' +
           'from usuario_dono_cadastro udc ' +
           'left join usuario u on u.id = udc.id_usuario ' +
           'left join participante dc on dc.id = udc.id_dono_cadastro ' +
           'where udc.id_usuario = :busca ' +
           'order by dc.nome '+Collate();

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('busca').AsInteger := IdUsuario;
    Qry.Open;

    Qry.First;

    DonoCadastro.Clear;

    if qry.RecordCount > 0 then
    begin
      while not Qry.EOF do
      begin
        DonoCadastro.Add(TUsuarioDonoCadastro.Create);
        with DonoCadastro.Items[Pred(DonoCadastro.Count)] do
        begin
          Id                := Qry.FieldByName('id').AsInteger;
          Usuario.Id        := Qry.FieldByName('id_usuario').AsInteger;
          Usuario.Nome      := Qry.FieldByName('nome_usuario').AsString;
          DonoCadastro.Id   := Qry.FieldByName('id_dono_cadastro').AsInteger;
          DonoCadastro.Nome := Qry.FieldByName('nome_dono_cadastro').AsString;
          Cadastro          := Qry.FieldByName('cadastro').AsDateTime;
        end;
        Qry.Next;
      end;
      Result := True;
    end
    else
    begin
      Erro := 'Usuário não tem acesso à nenhum cadastro!';
      Result := False;
    end;

  finally
    Qry.Close;
  end;
end;

constructor TLoginDAO.Create;
begin
  inherited;
end;

destructor TLoginDAO.Destroy;
begin
  inherited Destroy;
end;

end.

