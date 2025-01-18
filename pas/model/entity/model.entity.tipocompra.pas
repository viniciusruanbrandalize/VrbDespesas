unit model.entity.tipocompra;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TTipoCompra }

  TTipoCompra = class
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

{ TTipoCompra }

function TTipoCompra.GetId: Integer;
begin
  Result := FId;
end;

function TTipoCompra.GetNome: String;
begin
  Result := FNome;
end;

procedure TTipoCompra.SetId(AValue: Integer);
begin
  FId := AValue;
end;

procedure TTipoCompra.SetNome(AValue: String);
begin
  FNome := AValue;
end;

constructor TTipoCompra.Create;
begin
  //
end;

destructor TTipoCompra.Destroy;
begin
  inherited Destroy;
end;

end.

