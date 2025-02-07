unit model.entity.usuariodonocadastro;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.entity.usuario, model.entity.participante;

type

  { TUsuarioDonoCadastro }

  TUsuarioDonoCadastro = class
  private
    FCadastro: TDateTime;
    FDonoCadastro: TParticipante;
    FId:   Integer;
    FUsuario: TUsuario;
    function GetCadastro: TDateTime;
    function GetDonoCadastro: TParticipante;
    function GetId: Integer;
    function GetUsuario: TUsuario;
    procedure SetCadastro(AValue: TDateTime);
    procedure SetDonoCadastro(AValue: TParticipante);
    procedure SetId(AValue: Integer);
    procedure SetUsuario(AValue: TUsuario);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Usuario: TUsuario read GetUsuario write SetUsuario;
    property DonoCadastro: TParticipante read GetDonoCadastro write SetDonoCadastro;
    property Cadastro: TDateTime read GetCadastro write SetCadastro;
  end;

implementation

{ TUsuarioDonoCadastro }

function TUsuarioDonoCadastro.GetId: Integer;
begin
  Result := FId;
end;

function TUsuarioDonoCadastro.GetCadastro: TDateTime;
begin
  Result := FCadastro;
end;

function TUsuarioDonoCadastro.GetDonoCadastro: TParticipante;
begin
  Result := FDonoCadastro;
end;

function TUsuarioDonoCadastro.GetUsuario: TUsuario;
begin
  Result := FUsuario;
end;

procedure TUsuarioDonoCadastro.SetCadastro(AValue: TDateTime);
begin
  FCadastro := AValue;
end;

procedure TUsuarioDonoCadastro.SetDonoCadastro(AValue: TParticipante);
begin
  if AValue = nil then
    raise Exception.Create('O campo "Dono do Cadastro" precisa ser preenchido!')
  else
    FDonoCadastro := AValue;
end;

procedure TUsuarioDonoCadastro.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Id" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TUsuarioDonoCadastro.SetUsuario(AValue: TUsuario);
begin
  if AValue = nil then
    raise Exception.Create('O campo "Usuário" precisa ser preenchido!')
  else
    FUsuario:=AValue;
end;

constructor TUsuarioDonoCadastro.Create;
begin
  //
end;

destructor TUsuarioDonoCadastro.Destroy;
begin
  inherited Destroy;
end;

end.

