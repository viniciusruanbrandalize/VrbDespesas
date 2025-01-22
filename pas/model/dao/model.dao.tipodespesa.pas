unit model.dao.tipodespesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, SQLDB, model.entity.tipodespesa,
  model.connection.conexao1;

type

  { TTipoDespesaDAO }

  TTipoDespesaDAO = class
  private
    Qry: TSQLQuery;
  public
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    function BuscarPorId(TipoDespesa : TTipoDespesa; Id: Integer; out Erro: String): Boolean;
    function Inserir(TipoDespesa : TTipoDespesa; out Erro: string): Boolean;
    function Editar(TipoDespesa : TTipoDespesa; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    function GerarId(Gerador: String; Incremento: Integer=1): Integer;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TTipoDespesaDAO }

procedure TTipoDespesaDAO.Listar(lv: TListView);
var
  sql: String;
  item : TListItem;
begin
  try

    sql := 'select * from tipo_despesa order by nome';

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

procedure TTipoDespesaDAO.Pesquisar(lv: TListView; Campo, Busca: String);
var
  sql: String;
  item : TListItem;
  valor: Double;
begin
  try

    if TryStrToFloat(Busca, valor) then
    begin
      sql := 'select * from tipo_despesa ' +
             'where '+campo+' = :busca '+
             'order by nome';
    end
    else
    begin
      sql := 'select * from tipo_despesa ' +
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
      Qry.Next;
    end;

  finally
    qry.Close;
  end;
end;

function TTipoDespesaDAO.BuscarPorId(TipoDespesa : TTipoDespesa; Id: Integer; out Erro: String): Boolean;
var
  sql: String;
begin
  try

    sql := 'select * from tipo_despesa ' +
           'where id = :id ' +
           'order by id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger := id;
    Qry.Open;

    if Qry.RecordCount = 1 then
    begin
      TipoDespesa.Id    := Qry.FieldByName('id').AsInteger;
      TipoDespesa.Nome  := Qry.FieldByName('nome').AsString;
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

function TTipoDespesaDAO.Inserir(TipoDespesa : TTipoDespesa; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'insert into tipo_despesa(id, nome) values (:id, :nome)';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger  := TipoDespesa.Id;
    Qry.ParamByName('nome').AsString := TipoDespesa.Nome;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao inserir tipo de despesa: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TTipoDespesaDAO.Editar(TipoDespesa : TTipoDespesa; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'update tipo_despesa set nome = :nome ' +
           'where id = :id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger   := TipoDespesa.Id;
    Qry.ParamByName('nome').AsString  := TipoDespesa.Nome;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      dmConexao1.SQLTransaction.Rollback;
      Erro := 'Ocorreu um erro ao alterar tipo de despesa: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TTipoDespesaDAO.Excluir(Id: Integer; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'delete from tipo_despesa where id = :id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger  := Id;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao excluir tipo de despesa: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TTipoDespesaDAO.GerarId(Gerador: String; Incremento: Integer): Integer;
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

constructor TTipoDespesaDAO.Create;
begin
  Qry := TSQLQuery.Create(nil);
  qry.SQLConnection := dmConexao1.SQLConnector;
end;

destructor TTipoDespesaDAO.Destroy;
begin
  Qry.Free;
  inherited Destroy;
end;

end.
