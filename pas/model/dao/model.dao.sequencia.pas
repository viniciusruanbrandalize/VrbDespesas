unit model.dao.sequencia;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, model.connection.conexao1,
  model.connection.conexao2;

type

  TGenerator = (GEN_ID_BANCO, GEN_ID_BANDEIRA, GEN_ID_CARTAO, GEN_ID_CIDADE,
                GEN_ID_COFRE, GEN_ID_CONTA_BANCARIA, GEN_ID_DESPESA,
                GEN_ID_DESPESA_FORMA_PGTO, GEN_ID_FORMA_PGTO, GEN_ID_LOG_BACKUP,
                GEN_ID_LOGIN, GEN_ID_PAIS, GEN_ID_PARTICIPANTE, GEN_ID_RECEBIMENTO,
                GEN_ID_SUBTIPO_DESPESA, GEN_ID_TIPO_DESPESA, GEN_ID_USUARIO,
                GEN_ID_USUARIO_DONO_CADASTRO);

  { TSequenciaDAO }

  TSequenciaDAO = class
  private
    Qry: TSQLQuery;
    FDriver:      String;
    FNomeGerador: String;
    FSQL:         String;
    procedure GeneratorToString(Gerador: TGenerator);
  public
    function GerarId(Gerador: TGenerator; Incremento: Integer=1): Integer;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TSequenciaDAO }

procedure TSequenciaDAO.GeneratorToString(Gerador: TGenerator);
begin
  if FDriver = 'FIREBIRD' Then
  begin
    case Gerador of
      GEN_ID_BANCO:    FNomeGerador := 'gen_id_banco';
      GEN_ID_BANDEIRA: FNomeGerador := 'gen_id_bandeira';
      GEN_ID_CARTAO:   FNomeGerador := 'gen_id_cartao';
      //A IMPLEMENTAR....
    end;
  end;
end;

function TSequenciaDAO.GerarId(Gerador: TGenerator; Incremento: Integer): Integer;
var
  id: integer;
begin
  id := 0;
  try
    GeneratorToString(Gerador);

    if FDriver = 'FIREBIRD' then
    begin
      FSQL := 'SELECT GEN_ID('+FNomeGerador+', '+IntToStr(Incremento)+') AS ID ' +
              'FROM RDB$DATABASE';
    end;

    Qry.SQL.Add(FSQL);
    Qry.Open;

    id := Qry.FieldByName('ID').AsInteger;
    Result := id;

  finally
    Qry.Close;
  end;
end;

constructor TSequenciaDAO.Create;
begin
  Qry := TSQLQuery.Create(nil);
  qry.SQLConnection := dmConexao1.SQLConnector;
  FDriver := Trim(UpperCase(dmConexao1.SQLConnector.ConnectorType));
end;

destructor TSequenciaDAO.Destroy;
begin
  Qry.Free;
  inherited Destroy;
end;

end.
