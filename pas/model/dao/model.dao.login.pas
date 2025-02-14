unit model.dao.login;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, SQLDB, model.entity.login, model.entity.usuario,
  model.connection.conexao1, model.dao.padrao;

type

  { TLoginDAO }

  TLoginDAO = class(TPadraoDAO)
  private

  public
    procedure Listar(lv: TListView); override;
    function Inserir(Login : TLogin; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    function EncontrarUsuario(Usuario: TUsuario; Nome: String; out Erro: String): Boolean;
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
    Qry.ParamByName('id').AsInteger         := Login.Id;
    Qry.ParamByName('nome_pc').AsString     := Login.NomePC;
    Qry.ParamByName('ip_pc').AsString       := Login.IPPC;
    Qry.ParamByName('data').AsDate          := Login.Data;
    Qry.ParamByName('hora').AsTime          := Login.Hora;
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
           'where nome = :busca ' +
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

constructor TLoginDAO.Create;
begin
  inherited;
end;

destructor TLoginDAO.Destroy;
begin
  inherited Destroy;
end;

end.

