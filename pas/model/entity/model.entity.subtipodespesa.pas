unit model.entity.subtipodespesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.entity.tipodespesa;

type

  { TSubtipoDespesa }

  TSubtipoDespesa = class
  private
    FId:   Integer;
    FNome: String;
    FTipoDespesa: TTipoDespesa;
    function GetId: Integer;
    function GetNome: String;
    function GetTipoDespesa: TTipoDespesa;
    procedure SetId(AValue: Integer);
    procedure SetNome(AValue: String);
    procedure SetTipoDespesa(AValue: TTipoDespesa);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Nome: String read GetNome write SetNome;
    property TipoDespesa: TTipoDespesa read GetTipoDespesa write SetTipoDespesa;
  end;

implementation

{ TSubtipoDespesa }

function TSubtipoDespesa.GetId: Integer;
begin
  Result := FId;
end;

function TSubtipoDespesa.GetNome: String;
begin
  Result := FNome;
end;

function TSubtipoDespesa.GetTipoDespesa: TTipoDespesa;
begin
  Result := FTipoDespesa;
end;

procedure TSubtipoDespesa.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Id" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TSubtipoDespesa.SetNome(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Nome" precisa ser preenchido!')
  else
    FNome := AValue;
end;

procedure TSubtipoDespesa.SetTipoDespesa(AValue: TTipoDespesa);
begin
  if AValue = nil then
    raise Exception.Create('O campo "Tipo de despesa" precisa ser preenchido!')
  else
    FTipoDespesa := AValue;
end;

constructor TSubtipoDespesa.Create;
begin
  FTipoDespesa := TTipoDespesa.Create;
end;

destructor TSubtipoDespesa.Destroy;
begin
  FTipoDespesa.Free;
  inherited Destroy;
end;

end.

