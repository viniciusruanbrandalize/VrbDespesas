unit model.entity.estado;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.entity.pais;

type

  { TEstado }

  TEstado = class
  private
    FUF:   String;
    FNome: String;
    FIBGE: Integer;
    FPais: TPais;
    function GetIBGE: Integer;
    function GetPais: TPais;
    function GetUF: String;
    function GetNome: String;
    procedure SetIBGE(AValue: Integer);
    procedure SetNome(AValue: String);
    procedure SetPais(AValue: TPais);
    procedure SetUF(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property UF: String read GetUF write SetUF;
    property Nome: String read GetNome write SetNome;
    property IBGE: Integer read GetIBGE write SetIBGE;
    property Pais: TPais read GetPais write SetPais;
  end;

implementation

{ TEstado }

function TEstado.GetUF: String;
begin
  Result := FUF;
end;

function TEstado.GetIBGE: Integer;
begin
  Result := FIBGE;
end;

function TEstado.GetPais: TPais;
begin
  Result := FPais;
end;

function TEstado.GetNome: String;
begin
  Result := FNome;
end;

procedure TEstado.SetIBGE(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "IBGE" precisa ser preenchido!')
  else
    FIBGE := AValue;
end;

procedure TEstado.SetUF(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "UF" precisa ser preenchido!')
  else
    FUF := AValue;
end;

procedure TEstado.SetNome(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Nome" precisa ser preenchido!')
  else
    FNome := AValue;
end;

procedure TEstado.SetPais(AValue: TPais);
begin
  if AValue = nil then
    raise Exception.Create('O campo "Pais" precisa ser preenchido!')
  else
    FPais := AValue;
end;

constructor TEstado.Create;
begin
  //
end;

destructor TEstado.Destroy;
begin
  inherited Destroy;
end;

end.

