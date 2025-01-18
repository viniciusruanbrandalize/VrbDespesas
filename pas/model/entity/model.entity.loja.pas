unit model.entity.loja;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TLoja }

  TLoja = class
  private
    FId:   Integer;
    FNome: String;
    FRua: String;
    FNumero: Integer;
    FBairro: String;
    FCidade: String;
    FEstado: String;
    FPais: String;
    FCnpj: String;
    FTelefone: String;
    FCelular: String;
    FEmail: String;
    FObservacao: String;
    function GetBairro: String;
    function GetCelular: String;
    function GetCidade: String;
    function GetCnpj: String;
    function GetEmail: String;
    function GetEstado: String;
    function GetId: Integer;
    function GetNome: String;
    function GetNumero: Integer;
    function GetObservacao: String;
    function GetPais: String;
    function GetRua: String;
    function GetTelefone: String;
    procedure SetBairro(AValue: String);
    procedure SetCelular(AValue: String);
    procedure SetCidade(AValue: String);
    procedure SetCnpj(AValue: String);
    procedure SetEmail(AValue: String);
    procedure SetEstado(AValue: String);
    procedure SetId(AValue: Integer);
    procedure SetNome(AValue: String);
    procedure SetNumero(AValue: Integer);
    procedure SetObservacao(AValue: String);
    procedure SetPais(AValue: String);
    procedure SetRua(AValue: String);
    procedure SetTelefone(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Nome: String read GetNome write SetNome;
    property Rua: String read GetRua write SetRua;
    property Numero: Integer read GetNumero write SetNumero;
    property Bairro: String read GetBairro write SetBairro;
    property Cidade: String read GetCidade write SetCidade;
    property Estado: String read GetEstado write SetEstado;
    property Pais: String read GetPais write SetPais;
    property CNPJ: String read GetCnpj write SetCnpj;
    property Telefone: String read GetTelefone write SetTelefone;
    property Celular: String read GetCelular write SetCelular;
    property Email: String read GetEmail write SetEmail;
    property Observacap: String read GetObservacao write SetObservacao;
  end;

implementation

{ TLoja }

function TLoja.GetId: Integer;
begin
  Result := FId;
end;

function TLoja.GetBairro: String;
begin
  Result := FBairro;
end;

function TLoja.GetCelular: String;
begin
  Result := FCelular;
end;

function TLoja.GetCidade: String;
begin
  Result := FCidade;
end;

function TLoja.GetCnpj: String;
begin
  Result := FCnpj;
end;

function TLoja.GetEmail: String;
begin
  Result := FEmail;
end;

function TLoja.GetEstado: String;
begin
  Result := FEstado;
end;

function TLoja.GetNome: String;
begin
  Result := FNome;
end;

function TLoja.GetNumero: Integer;
begin
  Result := FNumero;
end;

function TLoja.GetObservacao: String;
begin
  Result := FObservacao;
end;

function TLoja.GetPais: String;
begin
  Result := FPais;
end;

function TLoja.GetRua: String;
begin
  Result := FRua;
end;

function TLoja.GetTelefone: String;
begin
  Result := FTelefone;
end;

procedure TLoja.SetBairro(AValue: String);
begin
  FBairro := AValue;
end;

procedure TLoja.SetCelular(AValue: String);
begin
  FCelular := AValue;
end;

procedure TLoja.SetCidade(AValue: String);
begin
  FCidade := AValue;
end;

procedure TLoja.SetCnpj(AValue: String);
begin
  FCnpj := AValue;
end;

procedure TLoja.SetEmail(AValue: String);
begin
  FEmail := AValue;
end;

procedure TLoja.SetEstado(AValue: String);
begin
  FEstado := AValue;
end;

procedure TLoja.SetId(AValue: Integer);
begin
  FId := AValue;
end;

procedure TLoja.SetNome(AValue: String);
begin
  FNome := AValue;
end;

procedure TLoja.SetNumero(AValue: Integer);
begin
  FNumero := AValue;
end;

procedure TLoja.SetObservacao(AValue: String);
begin
  FObservacao := AValue;
end;

procedure TLoja.SetPais(AValue: String);
begin
  FPais := AValue;
end;

procedure TLoja.SetRua(AValue: String);
begin
  FRua := AValue;
end;

procedure TLoja.SetTelefone(AValue: String);
begin
  FTelefone := AValue;
end;

constructor TLoja.Create;
begin
  //
end;

destructor TLoja.Destroy;
begin
  inherited Destroy;
end;

end.

