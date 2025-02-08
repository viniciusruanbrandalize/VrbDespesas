unit model.dao.participante;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, SQLDB, StdCtrls, model.entity.participante,
  model.connection.conexao1;

type

  { TParticipanteDAO }

  TParticipanteDAO = class
  private
    Qry: TSQLQuery;
  public
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    procedure PesquisarCidade(lbNome, lbId: TListBox; busca: String; out QtdRegistro: Integer);
    function BuscarPorId(Participante : TParticipante; Id: Integer; out Erro: String; DonoCadastro: Boolean = false): Boolean;
    function Inserir(Participante : TParticipante; out Erro: string): Boolean;
    function Editar(Participante : TParticipante; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    function GerarId(Gerador: String; Incremento: Integer=1): Integer;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TParticipanteDAO }

procedure TParticipanteDAO.Listar(lv: TListView);
var
  sql: String;
  item : TListItem;
begin
  try

    sql := 'select p.* from participante p ' +
           'order by p.nome';

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
      item.SubItems.Add(qry.FieldByName('fantasia').AsString);
      item.SubItems.Add(qry.FieldByName('cadastro').AsString);
      Qry.Next;
    end;

  finally
    Qry.Close;
  end;
end;

procedure TParticipanteDAO.Pesquisar(lv: TListView; Campo, Busca: String);
var
  sql: String;
  item : TListItem;
  valor: Double;
begin
  try

    if TryStrToFloat(Busca, valor) then
    begin
      sql := 'select * from participante ' +
             'where '+campo+' = :busca '+
             'order by nome';
    end
    else
    begin
      sql := 'select * from participante ' +
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
      item.SubItems.Add(qry.FieldByName('fantasia').AsString);
      item.SubItems.Add(qry.FieldByName('cadastro').AsString);
      Qry.Next;
    end;

  finally
    qry.Close;
  end;
end;

procedure TParticipanteDAO.PesquisarCidade(lbNome, lbId: TListBox;
  busca: String; out QtdRegistro: Integer);
var
  sql: String;
begin
  try

    sql := 'select first 10 id, nome, uf from cidade ' +
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
      lbNome.Items.Add(qry.FieldByName('nome').AsString + ' - '+
                       qry.FieldByName('uf').AsString);
      Qry.Next;
    end;

  finally
    qry.Close;
  end;
end;

function TParticipanteDAO.BuscarPorId(Participante : TParticipante; Id: Integer; out Erro: String;
  DonoCadastro: Boolean = false): Boolean;
var
  sql: String;
begin
  try

    sql := 'select p.*, c.nome as nome_cidade, c.uf from participante p ' +
           'left join cidade c on c.id = p.id_cidade ' +
           'where p.id = :id and dono_cadastro = :dono_cadastro ' +
           'order by p.id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger := id;
    Qry.ParamByName('dono_cadastro').AsBoolean := DonoCadastro;
    Qry.Open;

    if Qry.RecordCount = 1 then
    begin
      Participante.Id        := Qry.FieldByName('id').AsInteger;
      Participante.Pessoa    := Qry.FieldByName('pessoa').AsString;
      Participante.Nome      := Qry.FieldByName('nome').AsString;
      Participante.Fantasia  := Qry.FieldByName('fantasia').AsString;
      Participante.CNPJ      := Qry.FieldByName('cnpj').AsString;
      Participante.IE        := Qry.FieldByName('ie').AsInteger;
      Participante.Telefone  := Qry.FieldByName('telefone').AsString;
      Participante.Celular   := Qry.FieldByName('celular').AsString;
      Participante.Email     := Qry.FieldByName('email').AsString;
      Participante.CEP       := Qry.FieldByName('cep').AsString;
      Participante.Rua       := Qry.FieldByName('rua').AsString;
      Participante.Numero    := Qry.FieldByName('numero').Asinteger;
      Participante.Complemento := Qry.FieldByName('complemento').AsString;
      Participante.Bairro    := Qry.FieldByName('bairro').AsString;
      Participante.Obs       := Qry.FieldByName('obs').AsString;
      Participante.Cadastro  := Qry.FieldByName('cadastro').AsDateTime;
      Participante.Alteracao := Qry.FieldByName('alteracao').AsDateTime;
      Participante.EhDonoCadastro := Qry.FieldByName('dono_cadastro').AsBoolean;
      Participante.Cidade.Id := Qry.FieldByName('id_cidade').AsInteger;
      Participante.Cidade.Nome := Qry.FieldByName('nome_cidade').AsString;
      Participante.Cidade.Estado.UF := Qry.FieldByName('uf').AsString;
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

