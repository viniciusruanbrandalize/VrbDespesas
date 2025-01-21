unit model.entity.pagador;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.entity.participante, model.entity.cidade,
  model.entity.usuario;

type

  { TPagador }

  TPagador = class(TInterfacedObject, IParticipante)
  private
    FId: Integer;
    FPessoa: String;
    FNome: String;
    FFantasia: String;
    FCNPJ: String;
    FIE: Integer;
    FTelefone: String;
    FCelular: String;
    FEmail: String;
    FCEP: String;
    FRua: String;
    FNumero: Integer;
    FComplemento: String;
    FBairro: String;
    FObs: String;
    FCadastro: TDateTime;
    FAlteracao: TDateTime;
    FDonoCadastro: Boolean;
    FCidade: TCidade;
    FUsuarioCadastro: TUsuario;

    function GetAlteracao: TDateTime;
    function GetBairro: String;
    function GetCadastro: TDateTime;
    function GetCelular: String;
    function GetCEP: String;
    function GetCidade: TCidade;
    function GetCNPJ: String;
    function GetComplemento: String;
    function GetDonoCadastro: Boolean;
    function GetEmail: String;
    function GetFantasia: String;
    function GetId: Integer;
    function GetIE: Integer;
    function GetNome: String;
    function GetNumero: Integer;
    function GetObs: String;
    function GetPessoa: String;
    function GetRua: String;
    function GetTelefone: String;
    function GetUsuarioCadastro: TUsuario;
    procedure SetAlteracao(AValue: TDateTime);
    procedure SetBairro(AValue: String);
    procedure SetCadastro(AValue: TDateTime);
    procedure SetCelular(AValue: String);
    procedure SetCEP(AValue: String);
    procedure SetCidade(AValue: TCidade);
    procedure SetCNPJ(AValue: String);
    procedure SetComplemento(AValue: String);
    procedure SetDonoCadastro(AValue: Boolean);
    procedure SetEmail(AValue: String);
    procedure SetFantasia(AValue: String);
    procedure SetId(AValue: Integer);
    procedure SetIE(AValue: Integer);
    procedure SetNome(AValue: String);
    procedure SetNumero(AValue: Integer);
    procedure SetObs(AValue: String);
    procedure SetPessoa(AValue: String);
    procedure SetRua(AValue: String);
    procedure SetTelefone(AValue: String);
    procedure SetUsuarioCadastro(AValue: TUsuario);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Nome: String read GetNome write SetNome;
    property Pessoa: String read GetPessoa write SetPessoa;
    property Fantasia: String read GetFantasia write SetFantasia;
    property CNPJ: String read GetCNPJ write SetCNPJ;
    property IE: Integer read GetIE write SetIE;
    property Telefone: String read GetTelefone write SetTelefone;
    property Celular: String read GetCelular write SetCelular;
    property Email: String read GetEmail write SetEmail;
    property CEP: String read GetCEP write SetCEP;
    property Rua: String read GetRua write SetRua;
    property Numero: Integer read GetNumero write SetNumero;
    property Complemento: String read GetComplemento write SetComplemento;
    property Bairro: String read GetBairro write SetBairro;
    property Obs: String read GetObs write SetObs;
    property Cadastro: TDateTime read GetCadastro write SetCadastro;
    property Alteracao: TDateTime read GetAlteracao write SetAlteracao;
    property DonoCadastro: Boolean read GetDonoCadastro write SetDonoCadastro;
    property Cidade: TCidade read GetCidade write SetCidade;
    property UsuarioCadastro: TUsuario read GetUsuarioCadastro write SetUsuarioCadastro;
  end;

implementation

{ TPagador }

function TPagador.GetId: Integer;
begin
  Result := FId;
end;

function TPagador.GetAlteracao: TDateTime;
begin
  Result := FAlteracao;
end;

function TPagador.GetBairro: String;
begin
  Result := FBairro;
end;

function TPagador.GetCadastro: TDateTime;
begin
  Result := FCadastro;
end;

function TPagador.GetCelular: String;
begin
  Result := FCelular;
end;

function TPagador.GetCEP: String;
begin
  Result := FCEP;
end;

function TPagador.GetCidade: TCidade;
begin
  Result := FCidade;
end;

function TPagador.GetCNPJ: String;
begin
  Result := FCNPJ;
end;

function TPagador.GetComplemento: String;
begin
  Result := FComplemento;
end;

function TPagador.GetDonoCadastro: Boolean;
begin
  Result := FDonoCadastro;
end;

function TPagador.GetEmail: String;
begin
  Result := FEmail;
end;

function TPagador.GetFantasia: String;
begin
  Result := FFantasia;
end;

function TPagador.GetIE: Integer;
begin
  Result := FIE;
end;

function TPagador.GetNome: String;
begin
  Result := FNome;
end;

function TPagador.GetNumero: Integer;
begin
  Result := FNumero;
end;

function TPagador.GetObs: String;
begin
  Result := FObs;
end;

function TPagador.GetPessoa: String;
begin
  Result := FPessoa;
end;

function TPagador.GetRua: String;
begin
  Result := FRua;
end;

function TPagador.GetTelefone: String;
begin
  Result := FTelefone;
end;

function TPagador.GetUsuarioCadastro: TUsuario;
begin
  Result := FUsuarioCadastro;
end;

procedure TPagador.SetAlteracao(AValue: TDateTime);
begin
  FAlteracao := AValue;
end;

procedure TPagador.SetBairro(AValue: String);
begin
  FBairro := AValue;
end;

procedure TPagador.SetCadastro(AValue: TDateTime);
begin
  FCadastro := AValue;
end;

procedure TPagador.SetCelular(AValue: String);
begin
  FCelular := AValue;
end;

procedure TPagador.SetCEP(AValue: String);
begin
  FCEP := AValue;
end;

procedure TPagador.SetCidade(AValue: TCidade);
begin
  FCidade := AValue;
end;

procedure TPagador.SetCNPJ(AValue: String);
begin
  FCNPJ := AValue;
end;

procedure TPagador.SetComplemento(AValue: String);
begin
  FComplemento := AValue;
end;

procedure TPagador.SetDonoCadastro(AValue: Boolean);
begin
  FDonoCadastro := AValue;
end;

procedure TPagador.SetEmail(AValue: String);
begin
  FEmail := AValue;
end;

procedure TPagador.SetFantasia(AValue: String);
begin
  FFantasia := AValue;
end;

procedure TPagador.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Id" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TPagador.SetIE(AValue: Integer);
begin
  FIE := AValue;
end;

procedure TPagador.SetNome(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Nome" precisa ser preenchido!')
  else
    FNome := AValue;
end;

procedure TPagador.SetNumero(AValue: Integer);
begin
  FNumero := AValue;
end;

procedure TPagador.SetObs(AValue: String);
begin
  FObs := AValue;
end;

procedure TPagador.SetPessoa(AValue: String);
begin
  FPessoa := AValue;
end;

procedure TPagador.SetRua(AValue: String);
begin
  FRua := AValue;
end;

procedure TPagador.SetTelefone(AValue: String);
begin
  FTelefone := AValue;
end;

procedure TPagador.SetUsuarioCadastro(AValue: TUsuario);
begin
  FUsuarioCadastro := AValue;
end;

constructor TPagador.Create;
begin
  //
end;

destructor TPagador.Destroy;
begin
  inherited Destroy;
end;

end.

