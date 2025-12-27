{
*******************************************************************************
*   VRBDespesas                                                               *
*   Controle e gerenciamento de despesas.                                     *
*                                                                             *
*   Copyright (C) 2025 Vinícius Ruan Brandalize.                              *
*                                                                             *
*   This program is free software: you can redistribute it and/or modify      *
*   it under the terms of the GNU General Public License as published by      *
*   the Free Software Foundation, either version 3 of the License, or         *
*   (at your option) any later version.                                       *
*                                                                             *
*   This program is distributed in the hope that it will be useful,           *
*   but WITHOUT ANY WARRANTY; without even the implied warranty of            *
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             *
*   GNU General Public License for more details.                              *
*                                                                             *
*   You should have received a copy of the GNU General Public License         *
*   along with this program.  If not, see <https://www.gnu.org/licenses/>.    *
*                                                                             *
*   Contact: viniciusbrandalize2@gmail.com.                                   *
*                                                                             *
*******************************************************************************
}

unit model.dao.padrao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, SQLDB, model.connection.conexao1,
  model.connection.conexao2, StrUtils, model.ini.conexao, lib.util;

type

  TDriverDB = (DRV_FIREBIRD, DRV_MSSQLSERVER, DRV_MYSQL, DRV_MARIADB, DRV_ODBC,
               DRV_ORACLE, DRV_POSTGRESQL, DRV_SQLITE3);

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
                SEQ_ID_USUARIO_DONO_CADASTRO, SEQ_ID_ARQUIVO, SEQ_ID_UC_ACAO,
                SEQ_ID_UC_ACESSO);

  { TPadraoDAO }

  TPadraoDAO = class
  private
    FAutoInc: Boolean;
    FDriver: TDriverDB;
    FConectorPadrao: TSQLConnector;
    function SequenciaToString(Sequencia: TSequencia): String;
    function TabelaToString(Tabela: TTabela): String;
    function StrToDriverDB(Driver: String): TDriverDB;
    function TemCampoExcluido(Tabela: TTabela): Boolean;
  public
    Qry: TSQLQuery;
    procedure Listar(lv: TListView); virtual; abstract;
    procedure Pesquisar(lv: TListView; Campo, Busca: String); virtual; abstract;
    procedure PesquisaGenerica(Tabela: TTabela; objNome: TObject; lbId: TListBox; busca: String;
                                Limitacao: Integer; out QtdRegistro: Integer);
    function GerarId(Sequencia: TSequencia; Incremento: Integer=1; Conector: TSQLConnector = nil): Integer;
    function UltimoIdInserido(): Integer;
    function ILikeSQL(Campo: String = ''; Param: String = ''): String;
    function Collate(): String;
    procedure CriarQuery(var SQLQuery: TSQLQuery; Conector: TSQLConnector);
    procedure Commit(Conexao: Integer = 1);
    procedure Roolback(Conexao: Integer = 1);

    constructor Create; virtual;
    destructor Destroy; override;

    property Driver: TDriverDB read FDriver write FDriver;
    property AutoInc: Boolean read FAutoInc write FAutoInc;
  end;

implementation

{ TPadraoDAO }

function TPadraoDAO.SequenciaToString(Sequencia: TSequencia): String;
var
  NomeSeq: String;
