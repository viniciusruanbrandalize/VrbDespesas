unit model.dao.despesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, SQLDB, DB, model.dao.padrao,
  model.entity.despesa, model.entity.despesaformapagamento,
  model.entity.arquivo, model.connection.conexao1, model.connection.conexao2,
  lib.util;

type

  { TDespesaDAO }

  TDespesaDAO = class(TPadraoDAO)
  private
    QryArquivo: TSQLQuery;
  public
    procedure Listar(lv: TListView); override;
    procedure Pesquisar(lv: TListView; Campo, Busca: String); override;
    function BuscarPorId(Despesa : TDespesa; Id: Integer; out Erro: String): Boolean;
    function Inserir(Despesa : TDespesa; out Erro: string): Boolean;
    function Editar(Despesa : TDespesa; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;

    procedure ListarPagamento(lv: TListView; IdDespesa: Integer);
    function BuscarPagamentoPorId(Pagamento : TDespesaFormaPagamento; Id: Integer; out Erro: String): Boolean;
    procedure PesquisarPix(cbNome: TComboBox; lbId: TListBox; busca: String;
                                Limitacao: Integer; out QtdRegistro: Integer);
    procedure PesquisarCartao(cbNome: TComboBox; lbId: TListBox; busca: String;
                                Limitacao: Integer; out QtdRegistro: Integer);
    procedure PesquisarContaBancaria(cbNome: TComboBox; lbId: TListBox; busca: String;
                                      Limitacao: Integer; out QtdRegistro: Integer);

    function BuscarArquivoPorId(Arquivo: TArquivo; Id: Integer; out Erro: String): Boolean;
    function ExcluirArquivo(Id: Integer; out Erro: string): Boolean;

    constructor Create; override;
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

    if Driver = DRV_FIREBIRD then
    begin
      sql := 'select first 100 d.*, f.nome as nome_fornecedor from despesa d ' +
             'left join participante f on f.id = d.id_fornecedor ' +
             'where d.paga = true and d.id_dono_cadastro = :id_dono_cadastro ' +
             'order by d.data desc, d.hora desc';
    end
    else
    if Driver in [DRV_MYSQL, DRV_MARIADB, DRV_POSTGRESQL] then
    begin
      sql := 'select d.*, f.nome as nome_fornecedor from despesa d ' +
             'left join participante f on f.id = d.id_fornecedor ' +
             'where d.paga = true and d.id_dono_cadastro = :id_dono_cadastro ' +
             'order by d.data desc, d.hora desc ' +
             'limit 100';
    end;

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id_dono_cadastro').AsInteger := dmConexao1.DonoCadastro.Id;
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
             'where '+campo+' = :busca and d.paga = true and ' +
             'd.id_dono_cadastro = :id_dono_cadastro '+
             'order by d.data desc, d.hora desc';
    end
    else
    begin
      sql := 'select d.*, f.nome as nome_fornecedor from despesa d ' +
             'left join participante f on f.id = d.id_fornecedor ' +
             'where UPPER('+campo+') like :busca and d.paga = true and ' +
             'd.id_dono_cadastro = :id_dono_cadastro '+
             'order by d.data desc, d.hora desc';
    end;

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('busca').AsString := '%'+UpperCase(Busca)+'%';
    Qry.ParamByName('id_dono_cadastro').AsInteger := dmConexao1.DonoCadastro.Id;
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

function TDespesaDAO.BuscarPorId(Despesa : TDespesa; Id: Integer; out Erro: String): Boolean;
var
  sql: String;
  i: Integer;
begin
  try

    sql := 'select d.*, f.nome as nome_fornecedor, sd.nome as nome_subtipo ' +
           'from despesa d ' +
           'left join participante f on f.id = d.id_fornecedor ' +
           'left join subtipo_despesa sd on sd.id = d.id_subtipo ' +
           'where d.id = :id and d.paga = true and ' +
           'd.id_dono_cadastro = :id_dono_cadastro ' +
           'order by d.id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger := id;
    Qry.ParamByName('id_dono_cadastro').AsInteger := dmConexao1.DonoCadastro.Id;
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
      Despesa.NivelPrecisao := Qry.FieldByName('nivel_precisao').AsInteger;
      Despesa.Cadastro  := Qry.FieldByName('cadastro').AsDateTime;
      Despesa.Alteracao := Qry.FieldByName('alteracao').AsDateTime;
      Despesa.Observacao:= Qry.FieldByName('obs').AsString;
      Despesa.Fornecedor.Id := Qry.FieldByName('id_fornecedor').AsInteger;
      Despesa.Fornecedor.Nome := Qry.FieldByName('nome_fornecedor').AsString;
      Despesa.SubTipo.Id := Qry.FieldByName('id_subtipo').AsInteger;
      Despesa.SubTipo.Nome := Qry.FieldByName('nome_subtipo').AsString;
      Result := True;

      sql := 'select * from arquivo ' +
             'where id_despesa = :id ' +
             'order by nome';

      QryArquivo.Close;
      QryArquivo.SQL.Clear;
      QryArquivo.SQL.Add(sql);
      QryArquivo.ParamByName('id').AsInteger := id;
      QryArquivo.Open;

      QryArquivo.First;
      Despesa.Arquivo.Clear;

      while not QryArquivo.EOF do
      begin
        Despesa.Arquivo.Add(TArquivo.Create);
        i := Despesa.Arquivo.Count-1;
        Despesa.Arquivo[i].Id       := QryArquivo.FieldByName('id').AsInteger;
        Despesa.Arquivo[i].Nome     := QryArquivo.FieldByName('nome').AsString;
        Despesa.Arquivo[i].Extensao := QryArquivo.FieldByName('extensao').AsString;
        Despesa.Arquivo[i].DataHoraUpload := QryArquivo.FieldByName('data_hora_upload').AsDateTime;
        Despesa.Arquivo[i].Binario.WriteString(QryArquivo.FieldByName('binario').AsString);
        QryArquivo.Next;
      end;

      sql := 'select pgto.*, fp.nome as nome_forma_pgto from despesa_forma_pgto pgto ' +
           'left join forma_pgto fp on fp.id = pgto.id_forma_pgto ' +
           'where pgto.id_despesa = :id ' +
           'order by pgto.id';

      Qry.Close;
      Qry.SQL.Clear;
      Qry.SQL.Add(sql);
      Qry.ParamByName('id').AsInteger := id;
      Qry.Open;

      Qry.First;
      Despesa.DespesaFormaPagamento.Clear;

      while not Qry.EOF do
      begin
        Despesa.DespesaFormaPagamento.Add(TDespesaFormaPagamento.Create);
        i := Despesa.DespesaFormaPagamento.Count-1;
        Despesa.DespesaFormaPagamento[i].Id    := Qry.FieldByName('id').AsInteger;
        Despesa.DespesaFormaPagamento[i].Valor := Qry.FieldByName('valor').AsFloat;
        Despesa.DespesaFormaPagamento[i].FormaPagamento.Id   := Qry.FieldByName('id_forma_pgto').AsInteger;
        Despesa.DespesaFormaPagamento[i].FormaPagamento.Nome := Qry.FieldByName('nome_forma_pgto').AsString;
        Qry.Next;
      end;

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
  i: Integer;
begin
  try

    sql := 'insert into despesa (id, data, hora, descricao, chave_nfe, valor, desconto, ' +
           'frete, outros, total, paga, parcela, nivel_precisao, cadastro, obs, id_fornecedor, ' +
           'id_subtipo, id_dono_cadastro, id_usuario_cadastro) values (' +
           ':id, :data, :hora, :descricao, :chave_nfe, :valor, :desconto, ' +
           ':frete, :outros, :total, :paga, :parcela, :nivel_precisao, :cadastro, :obs, :id_fornecedor, ' +
           ':id_subtipo, :id_dono_cadastro, :id_usuario_cadastro)';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);

    if not AutoInc then
    begin
      Despesa.Id := GerarId(SEQ_ID_DESPESA);
      Qry.ParamByName('id').AsInteger      := Despesa.Id;
    end;

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
    Qry.ParamByName('id_dono_cadastro').AsInteger := Despesa.DonoCadastro.Id;
    Qry.ParamByName('nivel_precisao').AsInteger := Despesa.NivelPrecisao;
    Qry.ExecSQL;

    if AutoInc then
      Despesa.Id := UltimoIdInserido();

    sql := 'insert into despesa_forma_pgto (id, valor, id_conta_bancaria, ' +
           'chave_pix, id_cartao, id_despesa, id_forma_pgto) values (:id, :valor, ' +
           ':id_conta_bancaria, :chave_pix, :id_cartao, :id_despesa, :id_forma_pgto)';

    for i := 0 to Despesa.DespesaFormaPagamento.Count-1 do
    begin

      Qry.Close;
      Qry.SQL.Clear;
      Qry.SQL.Add(sql);

      if not AutoInc then
      begin
        Despesa.DespesaFormaPagamento[i].Id := GerarId(SEQ_ID_DESPESA_FORMA_PGTO);
        Qry.ParamByName('id').AsInteger     := Despesa.DespesaFormaPagamento[i].Id;
      end;

      Qry.ParamByName('valor').AsFloat               := Despesa.DespesaFormaPagamento[i].Valor;

      if Despesa.DespesaFormaPagamento[i].ContaBancaria.Id > 0 then
        Qry.ParamByName('id_conta_bancaria').AsInteger := Despesa.DespesaFormaPagamento[i].ContaBancaria.Id
      else
      if Despesa.DespesaFormaPagamento[i].Cartao.Id > 0 then
        Qry.ParamByName('id_cartao').AsInteger         := Despesa.DespesaFormaPagamento[i].Cartao.Id
      else
      if Despesa.DespesaFormaPagamento[i].Pix.Chave <> '-1' then
        Qry.ParamByName('chave_pix').AsString          := Despesa.DespesaFormaPagamento[i].Pix.Chave;

      Qry.ParamByName('id_forma_pgto').AsInteger     := Despesa.DespesaFormaPagamento[i].FormaPagamento.Id;
      Qry.ParamByName('id_despesa').AsInteger        := Despesa.Id;
      Qry.ExecSQL;
    end;

    sql := 'insert into arquivo (id, nome, extensao, binario, data_hora_upload, ' +
           'id_despesa) values (:id, :nome, :extensao, :binario, :data_hora_upload, ' +
           ':id_despesa)';

    for i := 0 to Despesa.Arquivo.Count-1 do
    begin
      QryArquivo.Close;
      QryArquivo.SQL.Clear;
      QryArquivo.SQL.Add(sql);

      if not AutoInc then
      begin
        Despesa.Arquivo[i].Id := GerarId(SEQ_ID_ARQUIVO, 1, dmConexao2.SQLConnector);
        QryArquivo.ParamByName('id').AsInteger := Despesa.Arquivo[i].Id;
      end;

      QryArquivo.ParamByName('nome').AsString          := Despesa.Arquivo[i].Nome;
      QryArquivo.ParamByName('extensao').AsString      := Despesa.Arquivo[i].Extensao;
      QryArquivo.ParamByName('data_hora_upload').AsDateTime := Despesa.Arquivo[i].DataHoraUpload;
      QryArquivo.ParamByName('binario').LoadFromStream(Despesa.Arquivo[i].Binario, ftBlob);
      QryArquivo.ParamByName('id_despesa').AsInteger   := Despesa.Id;
      QryArquivo.ExecSQL;
    end;

    dmConexao1.SQLTransaction.Commit;
    dmConexao2.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      dmConexao1.SQLTransaction.Rollback;
      dmConexao2.SQLTransaction.Rollback;
      Erro := 'Ocorreu um erro ao inserir despesa: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TDespesaDAO.Editar(Despesa : TDespesa; out Erro: string): Boolean;
