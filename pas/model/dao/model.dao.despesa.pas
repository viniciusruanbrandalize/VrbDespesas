unit model.dao.despesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, SQLDB, model.entity.despesa,
  model.connection.conexao1;

type

  { TDespesaDAO }

  TDespesaDAO = class
  private
    Qry: TSQLQuery;
  public
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    procedure PesquisarSubtipo(lbNome, lbId: TListBox; busca: String; out QtdRegistro: Integer);
    function BuscarPorId(Despesa : TDespesa; Id: Integer; out Erro: String): Boolean;
    function Inserir(Despesa : TDespesa; out Erro: string): Boolean;
    function Editar(Despesa : TDespesa; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    function GerarId(Gerador: String; Incremento: Integer=1): Integer;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TDespesaDAO }

procedure TDespesaDAO.Listar(lv: TListView);
var
  sql: String;
  item : TListItem;
begin
  try

    sql := 'select d.*, f.nome as nome_fornecedor from despesa d ' +
           'left join participante f on f.id = d.id_fornecedor ' +
           'order by d.data desc, d.hora desc';

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
      item.SubItems.Add(qry.FieldByName('nome_fornecedor').AsString);
      item.SubItems.Add(qry.FieldByName('descricao').AsString);
      item.SubItems.Add(FormatFloat(',#0.00', qry.FieldByName('total').AsFloat));
      Qry.Next;
    end;

  finally
    Qry.Close;
  end;
end;

procedure TDespesaDAO.Pesquisar(lv: TListView; Campo, Busca: String);
var
  sql: String;
  item : TListItem;
  valor: Double;
begin
  try

    if TryStrToFloat(Busca, valor) then
    begin
      sql := 'select d.*, f.nome as nome_fornecedor from despesa d ' +
             'left join participante f on f.id = d.id_fornecedor ' +
             'where '+campo+' = :busca '+
             'order by d.data desc, d.hora desc';
    end
    else
    begin
      sql := 'select d.*, f.nome as nome_fornecedor from despesa d ' +
             'left join participante f on f.id = d.id_fornecedor ' +
             'where UPPER('+campo+') like :busca '+
             'order by d.data desc, d.hora desc';
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
      item.SubItems.Add(qry.FieldByName('data').AsString);
      item.SubItems.Add(qry.FieldByName('hora').AsString);
      item.SubItems.Add(qry.FieldByName('nome_fornecedor').AsString);
      item.SubItems.Add(qry.FieldByName('descricao').AsString);
      item.SubItems.Add(FormatFloat(',#0.00', qry.FieldByName('total').AsFloat));
      Qry.Next;
    end;

  finally
    qry.Close;
  end;
end;

procedure TDespesaDAO.PesquisarSubtipo(lbNome, lbId: TListBox; busca: String;
  out QtdRegistro: Integer);
var
  sql: String;
begin
  try

    sql := 'select first 10 id, nome from subtipo_despesa ' +
           'where UPPER(nome) like :busca '+
           'order by nome';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('busca').AsString := '%'+UpperCase(Busca)+'%';
    Qry.Open;

    Qry.First;

    QtdRegistro := Qry.RecordCount;

    lbNome.Items.Clear;
    lbNome.Height := 100;
    lbId.Items.Clear;

    while not Qry.EOF do
    begin
      lbId.Items.Add(Qry.FieldByName('id').AsString);
      lbNome.Items.Add(qry.FieldByName('nome').AsString);
      Qry.Next;
    end;

  finally
    qry.Close;
  end;
end;

function TDespesaDAO.BuscarPorId(Despesa : TDespesa; Id: Integer; out Erro: String): Boolean;
var
  sql: String;
begin
  try

    sql := 'select d.*, f.nome as nome_fornecedor, sd.nome as nome_subtipo ' +
           'from despesa d ' +
           'left join participante f on f.id = d.id_fornecedor ' +
           'left join subtipo_despesa sd on sd.id = d.id_subtipo ' +
           'where d.id = :id ' +
           'order by d.id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger := id;
    Qry.Open;

    if Qry.RecordCount = 1 then
    begin
      Despesa.Id        := Qry.FieldByName('id').AsInteger;
      Despesa.Data      := Qry.FieldByName('data').AsDateTime;
      Despesa.Hora      := Qry.FieldByName('hora').AsDateTime;
      Despesa.Descricao := Qry.FieldByName('descricao').AsString;
      Despesa.ChaveNFE  := Qry.FieldByName('chave_nfe').AsString;
      Despesa.Valor     := Qry.FieldByName('valor').AsFloat;
      Despesa.Desconto  := Qry.FieldByName('desconto').AsFloat;
      Despesa.Frete     := Qry.FieldByName('frete').AsFloat;
      Despesa.Outros    := Qry.FieldByName('outros').AsFloat;
      Despesa.Total     := Qry.FieldByName('total').AsFloat;
      Despesa.Paga      := Qry.FieldByName('paga').AsBoolean;
      Despesa.Parcela   := Qry.FieldByName('parcela').AsInteger;
      Despesa.Cadastro  := Qry.FieldByName('cadastro').AsDateTime;
      Despesa.Alteracao := Qry.FieldByName('alteracao').AsDateTime;
      Despesa.Observacao:= Qry.FieldByName('obs').AsString;
      Despesa.Fornecedor.Id := Qry.FieldByName('id_fornecedor').AsInteger;
      Despesa.Fornecedor.Nome := Qry.FieldByName('nome_fornecedor').AsString;
      Despesa.SubTipo.Id := Qry.FieldByName('id_subtipo').AsInteger;
      Despesa.SubTipo.Nome := Qry.FieldByName('nome_subtipo').AsString;
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