begin
  NomeSeq := '';
  if FDriver = DRV_FIREBIRD Then
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
      SEQ_ID_UC_ACAO:               NomeSeq := 'gen_id_uc_acao';
      SEQ_ID_UC_ACESSO:             NomeSeq := 'gen_id_uc_acesso';
    end;
  end
  else
  if FDriver = DRV_POSTGRESQL Then
  begin
    case Sequencia of
      SEQ_ID_BANCO:                 NomeSeq := 'seq_id_banco';
      SEQ_ID_BANDEIRA:              NomeSeq := 'seq_id_bandeira';
      SEQ_ID_CARTAO:                NomeSeq := 'seq_id_cartao';
      SEQ_ID_CIDADE:                NomeSeq := 'seq_id_cidade';
      SEQ_ID_COFRE:                 NomeSeq := 'seq_id_cofre';
      SEQ_ID_CONTA_BANCARIA:        NomeSeq := 'seq_id_conta_bancaria';
      SEQ_ID_DESPESA:               NomeSeq := 'seq_id_despesa';
      SEQ_ID_DESPESA_FORMA_PGTO:    NomeSeq := 'seq_id_despesa_forma_pgto';
      SEQ_ID_FORMA_PGTO:            NomeSeq := 'seq_id_forma_pgto';
      SEQ_ID_LOG_BACKUP:            NomeSeq := 'seq_id_log_backup';
      SEQ_ID_LOGIN:                 NomeSeq := 'seq_id_login';
      SEQ_ID_PAIS:                  NomeSeq := 'seq_id_pais';
      SEQ_ID_PARTICIPANTE:          NomeSeq := 'seq_id_participante';
      SEQ_ID_RECEBIMENTO:           NomeSeq := 'seq_id_recebimento';
      SEQ_ID_SUBTIPO_DESPESA:       NomeSeq := 'seq_id_subtipo_despesa';
      SEQ_ID_TIPO_DESPESA:          NomeSeq := 'seq_id_tipo_despesa';
      SEQ_ID_USUARIO:               NomeSeq := 'seq_id_usuario';
      SEQ_ID_USUARIO_DONO_CADASTRO: NomeSeq := 'seq_id_usuario_dono_cadastro';
      SEQ_ID_ARQUIVO:               NomeSeq := 'seq_id_arquivo';
      SEQ_ID_UC_ACAO:               NomeSeq := 'seq_id_uc_acao';
      SEQ_ID_UC_ACESSO:             NomeSeq := 'seq_id_uc_acesso';
    end;
  end;
  Result := NomeSeq;
end;

function TPadraoDAO.TabelaToString(Tabela: TTabela): String;
var
  NomeTb: String;
begin
  NomeTb := '';
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
  Result := NomeTb;
end;

function TPadraoDAO.StrToDriverDB(Driver: String): TDriverDB;
begin
  if Driver = 'FIREBIRD' then
    Result := DRV_FIREBIRD
  else
  if Driver = 'POSTGRESQL' then
    result := DRV_POSTGRESQL
  else
  if Driver = 'MYSQL 5.7' then
    Result := DRV_MARIADB
  else
  if Pos('MYSQL', UpperCase(Driver)) <> 0 then
    Result := DRV_MYSQL
  else
  if Driver = 'MSSQLSERVER' then
    result := DRV_MSSQLSERVER
  else
  if Driver = 'ODBC' then
    result := DRV_ODBC
  else
  if Driver = 'SQLITE3' then
    result := DRV_SQLITE3
  else
  if Driver = 'ORACLE' then
    result := DRV_ORACLE;
end;

function TPadraoDAO.TemCampoExcluido(Tabela: TTabela): Boolean;
begin
  Result := (Tabela in [TB_BANCO, TB_BANDEIRA, TB_CARTAO, TB_CONTA_BANCARIA,
                        TB_FORMA_PGTO, TB_PARTICIPANTE, TB_PIX,
                        TB_SUBTIPO_DESPESA, TB_TIPO_DESPESA, TB_USUARIO]);
end;

procedure TPadraoDAO.PesquisaGenerica(Tabela: TTabela; objNome: TObject;
  lbId: TListBox; busca: String; Limitacao: Integer; out QtdRegistro: Integer);
var
  sql: String;
  NomeTabela: String;
  CmdLimit: String;
  WhereExcluido: String;
begin
  try

    CmdLimit := '';
    WhereExcluido := '';
    NomeTabela := TabelaToString(Tabela);

    if TemCampoExcluido(Tabela) then
      WhereExcluido := 'and excluido = false ';

    if FDriver = DRV_FIREBIRD then
    begin
      if Limitacao <> -1 then
        CmdLimit := 'first '+Limitacao.ToString;

      sql := 'select '+CmdLimit+' id, nome from '+NomeTabela+' '+
             'where '+ILikeSQL('nome', 'busca')+' '+WhereExcluido+
             'order by nome '+Collate();
    end
    else
    if FDriver in [DRV_POSTGRESQL, DRV_MYSQL, DRV_MARIADB] then
    begin
      if Limitacao <> -1 then
        CmdLimit := 'limit '+Limitacao.ToString;

      sql := 'select id, nome from '+NomeTabela+' '+
             'where '+ILikeSQL('nome', 'busca')+' '+WhereExcluido+
             'order by nome ' +CmdLimit;
    end;

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('busca').AsString := '%'+UpperCase(Busca)+'%';
    Qry.Open;

    Qry.First;

    QtdRegistro := Qry.RecordCount;

    if objNome is TListBox then
    begin
      (objNome as TListBox).Items.Clear;
      (objNome as TListBox).Height := 100;
    end
    else
    if objNome is TComboBox then
      (objNome as TComboBox).Items.Clear;

    lbId.Items.Clear;

    while not Qry.EOF do
    begin
      lbId.Items.Add(Qry.FieldByName('id').AsString);
      if objNome is TListBox then
        (objNome as TListBox).Items.Add(qry.FieldByName('nome').AsString)
      else
      if objNome is TComboBox then
        (objNome as TComboBox).Items.Add(qry.FieldByName('nome').AsString);
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

    if FDriver = DRV_FIREBIRD then
    begin
      sql := 'SELECT GEN_ID('+nomeSequencia+','+IntToStr(Incremento)+') AS ID '+
             'FROM RDB$DATABASE';
    end
    else
    if FDriver = DRV_POSTGRESQL then
    begin
      sql := 'select nextval('+QuotedStr('public.'+nomeSequencia)+') AS ID ';
    end
    else
    if FDriver = DRV_MSSQLSERVER then
    begin
      sql := 'SELECT NEXT VALUE FOR dbo.'+nomeSequencia+' AS ID';
    end;

    if sql <> EmptyStr then
    begin
      QryTemp.Close;
      QryTemp.SQL.Clear;
      QryTemp.SQL.Add(sql);
      QryTemp.Open;
      id := QryTemp.FieldByName('ID').AsInteger;
    end;

    Result := id;

  finally
    QryTemp.Close;
    QryTemp.Free;
  end;
