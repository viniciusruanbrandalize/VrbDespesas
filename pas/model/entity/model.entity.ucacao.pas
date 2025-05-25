unit model.entity.ucacao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.entity.uctela;

type

  { TUcAcao }

  TUcAcao = class
  private
    FId: Integer;
    FNome: String;
    FTitulo: String;
    FUcTela: TUcTela;
    function GetId: Integer;
    function GetNome: String;
    function GetTitulo: String;
    function GetUcTela: TUcTela;
    procedure SetId(AValue: Integer);
    procedure SetNome(AValue: String);
    procedure SetTitulo(AValue: String);
    procedure SetUcTela(AValue: TUcTela);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Nome: String read GetNome write SetNome;
    property Titulo: String read GetTitulo write SetTitulo;
    property UcTela: TUcTela read GetUcTela write SetUcTela;
  end;

implementation

{ TUcAcao }

function TUcAcao.GetNome: String;
begin
  Result := FNome;
end;

function TUcAcao.GetId: Integer;
begin
  Result := FId;
end;

function TUcAcao.GetTitulo: String;
begin
  Result := FTitulo;
end;

function TUcAcao.GetUcTela: TUcTela;
begin
  Result := FUcTela;
end;

procedure TUcAcao.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "ID" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TUcAcao.SetNome(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Nome" precisa ser preenchido!')
  else
    FNome := AValue;
end;

procedure TUcAcao.SetTitulo(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Titulo" precisa ser preenchido!')
  else
    FTitulo := AValue;
end;

procedure TUcAcao.SetUcTela(AValue: TUcTela);
begin
  if AValue = nil then
    raise Exception.Create('O campo "UcTela" precisa ser preenchido!')
  else
    FUcTela := AValue;
end;

constructor TUcAcao.Create;
begin
  FUcTela := TUcTela.Create;
end;

destructor TUcAcao.Destroy;
begin
  FreeAndNil(FUcTela);
  inherited Destroy;
end;

end.

