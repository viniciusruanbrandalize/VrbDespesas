unit model.dao.login;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, SQLDB, model.entity.login,
  model.connection.conexao1;

type

  { TLoginDAO }

  TLoginDAO = class
  private
    Qry: TSQLQuery;
  public
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    function BuscarPorId(Login : TLogin; Id: Integer; out Erro: String): Boolean;
    function Inserir(Login : TLogin; out Erro: string): Boolean;
    function Editar(Login : TLogin; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    function GerarId(Gerador: String; Incremento: Integer=1): Integer;
    constructor Create;
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

    sql := 'select first 20 l.*, u.nome as nome_usuario from login l ' +
           'left join usuario u on l.id_usuario = u.id ' +
           'order by data desc, hora desc';

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

procedure TLoginDAO.Pesquisar(lv: TListView; Campo, Busca: String);
var
  sql: String;
  item : TListItem;
  valor: Double;
begin
  try

    if TryStrToFloat(Busca, valor) then
    begin
      sql := 'select * from usuario ' +
             'where '+campo+' = :busca '+
             'order by nome';
    end
    else
    begin
      sql := 'select * from usuario ' +
             'where UPPER('+campo+') like :busca '+
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

function TLoginDAO.BuscarPorId(Login : TLogin; Id: Integer; out Erro: String): Boolean;
var
  sql: String;
begin
  try

    sql := 'select * from usuario ' +
           'where id = :id ' +
           'order by id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger := id;
    Qry.Open;

    if Qry.RecordCount = 1 then
    begin
      //Usuario.Id       := Qry.FieldByName('id').AsInteger;
      //Usuario.Nome     := Qry.FieldByName('nome').AsString;
      //Usuario.Senha    := Qry.FieldByName('senha').AsString;
      //Usuario.Email    := Qry.FieldByName('email').AsString;
      //Usuario.Cadastro := Qry.FieldByName('cadastro').AsDateTime;
      //Usuario.Alteracao := Qry.FieldByName('alteracao').AsDateTime;
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

function TLoginDAO.Inserir(Login : TLogin; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'insert into usuario(id, nome, senha, email, cadastro) values ' +
           '(:id, :nome, :senha, :email, :cadastro)';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    //Qry.ParamByName('id').AsInteger        := Usuario.Id;
    //Qry.ParamByName('nome').AsString       := Usuario.Nome;
    //Qry.ParamByName('senha').AsString      := Usuario.Senha;
    //Qry.ParamByName('email').AsString      := Usuario.Email;
    //Qry.ParamByName('cadastro').AsDateTime := Usuario.Cadastro;
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

function TLoginDAO.Editar(Login : TLogin; out Erro: string): Boolean;
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
    //Qry.ParamByName('id').AsInteger         := Usuario.Id;
    //Qry.ParamByName('nome').AsString        := Usuario.Nome;
    //Qry.ParamByName('senha').AsString       := Usuario.Senha;
    //Qry.ParamByName('email').AsString       := Usuario.Email;
    //Qry.ParamByName('alteracao').AsDateTime := Usuario.Alteracao;   //Now

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

function TLoginDAO.Excluir(Id: Integer; out Erro: string): Boolean;
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
      Erro := 'Ocorreu um erro ao excluir usuário: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TLoginDAO.GerarId(Gerador: String; Incremento: Integer
  ): Integer;
var
  qryGerador: TSQLQuery;
  sql: String;
  id: integer;
begin
  id := 0;
  qryGerador := TSQLQuery.Create(nil);
  try

    sql := 'SELECT GEN_ID('+Gerador+', '+IntToStr(Incremento)+') AS ID ' +
           'FROM RDB$DATABASE';

    qryGerador.SQLConnection := dmConexao1.SQLConnector;
    qryGerador.SQL.Add(sql);
    qryGerador.Open;

    id := qryGerador.FieldByName('ID').AsInteger;
    Result := id;

  finally
    qryGerador.Free;
  end;
end;

constructor TLoginDAO.Create;
begin
  Qry := TSQLQuery.Create(nil);
  qry.SQLConnection := dmConexao1.SQLConnector;
end;

destructor TLoginDAO.Destroy;
begin
  Qry.Free;
  inherited Destroy;
end;

end.

