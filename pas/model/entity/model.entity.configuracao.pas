unit model.entity.configuracao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TConfiguracao }

  TConfiguracao = class
  private
    FId:   Integer;
    FNome: String;
    FDescricao: String;
    FUso: String;
    FValor: String;
    FExcluido: Boolean;
    function GetDescricao: String;
    function GetExcluido: Boolean;
    function GetId: Integer;
    function GetNome: String;
    function GetUso: String;
    function GetValor: String;
    procedure SetDescricao(AValue: String);
    procedure SetExcluido(AValue: Boolean);
    procedure SetId(AValue: Integer);
    procedure SetNome(AValue: String);
    procedure SetUso(AValue: String);
    procedure SetValor(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Nome: String read GetNome write SetNome;
    property Descricao: String read GetDescricao write SetDescricao;
    property Uso: String read GetUso write SetUso;
    property Valor: String read GetValor write SetValor;
    property Excluido: Boolean read GetExcluido write SetExcluido;
  end;

implementation

{ TConfiguracao }

function TConfiguracao.GetId: Integer;
begin
  Result := FId;
end;

function TConfiguracao.GetDescricao: String;
begin
  Result := FDescricao;
end;

function TConfiguracao.GetExcluido: Boolean;
begin
  Result := FExcluido;
end;

function TConfiguracao.GetNome: String;
begin
  Result := FNome;
end;

function TConfiguracao.GetUso: String;
begin
  Result := FUso;
end;

function TConfiguracao.GetValor: String;
begin
  Result := FValor;
end;

procedure TConfiguracao.SetDescricao(AValue: String);
begin
  FDescricao := AValue;
end;

procedure TConfiguracao.SetExcluido(AValue: Boolean);
begin
  FExcluido := AValue;
end;

procedure TConfiguracao.SetId(AValue: Integer);
begin
  FId := AValue;
end;

procedure TConfiguracao.SetNome(AValue: String);
begin
  FNome := AValue;
end;

procedure TConfiguracao.SetUso(AValue: String);
begin
  FUso := AValue;
end;

procedure TConfiguracao.SetValor(AValue: String);
begin
  FValor := AValue;
end;

constructor TConfiguracao.Create;
begin
  //
end;

destructor TConfiguracao.Destroy;
begin
  inherited Destroy;
end;

end.

