unit model.dao.banco;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, SQLDB, model.dao.padrao, model.entity.banco,
  model.connection.conexao1;

type

  { TBancoDAO }

  TBancoDAO = class(TPadraoDAO)
  private

  public
    procedure Listar(lv: TListView); override;
    procedure Pesquisar(lv: TListView; Campo, Busca: String); override;
    function BuscarPorId(Banco : TBanco; Id: Integer; out Erro: String): Boolean;
    function Inserir(Banco: TBanco; out Erro: string): Boolean;
    function Editar(Banco: TBanco; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    constructor Create; override;
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

    sql := 'select * from banco where excluido = false order by nome';

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

procedure TBancoDAO.Pesquisar(lv: TListView; Campo, Busca: String);
var
  sql: String;
  item : TListItem;
  valor: Double;
begin
  try

    if TryStrToFloat(Busca, valor) then
    begin
      sql := 'select * from banco ' +
             'where '+campo+' = :busca and excluido = false '+
             'order by nome';
    end
    else
    begin
      sql := 'select * from banco ' +
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
      Qry.Next;
    end;

  finally
    qry.Close;
  end;
end;

function TBancoDAO.BuscarPorId(Banco: TBanco; Id: Integer; out Erro: String): Boolean;
var
  sql: String;
begin
  try

    sql := 'select * from banco ' +
           'where id = :id and excluido = false ' +
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

    sql := 'insert into banco(id, nome, numero, excluido) values ' +
           '(:id, :nome, :numero, :excluido)';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger  := Banco.Id;
    Qry.ParamByName('nome').AsString := Banco.Nome;
    Qry.ParamByName('numero').AsInteger  := Banco.Numero;
    Qry.ParamByName('excluido').AsBoolean := Banco.Excluido;
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

    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      dmConexao1.SQLTransaction.Rollback;
      Erro := 'Ocorreu um erro ao alterar banco: ' + sLineBreak + E.Message;
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
      try
        sql := 'update banco set excluido = true ' +
               'where id = :id';

        Qry.Close;
        Qry.SQL.Clear;
        Qry.SQL.Add(sql);
        Qry.ParamByName('id').AsInteger  := Id;
        Qry.ExecSQL;
        dmConexao1.SQLTransaction.Commit;

      except on E: Exception do
        begin
          Erro := 'Ocorreu um erro ao excluir banco: ' + sLineBreak + E.Message;
          Result := False;
        end;
      end;
    end;
  end;
end;

constructor TBancoDAO.Create;
begin
  inherited;
end;

destructor TBancoDAO.Destroy;
begin
  inherited Destroy;
end;

end.

