unit model.entity.cidade;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.entity.estado;

type

  { TCidade }

  TCidade = class
  private
    FId:   Integer;
    FNome: String;
    FIBGE: Integer;
    FEstado: TEstado;
    function GetEstado: TEstado;
    function GetIBGE: Integer;
    function GetId: Integer;
    function GetNome: String;
    procedure SetEstado(AValue: TEstado);
    procedure SetIBGE(AValue: Integer);
    procedure SetId(AValue: Integer);
    procedure SetNome(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Nome: String read GetNome write SetNome;
    property IBGE: Integer read GetIBGE write SetIBGE;
    property Estado: TEstado read GetEstado write SetEstado;
  end;

implementation

{ TCidade }

function TCidade.GetId: Integer;
begin
  Result := FId;
end;

function TCidade.GetEstado: TEstado;
begin
  Result := FEstado;
end;

function TCidade.GetIBGE: Integer;
begin
  Result := FIBGE;
end;

function TCidade.GetNome: String;
begin
  Result := FNome;
end;

procedure TCidade.SetEstado(AValue: TEstado);
begin
  if AValue = nil then
    raise Exception.Create('O campo "UF" precisa ser preenchido!')
  else
    FEstado := AValue;
end;

procedure TCidade.SetIBGE(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "IBGE" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TCidade.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Id" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TCidade.SetNome(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Nome" precisa ser preenchido!')
  else
    FNome := AValue;
end;

constructor TCidade.Create;
begin
  FEstado := TEstado.Create;
end;

destructor TCidade.Destroy;
begin
  FreeAndNil(FEstado);
  inherited Destroy;
end;

end.

