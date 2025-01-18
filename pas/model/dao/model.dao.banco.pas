unit model.dao.banco;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, SQLDB, model.entity.banco,
  model.connection.conexao1;

type

  { TBancoDAO }

  TBancoDAO = class
  private
    Qry: TSQLQuery;
  public
    procedure Listar(lv: TListView);
    function BuscarPorId(Banco : TBanco; Id: Integer; out Erro: String): Boolean;
    function Inserir(Banco: TBanco; out Erro: string): Boolean;
    function Editar(Banco: TBanco; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TBancoDAO }

procedure TBancoDAO.Listar(lv: TListView);
var
  sql: String;
  item : TListItem;
begin
  try

    sql := 'select * from banco order by nome_banco';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.Open;

    Qry.First;

    while not Qry.EOF do
    begin
      item := lv.Items.Add;
      item.Caption := Qry.FieldByName('id_banco').AsString;
      item.SubItems.Add(qry.FieldByName('nome_banco').AsString);
      Qry.Next;
    end;

  finally
    Qry.Close;
  end;
end;

function TBancoDAO.BuscarPorId(Banco: TBanco; Id: Integer; out Erro: String): Boolean;
var
  sql: String;
begin
  try

    sql := 'select * from banco ' +
           'where id_banco = :id_banco ' +
           'order by id_banco';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id_banco').AsInteger := id;
    Qry.Open;

    if Qry.RecordCount = 1 then
    begin
      Banco.Id   := Qry.FieldByName('id_banco').AsInteger;
      Banco.Nome := Qry.FieldByName('nome_banco').AsString;
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

function TBancoDAO.Inserir(Banco: TBanco; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'insert into banco(nome_banco) values (:nome_banco)';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('nome_banco').AsString := Banco.Nome;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao inserir banco: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TBancoDAO.Editar(Banco: TBanco; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'update banco set nome_banco = :nome_banco ' +
           'where id_banco = :id_banco';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id_banco').AsInteger  := Banco.Id;
    Qry.ParamByName('nome_banco').AsString := Banco.Nome;

    //dmConexao1.SQLTransaction.StartTransaction;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      dmConexao1.SQLTransaction.Rollback;
      Erro := 'Ocorreu um erro ao inserir banco: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TBancoDAO.Excluir(Id: Integer; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'delete from banco where id_banco = :id_banco';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id_banco').AsInteger  := Id;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao inserir banco: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

constructor TBancoDAO.Create;
begin
  Qry := TSQLQuery.Create(nil);
  qry.SQLConnection := dmConexao1.SQLConnector;
end;

destructor TBancoDAO.Destroy;
begin
  Qry.Free;
  inherited Destroy;
end;

end.

