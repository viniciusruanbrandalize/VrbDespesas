unit model.ini.erro;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, lib.cryptini;

type

  { TErroINI }

  TErroINI = class
  private

    {Erro X}
    FId:                String;  { ID DA SECAO }
    FData:              TDate;
    FHora:              TTime;
    FNomeComputador:    String;
    FIPComputador:      String;
    FMensagem:          String;
    FMensagemTratada:   String;
    FClasseErro:        String;
    FUnidadeErro:       String;
    FNomeFormAtivo:     String;
    FTituloFormAtivo:   String;
    FUnidadeFormAtivo:  String;
    FNomeObjAtivo:      String;
    FTituloObjAtivo:    String;
    FUnidadeObjAtivo:   String;
    FNomeObjErro:       String;
    FTituloObjErro:     String;
    FUnidadeObjErro:    String;
    FLinhaErro:         Integer;
    FFuncaoErro:        String;
    FVersaoExe:         String;
    FDataVersaoExe:     TDate;
    FArquiteturaExe:    String;
    FDiretorioExe:      String;
    FSistemaOperacional:String;
    FModoExe:           String; {DEBUG/RELEASE}
    FUsuario:           String;
    FArquivoErr:        String;

    function GetArquiteturaExe: String;
    function GetClasseErro: String;
    function GetData: TDate;
    function GetDataVersaoExe: TDate;
    function GetDiretorioExe: String;
    function GetFuncaoErro: String;
    function GetHora: TTime;
    function GetID: String;
    function GetIPComputador: String;
    function GetLinhaErro: Integer;
    function GetMensagem: String;
    function GetMensagemTratada: String;
    function GetModoExe: String;
    function GetNomeComputador: String;
    function GetNomeFormAtivo: String;
    function GetNomeObjAtivo: String;
    function GetNomeObjErro: String;
    function GetSistemaOperacional: String;
    function GetTituloObjAtivo: String;
    function GetTituloFormAtivo: String;
    function GetTituloObjErro: String;
    function GetUnidadeErro: String;
    function GetUnidadeFormAtivo: String;
    function GetUnidadeObjAtivo: String;
    function GetUnidadeObjErro: String;
    function GetUsuario: String;
    function GetVersaoExe: String;
    procedure SetArquiteturaExe(AValue: String);
    procedure SetClasseErro(AValue: String);
    procedure SetData(AValue: TDate);
    procedure SetDataVersaoExe(AValue: TDate);
    procedure SetDiretorioExe(AValue: String);
    procedure SetFuncaoErro(AValue: String);
    procedure SetHora(AValue: TTime);
    procedure SetID(AValue: String);
    procedure SetIPComputador(AValue: String);
    procedure SetLinhaErro(AValue: Integer);
    procedure SetMensagem(AValue: String);
    procedure SetMensagemTratada(AValue: String);
    procedure SetModoExe(AValue: String);
    procedure SetNomeComputador(AValue: String);
    procedure SetNomeFormAtivo(AValue: String);
    procedure SetNomeObjAtivo(AValue: String);
    procedure SetNomeObjErro(AValue: String);
    procedure SetSistemaOperacional(AValue: String);
    procedure SetTituloFormAtivo(AValue: String);
    procedure SetTituloObjAtivo(AValue: String);
    procedure SetTituloObjErro(AValue: String);
    procedure SetUnidadeErro(AValue: String);
    procedure SetUnidadeFormAtivo(AValue: String);
    procedure SetUnidadeObjAtivo(AValue: String);
    procedure SetUnidadeObjErro(AValue: String);
    procedure SetUsuario(AValue: String);
    procedure SetVersaoExe(AValue: String);
    procedure Carregar;
    function VerificarSecaoAtual: String;

  public
    procedure Escrever;
    procedure CarregarPorSecao(Secao: String);
    function ExisteSecaoIni(Secao: String): Boolean;
    constructor Create;
    destructor Destroy; override;
  published
    property ID: String read GetID write SetID;
    property Data: TDate read GetData write SetData;
    property Hora: TTime read GetHora write SetHora;
    property NomeComputador: String read GetNomeComputador write SetNomeComputador;
    property IPComputador: String read GetIPComputador write SetIPComputador;
    property Mensagem: String  read GetMensagem write SetMensagem;
    property MensagemTratada: String read GetMensagemTratada write SetMensagemTratada;
    property ClasseErro: String read GetClasseErro write SetClasseErro;
    property UnidadeErro: String read GetUnidadeErro write SetUnidadeErro;
    property NomeFormAtivo: String read GetNomeFormAtivo write SetNomeFormAtivo;
    property TituloFormAtivo: String read GetTituloFormAtivo write SetTituloFormAtivo;
    property UnidadeFormAtivo: String read GetUnidadeFormAtivo write SetUnidadeFormAtivo;
    property NomeObjAtivo: String read GetNomeObjAtivo write SetNomeObjAtivo;
    property TituloObjAtivo: String read GetTituloObjAtivo write SetTituloObjAtivo;
    property UnidadeObjAtivo: String read GetUnidadeObjAtivo write SetUnidadeObjAtivo;
    property NomeObjErro: String read GetNomeObjErro write SetNomeObjErro;
    property TituloObjErro: String read GetTituloObjErro write SetTituloObjErro;
    property UnidadeObjErro: String read GetUnidadeObjErro write SetUnidadeObjErro;
    property LinhaErro: Integer read GetLinhaErro write SetLinhaErro;
    property FuncaoErro: String read GetFuncaoErro write SetFuncaoErro;
    property VersaoExe: String read GetVersaoExe write SetVersaoExe;
    property DataVersaoExe: TDate read GetDataVersaoExe write SetDataVersaoExe;
    property ArquiteturaExe: String read GetArquiteturaExe write SetArquiteturaExe;
    property DiretorioExe: String read GetDiretorioExe write SetDiretorioExe;
    property SistemaOperacional: String read GetSistemaOperacional write SetSistemaOperacional;
    property ModoExe: String read GetModoExe write SetModoExe;
    property Usuario: String read GetUsuario write SetUsuario;

  end;

