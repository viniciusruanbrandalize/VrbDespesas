unit lib.cep;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, view.mensagem, vrbViaCep;

type

  { TLibCep }

  TLibCep = class
  private
    FVrbViaCep: TVrbViaCep;
    function GetEndereco: TListaVrbEndereco;
  public
    function BuscarPorCep(CEP: String; out Erro: String): Boolean;
    function BuscarPorLogradouro(Logradouro, Cidade, UF: String; out Erro: String): Boolean;
    constructor Create;
    destructor Destroy; override;
    property Endereco: TListaVrbEndereco read GetEndereco;
  end;

implementation

{ TLibCep }

function TLibCep.GetEndereco: TListaVrbEndereco;
begin
  Result := FVrbViaCep.Endereco;
end;

function TLibCep.BuscarPorCep(CEP: String; out Erro: String): Boolean;
begin
  FVrbViaCep.TipoBusca := bCep;
  FVrbViaCep.CEP := CEP;
  Result := FVrbViaCep.Buscar;
  Erro := FVrbViaCep.Erro;
end;

function TLibCep.BuscarPorLogradouro(Logradouro, Cidade, UF: String; out Erro: String): Boolean;
begin
  FVrbViaCep.TipoBusca := bLogradouro;
  FVrbViaCep.Logradouro := Logradouro;
  FVrbViaCep.Cidade     := Cidade;
  FVrbViaCep.UF         := UF;
  Result := FVrbViaCep.Buscar;
  Erro := FVrbViaCep.Erro;
end;

constructor TLibCep.Create;
begin
  FVrbViaCep := TVrbViaCep.Create(nil);
end;

destructor TLibCep.Destroy;
begin
  FreeAndNil(FVrbViaCep);
  Inherited Destroy;
end;

end.

