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

  end;

implementation

{ TConfiguracaoINI }

procedure TConfiguracaoINI.Ler;
begin

  lib.cryptini.LerString('BACKUP', 'GBAK', FGBak);
  lib.cryptini.LerString('BACKUP', 'PGDUMP', FPGDump);
  lib.cryptini.LerString('BACKUP', 'MYSQLDUMP', FMySQLDump);

end;

procedure TConfiguracaoINI.GravarDefault;
begin
  if not FileExists(FArquivoINI) then
  begin

    lib.cryptini.EscreverString('BACKUP', 'GBAK', 'C:\Program Files (x86)\Firebird\Firebird_5_0\gbak.exe');
    lib.cryptini.EscreverString('BACKUP', 'PGDUMP', 'C:\Program Files\PostgreSQL\16\bin\pg_dump.exe');
    lib.cryptini.EscreverString('BACKUP', 'MYSQLDUMP', 'D:\Projetos\Databases\Utilitarios\MySQL 5.7\bin\mysqldump.exe');

  end;
end;

procedure TConfiguracaoINI.Escrever;
begin

  lib.cryptini.EscreverString('BACKUP', 'GBAK', PChar(FGBak));
  lib.cryptini.EscreverString('BACKUP', 'PGDUMP', PChar(FPGDump));
  lib.cryptini.EscreverString('BACKUP', 'MYSQLDUMP', PChar(FMySQLDump));

end;

constructor TConfiguracaoINI.Create;
begin
  FArquivoINI := ExtractFilePath(ParamStr(0))+'configuracao.ini';
  FMd5        := 'compras_laz_2025_MD5';
  FKey        := 'compras_laz_2025_KEY';
  lib.cryptini.inicializar(PChar(FArquivoINI), PChar(FKey), PChar(FMd5));
  GravarDefault;
  ler;
end;

destructor TConfiguracaoINI.Destroy;
begin
  lib.cryptini.finalizar;
  inherited Destroy;
end;

end.
