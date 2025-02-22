unit model.dao.padrao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, SQLDB, model.connection.conexao1;

type

  TTabela = (TB_BANCO, TB_BANDEIRA, TB_CARTAO, TB_CIDADE, TB_COFRE,
             TB_CONFIGURACAO, TB_CONTA_BANCARIA, TB_DESPESA, TB_DESPESA_FORMA_PGTO,
             TB_ESTADO, TB_FORMA_PGTO, TB_LOG_BACKUP, TB_LOGIN, TB_PAIS,
             TB_PARTICIPANTE, TB_PIX, TB_RECEBIMENTO, TB_SUBTIPO_DESPESA,
             TB_TIPO_DESPESA, TB_UC_ACAO, TB_UC_ACESSO, TB_UC_TELA, TB_USUARIO,
             TB_USUARIO_DONO_CADASTRO, TB_ARQUIVO);

  TSequencia = (SEQ_ID_BANCO, SEQ_ID_BANDEIRA, SEQ_ID_CARTAO, SEQ_ID_CIDADE,
                SEQ_ID_COFRE, SEQ_ID_CONTA_BANCARIA, SEQ_ID_DESPESA,
                SEQ_ID_DESPESA_FORMA_PGTO, SEQ_ID_FORMA_PGTO, SEQ_ID_LOG_BACKUP,
                SEQ_ID_LOGIN, SEQ_ID_PAIS, SEQ_ID_PARTICIPANTE, SEQ_ID_RECEBIMENTO,
                SEQ_ID_SUBTIPO_DESPESA, SEQ_ID_TIPO_DESPESA, SEQ_ID_USUARIO,
                SEQ_ID_USUARIO_DONO_CADASTRO, SEQ_ID_ARQUIVO);

  { TPadraoDAO }

  TPadraoDAO = class
  private
    FDriver: String;
    FConectorPadrao: TSQLConnector;
    function SequenciaToString(Sequencia: TSequencia): String;
    function TabelaToString(Tabela: TTabela): String;
  public
    Qry: TSQLQuery;
    procedure Listar(lv: TListView); virtual; abstract;
    procedure Pesquisar(lv: TListView; Campo, Busca: String); virtual; abstract;
    procedure PesquisaGenerica(Tabela: TTabela; lbNome, lbId: TListBox; busca: String; Limitacao: Integer;
                                out QtdRegistro: Integer);
    function GerarId(Sequencia: TSequencia; Incremento: Integer=1; Conector: TSQLConnector = nil): Integer;

    procedure CriarQuery(var SQLQuery: TSQLQuery; Conector: TSQLConnector);
    constructor Create; virtual;
    destructor Destroy; override;
    property Driver: String read FDriver write FDriver;
  end;

implementation

{ TPadraoDAO }

function TPadraoDAO.SequenciaToString(Sequencia: TSequencia): String;
var
  NomeSeq: String;
begin
  NomeSeq := '';
  if FDriver = 'FIREBIRD' Then
  begin
    case Sequencia of
      SEQ_ID_BANCO:                 NomeSeq := 'gen_id_banco';
      SEQ_ID_BANDEIRA:              NomeSeq := 'gen_id_bandeira';
      SEQ_ID_CARTAO:                NomeSeq := 'gen_id_cartao';
      SEQ_ID_CIDADE:                NomeSeq := 'gen_id_cidade';
      SEQ_ID_COFRE:                 NomeSeq := 'gen_id_cofre';
      SEQ_ID_CONTA_BANCARIA:        NomeSeq := 'gen_id_conta_bancaria';
      SEQ_ID_DESPESA:               NomeSeq := 'gen_id_despesa';
      SEQ_ID_DESPESA_FORMA_PGTO:    NomeSeq := 'gen_id_despesa_forma_pgto';
      SEQ_ID_FORMA_PGTO:            NomeSeq := 'gen_id_forma_pgto';
      SEQ_ID_LOG_BACKUP:            NomeSeq := 'gen_id_log_backup';
      SEQ_ID_LOGIN:                 NomeSeq := 'gen_id_login';
      SEQ_ID_PAIS:                  NomeSeq := 'gen_id_pais';
      SEQ_ID_PARTICIPANTE:          NomeSeq := 'gen_id_participante';
      SEQ_ID_RECEBIMENTO:           NomeSeq := 'gen_id_recebimento';
      SEQ_ID_SUBTIPO_DESPESA:       NomeSeq := 'gen_id_subtipo_despesa';
      SEQ_ID_TIPO_DESPESA:          NomeSeq := 'gen_id_tipo_despesa';
      SEQ_ID_USUARIO:               NomeSeq := 'gen_id_usuario';
      SEQ_ID_USUARIO_DONO_CADASTRO: NomeSeq := 'gen_id_usuario_dono_cadastro';
      SEQ_ID_ARQUIVO:               NomeSeq := 'gen_id_arquivo';
    end;
  end;
  Result := NomeSeq;
