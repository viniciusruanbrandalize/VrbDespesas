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
    FDirFB: String;
    FDirPG: String;
    FDirMySQL: String;

    procedure Ler;
    procedure GravarDefault;

  public
    procedure Escrever;
    constructor Create;
    destructor Destroy; override;
  published

    { BACKUP }
    property DirFB: String read FDirFB write FDirFB;
    property DirPG: String read FDirPG write FDirPG;
    property DirMySQL: String read FDirMySQL write FDirMySQL;

  end;

implementation

{ TConfiguracaoINI }

procedure TConfiguracaoINI.Ler;
begin

  lib.cryptini.LerString('BACKUP', 'DIRFB', FDirFB);
  lib.cryptini.LerString('BACKUP', 'DIRPG', FDirPG);
  lib.cryptini.LerString('BACKUP', 'DIRMYSQL', FDirMySQL);

end;

procedure TConfiguracaoINI.GravarDefault;
begin
  if not FileExists(FArquivoINI) then
  begin

    lib.cryptini.EscreverString('BACKUP', 'DIRFB', 'C:\Program Files (x86)\Firebird\Firebird_5_0');
    lib.cryptini.EscreverString('BACKUP', 'DIRPG', 'C:\Program Files\PostgreSQL\15\bin');
    lib.cryptini.EscreverString('BACKUP', 'DIRMYSQL', 'C:\Program Files\MariaDB 11.4\bin');

  end;
end;

procedure TConfiguracaoINI.Escrever;
begin

  lib.cryptini.EscreverString('BACKUP', 'DIRFB', PChar(FDirFB));
  lib.cryptini.EscreverString('BACKUP', 'DIRPG', PChar(FDirPG));
  lib.cryptini.EscreverString('BACKUP', 'DIRMYSQL', PChar(FDirMySQL));

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
