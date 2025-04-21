unit model.connection.conexao1;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, SQLDBLib, SQLite3Conn, PQConnection,
  oracleconnection, odbcconn, mysql40conn, mysql41conn, mysql50conn,
  mysql51conn, mysql55conn, mysql56conn, mysql57conn, mysql80conn, MSSQLConn,
  IBConnection, model.ini.conexao, forms, view.mensagem, DB, lib.types,
  model.entity.usuariodonocadastro, model.entity.usuario, model.entity.participante;

type

  { TdmConexao1 }

  TdmConexao1 = class(TDataModule)
    SQLConnector: TSQLConnector;
    SQLDBLibraryLoader: TSQLDBLibraryLoader;
    SQLQuery: TSQLQuery;
    SQLTransaction: TSQLTransaction;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure SQLConnectorLog(Sender: TSQLConnection; EventType: TDBEventType;
      const Msg: String);
  private
    FUsuario: TUsuario;
    FDonoCadastro: TParticipante;
    FUsuarioDC: TUsuarioDonoCadastroLista;
    procedure ConectarBaseDeDados();
    function VerificarNomeDLL(Driver: String): String;
  public
    property Usuario:      TUsuario read FUsuario write FUsuario;
    property DonoCadastro: TParticipante read FDonoCadastro write FDonoCadastro;
    property UsuarioDC:    TUsuarioDonoCadastroLista read FUsuarioDC write FUsuarioDC;
  end;

var
  dmConexao1: TdmConexao1;

implementation

{$R *.lfm}

{ TdmConexao1 }

procedure TdmConexao1.DataModuleCreate(Sender: TObject);
begin
  FUsuario      := TUsuario.Create;
  FDonoCadastro := TParticipante.Create;
  FUsuarioDC    := TUsuarioDonoCadastroLista.Create;
  ConectarBaseDeDados;
  {$IFOPT D+}
  FUsuario.Id := 1;
  FUsuario.Nome := 'ADMIN';
  FDonoCadastro.Id := 77;
  {$ELSE}
  {$ENDIF}
end;

procedure TdmConexao1.DataModuleDestroy(Sender: TObject);
begin
  FUsuario.Free;
  FDonoCadastro.Free;
  FUsuarioDC.Free;
end;

procedure TdmConexao1.SQLConnectorLog(Sender: TSQLConnection;
  EventType: TDBEventType; const Msg: String);
var
  log: TextFile;
  arq: String;
  ini: TConexaoINI;
begin
  ini := TConexaoINI.Create;
  try

    if ini.LogSQL1 then
    begin
      arq := ExtractFilePath(ParamStr(0))+'SQLCon1.log';
      AssignFile(log, arq);
      try

        if FileExists(arq) then
        begin
          append(log);
        end
        else
        begin
          Rewrite(log);
        end;

        Writeln(log, DateTimeToStr(Now)+' -> '+msg);

      finally
        CloseFile(log);
      end;
    end;

  finally
    ini.Free;
  end;
end;

procedure TdmConexao1.ConectarBaseDeDados();
var
  ini: TConexaoINI;
begin
  ini := TConexaoINI.Create;
  try

    with SQLDBLibraryLoader do
    begin
      try
        Enabled            := False;
        ConnectionType     := ini.Driver1;
        LibraryName        := VerificarNomeDLL(ini.Driver1);
        Enabled            := True;
      except on e:Exception do
        TfrmMessage.Mensagem('Erro ao ler biblioteca: '+e.Message,
                              'Erro', 'E', [mbOk]);
      end;
    end;

    with SQLConnector do
    begin
      CharSet               := ini.CharSet1;
      ConnectorType         := ini.Driver1;
      DatabaseName          := ini.Banco1;
      HostName              := ini.Servidor1;
      UserName              := ini.Usuario1;
      Password              := ini.Senha1;
      Params.Values['port'] := ini.Porta1.ToString;
    end;

    try
      SQLConnector.Connected := True;
    except on e:Exception do
      TfrmMessage.Mensagem('Erro ao conectar com o banco de dados: '+
                            e.Message, 'Erro', 'E', [mbOk]);
    end;

  finally
    FreeAndNil(ini);
  end;