implementation

{ TErroINI }

function TErroINI.GetMensagem: String;
begin
  Result := FMensagem;
end;

function TErroINI.GetMensagemTratada: String;
begin
  Result := FMensagemTratada;
end;

function TErroINI.GetModoExe: String;
begin
  Result := FModoExe;
end;

function TErroINI.GetNomeComputador: String;
begin
  Result := FNomeComputador;
end;

function TErroINI.GetNomeFormAtivo: String;
begin
  Result := FNomeFormAtivo;
end;

function TErroINI.GetNomeObjAtivo: String;
begin
  Result := FNomeObjAtivo;
end;

function TErroINI.GetNomeObjErro: String;
begin
  Result := FNomeObjErro;
end;

function TErroINI.GetSistemaOperacional: String;
begin
  Result := FSistemaOperacional;
end;

function TErroINI.GetTituloObjAtivo: String;
begin
  Result := FTituloObjAtivo;
end;

function TErroINI.GetTituloFormAtivo: String;
begin
  Result := FTituloFormAtivo;
end;

function TErroINI.GetTituloObjErro: String;
begin
  Result := FTituloObjErro;
end;

function TErroINI.GetUnidadeErro: String;
begin
  Result := FUnidadeErro;
end;

function TErroINI.GetUnidadeFormAtivo: String;
begin
  Result := FUnidadeFormAtivo;
end;

function TErroINI.GetUnidadeObjAtivo: String;
begin
  Result := FUnidadeObjAtivo;
end;

function TErroINI.GetUnidadeObjErro: String;
begin
  Result := FUnidadeObjErro;
end;

function TErroINI.GetUsuario: String;
begin
  Result := FUsuario;
end;

