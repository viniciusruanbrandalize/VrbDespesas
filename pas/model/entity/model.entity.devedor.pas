unit model.entity.devedor;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TDevedor }

  TDevedor = class
  private
    FId:   Integer;
    FNome: String;
    FIdade: Integer;
    FDataNascimento: TDate;
    FRua: String;
    FNumero: Integer;
    FBairro: String;
    FCidade: String;
    FEstado: String;
    FPais: String;
    FCpf: String;
    FTelefone: String;
    FCelular: String;
    FEmail: String;
    function GetBairro: String;
    function GetCelular: String;
    function GetCidade: String;
    function GetCpf: String;
    function GetDataNascimento: TDate;
    function GetEmail: String;
    function GetEstado: String;
    function GetId: Integer;
    function GetIdade: Integer;
    function GetNome: String;
    function GetNumero: Integer;
    function GetPais: String;
    function GetRua: String;
    function GetTelefone: String;
    procedure SetBairro(AValue: String);
    procedure SetCelular(AValue: String);
    procedure SetCidade(AValue: String);
    procedure SetCpf(AValue: String);
    procedure SetDataNascimento(AValue: TDate);
    procedure SetEmail(AValue: String);
    procedure SetEstado(AValue: String);
    procedure SetId(AValue: Integer);
    procedure SetIdade(AValue: Integer);
    procedure SetNome(AValue: String);
    procedure SetNumero(AValue: Integer);
    procedure SetPais(AValue: String);
    procedure SetRua(AValue: String);
    procedure SetTelefone(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Nome: String read GetNome write SetNome;
    property Idade: Integer read GetIdade write SetIdade;
    property DataNascimento: TDate read GetDataNascimento write SetDataNascimento;
    property Rua: String read GetRua write SetRua;
    property Numero: Integer read GetNumero write SetNumero;
    property Bairro: String read GetBairro write SetBairro;
    property Cidade: String read GetCidade write SetCidade;
    property Estado: String read GetEstado write SetEstado;
    property Pais: String read GetPais write SetPais;
    property CPF: String read GetCpf write SetCpf;
    property Telefone: String read GetTelefone write SetTelefone;
    property Celular: String read GetCelular write SetCelular;
    property Email: String read GetEmail write SetEmail;
  end;

implementation

{ TDevedor }

function TDevedor.GetId: Integer;
begin
  Result := FId;
end;

function TDevedor.GetIdade: Integer;
begin
  Result := FIdade;
end;

function TDevedor.GetBairro: String;
begin
  Result := FBairro;
end;

function TDevedor.GetCelular: String;
begin
  Result := FCelular;
end;

function TDevedor.GetCidade: String;
begin
  Result := FCidade;
end;

function TDevedor.GetCpf: String;
begin
  Result := FCpf;
end;

function TDevedor.GetDataNascimento: TDate;
begin
  Result := FDataNascimento;
end;

function TDevedor.GetEmail: String;
begin
  Result := FEmail;
end;

function TDevedor.GetEstado: String;
begin
  Result := FEstado;
end;

function TDevedor.GetNome: String;
begin
  Result := FNome;
end;

function TDevedor.GetNumero: Integer;
begin
  Result := FNumero;
end;

function TDevedor.GetPais: String;
begin
  Result := FPais;
end;

function TDevedor.GetRua: String;
begin
  Result := FRua;
end;

function TDevedor.GetTelefone: String;
begin
  Result := FTelefone;
end;

procedure TDevedor.SetBairro(AValue: String);
begin
  FBairro := AValue;
end;

procedure TDevedor.SetCelular(AValue: String);
begin
  FCelular := AValue;
end;

procedure TDevedor.SetCidade(AValue: String);
begin
  FCidade := AValue;
end;

procedure TDevedor.SetCpf(AValue: String);
begin
  FCpf := AValue;
end;

procedure TDevedor.SetDataNascimento(AValue: TDate);
begin
  FDataNascimento := AValue;
end;

procedure TDevedor.SetEmail(AValue: String);
begin
  FEmail := AValue;
end;

procedure TDevedor.SetEstado(AValue: String);
begin
  FEstado := AValue;
end;

procedure TDevedor.SetId(AValue: Integer);
begin
  FId := AValue;
end;

procedure TDevedor.SetIdade(AValue: Integer);
begin
  FIdade := AValue;
end;

procedure TDevedor.SetNome(AValue: String);
begin
  FNome := AValue;
end;

procedure TDevedor.SetNumero(AValue: Integer);
begin
  FNumero := AValue;
end;

procedure TDevedor.SetPais(AValue: String);
begin
  FPais := AValue;
end;

procedure TDevedor.SetRua(AValue: String);
begin
  FRua := AValue;
end;

procedure TDevedor.SetTelefone(AValue: String);
begin
  FTelefone := AValue;
end;

constructor TDevedor.Create;
begin
  //
end;

destructor TDevedor.Destroy;
begin
  inherited Destroy;
end;

end.

