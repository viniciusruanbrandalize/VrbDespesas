unit model.entity.cartao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.entity.contabancaria, model.entity.bandeira,
  model.entity.participante, model.entity.usuario;

type

  { TCartao }

  TCartao = class
  private
    FAlteracao: TDateTime;
    FAproximacao: Boolean;
    FBandeira: TBandeira;
    FCadastro: TDateTime;
    FContaBancaria: TContaBancaria;
    FDonoCadastro: TParticipante;
    FId:   Integer;
    FNumero: String;
    FTipo: String;
    FUsuarioCadastro: TUsuario;
    FValidade: TDate;
    FExcluido: Boolean;
    function GetAlteracao: TDateTime;
    function GetAproximacao: Boolean;
    function GetBandeira: TBandeira;
    function GetCadastro: TDateTime;
    function GetContaBancaria: TContaBancaria;
    function GetDonoCadastro: TParticipante;
    function GetExcluido: Boolean;
    function GetId: Integer;
    function GetNumero: String;
    function GetTipo: String;
    function GetUsuarioCadastro: TUsuario;
    function GetValidade: TDate;
    procedure SetAlteracao(AValue: TDateTime);
    procedure SetAproximacao(AValue: Boolean);
    procedure SetBandeira(AValue: TBandeira);
    procedure SetCadastro(AValue: TDateTime);
    procedure SetContaBancaria(AValue: TContaBancaria);
    procedure SetDonoCadastro(AValue: TParticipante);
    procedure SetExcluido(AValue: Boolean);
    procedure SetId(AValue: Integer);
    procedure SetNumero(AValue: String);
    procedure SetTipo(AValue: String);
    procedure SetUsuarioCadastro(AValue: TUsuario);
    procedure SetValidade(AValue: TDate);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Numero: String read GetNumero write SetNumero;
    property Tipo: String read GetTipo write SetTipo;
    property Aproximacao: Boolean read GetAproximacao write SetAproximacao;
    property Validade: TDate read GetValidade write SetValidade;
    property Cadastro: TDateTime read GetCadastro write SetCadastro;
    property Alteracao: TDateTime read GetAlteracao write SetAlteracao;
    property Bandeira: TBandeira read GetBandeira write SetBandeira;
    property ContaBancaria: TContaBancaria read GetContaBancaria write SetContaBancaria;
    property DonoCadastro: TParticipante read GetDonoCadastro write SetDonoCadastro;
    property UsuarioCadastro: TUsuario read GetUsuarioCadastro write SetUsuarioCadastro;
    property Excluido: Boolean read GetExcluido write SetExcluido;
  end;

implementation

{ TCartao }

function TCartao.GetId: Integer;
begin
  Result := FId;
end;

function TCartao.GetAlteracao: TDateTime;
begin
  Result := FAlteracao;
end;

function TCartao.GetAproximacao: Boolean;
begin
  Result := FAproximacao;
end;

function TCartao.GetBandeira: TBandeira;
begin
  Result := FBandeira;
end;

function TCartao.GetCadastro: TDateTime;
begin
  Result := FCadastro;
end;

function TCartao.GetContaBancaria: TContaBancaria;
begin
  Result := FContaBancaria;
end;

function TCartao.GetDonoCadastro: TParticipante;
begin
  Result := FDonoCadastro;
end;

function TCartao.GetExcluido: Boolean;
begin
  Result := FExcluido;
end;

function TCartao.GetNumero: String;
begin
  Result := FNumero
end;

function TCartao.GetTipo: String;
begin
  Result := FTipo;
end;

function TCartao.GetUsuarioCadastro: TUsuario;
begin
  Result := FUsuarioCadastro;
end;

function TCartao.GetValidade: TDate;
begin
  Result := FValidade;
end;

procedure TCartao.SetAlteracao(AValue: TDateTime);
begin
  FAlteracao:=AValue;
end;

procedure TCartao.SetAproximacao(AValue: Boolean);
begin
  FAproximacao := AValue;
end;

procedure TCartao.SetBandeira(AValue: TBandeira);
begin
  FBandeira:=AValue;
end;

procedure TCartao.SetCadastro(AValue: TDateTime);
begin
  FCadastro := AValue;
end;

procedure TCartao.SetContaBancaria(AValue: TContaBancaria);
begin
  FContaBancaria:=AValue;
end;

procedure TCartao.SetDonoCadastro(AValue: TParticipante);
begin
  FDonoCadastro:=AValue;
end;

procedure TCartao.SetExcluido(AValue: Boolean);
begin
  FExcluido := AValue;
end;

procedure TCartao.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Id" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TCartao.SetNumero(AValue: String);
begin
  FNumero := AValue;
end;

procedure TCartao.SetTipo(AValue: String);
begin
  FTipo := AValue;
end;

procedure TCartao.SetUsuarioCadastro(AValue: TUsuario);
begin
  FUsuarioCadastro:=AValue;
end;

procedure TCartao.SetValidade(AValue: TDate);
begin
  FValidade := AValue;
end;

constructor TCartao.Create;
begin
  FBandeira        := TBandeira.Create;
  FContaBancaria   := TContaBancaria.Create;
  FUsuarioCadastro := TUsuario.Create;
end;

destructor TCartao.Destroy;
begin
  FBandeira.Free;
  FContaBancaria.Free;
  FUsuarioCadastro.Free;
  inherited Destroy;
end;

end.