function TErroINI.GetVersaoExe: String;
begin
  Result := FVersaoExe;
end;

procedure TErroINI.SetArquiteturaExe(AValue: String);
begin
  FArquiteturaExe := AValue;
end;

procedure TErroINI.SetClasseErro(AValue: String);
begin
  FClasseErro := AValue;
end;

function TErroINI.GetData: TDate;
begin
  Result := FData;
end;

function TErroINI.GetDataVersaoExe: TDate;
begin
  Result := FDataVersaoExe;
end;

function TErroINI.GetDiretorioExe: String;
begin
  Result := FDiretorioExe;
end;

function TErroINI.GetFuncaoErro: String;
begin
  Result := FFuncaoErro;
end;

function TErroINI.GetClasseErro: String;
begin
  Result := FClasseErro;
end;

function TErroINI.GetArquiteturaExe: String;
begin
  Result := FArquiteturaExe;
end;

function TErroINI.GetHora: TTime;
begin
  Result := FHora;
end;

function TErroINI.GetID: String;
begin
  Result := FId;
end;

function TErroINI.GetIPComputador: String;
begin
  Result := FIPComputador;
end;

function TErroINI.GetLinhaErro: Integer;
begin
  Result:= FLinhaErro;
end;

procedure TErroINI.SetData(AValue: TDate);
begin
  FData := AValue;
end;

procedure TErroINI.SetDataVersaoExe(AValue: TDate);
begin
  FDataVersaoExe := AValue;
end;

procedure TErroINI.SetDiretorioExe(AValue: String);
begin
  FDiretorioExe := AValue;
end;

procedure TErroINI.SetFuncaoErro(AValue: String);
begin
  FFuncaoErro := AValue;
end;

procedure TErroINI.SetHora(AValue: TTime);
begin
  FHora := AValue;
end;

procedure TErroINI.SetID(AValue: String);
begin
  FID := AValue;
end;

procedure TErroINI.SetIPComputador(AValue: String);
begin
  FIPComputador := AValue;
end;

procedure TErroINI.SetLinhaErro(AValue: Integer);
begin
  FLinhaErro := AValue;
end;

procedure TErroINI.SetMensagem(AValue: String);
begin
  FMensagem := AValue;
end;

procedure TErroINI.Carregar;
begin
  //
end;

function TErroINI.VerificarSecaoAtual: String;
var
  cod: Integer;
  SecaoExiste: Boolean;
begin
  cod := 1;
  while True do
  begin
    lib.cryptini.ExisteSecao(PChar(FormatFloat('000000', cod)), SecaoExiste);
    if not SecaoExiste then
      break;
    cod:= cod + 1;
  end;
  Result := FormatFloat('000000', cod);
end;

procedure TErroINI.Escrever;
var
  secao: String;