var
  sql: String;
  i: Integer;
begin
  try

    sql := 'update despesa set data=:data, hora=:hora, descricao=:descricao, ' +
           'chave_nfe=:chave_nfe, valor=:valor, desconto=:desconto, frete=:frete, ' +
           'outros=:outros, total=:total, paga=:paga, parcela=:parcela, ' +
           'alteracao=:alteracao, obs=:obs, id_fornecedor=:id_fornecedor, ' +
           'id_subtipo=:id_subtipo, nivel_precisao = :nivel_precisao ' +
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
    Qry.ParamByName('nivel_precisao').AsInteger := Despesa.NivelPrecisao;
    Qry.ExecSQL;

    for i := 0 to Despesa.Arquivo.Count-1 do
    begin
      //se for 0 insere
      if Despesa.Arquivo[i].Id = 0 then
      begin

        sql := 'insert into arquivo (id, nome, extensao, binario, data_hora_upload, ' +
           'id_despesa) values (:id, :nome, :extensao, :binario, :data_hora_upload, ' +
           ':id_despesa)';

        QryArquivo.Close;
        QryArquivo.SQL.Clear;
        QryArquivo.SQL.Add(sql);

        if not AutoInc then
        begin
          Despesa.Arquivo[i].Id := GerarId(SEQ_ID_ARQUIVO, 1, dmConexao2.SQLConnector);
          QryArquivo.ParamByName('id').AsInteger         := Despesa.Arquivo[i].Id;
        end;

        QryArquivo.ParamByName('nome').AsString          := Despesa.Arquivo[i].Nome;
        QryArquivo.ParamByName('extensao').AsString      := Despesa.Arquivo[i].Extensao;
        QryArquivo.ParamByName('data_hora_upload').AsDateTime := Despesa.Arquivo[i].DataHoraUpload;
        QryArquivo.ParamByName('binario').LoadFromStream(Despesa.Arquivo[i].Binario, ftBlob);
        QryArquivo.ParamByName('id_despesa').AsInteger   := Despesa.Id;
        QryArquivo.ExecSQL;

      end;
    end;

    dmConexao1.SQLTransaction.Commit;
    dmConexao2.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      dmConexao1.SQLTransaction.Rollback;
      dmConexao2.SQLTransaction.Rollback;
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