end;

function TdmConexao1.VerificarNomeDLL(Driver: String): String;
var
  Lib: String;
begin
  if UpperCase(Driver) = 'FIREBIRD' then
  begin
    {$IFDEF WIN32}
    Lib := ExtractFilePath(ParamStr(0))+'fbclient.dll';
    {$ENDIF}
    {$IFDEF WIN64}
    Lib := ExtractFilePath(ParamStr(0))+'fbclient.dll';
    {$ENDIF}
    {$IFDEF LINUX32}
    Lib := ExtractFilePath(ParamStr(0))+'fbclient.so';
    {$ENDIF}
    {$IFDEF LINUX64}
    Lib := ExtractFilePath(ParamStr(0))+'fbclient.so';
    {$ENDIF}
  end
  else
  if UpperCase(Driver) = 'POSTGRESQL' then
  begin
    {$IFDEF WIN32}
    Lib := ExtractFilePath(ParamStr(0))+'libpq.dll';
    {$ENDIF}
    {$IFDEF WIN64}
    Lib := ExtractFilePath(ParamStr(0))+'libpq.dll';
    {$ENDIF}
    {$IFDEF LINUX32}
    Lib := ExtractFilePath(ParamStr(0))+'libpq.so';
    {$ENDIF}
    {$IFDEF LINUX64}
    Lib := ExtractFilePath(ParamStr(0))+'libpq.so';
    {$ENDIF}
  end
  else
  if UpperCase(Driver) = 'MSSQLSERVER' then
  begin
    {$IFDEF WIN32}
    Lib := ExtractFilePath(ParamStr(0))+'sqlsrv32.dll';
    {$ENDIF}
    {$IFDEF WIN64}
    Lib := ExtractFilePath(ParamStr(0))+'sqlsrv64.dll';
    {$ENDIF}
    {$IFDEF LINUX32}
    Lib := ExtractFilePath(ParamStr(0))+'sqlsrv32.so';
    {$ENDIF}
    {$IFDEF LINUX64}
    Lib := ExtractFilePath(ParamStr(0))+'sqlsrv64.so';
    {$ENDIF}
  end
  else
  if UpperCase(Driver) = 'MYSQL 5.7' then
  begin
    {$IFDEF WIN32}
    Lib := ExtractFilePath(ParamStr(0))+'libmariadb.dll';
    {$ENDIF}
    {$IFDEF WIN64}
    Lib := ExtractFilePath(ParamStr(0))+'libmariadb.dll';
    {$ENDIF}
    {$IFDEF LINUX32}
    Lib := ExtractFilePath(ParamStr(0))+'libmariadb.so';
    {$ENDIF}
    {$IFDEF LINUX64}
    Lib := ExtractFilePath(ParamStr(0))+'libmariadb.so';
    {$ENDIF}
  end
  else
  if Pos('MYSQL', UpperCase(Driver)) <> 0 then
  begin
    {$IFDEF WIN32}
    Lib := ExtractFilePath(ParamStr(0))+'libmysql.dll';
    {$ENDIF}
    {$IFDEF WIN64}
    Lib := ExtractFilePath(ParamStr(0))+'libmysql.dll';
    {$ENDIF}
    {$IFDEF LINUX32}
    Lib := ExtractFilePath(ParamStr(0))+'libmysql.so';
    {$ENDIF}
    {$IFDEF LINUX64}
    Lib := ExtractFilePath(ParamStr(0))+'libmysql.so';
    {$ENDIF}
  end
  else
  if UpperCase(Driver) = 'SQLITE3' then
  begin
    {$IFDEF WIN32}
    Lib := ExtractFilePath(ParamStr(0))+'SQLite3.dll';
    {$ENDIF}
    {$IFDEF WIN64}
    Lib := ExtractFilePath(ParamStr(0))+'SQLite3.dll';
    {$ENDIF}
    {$IFDEF LINUX32}
    Lib := ExtractFilePath(ParamStr(0))+'SQLite3.so';
    {$ENDIF}
    {$IFDEF LINUX64}
    Lib := ExtractFilePath(ParamStr(0))+'SQLite3.so';
    {$ENDIF}
  end;
  Result := Lib;
end;

end.