function TParticipanteDAO.Inserir(Participante : TParticipante; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'insert into participante(id, pessoa, nome, fantasia, cnpj, ie, telefone, ' +
           'celular, email, cep, rua, numero, complemento, bairro, obs, cadastro, ' +
           'dono_cadastro, id_cidade, id_usuario_cadastro, id_dono_cadastro) '+
           'values (:id, :pessoa, :nome, :fantasia, :cnpj, :ie, :telefone, ' +
           ':celular, :email, :cep, :rua, :numero, :complemento, :bairro, :obs, :cadastro, ' +
           ':dono_cadastro, :id_cidade, :id_usuario_cadastro, :id_dono_cadastro)';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger           := Participante.Id;
    Qry.ParamByName('pessoa').AsString        := Participante.Pessoa;
    Qry.ParamByName('nome').AsString          := Participante.Nome;
    Qry.ParamByName('fantasia').AsString      := Participante.Fantasia;
    Qry.ParamByName('cnpj').AsString          := Participante.CNPJ;
    Qry.ParamByName('ie').AsInteger           := Participante.IE;
    Qry.ParamByName('telefone').AsString      := Participante.Telefone;
    Qry.ParamByName('celular').AsString       := Participante.Celular;
    Qry.ParamByName('email').AsString         := Participante.Email;
    Qry.ParamByName('cep').AsString           := Participante.CEP;
    Qry.ParamByName('rua').AsString           := Participante.Rua;
    Qry.ParamByName('numero').AsInteger       := Participante.Numero;
    Qry.ParamByName('complemento').AsString   := Participante.Complemento;
    Qry.ParamByName('bairro').AsString        := Participante.Bairro;
    Qry.ParamByName('obs').AsString           := Participante.Obs;
    Qry.ParamByName('cadastro').AsDateTime    := Participante.Cadastro;
    Qry.ParamByName('dono_cadastro').AsBoolean := Participante.EhDonoCadastro;
    Qry.ParamByName('id_cidade').AsInteger     := Participante.Cidade.Id;
    Qry.ParamByName('id_usuario_cadastro').AsInteger := Participante.UsuarioCadastro.Id;
    //Qry.ParamByName('id_dono_cadastro').AsInteger := Participante.DonoCadastro.Id;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao inserir participante: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TParticipanteDAO.Editar(Participante : TParticipante; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'update participante set pessoa=:pessoa, nome=:nome, fantasia=:fantasia, ' +
           'cnpj=:cnpj, ie=:ie, telefone=:telefone, celular=:celular, email=:email, ' +
           'cep=:cep, rua=:rua, numero=:numero, complemento=:complemento, ' +
           'bairro=:bairro, obs=:obs, alteracao=:alteracao, dono_cadastro=:dono_cadastro, ' +
           'id_cidade=:id_cidade ' +
           'where id = :id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger           := Participante.Id;
    Qry.ParamByName('pessoa').AsString        := Participante.Pessoa;
    Qry.ParamByName('nome').AsString          := Participante.Nome;
    Qry.ParamByName('fantasia').AsString      := Participante.Fantasia;
    Qry.ParamByName('cnpj').AsString          := Participante.CNPJ;
    Qry.ParamByName('ie').AsInteger           := Participante.IE;
    Qry.ParamByName('telefone').AsString      := Participante.Telefone;
    Qry.ParamByName('celular').AsString       := Participante.Celular;
    Qry.ParamByName('email').AsString         := Participante.Email;
    Qry.ParamByName('cep').AsString           := Participante.CEP;
    Qry.ParamByName('rua').AsString           := Participante.Rua;
    Qry.ParamByName('numero').AsInteger       := Participante.Numero;
    Qry.ParamByName('complemento').AsString   := Participante.Complemento;
    Qry.ParamByName('bairro').AsString        := Participante.Bairro;
    Qry.ParamByName('obs').AsString           := Participante.Obs;
    Qry.ParamByName('alteracao').AsDateTime   := Participante.Alteracao;
    Qry.ParamByName('dono_cadastro').AsBoolean := Participante.EhDonoCadastro;
    Qry.ParamByName('id_cidade').AsInteger     := Participante.Cidade.Id;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      dmConexao1.SQLTransaction.Rollback;
      Erro := 'Ocorreu um erro ao alterar participante: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TParticipanteDAO.Excluir(Id: Integer; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'delete from participante where id = :id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger  := Id;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao excluir participante: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TParticipanteDAO.GerarId(Gerador: String; Incremento: Integer): Integer;
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

constructor TParticipanteDAO.Create;
begin
  Qry := TSQLQuery.Create(nil);
  qry.SQLConnection := dmConexao1.SQLConnector;
end;

destructor TParticipanteDAO.Destroy;
begin
  Qry.Free;
  inherited Destroy;
end;

end.
