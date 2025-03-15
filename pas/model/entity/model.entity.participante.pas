unit model.entity.participante;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.entity.cidade, model.entity.usuario;

type

  { TParticipante }

  TParticipante = class
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
    FExcluido: Boolean;
    FEhDonoCadastro: Boolean;
    FCidade: TCidade;
    FUsuarioCadastro: TUsuario;
    FDonoCadastro: TParticipante;
    function GetAlteracao: TDateTime;
    function GetBairro: String;
    function GetCadastro: TDateTime;
    function GetCelular: String;
    function GetCEP: String;
    function GetCidade: TCidade;
    function GetCNPJ: String;
    function GetComplemento: String;
    function GetDonoCadastro: TParticipante;
    function GetEhDonoCadastro: Boolean;
    function GetEmail: String;
    function GetExcluido: Boolean;
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
    procedure SetDonoCadastro(AValue: TParticipante);
    procedure SetEhDonoCadastro(AValue: Boolean);
    procedure SetEmail(AValue: String);
    procedure SetExcluido(AValue: Boolean);
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
    property EhDonoCadastro: Boolean read GetEhDonoCadastro write SetEhDonoCadastro;
    property Excluido: Boolean read GetExcluido write SetExcluido;
    property Cidade: TCidade read GetCidade write SetCidade;
    property UsuarioCadastro: TUsuario read GetUsuarioCadastro write SetUsuarioCadastro;
    property DonoCadastro: TParticipante read GetDonoCadastro write SetDonoCadastro;
  end;

implementation

{ TParticipante }

function TParticipante.GetId: Integer;
begin
  Result := FId;
end;

function TParticipante.GetAlteracao: TDateTime;
begin
  Result := FAlteracao;
end;

function TParticipante.GetBairro: String;
begin
  Result := FBairro;
end;

function TParticipante.GetCadastro: TDateTime;
begin
  Result := FCadastro;
end;

function TParticipante.GetCelular: String;
begin
  Result := FCelular;
end;

function TParticipante.GetCEP: String;
begin
  Result := FCEP;
end;

function TParticipante.GetCidade: TCidade;
begin
  Result := FCidade;
end;

function TParticipante.GetCNPJ: String;
begin
  Result := FCNPJ;
end;

function TParticipante.GetComplemento: String;
begin
  Result := FComplemento;
end;

function TParticipante.GetDonoCadastro: TParticipante;
begin
  Result := FDonoCadastro;
end;

function TParticipante.GetEhDonoCadastro: Boolean;
begin
  Result := FEhDonoCadastro;
end;

function TParticipante.GetEmail: String;
begin
  Result := FEmail;
end;

function TParticipante.GetExcluido: Boolean;
begin
  Result := FExcluido;
end;

function TParticipante.GetFantasia: String;
begin
  Result := FFantasia;
end;

function TParticipante.GetIE: Integer;
begin
  Result := FIE;
end;

function TParticipante.GetNome: String;
begin
  Result := FNome;
end;

function TParticipante.GetNumero: Integer;
begin
  Result := FNumero;
end;

function TParticipante.GetObs: String;
begin
  Result := FObs;
end;

function TParticipante.GetPessoa: String;
begin
  Result := FPessoa;
end;

function TParticipante.GetRua: String;
begin
  Result := FRua;
end;

function TParticipante.GetTelefone: String;
begin
  Result := FTelefone;
end;

function TParticipante.GetUsuarioCadastro: TUsuario;
begin
  Result := FUsuarioCadastro;
end;

procedure TParticipante.SetAlteracao(AValue: TDateTime);
begin
  FAlteracao := AValue;
end;

procedure TParticipante.SetBairro(AValue: String);
begin
  FBairro := AValue;
end;

procedure TParticipante.SetCadastro(AValue: TDateTime);
begin
  FCadastro := AValue;
end;

procedure TParticipante.SetCelular(AValue: String);
begin
  FCelular := AValue;
end;

procedure TParticipante.SetCEP(AValue: String);
begin
  FCEP := AValue;
end;

procedure TParticipante.SetCidade(AValue: TCidade);
begin
  FCidade := AValue;
end;

procedure TParticipante.SetCNPJ(AValue: String);
begin
  FCNPJ := AValue;
end;

procedure TParticipante.SetComplemento(AValue: String);
begin
  FComplemento := AValue;
end;

procedure TParticipante.SetDonoCadastro(AValue: TParticipante);
begin
  FDonoCadastro := AValue;
end;

procedure TParticipante.SetEhDonoCadastro(AValue: Boolean);
begin
  FEhDonoCadastro := AValue;
end;

procedure TParticipante.SetEmail(AValue: String);
begin
  FEmail := AValue;
end;

procedure TParticipante.SetExcluido(AValue: Boolean);
begin
  FExcluido := AValue;
end;

procedure TParticipante.SetFantasia(AValue: String);
begin
  FFantasia := AValue;
end;

procedure TParticipante.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Id" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TParticipante.SetIE(AValue: Integer);
begin
  FIE := AValue;
end;

procedure TParticipante.SetNome(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Nome" precisa ser preenchido!')
  else
    FNome := AValue;
end;

procedure TParticipante.SetNumero(AValue: Integer);
begin
  FNumero := AValue;
end;

procedure TParticipante.SetObs(AValue: String);
begin
  FObs := AValue;
end;

procedure TParticipante.SetPessoa(AValue: String);
begin
  FPessoa := AValue;
end;

procedure TParticipante.SetRua(AValue: String);
begin
  FRua := AValue;
end;

procedure TParticipante.SetTelefone(AValue: String);
begin
  FTelefone := AValue;
end;

procedure TParticipante.SetUsuarioCadastro(AValue: TUsuario);
begin
  FUsuarioCadastro := AValue;
end;

constructor TParticipante.Create;
begin
  FCidade := TCidade.Create;
  FUsuarioCadastro := TUsuario.Create;
  //FDonoCadastro := TParticipante.Create; //Nao criar leva a um loop
end;

destructor TParticipante.Destroy;
begin
  FreeAndNil(FCidade);
  FreeAndNil(FUsuarioCadastro);
  FreeAndNil(FDonoCadastro);
  inherited Destroy;
end;

end.

