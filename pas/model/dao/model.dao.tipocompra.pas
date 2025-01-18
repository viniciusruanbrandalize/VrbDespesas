unit model.dao.tipocompra;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, SQLDB, model.entity.tipocompra,
  model.connection.conexao1;

type

  { TTipoCompraDAO }

  TTipoCompraDAO = class
  private
    Qry: TSQLQuery;
  public
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    function BuscarPorId(TipoCompra : TTipoCompra; Id: Integer; out Erro: String): Boolean;
    function Inserir(TipoCompra : TTipoCompra; out Erro: string): Boolean;
    function Editar(TipoCompra : TTipoCompra; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TTipoCompraDAO }

procedure TTipoCompraDAO.Listar(lv: TListView);
var
  sql: String;
  item : TListItem;
begin
  try

    sql := 'select * from tipo_compra order by desc_tipo_compra';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.Open;

    Qry.First;

    while not Qry.EOF do
    begin
      item := lv.Items.Add;
      item.Caption := Qry.FieldByName('id_tipo_compra').AsString;
      item.SubItems.Add(qry.FieldByName('desc_tipo_compra').AsString);
      Qry.Next;
    end;

  finally
    Qry.Close;
  end;
end;

procedure TTipoCompraDAO.Pesquisar(lv: TListView; Campo, Busca: String);
var
  sql: String;
  item : TListItem;
begin
  try

    sql := 'select * from tipo_compra ' +
           'where '+campo+' like :busca '+
           'order by desc_tipo_compra';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('busca').AsString := QuotedStr('%'+Busca+'%');
    Qry.Open;

    Qry.First;

    while not Qry.EOF do
    begin
      item := lv.Items.Add;
      item.Caption := Qry.FieldByName('id_tipo_compra').AsString;
      item.SubItems.Add(qry.FieldByName('desc_tipo_compra').AsString);
      Qry.Next;
    end;

  finally
    qry.Close;
  end;
end;

function TTipoCompraDAO.BuscarPorId(TipoCompra : TTipoCompra; Id: Integer; out Erro: String): Boolean;
var
  sql: String;
begin
  try

    sql := 'select * from tipo_compra ' +
           'where id_tipo_compra = :id_tipo_compra ' +
           'order by id_tipo_compra';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id_tipo_compra').AsInteger := id;
    Qry.Open;

    if Qry.RecordCount = 1 then
    begin
      TipoCompra.Id    := Qry.FieldByName('id_tipo_compra').AsInteger;
      TipoCompra.Nome  := Qry.FieldByName('desc_tipo_compra').AsString;
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

function TTipoCompraDAO.Inserir(TipoCompra : TTipoCompra; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'insert into tipo_compra(desc_tipo_compra) values ' +
           '(:desc_tipo_compra)';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('desc_tipo_compra').AsString  := TipoCompra.Nome;
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

function TTipoCompraDAO.Editar(TipoCompra : TTipoCompra; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'update tipo_compra set desc_tipo_compra = :desc_tipo_compra ' +
           'where id_tipo_compra = :id_tipo_compra';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id_tipo_compra').AsInteger   := TipoCompra.Id;
    Qry.ParamByName('desc_tipo_compra').AsString  := TipoCompra.Nome;
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

function TTipoCompraDAO.Excluir(Id: Integer; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'delete from tipo_compra where id_tipo_compra = :id_tipo_compra';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id_tipo_compra').AsInteger  := Id;
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

constructor TTipoCompraDAO.Create;
begin
  Qry := TSQLQuery.Create(nil);
  qry.SQLConnection := dmConexao1.SQLConnector;
end;

destructor TTipoCompraDAO.Destroy;
begin
  Qry.Free;
  inherited Destroy;
end;

end.
