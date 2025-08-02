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

unit model.dao.copiaseguranca;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, model.dao.padrao, Forms, dialogs,
  lib.types, model.ini.configuracao, model.ini.conexao, process,
  {$IFDEF MSWINDOWS}
  Windows
  {$ENDIF}
  {$IFDEF LINUX}
  FileUtil
  {$ENDIF} ;

type

  { TCopiaSegurancaDAO }

  TCopiaSegurancaDAO = class
  private
    DAO: TPadraoDAO;
    FTabelas: TStringList;
    FColunas: TStringList;
    FSequencias: TStringList;
    FSequenciasValores: TStringList;
    FComandos: TStringList;
    procedure BuscarTabelas(var pgb: TProgressBar; var lblStatus: TLabel);
    procedure BuscarColunas(Tabela: String; var pgb: TProgressBar; var lblStatus: TLabel);
    procedure BuscarSequencias(var pgb: TProgressBar; var lblStatus: TLabel);
    procedure BuscarValorSequencias(var pgb: TProgressBar; var lblStatus: TLabel);
    function BuscarTotalRegistros(): LongInt;
    procedure GerarInserts(var pgb: TProgressBar; var lblStatus: TLabel);
    procedure GerarSequencias(var pgb: TProgressBar; var lblStatus: TLabel);
    function FazerDump(Destino: String; var mLog: TMemo): Boolean;
  public
    function FazerBackup(Destino: String; var pgb: TProgressBar; var lblStatus: TLabel; var mLog: TMemo; Tipo: TTipoBackup): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TCopiaSegurancaDAO }

procedure TCopiaSegurancaDAO.BuscarTabelas(var pgb: TProgressBar;
  var lblStatus: TLabel);
var
  SQL: String;
begin

  FTabelas.Clear;
  lblStatus.Caption := 'Buscando Tabelas...';

  if DAO.Driver = DRV_FIREBIRD then
  begin
    SQL := 'SELECT RDB$RELATION_NAME AS TABELA ' +
           'FROM RDB$RELATIONS ' +
           'WHERE RDB$VIEW_BLR IS NULL ' +
           'AND (RDB$SYSTEM_FLAG IS NULL OR RDB$SYSTEM_FLAG = 0) ' +
           'ORDER BY 1';
  end;

  DAO.Qry.Close;
  DAO.Qry.SQL.Clear;
  DAO.Qry.SQL.Add(sql);
  DAO.Qry.Open;
  DAO.Qry.First;

  while not DAO.Qry.EOF do
  begin
    FTabelas.Add(Trim(DAO.Qry.FieldByName('TABELA').AsString));
    lblStatus.Caption := 'Buscando Tabelas... '+DAO.Qry.FieldByName('TABELA').AsString;
    Application.ProcessMessages;
    DAO.Qry.Next;
  end;

end;

procedure TCopiaSegurancaDAO.BuscarColunas(Tabela: String; var pgb: TProgressBar;
  var lblStatus: TLabel);
var
  SQL: String;
begin

  FColunas.Clear;
  lblStatus.Caption := 'Buscando Colunas...';

  if DAO.Driver = DRV_FIREBIRD then
  begin
    SQL := 'SELECT RDB$FIELD_NAME AS COLUNA ' +
           'FROM RDB$RELATION_FIELDS ' +
           'WHERE RDB$RELATION_NAME = :tabela ';
  end;

  DAO.Qry.Close;
  DAO.Qry.SQL.Clear;
  DAO.Qry.SQL.Add(sql);
  DAO.Qry.ParamByName('tabela').AsString := Tabela;
  DAO.Qry.Open;
  DAO.Qry.First;

  while not DAO.Qry.EOF do
  begin
    FColunas.Add(Trim(DAO.Qry.FieldByName('COLUNA').AsString));
    lblStatus.Caption := 'Buscando Colunas... '+DAO.Qry.FieldByName('COLUNA').AsString;
    Application.ProcessMessages;
    DAO.Qry.Next;
  end;

end;

procedure TCopiaSegurancaDAO.BuscarSequencias(var pgb: TProgressBar;
  var lblStatus: TLabel);