begin
  secao := VerificarSecaoAtual;
  lib.cryptini.EscreverData( PChar(secao), 'DATA',                  FData);
  lib.cryptini.EscreverHora( PChar(secao), 'HORA',                  FHora);
  lib.cryptini.EscreverString( PChar(secao), 'NOME_COMPUTADOR',     PChar(FNomeComputador));
  lib.cryptini.EscreverString( PChar(secao), 'IP_COMPUTADOR',       PChar(FIPComputador));
  lib.cryptini.EscreverString( PChar(secao), 'MENSAGEM',            PChar(FMensagem));
  lib.cryptini.EscreverString( PChar(secao), 'MENSAGEM_TRATADA',    PChar(FMensagemTratada));
  lib.cryptini.EscreverString( PChar(secao), 'CLASSE_ERRO',         PChar(FClasseErro));
  lib.cryptini.EscreverString( PChar(secao), 'UNIDADE_ERRO',        PChar(FUnidadeErro));
  lib.cryptini.EscreverString( PChar(secao), 'NOME_FORM_ATIVO',     PChar(FNomeFormAtivo));
  lib.cryptini.EscreverString( PChar(secao), 'TITULO_FORM_ATIVO',   PChar(FTituloFormAtivo));
  lib.cryptini.EscreverString( PChar(secao), 'UNIDADE_FORM_ATIVO',  PChar(FUnidadeFormAtivo));
  lib.cryptini.EscreverString( PChar(secao), 'NOME_OBJ_ATIVO',      PChar(FNomeObjAtivo));
  lib.cryptini.EscreverString( PChar(secao), 'TITULO_OBJ_ATIVO',    PChar(FTituloObjAtivo));
  lib.cryptini.EscreverString( PChar(secao), 'UNIDADE_OBJ_ATIVO',   PChar(FUnidadeObjAtivo));
  lib.cryptini.EscreverString( PChar(secao), 'NOME_OBJ_ERRO',       PChar(FNomeObjErro));
  lib.cryptini.EscreverString( PChar(secao), 'TITULO_OBJ_ERRO',     PChar(FTituloObjErro));
  lib.cryptini.EscreverString( PChar(secao), 'UNIDADE_OBJ_ERRO',    PChar(FUnidadeObjErro));
  lib.cryptini.EscreverInteger( PChar(secao), 'LINHA_ERRO',         FLinhaErro);
  lib.cryptini.EscreverString( PChar(secao), 'FUNCAO_ERRO',         PChar(FFuncaoErro));
  lib.cryptini.EscreverString( PChar(secao), 'VERSAO_EXE',          PChar(FVersaoExe));
  lib.cryptini.EscreverData( PChar(secao), 'DATA_VERSAO_EXE',       FDataVersaoExe);
  lib.cryptini.EscreverString( PChar(secao), 'ARQUITETURA_EXE',     PChar(FArquiteturaExe));
  lib.cryptini.EscreverString( PChar(secao), 'DIRETORIO_EXE',       PChar(FDiretorioExe));
  lib.cryptini.EscreverString( PChar(secao), 'SISTEMA_OPERACIONAL', PChar(FSistemaOperacional));
  lib.cryptini.EscreverString( PChar(secao), 'MODO_EXE',            PChar(FModoExe));
  lib.cryptini.EscreverString( PChar(secao), 'USUARIO',             PChar(FUsuario));
end;

procedure TErroINI.CarregarPorSecao(Secao: String);
begin
  FId := Secao;
  lib.cryptini.LerData(PChar(Secao),    'DATA', FData);
  lib.cryptini.LerHora(PChar(Secao),    'HORA', FHora);
  lib.cryptini.LerString(PChar(Secao),  'MENSAGEM', FMensagem);
  lib.cryptini.LerString(PChar(Secao),  'MENSAGEM_TRATADA', FMensagemTratada);
  lib.cryptini.LerString(PChar(Secao),  'NOME_COMPUTADOR', FNomeComputador);
  lib.cryptini.LerString(PChar(Secao),  'IP_COMPUTADOR', FIPComputador);
  lib.cryptini.LerString(PChar(Secao),  'CLASSE_ERRO', FClasseErro);
  lib.cryptini.LerString(PChar(Secao),  'UNIDADE_ERRO', FUnidadeErro);
  lib.cryptini.LerString(PChar(Secao),  'NOME_FORM_ATIVO', FNomeFormAtivo);
  lib.cryptini.LerString(PChar(Secao),  'TITULO_FORM_ATIVO', FTituloFormAtivo);
  lib.cryptini.LerString(PChar(Secao),  'TITULO_FORM_ATIVO', FTituloFormAtivo);
  lib.cryptini.LerString(PChar(Secao),  'UNIDADE_FORM_ATIVO', FUnidadeFormAtivo);
  lib.cryptini.LerString(PChar(Secao),  'TITULO_OBJ_ATIVO', FTituloObjAtivo);
  lib.cryptini.LerString(PChar(Secao),  'UNIDADE_OBJ_ATIVO', FUnidadeObjAtivo);
  lib.cryptini.LerString(PChar(Secao),  'NOME_OBJ_ERRO', FNomeObjErro);
  lib.cryptini.LerString(PChar(Secao),  'TITULO_OBJ_ERRO', FTituloObjErro);
  lib.cryptini.LerString(PChar(Secao),  'UNIDADE_OBJ_ERRO', FUnidadeObjErro);
  lib.cryptini.LerInteger(PChar(Secao), 'LINHA_ERRO', FLinhaErro);
  lib.cryptini.LerString(PChar(Secao),  'FUNCAO_ERRO', FFuncaoErro);
  lib.cryptini.LerString(PChar(Secao),  'VERSAO_EXE', FVersaoExe);
  lib.cryptini.LerData(PChar(Secao),    'DATA_VERSAO_EXE', FDataVersaoExe);
  lib.cryptini.LerString(PChar(Secao),  'ARQUITETURA_EXE', FArquiteturaExe);
  lib.cryptini.LerString(PChar(Secao),  'DIRETORIO_EXE', FDiretorioExe);
  lib.cryptini.LerString(PChar(Secao),  'SISTEMA_OPERACIONAL', FSistemaOperacional);
  lib.cryptini.LerString(PChar(Secao),  'MODO_EXE', FModoExe);
  lib.cryptini.LerString(PChar(Secao),  'USUARIO', FUsuario);
