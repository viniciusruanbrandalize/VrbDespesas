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
    function GerarId(Gerador: String; Incremento: Integer=1): Integer;
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

    sql := 'select * from banco order by nome';

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
           'where id = :id ' +
           'order by id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger := id;
    Qry.Open;

    if Qry.RecordCount = 1 then
    begin
      Banco.Id   := Qry.FieldByName('id').AsInteger;
      Banco.Nome := Qry.FieldByName('nome').AsString;
      Banco.Numero := Qry.FieldByName('numero').AsInteger;
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

    sql := 'insert into banco(id, nome, numero) values (:id, :nome, :numero)';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger  := Banco.Id;
    Qry.ParamByName('nome').AsString := Banco.Nome;
    Qry.ParamByName('numero').AsInteger  := Banco.Numero;
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

    sql := 'update banco set nome = :nome, numero = :numero ' +
           'where id = :id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger  := Banco.Id;
    Qry.ParamByName('nome').AsString := Banco.Nome;
    Qry.ParamByName('numero').AsInteger  := Banco.Numero;

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

    sql := 'delete from banco where id = :id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger  := Id;
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

function TBancoDAO.GerarId(Gerador: String; Incremento: Integer=1): Integer;
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