var
  SQL: String;
begin

  if DAO.Driver = DRV_FIREBIRD then
  begin
    SQL := 'SELECT RDB$GENERATOR_NAME AS SEQ FROM RDB$GENERATORS';
  end;

  DAO.Qry.Close;
  DAO.Qry.SQL.Clear;
  DAO.Qry.SQL.Add(SQL);
  DAO.Qry.Open;
  DAO.Qry.First;

  while not DAO.Qry.EOF do
  begin

    if DAO.Driver = DRV_FIREBIRD then
    begin
      if Pos('GEN_', UpperCase(Trim(DAO.Qry.FieldByName('SEQ').AsString))) <> 0 then
        FSequencias.Add(Trim(DAO.Qry.FieldByName('SEQ').AsString));
    end;
    DAO.Qry.Next;
  end;

end;

procedure TCopiaSegurancaDAO.BuscarValorSequencias(var pgb: TProgressBar;
  var lblStatus: TLabel);
var
  SQL: String;
  i: Integer;
begin

  for i := 0 to Pred(FSequencias.Count) do
  begin

    if DAO.Driver = DRV_FIREBIRD then
    begin
      SQL := 'SELECT GEN_ID('+FSequencias[i]+',0) AS ID '+
             'FROM RDB$DATABASE';
    end;

    DAO.Qry.Close;
    DAO.Qry.SQL.Clear;
    DAO.Qry.SQL.Add(SQL);
    DAO.Qry.Open;
    DAO.Qry.First;

    FSequenciasValores.Add(Trim(DAO.Qry.FieldByName('ID').AsString));

  end;

end;

function TCopiaSegurancaDAO.BuscarTotalRegistros(): LongInt;
var
  i: Integer;
  total: LongInt;
  SQL: String;
begin
  total := 0;
  for i := 0 to Pred(FTabelas.Count) do
  begin
    SQL := 'SELECT COUNT(*) AS QUANTIDADE FROM '+FTabelas[i];

    DAO.Qry.Close;
    DAO.Qry.SQL.Clear;
    DAO.Qry.SQL.Add(SQL);
    DAO.Qry.Open;

    total := total + DAO.Qry.FieldByName('QUANTIDADE').AsInteger;
  end;
  Result := total;
end;

procedure TCopiaSegurancaDAO.GerarInserts(var pgb: TProgressBar;
  var lblStatus: TLabel);
var
  i, j: Integer;
  SQL: String;
  StrColunas: String;
  StrColunasConcat: String;
  Comando: String;