procedure TDespesaDAO.ListarPagamento(lv: TListView; IdDespesa: Integer);
var
  sql: String;
  item : TListItem;
begin
  try

    sql := 'select pgto.*, fp.nome as nome_forma_pgto from despesa_forma_pgto pgto ' +
           'left join forma_pgto fp on fp.id = pgto.id_forma_pgto ' +
           'left join despesa d on d.id = pgto.id_despesa ' +
           'where pgto.id_despesa = :id and d.paga = true and ' +
           'd.id_dono_cadastro = :id_dono_cadastro ' +
           'order by pgto.id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger := IdDespesa;
    Qry.ParamByName('id_dono_cadastro').AsInteger := dmConexao1.DonoCadastro.Id;
    Qry.Open;

    Qry.First;

    while not Qry.EOF do
    begin
      item := lv.Items.Add;
      item.Caption := Qry.FieldByName('id').AsString;
      item.SubItems.Add(qry.FieldByName('nome_forma_pgto').AsString);
      item.SubItems.Add(FormatFloat(',#0.00', qry.FieldByName('valor').AsFloat));
      Qry.Next;
    end;

  finally
    Qry.Close;
  end;
end;

function TDespesaDAO.BuscarPagamentoPorId(Pagamento: TDespesaFormaPagamento;
  Id: Integer; out Erro: String): Boolean;
