unit model.dao.contabancaria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, SQLDB, model.entity.contabancaria,
  model.connection.conexao1;

type

  { TContaBancariaDAO }

  TContaBancariaDAO = class
  private
    Qry: TSQLQuery;
  public
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    procedure PesquisarBanco(lbNome, lbId: TListBox; busca: String; out QtdRegistro: Integer);
    function BuscarPorId(ContaBancaria : TContaBancaria; Id: Integer; out Erro: String): Boolean;
    function Inserir(ContaBancaria: TContaBancaria; out Erro: string): Boolean;
    function Editar(ContaBancaria: TContaBancaria; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    function GerarId(Gerador: String; Incremento: Integer=1): Integer;
    procedure ListarPix(lv: TListView; IdConta: Integer);
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TContaBancariaDAO }

procedure TContaBancariaDAO.Listar(lv: TListView);
var
  sql: String;
  item : TListItem;
begin
  try

    sql := 'select cb.*, b.nome as nome_banco from conta_bancaria cb ' +
           'left join banco b on b.id = cb.id_banco ' +
           'order by b.nome';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.Open;

    Qry.First;

    while not Qry.EOF do
    begin
      item := lv.Items.Add;
      item.Caption := Qry.FieldByName('id').AsString;
      item.SubItems.Add(qry.FieldByName('numero').AsString);
      item.SubItems.Add(qry.FieldByName('agencia').AsString);
      item.SubItems.Add(qry.FieldByName('nome_banco').AsString);
      Qry.Next;
    end;

  finally
    Qry.Close;
  end;
end;

procedure TContaBancariaDAO.Pesquisar(lv: TListView; Campo, Busca: String);
var
  sql: String;
  item : TListItem;
  valor: Double;
begin
  try

    if TryStrToFloat(Busca, valor) then
    begin
      sql := 'select cb.*, b.nome as nome_banco from conta_bancaria cb ' +
             'left join banco b on b.id = cb.id_banco ' +
             'where '+campo+' = :busca '+
             'order by b.nome';
    end
    else
    begin
      sql := 'select cb.*, b.nome as nome_banco from conta_bancaria cb ' +
             'left join banco b on b.id = cb.id_banco ' +
             'where UPPER('+campo+') like :busca '+
             'order by b.nome';
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
      item.SubItems.Add(qry.FieldByName('numero').AsString);
      item.SubItems.Add(qry.FieldByName('agencia').AsString);
      item.SubItems.Add(qry.FieldByName('nome_banco').AsString);
      Qry.Next;
    end;

  finally
    qry.Close;
  end;
end;

procedure TContaBancariaDAO.PesquisarBanco(lbNome, lbId: TListBox;
  busca: String; out QtdRegistro: Integer);
var
  sql: String;
begin
  try

    sql := 'select first 10 id, nome from banco ' +
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

function TContaBancariaDAO.BuscarPorId(ContaBancaria: TContaBancaria; Id: Integer; out Erro: String): Boolean;
var
  sql: String;
begin
  try

    sql := 'select cb.*, b.nome as nome_banco from conta_bancaria cb ' +
           'left join banco b on b.id = cb.id_banco ' +
           'where cb.id = :id ' +
           'order by cb.id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger := id;
    Qry.Open;

    if Qry.RecordCount = 1 then
    begin
      ContaBancaria.Id        := Qry.FieldByName('id').AsInteger;
      ContaBancaria.Numero    := Qry.FieldByName('numero').AsString;
      ContaBancaria.Agencia   := Qry.FieldByName('agencia').AsString;
      ContaBancaria.Tipo      := Qry.FieldByName('tipo').AsString;
      ContaBancaria.Cadastro  := Qry.FieldByName('cadastro').AsDateTime;
      ContaBancaria.Alteracao := Qry.FieldByName('alteracao').AsDateTime;
      ContaBancaria.Banco.Id  := Qry.FieldByName('id_banco').AsInteger;
      ContaBancaria.Banco.Nome := Qry.FieldByName('nome_banco').AsString;
      //ContaBancaria.DonoCadastro.
      ContaBancaria.UsuarioCadastro.Id := Qry.FieldByName('id_usuario_cadastro').AsInteger;
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

function TContaBancariaDAO.Inserir(ContaBancaria: TContaBancaria; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'insert into conta_bancaria(id, numero, agencia, tipo, cadastro, ' +
           'id_banco, id_usuario_cadastro, id_dono_cadastro) values ' +
           '(:id, :numero, :agencia, :tipo, :cadastro, :id_banco, ' +
           ':id_usuario_cadastro, :id_dono_cadastro)';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger     := ContaBancaria.Id;
    Qry.ParamByName('numero').AsString  := ContaBancaria.Numero;
    Qry.ParamByName('agencia').AsString := ContaBancaria.Agencia;
    Qry.ParamByName('tipo').AsString    := ContaBancaria.Tipo;
    Qry.ParamByName('cadastro').AsDateTime := ContaBancaria.Cadastro;
    Qry.ParamByName('id_banco').AsInteger  := ContaBancaria.Banco.Id;
    Qry.ParamByName('id_usuario_cadastro').AsInteger  := ContaBancaria.UsuarioCadastro.Id;
    //Qry.ParamByName('id_dono_cadastro').AsInteger := 1; //ContaBancaria.DonoCadastro.
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao inserir Conta Bancaria: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TContaBancariaDAO.Editar(ContaBancaria: TContaBancaria; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'update conta_bancaria set numero = :numero, agencia = :agencia, ' +
           'tipo = :tipo, alteracao = :alteracao, id_banco = :id_banco ' +
           'where id = :id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger     := ContaBancaria.Id;
    Qry.ParamByName('numero').AsString  := ContaBancaria.Numero;
    Qry.ParamByName('agencia').AsString := ContaBancaria.Agencia;
    Qry.ParamByName('tipo').AsString    := ContaBancaria.Tipo;
    Qry.ParamByName('alteracao').AsDateTime := ContaBancaria.Alteracao;
    Qry.ParamByName('id_banco').AsInteger := ContaBancaria.Banco.Id;

    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      dmConexao1.SQLTransaction.Rollback;
      Erro := 'Ocorreu um erro ao inserir Conta Bancaria: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TContaBancariaDAO.Excluir(Id: Integer; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'delete from conta_bancaria where id = :id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger  := Id;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao inserir Conta Bancaria: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TContaBancariaDAO.GerarId(Gerador: String; Incremento: Integer=1): Integer;
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

procedure TContaBancariaDAO.ListarPix(lv: TListView; IdConta: Integer);
var
  sql: String;
  item : TListItem;
begin
  try

    sql := 'select * from pix ' +
           'where id_conta_bancaria = :id_conta_bancaria ' +
           'order by cadastro desc';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id_conta_bancaria').AsInteger := IdConta;
    Qry.Open;

    Qry.First;

    while not Qry.EOF do
    begin
      item := lv.Items.Add;
      item.Caption := Qry.FieldByName('chave').AsString;
      item.SubItems.Add(qry.FieldByName('chave').AsString);
      item.SubItems.Add(qry.FieldByName('tipo').AsString);
      item.SubItems.Add(qry.FieldByName('cadastro').AsString);
      Qry.Next;
    end;

  finally
    Qry.Close;
  end;
end;

constructor TContaBancariaDAO.Create;
begin
  Qry := TSQLQuery.Create(nil);
  qry.SQLConnection := dmConexao1.SQLConnector;
end;

destructor TContaBancariaDAO.Destroy;
begin
  Qry.Free;
  inherited Destroy;
end;

end.

