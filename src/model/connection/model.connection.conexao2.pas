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

unit model.connection.conexao2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, SQLDBLib, SQLite3Conn, PQConnection,
  oracleconnection, odbcconn, MSSQLConn, mysql57conn, mysql56conn, mysql80conn,
  mysql55conn, mysql51conn, mysql50conn, mysql41conn, mysql40conn, IBConnection,
  model.ini.conexao, forms, view.mensagem, DB;

type

  { TdmConexao2 }

  TdmConexao2 = class(TDataModule)
    SQLConnector: TSQLConnector;
    SQLDBLibraryLoader: TSQLDBLibraryLoader;
    SQLQuery: TSQLQuery;
    SQLTransaction: TSQLTransaction;
    procedure DataModuleCreate(Sender: TObject);
    procedure SQLConnectorLog(Sender: TSQLConnection; EventType: TDBEventType;
      const Msg: String);
  private
    procedure ConectarBaseDeDados();
    function VerificarNomeDLL(Driver: String): String;
  public
    function TestarConexao: Boolean;
  end;

var
  dmConexao2: TdmConexao2;

implementation

{$R *.lfm}

{ TdmConexao2 }

procedure TdmConexao2.SQLConnectorLog(Sender: TSQLConnection;
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
      arq := ExtractFilePath(ParamStr(0))+'SQLCon2.log';
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

procedure TdmConexao2.DataModuleCreate(Sender: TObject);
begin
  ConectarBaseDeDados;
end;

procedure TdmConexao2.ConectarBaseDeDados();
var
  ini: TConexaoINI;
begin
  ini := TConexaoINI.Create;
  try

    with SQLDBLibraryLoader do
    begin
      try
        Enabled            := False;
        ConnectionType     := ini.Driver2;
        LibraryName        := VerificarNomeDLL(ini.Driver2);
        Enabled            := True;
      except on e:Exception do
        TfrmMessage.Mensagem('Erro ao ler biblioteca: '+e.Message,
                              'Erro', 'E', [mbOk]);
      end;
    end;

    with SQLConnector do
    begin
      CharSet               := ini.CharSet2;
      ConnectorType         := ini.Driver2;
      DatabaseName          := ini.Banco2;
      HostName              := ini.Servidor2;
      UserName              := ini.Usuario2;
      Password              := ini.Senha2;
      Params.Values['Port'] := ini.Porta2.ToString;
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

function TdmConexao2.VerificarNomeDLL(Driver: String): String;
var
  Lib: String;
begin
  if UpperCase(Driver) = 'FIREBIRD' then
  begin
    {$IFDEF MSWINDOWS}
    Lib := ExtractFilePath(ParamStr(0))+'fbclient.dll';
    {$ENDIF}
    {$IFDEF LINUX}
    Lib := ExtractFilePath(ParamStr(0))+'fbclient.so';
    {$ENDIF}
  end
  else
  if UpperCase(Driver) = 'POSTGRESQL' then
  begin
    {$IFDEF MSWINDOWS}
    Lib := ExtractFilePath(ParamStr(0))+'libpq.dll';
    {$ENDIF}
    {$IFDEF LINUX}
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
    {$IFDEF LINUX}
      {$IFDEF CPU32}
      Lib := ExtractFilePath(ParamStr(0))+'sqlsrv32.so';
      {$ENDIF}
      {$IFDEF CPU64}
      Lib := ExtractFilePath(ParamStr(0))+'sqlsrv64.so';
      {$ENDIF}
    {$ENDIF}
  end
  else
  if UpperCase(Driver) = 'MYSQL 5.7' then
  begin
    {$IFDEF MSWINDOWS}
    Lib := ExtractFilePath(ParamStr(0))+'libmariadb.dll';
    {$ENDIF}
    {$IFDEF LINUX}
    Lib := ExtractFilePath(ParamStr(0))+'libmariadb.so';
    {$ENDIF}
  end
  else
  if Pos('MYSQL', UpperCase(Driver)) <> 0 then
  begin
    {$IFDEF MSWINDOWS}
    Lib := ExtractFilePath(ParamStr(0))+'libmysql.dll';
    {$ENDIF}
    {$IFDEF LINUX}
    Lib := ExtractFilePath(ParamStr(0))+'libmysql.so';
    {$ENDIF}
  end
  else
  if UpperCase(Driver) = 'SQLITE3' then
  begin
    {$IFDEF MSWINDOWS}
    Lib := ExtractFilePath(ParamStr(0))+'SQLite3.dll';
    {$ENDIF}
    {$IFDEF LINUX}
    Lib := ExtractFilePath(ParamStr(0))+'SQLite3.so';
    {$ENDIF}
  end;
  Result := Lib;
end;

function TdmConexao2.TestarConexao: Boolean;
var
  qryTemp: TSQLQuery;
begin
  qryTemp := TSQLQuery.Create(nil);
  try
    try
      qryTemp.SQLConnection := SQLConnector;
      qryTemp.SQL.Add('select id from arquivo where id = :id');
      qryTemp.ParamByName('id').AsInteger := 0;
      qryTemp.Open;
      Result := True;
    except
      Result := False;
    end;
  finally
    qryTemp.Free;
  end;
end;

end.