begin
  try
    BuscarTabelas(pgb, lblStatus);
    pgb.Max := BuscarTotalRegistros();
    pgb.Position := 0;

    for i := 0 to Pred(FTabelas.Count) do
    begin
      StrColunas := '';
      BuscarColunas(FTabelas[i], pgb, lblStatus);

      for j := 0 to Pred(FColunas.Count) do
      begin
        if StrColunas = EmptyStr then
        begin
          StrColunas       := FColunas[j];
          StrColunasConcat := 'COALESCE(' + FColunas[j] +','+QuotedStr('NULL')+')';
        end
        else
        begin
          StrColunas := StrColunas +','+ FColunas[j];
          StrColunasConcat := StrColunasConcat +'||'+QuotedStr(QuotedStr(','))+
                              '||' + 'COALESCE('+ FColunas[j]+','+QuotedStr('NULL')+')';
        end;
      end;

      //MONTA O SQL DE INSERTS
      SQL := 'SELECT '+QuotedStr('INSERT INTO '+FTabelas[i]+'('+StrColunas+') VALUES (''')+'||'+
              StrColunasConcat+'||'+QuotedStr(''');')+' AS COMANDO FROM '+FTabelas[i];

      //EXECUTA SQL
      DAO.Qry.Close;
      DAO.Qry.SQL.Clear;
      DAO.Qry.SQL.Add(SQL);
      DAO.Qry.Open;
      DAO.Qry.First;

      while not DAO.Qry.EOF do
      begin
        Comando := Trim(DAO.Qry.FieldByName('COMANDO').AsString);
        Comando := StringReplace(Comando, QuotedStr('NULL'), 'NULL', [rfReplaceAll, rfIgnoreCase]);
        FComandos.Add(Comando);
        pgb.Position := pgb.Position + 1;
        lblStatus.Caption := 'Exportando '+FTabelas[i]+'... '+IntToStr(pgb.Position)+
                             ' de '+IntToStr(pgb.Max)+' registros.';
        Application.ProcessMessages;
        DAO.Qry.Next;
      end;

    end;

  finally

  end;
end;

procedure TCopiaSegurancaDAO.GerarSequencias(var pgb: TProgressBar;
  var lblStatus: TLabel);
var
  i: Integer;
  Comando: String;
begin

  BuscarSequencias(pgb, lblStatus);
  BuscarValorSequencias(pgb, lblStatus);

  for i := 0 to Pred(FSequencias.Count) do
  begin
    if DAO.Driver = DRV_FIREBIRD then
    begin
      Comando := 'SET GENERATOR '+FSequencias[i]+' TO '+FSequenciasValores[i]+';';
    end;
    FComandos.Add(Comando);
  end;

end;

function TCopiaSegurancaDAO.FazerDump(Destino: String; var mLog: TMemo): Boolean;
  const READ_BYTES = 2048;
var
  aProcess: TProcess;
  MemStream: TMemoryStream;
  NumBytes: LongInt;
  BytesRead: LongInt;
  Lines: TStringList;
  ArqLnCmd: TStringList;
  ConfigINI: TConfiguracaoINI;
  ConexaoINI: TConexaoINI;
  UsuarioDB1,
  SenhaDB1,
  NomeBanco1,
  PortaDB1,
  HostDB1,
  gbak,
  pgdump,
  mysqldump,
  ArqTemp: String;
begin

  MemStream := TMemoryStream.Create;
  Lines := TStringList.Create;
  BytesRead := 0;
  aProcess := TProcess.Create(nil);
  try

    ConfigINI := TConfiguracaoINI.Create;
    try
      gbak      := ConfigINI.GBak;
      pgdump    := ConfigINI.PGDump;
      mysqldump := ConfigINI.MySQLDump;
    finally
      ConfigINI.Free;
    end;

    ConexaoINI := TConexaoINI.Create;
    try
      UsuarioDB1 := ConexaoINI.Usuario1;
      SenhaDB1   := ConexaoINI.Senha1;
      NomeBanco1 := ConexaoINI.Banco1;
      HostDB1    := ConexaoINI.Servidor1;
      PortaDB1   := ConexaoINI.Porta1.ToString;
    finally
      ConexaoINI.Free;
    end;

    if DAO.Driver = DRV_FIREBIRD then
    begin

      ArqTemp := ExtractFilePath(ParamStr(0))+'TEMP.FDB';

      if FileExists(NomeBanco1) then
      begin
        {$IFDEF MSWINDOWS}
        CopyFile(PChar(NomeBanco1), PChar(ArqTemp), true);
        {$ENDIF}
        {$IFDEF LINUX}

        {$ENDIF}
      end;

      aProcess.Executable := gbak;
      aProcess.Parameters.Add('-b');
      aProcess.Parameters.Add('-v');
      aProcess.Parameters.Add('-user');
      aProcess.Parameters.Add(UsuarioDB1);
      aProcess.PArameters.Add('-password');
      aProcess.Parameters.Add(SenhaDB1);
      aProcess.Parameters.Add(ArqTemp);
      aProcess.Parameters.Add(Destino+'\VRB_DESPESA_'+FormatDateTime('yyyymmdd_hhnnss', Now)+'.FBK');

    end
    else
    if (DAO.Driver = DRV_MYSQL) or (DAO.Driver = DRV_MARIADB) then
    begin

      aProcess.Executable := mysqldump;
      aProcess.Parameters.Add('--host='+HostDB1);
      aProcess.Parameters.Add('--databases');
      aProcess.Parameters.Add(NomeBanco1);
      aProcess.Parameters.Add('--user='+UsuarioDB1);
      aProcess.Parameters.Add('--password="'+SenhaDB1+'"');
      aProcess.Parameters.Add('--port='+PortaDB1);
      aProcess.Parameters.Add('--skip-ssl');

    end
    else
    if DAO.Driver = DRV_POSTGRESQL then
    begin

      ArqLnCmd := TStringList.Create;
      try
        ArqLnCmd.Add('set pgpassword="'+SenhaDB1+'"');
        ArqLnCmd.Add(
                     '"' + pgdump + '" --file "' +
                     Destino+'\VRB_DESPESA_'+FormatDateTime('yyyymmdd_hhnnss', Now)+'.backup" ' +
                     '--host "'+HostDB1+'" --port '+PortaDB1+' --username "'+UsuarioDB1+'" ' +
                     '--no-password --verbose --format=c --blobs "'+NomeBanco1+'"');
        ArqLnCmd.SaveToFile(ExtractFilePath(ParamStr(0))+'bkp_pg.bat');
      finally
        ArqLnCmd.Free;
      end;

      aProcess.Executable := ExtractFilePath(ParamStr(0))+'bkp_pg.bat';

    end;

    aprocess.ShowWindow := swoHIDE;
    AProcess.Options := AProcess.Options + [poUsePipes,poStderrToOutPut];
    aProcess.Execute;

    while aProcess.Running do
    begin
      MemStream.SetSize(BytesRead + READ_BYTES);
      NumBytes := aProcess.Output.Read((MemStream.Memory + BytesRead)^, READ_BYTES);

      if NumBytes > 0 then
        Inc(BytesRead, NumBytes)
      else
        Break;

      Application.ProcessMessages;

    end;

    MemStream.SetSize(BytesRead);
    Lines.LoadFromStream(MemStream);

    if (DAO.Driver = DRV_MYSQL) or (DAO.Driver = DRV_MARIADB) then
      MemStream.SaveToFile(Destino+'\VRB_DESPESA_'+FormatDateTime('yyyymmdd_hhnnss', Now)+'.SQL');

    mLog.Lines := Lines;

    Result := True;

  finally

    {$IFDEF MSWINDOWS}
    if FileExists(ArqTemp) then
      DeleteFile(PChar(ArqTemp));

    if FileExists(ExtractFilePath(ParamStr(0))+'bkp_pg.bat') then
      DeleteFile(PChar(ExtractFilePath(ParamStr(0))+'bkp_pg.bat'));
    {$ENDIF}

    aProcess.Free;
    Lines.Free;
    MemStream.Free;
  end;
end;

function TCopiaSegurancaDAO.FazerBackup(Destino: String; var pgb: TProgressBar;
  var lblStatus: TLabel; var mLog: TMemo; Tipo: TTipoBackup): Boolean;
begin
  try
    case Tipo of
      bkpSQL:
      begin
        FComandos.Clear;
        FComandos.Add('--  BACKUP DA BASE DE DADOS DO SISTEMA VRB DESPESA  ');
        FComandos.Add('');
        FComandos.Add('--  INSERTS');
        GerarInserts(pgb, lblStatus);
        FComandos.Add('');
        FComandos.Add('--  SEQUENCES');
        GerarSequencias(pgb, lblStatus);
        FComandos.SaveToFile(Destino+'\vrb_despesa_'+FormatDateTime('yyyymmdd_hhnnss', Now)+'.SQL');
        Result := True;
      end;
      bkpDump:
      begin
        Result := FazerDump(Destino, mLog);
      end;
    end;
  finally

  end;
end;

constructor TCopiaSegurancaDAO.Create;
begin
  DAO := TPadraoDAO.Create;
  FTabelas := TStringList.Create;
  FColunas := TStringList.Create;
  FSequencias := TStringList.Create;
  FSequenciasValores := TStringList.Create;
  FComandos := TStringList.Create;
end;

destructor TCopiaSegurancaDAO.Destroy;
begin
  FreeAndNil(DAO);
  FTabelas.Free;
  FColunas.Free;
  FSequencias.Free;
  FSequenciasValores.Free;
  FComandos.Free;
  inherited Destroy;
end;

end.
