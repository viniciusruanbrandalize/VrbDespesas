unit model.dao.padrao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, SQLDB, model.connection.conexao1;

type

  TTabela = (TB_BANCO, TB_BANDEIRA, TB_CARTAO, TB_CIDADE);

  { TPadraoDAO }

  TPadraoDAO = class
  private
    Qry: TSQLQuery;
  public
    procedure Listar(lv: TListView); virtual; abstract;
    procedure Pesquisar(lv: TListView; Campo, Busca: String); virtual; abstract;
    procedure PesquisaGenerica(Tabela: TTabela; lbNome, lbId: TListBox; busca: String; Limitacao: Integer;
                                out QtdRegistro: Integer);
    procedure CriarQuery(var SQLQuery: TSQLQuery; Conector: TSQLConnector);
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TPadraoDAO }

procedure TPadraoDAO.PesquisaGenerica(Tabela: TTabela; lbNome, lbId: TListBox;
  busca: String; Limitacao: Integer; out QtdRegistro: Integer);
var
  sql: String;
begin
  try

    sql := 'select first 10 id, nome from tipo_despesa ' +
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

procedure TPadraoDAO.CriarQuery(var SQLQuery: TSQLQuery; Conector: TSQLConnector);
begin
  SQLQuery := TSQLQuery.Create(nil);
  SQLQuery.SQLConnection := Conector;
end;

constructor TPadraoDAO.Create;
begin
  CriarQuery(Qry, dmConexao1.SQLConnector);
end;

destructor TPadraoDAO.Destroy;
begin
  Qry.Free;
  inherited Destroy;
end;

end.

