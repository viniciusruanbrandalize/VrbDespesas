unit model.entity.fornecedor;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.entity.participante, model.entity.cidade,
  model.entity.usuario;

type

  { TFornecedor }

  TFornecedor = class(TInterfacedObject, IParticipante)
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
    FParticipante: IParticipante;

    function GetId: Integer;
    function GetNome: String;
    procedure SetId(AValue: Integer);
    procedure SetNome(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Nome: String read GetNome write SetNome;
  end;

implementation

{ TFornecedor }

function TFornecedor.GetId: Integer;
begin
  Result := FId;
end;

function TFornecedor.GetNome: String;
begin
  Result := FNome;
end;

procedure TFornecedor.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Id" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TFornecedor.SetNome(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Nome" precisa ser preenchido!')
  else
    FNome := AValue;
end;

constructor TFornecedor.Create;
begin
  //
end;

destructor TFornecedor.Destroy;
begin
  inherited Destroy;
end;

end.

