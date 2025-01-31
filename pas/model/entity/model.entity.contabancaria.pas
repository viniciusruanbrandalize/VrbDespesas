unit model.entity.contabancaria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.entity.banco, model.entity.usuario,
  model.entity.participante, model.entity.donocadastro;

type

  { TContaBancaria }

  TContaBancaria = class
  private
    FAgencia: String;
    FId:   Integer;
    FNumero: String;
    FTipo: String;
    FCadastro: TDateTime;
    FAlteracao: TDateTime;
    FBanco: TBanco;
    FUsuarioCadastro: TUsuario;
    FDonoCadastro: IParticipante;
    function GetAgencia: String;
    function GetAlteracao: TDateTime;
    function GetBanco: TBanco;
    function GetCadastro: TDateTime;
    function GetDonoCadastro: IParticipante;
    function GetId: Integer;
    function GetNumero: String;
    function GetTipo: String;
    function GetUsuarioCadastro: TUsuario;
    procedure SetAgencia(AValue: String);
    procedure SetAlteracao(AValue: TDateTime);
    procedure SetBanco(AValue: TBanco);
    procedure SetCadastro(AValue: TDateTime);
    procedure SetDonoCadastro(AValue: IParticipante);
    procedure SetId(AValue: Integer);
    procedure SetNumero(AValue: String);
    procedure SetTipo(AValue: String);
    procedure SetUsuarioCadastro(AValue: TUsuario);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Numero: String read GetNumero write SetNumero;
    property Agencia: String read GetAgencia write SetAgencia;
    property Tipo: String read GetTipo write SetTipo;
    property Cadastro: TDateTime read GetCadastro write SetCadastro;
    property Alteracao: TDateTime read GetAlteracao write SetAlteracao;
    property Banco: TBanco read GetBanco write SetBanco;
    property UsuarioCadastro: TUsuario read GetUsuarioCadastro write SetUsuarioCadastro;
    property DonoCadastro: IParticipante read GetDonoCadastro write SetDonoCadastro;
  end;

implementation

{ TContaBancaria }

function TContaBancaria.GetId: Integer;
begin
  Result := FId;
end;

function TContaBancaria.GetAgencia: String;
begin
  Result := FAgencia;
end;

function TContaBancaria.GetAlteracao: TDateTime;
begin
  Result := FAlteracao;
end;

function TContaBancaria.GetBanco: TBanco;
begin
  Result := FBanco;
end;

function TContaBancaria.GetCadastro: TDateTime;
begin
  Result := FCadastro;
end;

function TContaBancaria.GetDonoCadastro: IParticipante;
begin
  Result := FDonoCadastro;
end;

function TContaBancaria.GetNumero: String;
begin
  Result := FNumero;
end;

function TContaBancaria.GetTipo: String;
begin
  Result := FTipo;
end;

function TContaBancaria.GetUsuarioCadastro: TUsuario;
begin
  Result := FUsuarioCadastro;
end;

procedure TContaBancaria.SetAgencia(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Agência" precisa ser preenchido!')
  else
    FAgencia := AValue;
end;

procedure TContaBancaria.SetAlteracao(AValue: TDateTime);
begin
  if FAlteracao=AValue then Exit;
  FAlteracao:=AValue;
end;

procedure TContaBancaria.SetBanco(AValue: TBanco);
begin
  if AValue = nil then
    raise Exception.Create('O campo "Banco" precisa ser preenchido!')
  else
    FBanco := AValue;
end;

procedure TContaBancaria.SetCadastro(AValue: TDateTime);
begin
  if FCadastro=AValue then Exit;
  FCadastro:=AValue;
end;

procedure TContaBancaria.SetDonoCadastro(AValue: IParticipante);
begin
  FDonoCadastro := AValue;
end;

procedure TContaBancaria.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Id" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TContaBancaria.SetNumero(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Número" precisa ser preenchido!')
  else
    FNumero := AValue;
end;

procedure TContaBancaria.SetTipo(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Tipo" precisa ser preenchido!')
  else
    FTipo := AValue;
end;

procedure TContaBancaria.SetUsuarioCadastro(AValue: TUsuario);
begin
  if FUsuarioCadastro=AValue then Exit;
  FUsuarioCadastro:=AValue;
end;

constructor TContaBancaria.Create;
begin
  FBanco := TBanco.Create;
  FDonoCadastro := TDonoCadastro.Create;
  FUsuarioCadastro := TUsuario.Create;
end;

destructor TContaBancaria.Destroy;
begin
  FBanco.Free;
  FUsuarioCadastro.Free;
  FreeAndNil(FDonoCadastro);
  inherited Destroy;
end;

end.

