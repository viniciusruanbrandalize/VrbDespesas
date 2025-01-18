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

    sql := 'select * from forma_pgto order by nome_forma_pgto';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.Open;

    Qry.First;

    while not Qry.EOF do
    begin
      item := lv.Items.Add;
      item.Caption := Qry.FieldByName('id_forma_pgto').AsString;
      item.SubItems.Add(qry.FieldByName('nome_forma_pgto').AsString);
      item.SubItems.Add(qry.FieldByName('sigla_forma_pgto').AsString);
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
           'where id_forma_pgto = :id_forma_pgto ' +
           'order by id_forma_pgto';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id_forma_pgto').AsInteger := id;
    Qry.Open;

    if Qry.RecordCount = 1 then
    begin
      FormaPagamento.Id    := Qry.FieldByName('id_forma_pgto').AsInteger;
      FormaPagamento.Nome  := Qry.FieldByName('nome_forma_pgto').AsString;
      FormaPagamento.Sigla := Qry.FieldByName('sigla_forma_pgto').AsString;
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

    sql := 'insert into forma_pgto(nome_forma_pgto, sigla_forma_pgto) values ' +
           '(:nome_forma_pgto, :sigla_forma_pgto)';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('nome_forma_pgto').AsString  := FormaPagamento.Nome;
    Qry.ParamByName('sigla_forma_pgto').AsString := FormaPagamento.Sigla;
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

    sql := 'update forma_pgto set nome_forma_pgto = :nome_forma_pgto, ' +
           'sigla_forma_pgto = :sigla_forma_pgto ' +
           'where id_forma_pgto = :id_forma_pgto';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id_forma_pgto').AsInteger   := FormaPagamento.Id;
    Qry.ParamByName('nome_forma_pgto').AsString  := FormaPagamento.Nome;
    Qry.ParamByName('sigla_forma_pgto').AsString := FormaPagamento.Sigla;
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

    sql := 'delete from forma_pgto where id_forma_pgto = :id_forma_pgto';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id_forma_pgto').AsInteger  := Id;
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

