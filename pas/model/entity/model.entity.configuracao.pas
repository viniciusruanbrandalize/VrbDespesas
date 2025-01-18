unit model.entity.configuracao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TConfiguracao }

  TConfiguracao = class
  private
    FId:   Integer;
    FAparencia: String;
    function GetId: Integer;
    function GetAparencia: String;
    procedure SetId(AValue: Integer);
    procedure SetAparencia(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Aparencia: String read GetAparencia write SetAparencia;
  end;

implementation

{ TConfiguracao }

function TConfiguracao.GetId: Integer;
begin
  Result := FId;
end;

function TConfiguracao.GetAparencia: String;
begin
  Result := FAparencia;
end;

procedure TConfiguracao.SetId(AValue: Integer);
begin
  FId := AValue;
end;

procedure TConfiguracao.SetAparencia(AValue: String);
begin
  FAparencia := AValue;
end;

constructor TConfiguracao.Create;
begin
  //
end;

destructor TConfiguracao.Destroy;
begin
  inherited Destroy;
end;

end.

