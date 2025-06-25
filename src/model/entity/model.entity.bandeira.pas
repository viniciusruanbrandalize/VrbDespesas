unit model.entity.bandeira;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TBandeira }

  TBandeira = class
  private
    FId:   Integer;
    FNome: String;
    FExcluido: Boolean;
    function GetExcluido: Boolean;
    function GetId: Integer;
    function GetNome: String;
    procedure SetExcluido(AValue: Boolean);
    procedure SetId(AValue: Integer);
    procedure SetNome(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Nome: String read GetNome write SetNome;
    property Excluido: Boolean read GetExcluido write SetExcluido;
  end;

implementation

{ TBandeira }

function TBandeira.GetId: Integer;
begin
  Result := FId;
end;

function TBandeira.GetExcluido: Boolean;
begin
  Result := FExcluido;
end;

function TBandeira.GetNome: String;
begin
  Result := FNome;
end;

procedure TBandeira.SetExcluido(AValue: Boolean);
begin
  FExcluido := AValue;
end;

procedure TBandeira.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Id" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TBandeira.SetNome(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Nome" precisa ser preenchido!')
  else
    FNome := AValue;
end;

constructor TBandeira.Create;
begin
  //
end;

destructor TBandeira.Destroy;
begin
  inherited Destroy;
end;

end.

