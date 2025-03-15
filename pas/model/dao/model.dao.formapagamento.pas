unit model.dao.formapagamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, SQLDB, model.entity.formapagamento,
  model.dao.padrao, model.connection.conexao1;

type

  { TFormaPagamentoDAO }

  TFormaPagamentoDAO = class(TPadraoDAO)
  private

  public
    procedure Listar(lv: TListView); override;
    procedure Pesquisar(lv: TListView; Campo, Busca: String); override;
    function BuscarPorId(FormaPagamento : TFormaPagamento; Id: Integer; out Erro: String): Boolean;
    function Inserir(FormaPagamento : TFormaPagamento; out Erro: string): Boolean;
    function Editar(FormaPagamento : TFormaPagamento; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    constructor Create; override;
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

    sql := 'select * from forma_pgto where excluido = false order by nome';

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
    //dmConexao1.SQLTransaction.Commit;
  finally
    Qry.Close;
  end;
end;

procedure TFormaPagamentoDAO.Pesquisar(lv: TListView; Campo, Busca: String);
var
  sql: String;
  item : TListItem;
  valor: Double;
begin
  try

    if TryStrToFloat(Busca, valor) then
    begin
      sql := 'select * from forma_pgto ' +
             'where '+campo+' = :busca and excluido = false '+
             'order by nome';
    end
    else
    begin
      sql := 'select * from forma_pgto ' +
             'where UPPER('+campo+') like :busca and excluido = false '+
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
      item.SubItems.Add(qry.FieldByName('sigla').AsString);
      Qry.Next;
    end;

  finally
    qry.Close;
  end;
end;

function TFormaPagamentoDAO.BuscarPorId(FormaPagamento : TFormaPagamento; Id: Integer; out Erro: String): Boolean;
var
  sql: String;
begin
  try

    sql := 'select * from forma_pgto ' +
           'where id = :id and excluido = false ' +
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

    sql := 'insert into forma_pgto(id, nome, sigla, excluido) values ' +
           '(:id, :nome, :sigla, :excluido)';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger   := FormaPagamento.Id;
    Qry.ParamByName('nome').AsString  := FormaPagamento.Nome;
    Qry.ParamByName('sigla').AsString := FormaPagamento.Sigla;
    Qry.ParamByName('excluido').AsBoolean := FormaPagamento.Excluido;
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
      try

        sql := 'update forma_pgto set excluido = true where id = :id';

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
  end;
end;

constructor TFormaPagamentoDAO.Create;
begin
  inherited;
end;

destructor TFormaPagamentoDAO.Destroy;
begin
  inherited Destroy;
end;

end.

