unit model.entity.usuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TUsuario }

  TUsuario = class
  private
    FId:   Integer;
    FNome: String;
    FSenha: String;
    FEmail: String;
    FDataCadastro: TDate;
    FHoraCadastro: TTime;
    function GetDataCadastro: TDate;
    function GetEmail: String;
    function GetHoraCadastro: TTime;
    function GetId: Integer;
    function GetNome: String;
    function GetSenha: String;
    procedure SetDataCadastro(AValue: TDate);
    procedure SetEmail(AValue: String);
    procedure SetHoraCadastro(AValue: TTime);
    procedure SetId(AValue: Integer);
    procedure SetNome(AValue: String);
    procedure SetSenha(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Nome: String read GetNome write SetNome;
    property Senha: String read GetSenha write SetSenha;
    property Email: String read GetEmail write SetEmail;
    property DataCadastro: TDate read GetDataCadastro write SetDataCadastro;
    property HoraCadastro: TTime read GetHoraCadastro write SetHoraCadastro;
  end;

implementation

{ TUsuario }

function TUsuario.GetDataCadastro: TDate;
begin
  Result := FDataCadastro;
end;

function TUsuario.GetEmail: String;
begin
  Result := FEmail;
end;

function TUsuario.GetHoraCadastro: TTime;
begin
  Result := FHoraCadastro;
end;

function TUsuario.GetSenha: String;
begin
  Result := FSenha;
end;

procedure TUsuario.SetDataCadastro(AValue: TDate);
begin
  FDataCadastro := AValue;
end;

procedure TUsuario.SetEmail(AValue: String);
begin
  FEmail := AValue;
end;

procedure TUsuario.SetHoraCadastro(AValue: TTime);
begin
  FHoraCadastro := AValue;
end;

procedure TUsuario.SetSenha(AValue: String);
begin
  FSenha := AValue;
end;

function TUsuario.GetId: Integer;
begin
  Result := FId;
end;

function TUsuario.GetNome: String;
begin
  Result := FNome;
end;

procedure TUsuario.SetId(AValue: Integer);
begin
  FId := AValue;
end;

procedure TUsuario.SetNome(AValue: String);
begin
  FNome := AValue;
end;

constructor TUsuario.Create;
begin
  //
end;

destructor TUsuario.Destroy;
begin
  inherited Destroy;
end;

end.
