unit model.entity.subtipocompra;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.tipocompra;

type

  { TSubtipoCompra }

  TSubtipoCompra = class
  private
    FId:   Integer;
    FNome: String;
    FTipoCompra: TTipoCompra;
    function GetId: Integer;
    function GetNome: String;
    function GetTipoCompra: TTipoCompra;
    procedure SetId(AValue: Integer);
    procedure SetNome(AValue: String);
    procedure SetTipoCompra(AValue: TTipoCompra);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Nome: String read GetNome write SetNome;
    property TipoCompra: TTipoCompra read GetTipoCompra write SetTipoCompra;
  end;

implementation

{ TSubtipoCompra }

function TSubtipoCompra.GetId: Integer;
begin
  Result := FId;
end;

function TSubtipoCompra.GetNome: String;
begin
  Result := FNome;
end;

function TSubtipoCompra.GetTipoCompra: TTipoCompra;
begin
  Result := FTipoCompra;
end;

procedure TSubtipoCompra.SetId(AValue: Integer);
begin
  FId := AValue;
end;

procedure TSubtipoCompra.SetNome(AValue: String);
begin
  FNome := AValue;
end;

procedure TSubtipoCompra.SetTipoCompra(AValue: TTipoCompra);
begin
  FTipoCompra := AValue;
end;

constructor TSubtipoCompra.Create;
begin
  //
end;

destructor TSubtipoCompra.Destroy;
begin
  inherited Destroy;
end;

end.

