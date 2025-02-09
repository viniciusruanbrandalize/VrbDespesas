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

    { CEP }
    FChaveAcesso: String;
    FUsuario:     String;
    FSenha:       String;
    FWebService:  Integer;
    FTimeOut:     Integer;

    procedure Ler;
    procedure GravarDefault;

  public
    procedure Escrever;
    constructor Create;
    destructor Destroy; override;
  published

    { CEP }
    property ChaveAcesso: String read FChaveAcesso write FChaveAcesso;
    property Usuario: String read FUsuario write FUsuario;
    property Senha: String read FSenha write FSenha;
    property WebService: Integer read FWebService write FWebService;
    property TimeOut: Integer read FTimeOut write FTimeOut;

  end;

implementation

{ TConfiguracaoINI }

procedure TConfiguracaoINI.Ler;
begin

  lib.cryptini.LerString('CEP', 'CHAVE', FChaveAcesso);
  lib.cryptini.LerString('CEP', 'USUARIO', FUsuario);
  lib.cryptini.LerString('CEP', 'SENHA', FSenha);
  lib.cryptini.LerInteger('CEP', 'WEBSERVICE', FWebService);
  lib.cryptini.LerInteger('CEP', 'TIMEOUT', FTimeOut);

end;

procedure TConfiguracaoINI.GravarDefault;
begin
  if not FileExists(FArquivoINI) then
  begin

    lib.cryptini.EscreverString('CEP', 'CHAVE', '');
    lib.cryptini.EscreverString('CEP', 'USUARIO', '');
	lib.cryptini.EscreverString('CEP', 'SENHA', '');
    lib.cryptini.EscreverInteger('CEP', 'WEBSERVICE', 10);
	lib.cryptini.EscreverInteger('CEP', 'TIMEOUT', 9000);

  end;
end;

procedure TConfiguracaoINI.Escrever;
begin

  lib.cryptini.EscreverString('CEP', 'CHAVE', PChar(FChaveAcesso));
  lib.cryptini.EscreverString('CEP', 'USUARIO',  PChar(FUsuario));
  lib.cryptini.EscreverString('CEP', 'SENHA',  PChar(FSenha));
  lib.cryptini.EscreverInteger('CEP', 'WEBSERVICE',  FWebService);
  lib.cryptini.EscreverInteger('CEP', 'TIMEOUT',  FTimeOut);

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
