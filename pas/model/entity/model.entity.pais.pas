unit model.entity.pais;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TPais }

  TPais = class
  private
    FId:   Integer;
    FNome: String;
    FSiscomex: String;
    FSped: String;
    function GetId: Integer;
    function GetNome: String;
    function GetSiscomex: String;
    function GetSped: String;
    procedure SetId(AValue: Integer);
    procedure SetNome(AValue: String);
    procedure SetSiscomex(AValue: String);
    procedure SetSped(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Nome: String read GetNome write SetNome;
    property Siscomex: String read GetSiscomex write SetSiscomex;
    property Sped: String read GetSped write SetSped;
  end;

implementation

{ TPais }

function TPais.GetId: Integer;
begin
  Result := FId;
end;

function TPais.GetNome: String;
begin
  Result := FNome;
end;

function TPais.GetSiscomex: String;
begin
  Result := FSiscomex;
end;

function TPais.GetSped: String;
begin
  Result := FSped;
end;

procedure TPais.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Id" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TPais.SetNome(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Nome" precisa ser preenchido!')
  else
    FNome := AValue;
end;

procedure TPais.SetSiscomex(AValue: String);
begin
  FSiscomex := AValue;
end;

procedure TPais.SetSped(AValue: String);
begin
  FSped := AValue;
end;

constructor TPais.Create;
begin
  //
end;

destructor TPais.Destroy;
begin
  inherited Destroy;
end;

end.

