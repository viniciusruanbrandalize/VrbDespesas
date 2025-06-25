unit model.entity.ucacesso;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.entity.ucacao, model.entity.usuario;

type

  { TUcAcesso }

  TUcAcesso = class
  private
    FId: Integer;
    FUcAcao: TUcAcao;
    FUsuario: TUsuario;
    function GetId: Integer;
    function GetUcAcao: TUcAcao;
    function GetUsuario: TUsuario;
    procedure SetId(AValue: Integer);
    procedure SetUcAcao(AValue: TUcAcao);
    procedure SetUsuario(AValue: TUsuario);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property UcAcao: TUcAcao read GetUcAcao write SetUcAcao;
    property Usuario: TUsuario read GetUsuario write SetUsuario;
  end;

implementation

{ TUcAcesso }

function TUcAcesso.GetId: Integer;
begin
  Result := FId;
end;

function TUcAcesso.GetUcAcao: TUcAcao;
begin
  Result := FUcAcao;
end;

function TUcAcesso.GetUsuario: TUsuario;
begin
  Result := FUsuario;
end;

procedure TUcAcesso.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "ID" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TUcAcesso.SetUcAcao(AValue: TUcAcao);
begin
  if AValue = nil then
    raise Exception.Create('O campo "UcAcao" precisa ser preenchido!')
  else
    FUcAcao := AValue;
end;

procedure TUcAcesso.SetUsuario(AValue: TUsuario);
begin
  if AValue = nil then
    raise Exception.Create('O campo "Usuário" precisa ser preenchido!')
  else
    FUsuario := AValue;
end;

constructor TUcAcesso.Create;
begin
  FUcAcao  := TUcAcao.Create;
  FUsuario := TUsuario.Create;
end;

destructor TUcAcesso.Destroy;
begin
  FreeAndNil(FUcAcao);
  FreeAndNil(FUsuario);
  inherited Destroy;
end;

end.

