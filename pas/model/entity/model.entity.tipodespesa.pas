unit model.entity.tipodespesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TTipoDespesa }

  TTipoDespesa = class
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

{ TTipoDespesa }

function TTipoDespesa.GetId: Integer;
begin
  Result := FId;
end;

function TTipoDespesa.GetNome: String;
begin
  Result := FNome;
end;

procedure TTipoDespesa.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Id" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TTipoDespesa.SetNome(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Nome" precisa ser preenchido!')
  else
    FNome := AValue;
end;

constructor TTipoDespesa.Create;
begin
  //
end;

destructor TTipoDespesa.Destroy;
begin
  inherited Destroy;
end;

end.