end;

function TPadraoDAO.UltimoIdInserido(): Integer;
var
  id: Integer;
  sql: String;
begin
  id := 0;
  sql := '';
  try

    if (FDriver = DRV_MYSQL) or (FDriver = DRV_MARIADB) then
      sql := 'select last_insert_id() as id';

    if sql <> EmptyStr then
    begin
      Qry.Close;
      Qry.SQL.Clear;
      Qry.SQL.Add(sql);
      Qry.Open;
      id := Qry.FieldByName('id').AsInteger;
    end;

    Result := id;

  finally
    Qry.Close;
  end;
end;

function TPadraoDAO.ILikeSQL(Campo: String = ''; Param: String = ''): String;
begin
  if Param = '' then
    Param := Campo;
  case FDriver of
    DRV_FIREBIRD: Result := IfThen(Campo = '', IfThen(Collate() = '', 'like', Collate()+' like'),
                                               IfThen(Collate() = '', 'upper('+Campo+') like upper(:'+Param+')', 'upper('+Campo+')'+Collate()+' like upper(:'+Param+')'));
    DRV_MYSQL, DRV_MARIADB: Result := IfThen(Campo = '', 'like', 'upper('+Campo+') like upper(:'+Param+')');
    DRV_POSTGRESQL:         Result := IfThen(Campo = '', 'ilike', 'unaccent('+Campo+') ilike unaccent(:'+Param+')');
    else
      Result := IfThen(Campo = '', 'like', 'upper('+Campo+') like upper(:'+Param+')');
  end;
end;

function TPadraoDAO.Collate(): String;
var
  INI: TConexaoINI;
begin
  INI := TConexaoINI.Create;
  try
    case FDriver of
      DRV_FIREBIRD: Result := IfThen(Trim(INI.Collate1) = '', '', 'collate '+Trim(INI.Collate1));
      else
        Result := '';
    end;
  finally
    INI.Free;
  end;
end;

procedure TPadraoDAO.CriarQuery(var SQLQuery: TSQLQuery; Conector: TSQLConnector);
begin
  SQLQuery := TSQLQuery.Create(nil);
  SQLQuery.SQLConnection := Conector;
end;

procedure TPadraoDAO.Commit(Conexao: Integer = 1);
begin
  case Conexao of
    1: dmConexao1.SQLTransaction.Commit;
    2: dmConexao2.SQLTransaction.Commit;
  end;
end;

procedure TPadraoDAO.Roolback(Conexao: Integer = 1);
begin
  case Conexao of
    1: dmConexao1.SQLTransaction.Rollback;
    2: dmConexao2.SQLTransaction.Rollback;
  end;
end;

constructor TPadraoDAO.Create;
begin
  FConectorPadrao := dmConexao1.SQLConnector;
  FDriver := StrToDriverDB(Trim(UpperCase(dmConexao1.SQLConnector.ConnectorType)));
  FAutoInc := (FDriver in [DRV_MYSQL, DRV_MARIADB]);
  CriarQuery(Qry, FConectorPadrao);
end;

destructor TPadraoDAO.Destroy;
begin
  Qry.Free;
  inherited Destroy;
end;

end.