var
  sql: String;
begin
  try

    sql := 'select pgto.*, fp.nome as nome_forma_pgto, card.numero as numero_cartao, ' +
           'ban.nome as nome_bandeira, cb.numero as numero_conta, cb.agencia as agencia_conta, ' +
           'bco.nome as nome_banco ' +
           'from despesa_forma_pgto pgto ' +
           'left join despesa d on d.id = pgto.id_despesa ' +
           'left join conta_bancaria cb on cb.id = pgto.id_conta_bancaria ' +
           'left join forma_pgto fp on fp.id = pgto.id_forma_pgto ' +
           'left join cartao card on card.id = pgto.id_cartao ' +
           'left join bandeira ban on ban.id = card.id_bandeira ' +
           'left join banco bco on bco.id = cb.id_banco ' +
           'where pgto.id_despesa = :id and d.paga = true and ' +
           'd.id_dono_cadastro = :id_dono_cadastro ' +
           'order by pgto.id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger := id;
    Qry.ParamByName('id_dono_cadastro').AsInteger := dmConexao1.DonoCadastro.Id;
    Qry.Open;

    if Qry.RecordCount = 1 then
    begin
      Pagamento.Id                   := Qry.FieldByName('id').AsInteger;
      Pagamento.Valor                := Qry.FieldByName('valor').AsFloat;
      Pagamento.FormaPagamento.Id    := Qry.FieldByName('id_forma_pgto').AsInteger;
      Pagamento.FormaPagamento.Nome  := Qry.FieldByName('nome_forma_pgto').AsString;
      Pagamento.Cartao.Id            := Qry.FieldByName('id_cartao').AsInteger;
      Pagamento.Cartao.Numero        := Qry.FieldByName('numero_cartao').AsString;
      Pagamento.Cartao.Bandeira.Nome := Qry.FieldByName('nome_bandeira').AsString;
      Pagamento.ContaBancaria.Id     := Qry.FieldByName('id_conta_bancaria').AsInteger;
      Pagamento.ContaBancaria.Numero := Qry.FieldByName('numero_conta').AsString;
      Pagamento.ContaBancaria.Agencia:= Qry.FieldByName('agencia_conta').AsString;
      Pagamento.ContaBancaria.Banco.Nome := Qry.FieldByName('nome_banco').AsString;
      Pagamento.Pix.Chave            := Qry.FieldByName('chave_pix').AsString;
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

