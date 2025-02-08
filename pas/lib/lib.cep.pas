unit lib.cep;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, dynlibs, view.mensagem;

type
  TDLLBuscarPorCep = function(eCEP: ShortString; const sResposta: PAnsiChar; out esTamanho: Integer): Integer; stdcall;
  TDLLInicializar  = function(eArqConfig, eChaveCrypt: String): Integer; stdcall;
  TDLLFinalizar    = function: Integer; stdcall;
  TDLLConfigLer    = function(eArqConfig: String): Integer; stdcall;
  TDLLConfigGravar = function(eArqConfig: String): Integer; stdcall;
  TDLLConfigGravarValor = function(eSessao, eChave, sValor: String): Integer; stdcall;
  TDLLUltimoRetorno     = function(sResposta: ShortString; out esTamanho: Integer): Integer; stdcall;

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
    CEPBuscarPorCep:      TDLLBuscarPorCep;
    CEPInicializar:       TDLLInicializar;
    CEPFinalizar:         TDLLFinalizar;
    CEPConfigLer:         TDLLConfigLer;
    CEPConfigGravar:      TDLLConfigGravar;
    CEPConfigGravarValor: TDLLConfigGravarValor;
    CEPUltimoRetorno:     TDLLUltimoRetorno;
    procedure AtribuirFuncoesDLL;
  public
    function BuscarPorCep(bCEP: String): Boolean;
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
    Pointer(CEPInicializar)  := GetProcAddress(FHandle, PWideChar('CEP_Inicializar'));
    Pointer(CEPFinalizar)    := GetProcAddress(FHandle, PWideChar('CEP_Finalizar'));
    Pointer(CEPBuscarPorCep) := GetProcAddress(FHandle, PWideChar('CEP_BuscarPorCEP'));
    Pointer(CEPConfigLer)    := GetProcAddress(FHandle, PWideChar('CEP_ConfigLer'));
    Pointer(CEPConfigGravar) := GetProcAddress(FHandle, PWideChar('CEP_ConfigGravar'));
    Pointer(CEPConfigGravarValor) := GetProcAddress(FHandle, PWideChar('CEP_ConfigGravarValor'));
    Pointer(CEPUltimoRetorno)     := GetProcAddress(FHandle, PWideChar('CEP_UltimoRetorno'));
  end
  else
  begin
    TfrmMessage.Mensagem('libvrbconsultacep32.dll não encontrada!', 'Erro', 'E', [mbOk], mbOk, 12);
    Abort;
    Destroy;
  end;
end;

function TLibVrbConsultaCep.BuscarPorCep(bCEP: String): Boolean;
var
  tamanho: Integer;
  retorno: Integer;
  resposta: String;
begin

  tamanho := 198;
  retorno := CEPBuscarPorCep(bCEP, PAnsiChar(resposta), tamanho);
  FBairro := resposta;

  case retorno of
    -1:  TfrmMessage.Mensagem('API de CEP não inicializada!', 'Erro', 'E', [mbOk],mbOk, 12);
    -10: TfrmMessage.Mensagem('Erro ao consultar CEP!', 'Erro', 'E', [mbOk], mbOk, 12);
  end;

  result := (retorno = 0);
end;

constructor TLibVrbConsultaCep.Create;
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
  CEPInicializar('config_acbr.ini', '');
  CEPConfigGravarValor('CEP','WebService','10');
  CEPConfigGravarValor('CEP','PesquisarIBGE','1');
  CEPConfigLer('config_acbr.ini');
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

