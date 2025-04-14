unit lib.cep;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, dynlibs, view.mensagem, model.ini.configuracao;

type
  TLibCEPBuscarPorCep = function(CEP: PChar): Boolean; stdcall;
  TLibCEPInicializar  = procedure(WS, TimeOut: Integer; ChaveAcesso, Usuario, Senha: PChar); stdcall;
  TLibCEPFinalizar    = procedure(); stdcall;
  TLibCEPGet          = function(): PChar; stdcall; {Todos os Gets da Lib}

type

  { TLibVrbConsultaCep }

  TLibVrbConsultaCep = class
  private
    FNomeDLL:     String;
    FLogradouro:  String;
    FComplemento: String;
    FBairro:      String;
    FCidade:      String;
    FUf:          String;
    FLatitude:    String;
    FLongitude:   String;
    FCep:         String;
    FHandle:              THandle;
    CEPBuscarPorCep:      TLibCEPBuscarPorCep;
    CEPInicializar:       TLibCEPInicializar;
    CEPFinalizar:         TLibCEPFinalizar;
    CEPGetCEP:            TLibCEPGet;
    CEPGetLogradouro:     TLibCEPGet;
    CEPGetTipoLogradouro: TLibCEPGet;
    CEPGetComplemento:    TLibCEPGet;
    CEPGetBairro:         TLibCEPGet;
    CEPGetCidade:         TLibCEPGet;
    CEPGetUF:             TLibCEPGet;
    CEPGetLatitude:       TLibCEPGet;
    CEPGETLongitude:      TLibCEPGet;
    procedure AtribuirFuncoesDLL;
  public
    function BuscarPorCep(bCEP: String; out Erro: String): Boolean;
    constructor Create;
    destructor Destroy; override;
  published
    property Logradouro:  String read FLogradouro;
    property Complemento: String read FComplemento;
    property Bairro:      String read FBairro;
    property Cidade:      String read FCidade;
    property UF:          String read FUf;
    property CEP:         String read FCep;
    property Latitude:    String read FLatitude;
    property Longitude:   String read FLongitude;
  end;

implementation

{ TLibVrbConsultaCep }

procedure TLibVrbConsultaCep.AtribuirFuncoesDLL;
begin
  if FHandle <> 0 then
  begin
    Pointer(CEPInicializar)  := GetProcAddress(FHandle, PWideChar('inicializar'));
    Pointer(CEPFinalizar)    := GetProcAddress(FHandle, PWideChar('finalizar'));
    Pointer(CEPBuscarPorCep) := GetProcAddress(FHandle, PWideChar('BuscarPorCEP'));
    Pointer(CEPGetCEP)       := GetProcAddress(FHandle, PWideChar('getCep'));
    Pointer(CEPGetLogradouro):= GetProcAddress(FHandle, PWideChar('getLogradouro'));
    Pointer(CEPGetTipoLogradouro):= GetProcAddress(FHandle, PWideChar('getTipoLogradouro'));
    Pointer(CEPGetComplemento):= GetProcAddress(FHandle, PWideChar('getComplemento'));
    Pointer(CEPGetBairro)    := GetProcAddress(FHandle, PWideChar('getBairro'));
    Pointer(CEPGetCidade)    := GetProcAddress(FHandle, PWideChar('getCidade'));
    Pointer(CEPGetUF)        := GetProcAddress(FHandle, PWideChar('getUF'));
    Pointer(CEPGetLatitude)  := GetProcAddress(FHandle, PWideChar('getLatitude'));
    Pointer(CEPGETLongitude) := GetProcAddress(FHandle, PWideChar('getLongitude'));
  end
  else
  begin
    TfrmMessage.Mensagem('libvrbconsultacep32.dll não encontrada!', 'Erro', 'E', [mbOk], mbOk, 12);
    Abort;
    Destroy;
  end;
end;

function TLibVrbConsultaCep.BuscarPorCep(bCEP: String; out Erro: String): Boolean;
var
  consultou: Boolean;
begin

  consultou := CEPBuscarPorCep(PChar(bCEP));

  if not consultou then
    Erro := 'Erro ao consultar CEP!'
  else
  begin
    Erro := '';
    FBairro      := AnsiString( CEPGetBairro );
    FLogradouro  := AnsiString( CEPGetLogradouro );
    FComplemento := AnsiString( CEPGetComplemento );
    FCep         := AnsiString( CEPGetCEP );
    FCidade      := AnsiString( CEPGetCidade );
    FUf          := AnsiString( CEPGetUF );
    FLatitude    := AnsiString( CEPGetLatitude );
    FLongitude   := AnsiString( CEPGETLongitude );
  end;

  result := consultou;
end;

constructor TLibVrbConsultaCep.Create;
var
  ConfiguracaoINI: TConfiguracaoINI;
begin

  {$IFDEF WIN32}
  FNomeDLL := 'libvrbconsultacep32.dll';
  {$ENDIF}
  {$IFDEF WIN64}
  FNomeDLL := 'libvrbconsultacep64.dll';
  {$ENDIF}
  {$IFDEF LINUX32}
  FNomeDLL := 'libvrbconsultacep32.so';
  {$ENDIF}
  {$IFDEF LINUX64}
  FNomeDLL := 'libvrbconsultacep64.so';
  {$ENDIF}

  FHandle := LoadLibrary(FNomeDLL);
  AtribuirFuncoesDLL;

  ConfiguracaoINI := TConfiguracaoINI.Create;
  try
    CEPInicializar(0,
                   0,
                   Pchar(''),
                   Pchar(''),
                   Pchar(''));
  finally
    FreeAndNil(ConfiguracaoINI);
  end;
end;

destructor TLibVrbConsultaCep.Destroy;
begin
  if FHandle <> 0 then
  begin
    CEPFinalizar;
    FreeLibrary(FHandle);
  end;
  Inherited Destroy;
end;

end.