procedure TDespesaDAO.PesquisarPix(cbNome: TComboBox; lbId: TListBox;
  busca: String; Limitacao: Integer; out QtdRegistro: Integer);
var
  sql: String;
  CmdLimit: String;
begin
  try

    CmdLimit := '';

    if Driver = DRV_FIREBIRD then
    begin
      if Limitacao <> -1 then
        CmdLimit := 'first '+Limitacao.ToString;

      sql := 'select '+CmdLimit+' chave from pix '+
             'where UPPER(chave) like :busca and ' +
             'id_dono_cadastro = :id_dono_cadastro '+
             'order by chave';
    end
    else
    if Driver in [DRV_MYSQL, DRV_MARIADB, DRV_POSTGRESQL] then
    begin
      if Limitacao <> -1 then
        CmdLimit := 'limit '+Limitacao.ToString;

      sql := 'select chave from pix '+
             'where UPPER(chave) like :busca and ' +
             'id_dono_cadastro = :id_dono_cadastro '+
             'order by chave '+CmdLimit;
    end;

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('busca').AsString := '%'+UpperCase(Busca)+'%';
    Qry.ParamByName('id_dono_cadastro').AsInteger := dmConexao1.DonoCadastro.Id;
    Qry.Open;

    Qry.First;

    QtdRegistro := Qry.RecordCount;

    cbNome.Items.Clear;
    cbNome.Height := 100;

    lbId.Items.Clear;

    while not Qry.EOF do
    begin
      lbId.Items.Add(Qry.FieldByName('chave').AsString);
      cbNome.Items.Add(qry.FieldByName('chave').AsString);
      Qry.Next;
    end;

  finally
    qry.Close;
  end;
end;

procedure TDespesaDAO.PesquisarCartao(cbNome: TComboBox; lbId: TListBox;
  busca: String; Limitacao: Integer; out QtdRegistro: Integer);
var
  sql: String;
  CmdLimit: String;
begin
  try

    CmdLimit := '';

    if Driver = DRV_FIREBIRD then
    begin
      if Limitacao <> -1 then
        CmdLimit := 'first '+Limitacao.ToString;

      sql := 'select '+CmdLimit+' c.id, c.numero, bnc.nome as nome_banco, ' +
             'b.nome as nome_bandeira ' +
             'from cartao c ' +
             'left join bandeira b on b.id = c.id_bandeira ' +
             'left join conta_bancaria cb on cb.id = c.id_conta_bancaria ' +
             'left join banco bnc on bnc.id = cb.id_banco '+
             'where UPPER(c.numero) like :busca and ' +
             'c.id_dono_cadastro = :id_dono_cadastro '+
             'order by c.numero';
    end
    else
    if Driver in [DRV_MYSQL, DRV_MARIADB, DRV_POSTGRESQL] then
    begin
      if Limitacao <> -1 then
        CmdLimit := 'limit '+Limitacao.ToString;

      sql := 'select c.id, c.numero, bnc.nome as nome_banco, ' +
             'b.nome as nome_bandeira ' +
             'from cartao c ' +
             'left join bandeira b on b.id = c.id_bandeira ' +
             'left join conta_bancaria cb on cb.id = c.id_conta_bancaria ' +
             'left join banco bnc on bnc.id = cb.id_banco '+
             'where UPPER(c.numero) like :busca and ' +
             'c.id_dono_cadastro = :id_dono_cadastro '+
             'order by c.numero '+CmdLimit;
    end;

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('busca').AsString := '%'+UpperCase(Busca)+'%';
    Qry.ParamByName('id_dono_cadastro').AsInteger := dmConexao1.DonoCadastro.Id;
    Qry.Open;

    Qry.First;

    QtdRegistro := Qry.RecordCount;

    cbNome.Items.Clear;
    cbNome.Height := 100;

    lbId.Items.Clear;

    while not Qry.EOF do
    begin
      lbId.Items.Add(Qry.FieldByName('id').AsString);
      cbNome.Items.Add(qry.FieldByName('numero').AsString+' - '+
                       qry.FieldByName('nome_bandeira').AsString+' - '+
                       qry.FieldByName('nome_banco').AsString);
      Qry.Next;
    end;

  finally
    qry.Close;
  end;
