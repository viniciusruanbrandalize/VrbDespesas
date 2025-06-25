unit model.dao.bandeira;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, SQLDB, model.dao.padrao, model.entity.bandeira,
  model.connection.conexao1;

type

  { TBandeiraDAO }

  TBandeiraDAO = class(TPadraoDAO)
  private

  public
    procedure Listar(lv: TListView); override;
    procedure Pesquisar(lv: TListView; Campo, Busca: String); override;
    function BuscarPorId(Bandeira : TBandeira; Id: Integer; out Erro: String): Boolean;
    function Inserir(Bandeira: TBandeira; out Erro: string): Boolean;
    function Editar(Bandeira: TBandeira; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

{ TBandeiraDAO }

procedure TBandeiraDAO.Listar(lv: TListView);
var
  sql: String;
  item : TListItem;
begin
  try

    sql := 'select * from bandeira where excluido = false order by nome';

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

procedure TBandeiraDAO.Pesquisar(lv: TListView; Campo, Busca: String);
var
  sql: String;
  item : TListItem;
  valor: Double;
begin
  try

    if TryStrToFloat(Busca, valor) then
    begin
      sql := 'select * from bandeira ' +
             'where '+campo+' = :busca and excluido = false '+
             'order by nome';
    end
    else
    begin
      sql := 'select * from bandeira ' +
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

function TBandeiraDAO.BuscarPorId(Bandeira: TBandeira; Id: Integer; out Erro: String): Boolean;
var
  sql: String;
begin
  try

    sql := 'select * from bandeira ' +
           'where id = :id and excluido = false ' +
           'order by id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger := id;
    Qry.Open;

    if Qry.RecordCount = 1 then
    begin
      Bandeira.Id   := Qry.FieldByName('id').AsInteger;
      Bandeira.Nome := Qry.FieldByName('nome').AsString;
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

function TBandeiraDAO.Inserir(Bandeira: TBandeira; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'insert into bandeira(id, nome, excluido) values (:id, :nome, :excluido)';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);

    if not AutoInc then
    begin
      Bandeira.Id := GerarId(SEQ_ID_BANDEIRA);
      Qry.ParamByName('id').AsInteger  := Bandeira.Id;
    end;

    Qry.ParamByName('nome').AsString := Bandeira.Nome;
    Qry.ParamByName('excluido').AsBoolean := Bandeira.Excluido;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao inserir Bandeira: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TBandeiraDAO.Editar(Bandeira: TBandeira; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'update bandeira set nome = :nome ' +
           'where id = :id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger  := Bandeira.Id;
    Qry.ParamByName('nome').AsString := Bandeira.Nome;

    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      dmConexao1.SQLTransaction.Rollback;
      Erro := 'Ocorreu um erro ao alterar Bandeira: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TBandeiraDAO.Excluir(Id: Integer; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'delete from bandeira where id = :id';

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

        sql := 'update bandeira set excluido = true where id = :id';

        Qry.Close;
        Qry.SQL.Clear;
        Qry.SQL.Add(sql);
        Qry.ParamByName('id').AsInteger  := Id;
        Qry.ExecSQL;
        dmConexao1.SQLTransaction.Commit;

        Result := True;

      except on E: Exception do
        begin
          Erro := 'Ocorreu um erro ao excluir Bandeira: ' + sLineBreak + E.Message;
          Result := False;
        end;
      end;
    end;
  end;
end;

constructor TBandeiraDAO.Create;
begin
  Inherited;
end;

destructor TBandeiraDAO.Destroy;
begin
  inherited Destroy;
end;

end.