end;

function TPadraoDAO.TabelaToString(Tabela: TTabela): String;
var
  NomeTb: String;
begin
  NomeTb := '';
  if FDriver = 'FIREBIRD' Then
  begin
    case Tabela of
      TB_BANCO:                 NomeTb := 'banco';
      TB_BANDEIRA:              NomeTb := 'bandeira';
      TB_CARTAO:                NomeTb := 'cartao';
      TB_CIDADE:                NomeTb := 'cidade';
      TB_COFRE:                 NomeTb := 'cofre';
      TB_CONFIGURACAO:          NomeTb := 'configuracao';
      TB_CONTA_BANCARIA:        NomeTb := 'conta_bancaria';
      TB_DESPESA:               NomeTb := 'despesa';
      TB_DESPESA_FORMA_PGTO:    NomeTb := 'despesa_forma_pgto';
      TB_ESTADO:                NomeTb := 'estado';
      TB_FORMA_PGTO:            NomeTb := 'forma_pgto';
      TB_LOG_BACKUP:            NomeTb := 'log_backup';
      TB_LOGIN:                 NomeTb := 'login';
      TB_PAIS:                  NomeTb := 'pais';
      TB_PARTICIPANTE:          NomeTb := 'participante';
      TB_PIX:                   NomeTb := 'pix';
      TB_RECEBIMENTO:           NomeTb := 'recebimento';
      TB_SUBTIPO_DESPESA:       NomeTb := 'subtipo_despesa';
      TB_TIPO_DESPESA:          NomeTb := 'tipo_despesa';
      TB_UC_ACAO:               NomeTb := 'uc_acao';
      TB_UC_ACESSO:             NomeTb := 'uc_acesso';
      TB_UC_TELA:               NomeTb := 'uc_tela';
      TB_USUARIO:               NomeTb := 'usuario';
      TB_USUARIO_DONO_CADASTRO: NomeTb := 'usuario_dono_cadastro';
      TB_ARQUIVO:               NomeTb := 'arquivo';
    end;
  end;
  Result := NomeTb;
end;

procedure TPadraoDAO.PesquisaGenerica(Tabela: TTabela; lbNome, lbId: TListBox;
  busca: String; Limitacao: Integer; out QtdRegistro: Integer);
var
  sql: String;
  NomeTabela: String;
begin
  try

    NomeTabela := TabelaToString(Tabela);

    if FDriver = 'FIREBIRD' then
    begin
      sql := 'select first '+Limitacao.ToString+' id, nome from '+NomeTabela+' '+
             'where UPPER(nome) like :busca '+
             'order by nome';
    end;

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

function TPadraoDAO.GerarId(Sequencia: TSequencia; Incremento: Integer;
  Conector: TSQLConnector = nil): Integer;
var
  id: integer;
  sql: String;
  nomeSequencia: String;
  QryTemp: TSQLQuery;
begin
  id := 0;

  if Conector = nil then
    CriarQuery(QryTemp, FConectorPadrao)
  else
    CriarQuery(QryTemp, Conector);

  try
    nomeSequencia := SequenciaToString(Sequencia);

    if FDriver = 'FIREBIRD' then
    begin
      sql := 'SELECT GEN_ID('+nomeSequencia+','+IntToStr(Incremento)+') AS ID '+
             'FROM RDB$DATABASE';
    end;

    QryTemp.Close;
    QryTemp.SQL.Clear;
    QryTemp.SQL.Add(sql);
    QryTemp.Open;

    id := QryTemp.FieldByName('ID').AsInteger;
    Result := id;

  finally
    QryTemp.Close;
    QryTemp.Free;
  end;
end;

procedure TPadraoDAO.CriarQuery(var SQLQuery: TSQLQuery; Conector: TSQLConnector);
begin
  SQLQuery := TSQLQuery.Create(nil);
  SQLQuery.SQLConnection := Conector;
end;

constructor TPadraoDAO.Create;
begin
  FConectorPadrao := dmConexao1.SQLConnector;
  FDriver := Trim(UpperCase(dmConexao1.SQLConnector.ConnectorType));
  CriarQuery(Qry, FConectorPadrao);
end;

destructor TPadraoDAO.Destroy;
begin
  Qry.Free;
  inherited Destroy;
end;

end.