function TDespesaDAO.Inserir(Despesa : TDespesa; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'insert into despesa (id, data, hora, descricao, chave_nfe, valor, desconto, ' +
           'frete, outros, total, paga, parcela, cadastro, obs, id_fornecedor, ' +
           'id_subtipo, id_dono_cadastro, id_usuario_cadastro) values (' +
           ':id, :data, :hora, :descricao, :chave_nfe, :valor, :desconto, ' +
           ':frete, :outros, :total, :paga, :parcela, :cadastro, :obs, :id_fornecedor, ' +
           ':id_subtipo, :id_dono_cadastro, :id_usuario_cadastro)';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger        := Despesa.Id;
    Qry.ParamByName('data').AsDate         := Despesa.Data;
    Qry.ParamByName('hora').AsTime         := Despesa.Hora;
    Qry.ParamByName('descricao').AsString  := Despesa.Descricao;
    Qry.ParamByName('chave_nfe').AsString  := Despesa.ChaveNFE;
    Qry.ParamByName('valor').AsFloat       := Despesa.Valor;
    Qry.ParamByName('desconto').AsFloat    := Despesa.Desconto;
    Qry.ParamByName('frete').AsFloat       := Despesa.Frete;
    Qry.ParamByName('outros').AsFloat      := Despesa.Outros;
    Qry.ParamByName('total').AsFloat       := Despesa.Total;
    Qry.ParamByName('paga').AsBoolean      := Despesa.Paga;
    Qry.ParamByName('parcela').AsFloat     := Despesa.Parcela;
    Qry.ParamByName('cadastro').AsDateTime := Despesa.Cadastro;
    Qry.ParamByName('obs').AsString        := Despesa.Observacao;
    Qry.ParamByName('id_fornecedor').AsInteger := Despesa.Fornecedor.Id;
    Qry.ParamByName('id_subtipo').AsInteger := Despesa.SubTipo.Id;
    Qry.ParamByName('id_usuario_cadastro').AsInteger := Despesa.UsuarioCadastro.Id;
    //Qry.ParamByName('id_dono_cadastro').AsInteger := Despesa.DonoCadastro.Id;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao inserir despesa: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TDespesaDAO.Editar(Despesa : TDespesa; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'update despesa set "data"=:data, hora=:hora, descricao=:descricao, ' +
           'chave_nfe=:chave_nfe, valor=:valor, desconto=:desconto, frete=:frete, ' +
           'outros=:outros, total=:total, paga=:paga, parcela=:parcela, ' +
           'alteracao=:alteracao, obs=:obs, id_fornecedor=:id_fornecedor, ' +
           'id_subtipo=:id_subtipo ' +
           'where id = :id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger        := Despesa.Id;
    Qry.ParamByName('data').AsDate         := Despesa.Data;
    Qry.ParamByName('hora').AsTime         := Despesa.Hora;
    Qry.ParamByName('descricao').AsString  := Despesa.Descricao;
    Qry.ParamByName('chave_nfe').AsString  := Despesa.ChaveNFE;
    Qry.ParamByName('valor').AsFloat       := Despesa.Valor;
    Qry.ParamByName('desconto').AsFloat    := Despesa.Desconto;
    Qry.ParamByName('frete').AsFloat       := Despesa.Frete;
    Qry.ParamByName('outros').AsFloat      := Despesa.Outros;
    Qry.ParamByName('total').AsFloat       := Despesa.Total;
    Qry.ParamByName('paga').AsBoolean      := Despesa.Paga;
    Qry.ParamByName('parcela').AsFloat     := Despesa.Parcela;
    Qry.ParamByName('alteracao').AsDateTime := Despesa.Alteracao;
    Qry.ParamByName('obs').AsString        := Despesa.Observacao;
    Qry.ParamByName('id_fornecedor').AsInteger := Despesa.Fornecedor.Id;
    Qry.ParamByName('id_subtipo').AsInteger := Despesa.SubTipo.Id;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      dmConexao1.SQLTransaction.Rollback;
      Erro := 'Ocorreu um erro ao alterar despesa: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TDespesaDAO.Excluir(Id: Integer; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'delete from despesa where id = :id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger  := Id;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao excluir despesa: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TDespesaDAO.GerarId(Gerador: String; Incremento: Integer): Integer;
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

constructor TDespesaDAO.Create;
begin
  Qry := TSQLQuery.Create(nil);
  qry.SQLConnection := dmConexao1.SQLConnector;
end;

destructor TDespesaDAO.Destroy;
begin
  Qry.Free;
  inherited Destroy;
end;

end.