end;

procedure TDespesaDAO.PesquisarContaBancaria(cbNome: TComboBox; lbId: TListBox;
  busca: String; Limitacao: Integer; out QtdRegistro: Integer);
var
  sql: String;
  CmdLimit: String;
begin
  try

    CmdLimit := '';

    if Driver = DRV_FIREBIRD then
    begin
      if Limitacao <> -1 then
        CmdLimit := 'first '+Limitacao.ToString;

      sql := 'select '+CmdLimit+' cb.id, cb.numero, cb.agencia, bnc.nome as nome_banco ' +
             'from conta_bancaria cb ' +
             'left join banco bnc on bnc.id = cb.id_banco '+
             'where UPPER(cb.numero) like :busca and cb.excluido = false and ' +
             'cb.id_dono_cadastro = :id_dono_cadastro '+
             'order by cb.numero';
    end
    else
    if Driver in [DRV_MYSQL, DRV_MARIADB, DRV_POSTGRESQL] then
    begin
      if Limitacao <> -1 then
        CmdLimit := 'limit '+Limitacao.ToString;

      sql := 'select cb.id, cb.numero, cb.agencia, bnc.nome as nome_banco ' +
             'from conta_bancaria cb ' +
             'left join banco bnc on bnc.id = cb.id_banco '+
             'where UPPER(cb.numero) like :busca and cb.excluido = false and ' +
             'cb.id_dono_cadastro = :id_dono_cadastro '+
             'order by cb.numero '+CmdLimit;
    end;

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('busca').AsString := '%'+UpperCase(Busca)+'%';
    Qry.ParamByName('id_dono_cadastro').AsInteger := dmConexao1.DonoCadastro.Id;
    Qry.Open;

    Qry.First;

    QtdRegistro := Qry.RecordCount;

    cbNome.Items.Clear;
    cbNome.Height := 100;

    lbId.Items.Clear;

    while not Qry.EOF do
    begin
      lbId.Items.Add(Qry.FieldByName('id').AsString);
      cbNome.Items.Add('Nº. '+qry.FieldByName('numero').AsString+' Ag. '+
                       qry.FieldByName('agencia').AsString+' - '+
                       qry.FieldByName('nome_banco').AsString);
      Qry.Next;
    end;

  finally
    qry.Close;
  end;
end;

function TDespesaDAO.BuscarArquivoPorId(Arquivo: TArquivo; Id: Integer; out
  Erro: String): Boolean;
var
  sql: String;
begin
  try

    sql := 'select * from arquivo ' +
           'where id = :id ' +
           'order by id';

    QryArquivo.Close;
    QryArquivo.SQL.Clear;
    QryArquivo.SQL.Add(sql);
    QryArquivo.ParamByName('id').AsInteger := id;
    QryArquivo.Open;

    if QryArquivo.RecordCount = 1 then
    begin
      Arquivo.Id              := QryArquivo.FieldByName('id').AsInteger;
      Arquivo.DataHoraUpload  := QryArquivo.FieldByName('data_hora_upload').AsDateTime;
      Arquivo.Nome            := QryArquivo.FieldByName('nome').AsString;
      Arquivo.Extensao        := QryArquivo.FieldByName('extensao').AsString;
      Arquivo.IdDespesa       := QryArquivo.FieldByName('id_despesa').AsInteger;
      Arquivo.Binario.WriteString(QryArquivo.FieldByName('binario').AsString);
      Result := True;
    end
    else
    if QryArquivo.RecordCount > 1 then
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
    QryArquivo.Close;
  end;
end;

function TDespesaDAO.ExcluirArquivo(Id: Integer; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'delete from arquivo where id = :id';

    QryArquivo.Close;
    QryArquivo.SQL.Clear;
    QryArquivo.SQL.Add(sql);
    QryArquivo.ParamByName('id').AsInteger  := Id;
    QryArquivo.ExecSQL;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao excluir arquivo: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

constructor TDespesaDAO.Create;
begin
  inherited;
  CriarQuery(QryArquivo, dmConexao2.SQLConnector);
end;

destructor TDespesaDAO.Destroy;
begin
  QryArquivo.Free;
  inherited Destroy;
end;

end.
