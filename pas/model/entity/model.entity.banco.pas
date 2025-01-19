unit model.entity.banco;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TBanco }

  TBanco = class
  private
    FId:   Integer;
    FNome: String;
    FNumero: Integer;
    function GetId: Integer;
    function GetNome: String;
    function GetNumero: Integer;
    procedure SetId(AValue: Integer);
    procedure SetNome(AValue: String);
    procedure SetNumero(AValue: Integer);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Nome: String read GetNome write SetNome;
    property Numero: Integer read GetNumero write SetNumero;
  end;

implementation

{ TBanco }

function TBanco.GetId: Integer;
begin
  Result := FId;
end;

function TBanco.GetNome: String;
begin
  Result := FNome;
end;

function TBanco.GetNumero: Integer;
begin
  Result := FNumero;
end;

procedure TBanco.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Id" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TBanco.SetNome(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Nome" precisa ser preenchido!')
  else
    FNome := AValue;
end;

procedure TBanco.SetNumero(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Número" precisa ser preenchido!')
  else
    FNumero := AValue;
end;

constructor TBanco.Create;
begin
  //
end;

destructor TBanco.Destroy;
begin
  inherited Destroy;
end;

end.

