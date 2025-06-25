unit model.entity.formapagamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TFormaPagamento }

  TFormaPagamento = class
  private
    FId:   Integer;
    FNome: String;
    FSigla: String;
    FExcluido: Boolean;
    function GetExcluido: Boolean;
    function GetId: Integer;
    function GetNome: String;
    function GetSigla: String;
    procedure SetExcluido(AValue: Boolean);
    procedure SetId(AValue: Integer);
    procedure SetNome(AValue: String);
    procedure SetSigla(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Nome: String read GetNome write SetNome;
    property Sigla: String read GetSigla write SetSigla;
    property Excluido: Boolean read GetExcluido write SetExcluido;
  end;

implementation

{ TFormaPagamento }

function TFormaPagamento.GetId: Integer;
begin
  Result := FId;
end;

function TFormaPagamento.GetExcluido: Boolean;
begin
  Result := FExcluido;
end;

function TFormaPagamento.GetNome: String;
begin
  Result := FNome;
end;

function TFormaPagamento.GetSigla: String;
begin
  Result := FSigla;
end;

procedure TFormaPagamento.SetExcluido(AValue: Boolean);
begin
  FExcluido := AValue;
end;

procedure TFormaPagamento.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Id" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TFormaPagamento.SetNome(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Nome" precisa ser preenchido!')
  else
    FNome := AValue;
end;

procedure TFormaPagamento.SetSigla(AValue: String);
begin
  FSigla := AValue;
end;

constructor TFormaPagamento.Create;
begin
  //
end;

destructor TFormaPagamento.Destroy;
begin
  inherited Destroy;
end;

end.

