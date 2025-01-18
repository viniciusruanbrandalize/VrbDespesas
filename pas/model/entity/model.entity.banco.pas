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
    function GetId: Integer;
    function GetNome: String;
    procedure SetId(AValue: Integer);
    procedure SetNome(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Nome: String read GetNome write SetNome;
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

procedure TBanco.SetId(AValue: Integer);
begin
  FId := AValue;
end;

procedure TBanco.SetNome(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Nome" precisa ser preenchido!')
  else
    FNome := AValue;
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

