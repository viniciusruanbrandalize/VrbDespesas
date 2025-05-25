unit model.entity.uctela;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TUcTela }

  TUcTela = class
  private
    FNome: String;
    FTitulo: String;
    function GetNome: String;
    function GetTitulo: String;
    procedure SetNome(AValue: String);
    procedure SetTitulo(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Nome: String read GetNome write SetNome;
    property Titulo: String read GetTitulo write SetTitulo;
  end;

implementation

{ TUcTela }

function TUcTela.GetNome: String;
begin
  Result := FNome;
end;

function TUcTela.GetTitulo: String;
begin
  Result := FTitulo;
end;

procedure TUcTela.SetNome(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Nome" precisa ser preenchido!')
  else
    FNome := AValue;
end;

procedure TUcTela.SetTitulo(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Titulo" precisa ser preenchido!')
  else
    FTitulo := AValue;
end;

constructor TUcTela.Create;
begin
  //
end;

destructor TUcTela.Destroy;
begin
  inherited Destroy;
end;

end.

