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

    { BACKUP }
    type
    TBackup = class
    private
      FGBak: String;
      FPGDump: String;
      FMySQLDump: String;
      FSQLite3: String;
    published
      property GBak: String read FGBak write FGBak;
      property PGDump: String read FPGDump write FPGDump;
      property MySQLDump: String read FMySQLDump write FMySQLDump;
      property SQLite3: String read FSQLite3 write FSQLite3;
    end;

    { DONO_CADASTRO }
    type
    TDonoCadastro = class
    private
      FDCId: Integer;
      FDCNaoPerguntar: Boolean;
    published
      property DCId: Integer read FDCId write FDCId;
      property DCNaoPerguntar: Boolean read FDCNaoPerguntar write FDCNaoPerguntar;
    end;

  private

    FArquivoINI: String;
    FKey:        String;
    FMd5:        String;

    FBackup: TBackup;
    FDonoCadastro: TDonoCadastro;

    procedure Ler;
    procedure GravarDefault;

  public
    procedure Escrever;
    constructor Create;
    destructor Destroy; override;
  published
    property Backup: TBackup read FBackup write FBackup;
    property DonoCadastro: TDonoCadastro read FDonoCadastro write FDonoCadastro;
  end;

implementation

{ TConfiguracaoINI }

procedure TConfiguracaoINI.Ler;
begin

  FBackup.FGBak      := lib.cryptini.LerString(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'BACKUP', 'GBAK', '');
  FBackup.FPGDump    := lib.cryptini.LerString(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'BACKUP', 'PGDUMP', '');
  FBackup.FMySQLDump := lib.cryptini.LerString(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'BACKUP', 'MYSQLDUMP', '');
  FBackup.FSQLite3   := lib.cryptini.LerString(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'BACKUP', 'SQLITE3', '');

  FDonoCadastro.FDCId           := lib.cryptini.LerInteger(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'DONO_CADASTRO', 'ID', 0);
  FDonoCadastro.FDCNaoPerguntar := lib.cryptini.LerBoolean(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'DONO_CADASTRO', 'NAOPERGUNTAR', false);

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

  lib.cryptini.EscreverString(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'BACKUP', 'GBAK', PChar(FBackup.FGBak));
  lib.cryptini.EscreverString(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'BACKUP', 'PGDUMP', PChar(FBackup.FPGDump));
  lib.cryptini.EscreverString(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'BACKUP', 'MYSQLDUMP', PChar(FBackup.FMySQLDump));
  lib.cryptini.EscreverString(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'BACKUP', 'SQLITE3', PChar(FBackup.FSQLite3));

  lib.cryptini.EscreverInteger(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'DONO_CADASTRO', 'ID', FDonoCadastro.FDCId);
  lib.cryptini.EscreverBoolean(PChar(FArquivoINI), PChar(FKey), PChar(FMd5), 'DONO_CADASTRO', 'NAOPERGUNTAR', FDonoCadastro.FDCNaoPerguntar);

end;

constructor TConfiguracaoINI.Create;
begin
  FArquivoINI := ExtractFilePath(ParamStr(0))+'configuracao.ini';
  FMd5        := 'compras_laz_2025_MD5';
  FKey        := 'compras_laz_2025_KEY';
  FBackup       := TBackup.Create;
  FDonoCadastro := TDonoCadastro.Create;
  GravarDefault;
  ler;
end;

destructor TConfiguracaoINI.Destroy;
begin
  FBackup.Free;
  FDonoCadastro.Free;
  inherited Destroy;
end;

end.
