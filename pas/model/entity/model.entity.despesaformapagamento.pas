unit model.entity.despesaformapagamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.entity.despesa, model.entity.contabancaria,
  model.entity.pix, model.entity.formapagamento;  //falta cartao

type

  { TDespesaFormaPagamento }

  TDespesaFormaPagamento = class
  private
    FId:   Integer;
    FNome: String;
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

{ TDespesaFormaPagamento }

function TDespesaFormaPagamento.GetId: Integer;
begin
  Result := FId;
end;

function TDespesaFormaPagamento.GetNome: String;
begin
  Result := FNome;
end;

procedure TDespesaFormaPagamento.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Id" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TDespesaFormaPagamento.SetNome(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Nome" precisa ser preenchido!')
  else
    FNome := AValue;
end;

constructor TDespesaFormaPagamento.Create;
begin
  //
end;

destructor TDespesaFormaPagamento.Destroy;
begin
  inherited Destroy;
end;

end.

