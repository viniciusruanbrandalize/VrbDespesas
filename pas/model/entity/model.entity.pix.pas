unit model.entity.pix;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.entity.contabancaria, model.entity.usuario,
  model.entity.participante;

type

  { TPix }

  TPix = class
  private
    FAlteracao: TDateTime;
    FCadastro: TDateTime;
    FChave: String;
    FContaBancaria: TContaBancaria;
    FDonoCadastro: TParticipante;
    FTipo: String;
    FUsuarioCadastro: TUsuario;
    FExcluido: Boolean;
    function GetAlteracao: TDateTime;
    function GetCadastro: TDateTime;
    function GetChave: String;
    function GetContaBancaria: TContaBancaria;
    function GetDonoCadastro: TParticipante;
    function GetExcluido: Boolean;
    function GetTipo: String;
    function GetUsuarioCadastro: TUsuario;
    procedure SetAlteracao(AValue: TDateTime);
    procedure SetCadastro(AValue: TDateTime);
    procedure SetChave(AValue: String);
    procedure SetContaBancaria(AValue: TContaBancaria);
    procedure SetDonoCadastro(AValue: TParticipante);
    procedure SetExcluido(AValue: Boolean);
    procedure SetTipo(AValue: String);
    procedure SetUsuarioCadastro(AValue: TUsuario);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Chave: String read GetChave write SetChave;
    property Tipo: String read GetTipo write SetTipo;
    property Cadastro: TDateTime read GetCadastro write SetCadastro;
    property Alteracao: TDateTime read GetAlteracao write SetAlteracao;
    property Excluido: Boolean read GetExcluido write SetExcluido;
    property ContaBancaria: TContaBancaria read GetContaBancaria write SetContaBancaria;
    property DonoCadastro: TParticipante read GetDonoCadastro write SetDonoCadastro;
    property UsuarioCadastro: TUsuario read GetUsuarioCadastro write SetUsuarioCadastro;
  end;

implementation

{ TPix }

procedure TPix.SetChave(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Chave" precisa ser preenchido!')
  else
    FChave := AValue;
end;

procedure TPix.SetContaBancaria(AValue: TContaBancaria);
begin
  if AValue = nil then
    raise Exception.Create('O campo "Chave" precisa ser preenchido!')
  else
    FContaBancaria := AValue;
end;

procedure TPix.SetDonoCadastro(AValue: TParticipante);
begin
  if FDonoCadastro=AValue then Exit;
  FDonoCadastro:=AValue;
end;

procedure TPix.SetExcluido(AValue: Boolean);
begin
  FExcluido := AValue;
end;

procedure TPix.SetCadastro(AValue: TDateTime);
begin
  if FCadastro=AValue then Exit;
  FCadastro:=AValue;
end;

procedure TPix.SetAlteracao(AValue: TDateTime);
begin
  if FAlteracao=AValue then Exit;
  FAlteracao:=AValue;
end;

function TPix.GetAlteracao: TDateTime;
begin
  Result := FAlteracao;
end;

function TPix.GetCadastro: TDateTime;
begin
  Result := FCadastro;
end;

function TPix.GetChave: String;
begin
  Result := FChave;
end;

function TPix.GetContaBancaria: TContaBancaria;
begin
  Result := FContaBancaria;
end;

function TPix.GetDonoCadastro: TParticipante;
begin
  Result := FDonoCadastro;
end;

function TPix.GetExcluido: Boolean;
begin
  Result := FExcluido;
end;

function TPix.GetTipo: String;
begin
  Result := FTipo;
end;

function TPix.GetUsuarioCadastro: TUsuario;
begin
  Result := FUsuarioCadastro;
end;

procedure TPix.SetTipo(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Tipo" precisa ser preenchido!')
  else
    FTipo:=AValue;
end;

procedure TPix.SetUsuarioCadastro(AValue: TUsuario);
begin
  if FUsuarioCadastro=AValue then Exit;
  FUsuarioCadastro:=AValue;
end;

constructor TPix.Create;
begin
  FUsuarioCadastro := TUsuario.Create;
  FContaBancaria   := TContaBancaria.Create;
end;

destructor TPix.Destroy;
begin
  if Assigned(FUsuarioCadastro) then
    FUsuarioCadastro.Free;
  if Assigned(FContaBancaria) then
    FContaBancaria.Free;
  inherited Destroy;
end;

end.

