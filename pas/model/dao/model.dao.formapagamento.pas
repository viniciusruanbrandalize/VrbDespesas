unit model.dao.formapagamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, SQLDB, model.entity.formapagamento,
  model.connection.conexao1;

type

  { TFormaPagamentoDAO }

  TFormaPagamentoDAO = class
  private
    Qry: TSQLQuery;
  public
    procedure Listar(lv: TListView);
    function BuscarPorId(FormaPagamento : TFormaPagamento; Id: Integer; out Erro: String): Boolean;
    function Inserir(FormaPagamento : TFormaPagamento; out Erro: string): Boolean;
    function Editar(FormaPagamento : TFormaPagamento; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    function GerarId(Gerador: String; Incremento: Integer=1): Integer;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TFormaPagamentoDAO }

procedure TFormaPagamentoDAO.Listar(lv: TListView);
var
  sql: String;
  item : TListItem;
begin
  try

    sql := 'select * from forma_pgto order by nome';

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
      item.SubItems.Add(qry.FieldByName('sigla').AsString);
      Qry.Next;
    end;

  finally
    Qry.Close;
  end;
end;

function TFormaPagamentoDAO.BuscarPorId(FormaPagamento : TFormaPagamento; Id: Integer; out Erro: String): Boolean;
var
  sql: String;
begin
  try

    sql := 'select * from forma_pgto ' +
           'where id = :id ' +
           'order by id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger := id;
    Qry.Open;

    if Qry.RecordCount = 1 then
    begin
      FormaPagamento.Id    := Qry.FieldByName('id').AsInteger;
      FormaPagamento.Nome  := Qry.FieldByName('nome').AsString;
      FormaPagamento.Sigla := Qry.FieldByName('sigla').AsString;
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

function TFormaPagamentoDAO.Inserir(FormaPagamento : TFormaPagamento; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'insert into forma_pgto(id, nome, sigla) values ' +
           '(:id, :nome, :sigla)';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger   := FormaPagamento.Id;
    Qry.ParamByName('nome').AsString  := FormaPagamento.Nome;
    Qry.ParamByName('sigla').AsString := FormaPagamento.Sigla;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao inserir forma de pagamento: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TFormaPagamentoDAO.Editar(FormaPagamento : TFormaPagamento; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'update forma_pgto set nome = :nome, ' +
           'sigla = :sigla ' +
           'where id = :id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger   := FormaPagamento.Id;
    Qry.ParamByName('nome').AsString  := FormaPagamento.Nome;
    Qry.ParamByName('sigla').AsString := FormaPagamento.Sigla;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      dmConexao1.SQLTransaction.Rollback;
      Erro := 'Ocorreu um erro ao alterar forma de pagamento: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TFormaPagamentoDAO.Excluir(Id: Integer; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'delete from forma_pgto where id = :id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger  := Id;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao excluir forma de pagamento: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TFormaPagamentoDAO.GerarId(Gerador: String; Incremento: Integer
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

constructor TFormaPagamentoDAO.Create;
begin
  Qry := TSQLQuery.Create(nil);
  qry.SQLConnection := dmConexao1.SQLConnector;
end;

destructor TFormaPagamentoDAO.Destroy;
begin
  Qry.Free;
  inherited Destroy;
end;

end.

