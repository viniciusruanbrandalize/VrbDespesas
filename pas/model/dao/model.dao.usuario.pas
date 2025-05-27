unit model.dao.usuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, SQLDB, model.entity.usuario,
  model.dao.padrao, model.connection.conexao1, CheckLst, StdCtrls,
  model.entity.uctela, model.entity.ucacao;

type

  { TUsuarioDAO }

  TUsuarioDAO = class(TPadraoDAO)
  private

  public
    procedure Listar(lv: TListView); override;
    procedure Pesquisar(lv: TListView; Campo, Busca: String); override;
    function BuscarPorId(Usuario : TUsuario; Id: Integer; out Erro: String): Boolean;
    function Inserir(Usuario : TUsuario; out Erro: string): Boolean;
    function Editar(Usuario : TUsuario; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
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
           'order by nome';

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
             'order by nome';
    end
    else
    begin
      sql := 'select * from usuario ' +
             'where UPPER('+campo+') like :busca and excluido = :excluido '+
             'order by nome';
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

constructor TUsuarioDAO.Create;
begin
  inherited;
end;

destructor TUsuarioDAO.Destroy;
begin
  inherited Destroy;
end;

end.