end;

function TErroINI.ExisteSecaoIni(Secao: String): Boolean;
begin
  lib.cryptini.ExisteSecao(PChar(Secao), Result);
end;

procedure TErroINI.SetMensagemTratada(AValue: String);
begin
  FMensagemTratada := AValue;
end;

procedure TErroINI.SetModoExe(AValue: String);
begin
  FModoExe := AValue;
end;

procedure TErroINI.SetNomeComputador(AValue: String);
begin
  FNomeComputador := AValue;
end;

procedure TErroINI.SetNomeFormAtivo(AValue: String);
begin
  FNomeFormAtivo := AValue;
end;

procedure TErroINI.SetNomeObjAtivo(AValue: String);
begin
  FNomeObjAtivo := AValue;
end;

procedure TErroINI.SetNomeObjErro(AValue: String);
begin
  FNomeObjErro := AValue;
end;

procedure TErroINI.SetSistemaOperacional(AValue: String);
begin
  FSistemaOperacional := AValue;
end;

procedure TErroINI.SetTituloFormAtivo(AValue: String);
begin
  FTituloFormAtivo := AValue;
end;

procedure TErroINI.SetTituloObjAtivo(AValue: String);
begin
  FTituloObjAtivo := AValue;
end;

procedure TErroINI.SetTituloObjErro(AValue: String);
begin
  FTituloObjErro := AValue;
end;

procedure TErroINI.SetUnidadeErro(AValue: String);
begin
  FUnidadeErro := AValue;
end;

procedure TErroINI.SetUnidadeFormAtivo(AValue: String);
begin
  FUnidadeFormAtivo := AValue;
end;

procedure TErroINI.SetUnidadeObjAtivo(AValue: String);
begin
  FUnidadeObjAtivo := AValue;
end;

procedure TErroINI.SetUnidadeObjErro(AValue: String);
begin
  FUnidadeObjErro := AValue;
end;

procedure TErroINI.SetUsuario(AValue: String);
begin
  FUsuario := AValue;
end;

procedure TErroINI.SetVersaoExe(AValue: String);
begin
  FVersaoExe := AValue;
end;

constructor TErroINI.Create;
var
  KEY, MD5: String;
begin
  FArquivoErr := ExtractFilePath(ParamStr(0))+'Erro.err';
  KEY := 'compras_laz_2025_KEY';
  MD5 := 'compras_laz_2025_MD5';
  lib.cryptini.inicializar(PChar(FArquivoErr), PChar(KEY), Pchar(MD5));
end;

destructor TErroINI.Destroy;
begin
  lib.cryptini.finalizar;
  inherited Destroy;
end;

end.

