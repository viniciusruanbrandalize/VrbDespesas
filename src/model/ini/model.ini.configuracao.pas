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

unit model.ini.configuracao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, lib.cryptini;

type

  { TConfiguracaoINI }

  TConfiguracaoINI = class
  private
  
    FArquivoINI: String;
    FKey:        String;
    FMd5:        String;

    { BACKUP }
    FGBak: String;
    FPGDump: String;
    FMySQLDump: String;
    FSQLite3: String;

    { DONO_CADASTRO }
    FDCId: Integer;
    FDCNaoPerguntar: Boolean;

    procedure Ler;
    procedure GravarDefault;

  public
    procedure Escrever;
    constructor Create;
    destructor Destroy; override;
  published

    { BACKUP }
    property GBak: String read FGBak write FGBak;
    property PGDump: String read FPGDump write FPGDump;
    property MySQLDump: String read FMySQLDump write FMySQLDump;
    property SQLite3: String read FSQLite3 write FSQLite3;

    { DONO_CADASTRO }
    property DCId: Integer read FDCId write FDCId;
    property DCNaoPerguntar: Boolean read FDCNaoPerguntar write FDCNaoPerguntar;

  end;

implementation

{ TConfiguracaoINI }

procedure TConfiguracaoINI.Ler;
begin

  FGBak      := lib.cryptini.LerString(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'BACKUP', 'GBAK', '');
  FPGDump    := lib.cryptini.LerString(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'BACKUP', 'PGDUMP', '');
  FMySQLDump := lib.cryptini.LerString(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'BACKUP', 'MYSQLDUMP', '');
  FSQLite3   := lib.cryptini.LerString(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'BACKUP', 'SQLITE3', '');

  FDCId           := lib.cryptini.LerInteger(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'DONO_CADASTRO', 'ID', 0);
  FDCNaoPerguntar := lib.cryptini.LerBoolean(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'DONO_CADASTRO', 'NAOPERGUNTAR', false);

end;

procedure TConfiguracaoINI.GravarDefault;
begin
  if not FileExists(FArquivoINI) then
  begin

    lib.cryptini.EscreverString(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'BACKUP', 'GBAK', 'C:\Program Files (x86)\Firebird\Firebird_5_0\gbak.exe');
    lib.cryptini.EscreverString(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'BACKUP', 'PGDUMP', 'C:\Program Files\PostgreSQL\17\bin\pg_dump.exe');
    lib.cryptini.EscreverString(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'BACKUP', 'MYSQLDUMP', 'C:\Program Files\MariaDB 11.8\bin\mysqldump.exe');
    lib.cryptini.EscreverString(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'BACKUP', 'SQLITE3', PChar(ExtractFilePath(ParamStr(0))+'sqlite\sqlite3.exe'));

    lib.cryptini.EscreverInteger(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'DONO_CADASTRO', 'ID', 1);
    lib.cryptini.EscreverBoolean(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'DONO_CADASTRO', 'NAOPERGUNTAR', false);

  end;
end;

procedure TConfiguracaoINI.Escrever;
begin

  lib.cryptini.EscreverString(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'BACKUP', 'GBAK', PChar(FGBak));
  lib.cryptini.EscreverString(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'BACKUP', 'PGDUMP', PChar(FPGDump));
  lib.cryptini.EscreverString(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'BACKUP', 'MYSQLDUMP', PChar(FMySQLDump));
  lib.cryptini.EscreverString(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'BACKUP', 'SQLITE3', PChar(FSQLite3));

  lib.cryptini.EscreverInteger(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'DONO_CADASTRO', 'ID', FDCId);
  lib.cryptini.EscreverBoolean(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'DONO_CADASTRO', 'NAOPERGUNTAR', FDCNaoPerguntar);

end;

constructor TConfiguracaoINI.Create;
begin
  FArquivoINI := ExtractFilePath(ParamStr(0))+'configuracao.ini';
  FMd5        := 'compras_laz_2025_MD5';
  FKey        := 'compras_laz_2025_KEY';
  GravarDefault;
  ler;
end;

destructor TConfiguracaoINI.Destroy;
begin
  inherited Destroy;
end;

end.
