unit model.entity.formapagamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TFormaPagamento }

  TFormaPagamento = class
  private
    FId:   Integer;
    FNome: String;
    FSigla: String;
    function GetId: Integer;
    function GetNome: String;
    function GetSigla: String;
    procedure SetId(AValue: Integer);
    procedure SetNome(AValue: String);
    procedure SetSigla(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Nome: String read GetNome write SetNome;
    property Sigla: String read GetSigla write SetSigla;
  end;

implementation

{ TFormaPagamento }

function TFormaPagamento.GetId: Integer;
begin
  Result := FId;
end;

function TFormaPagamento.GetNome: String;
begin
  Result := FNome;
end;

function TFormaPagamento.GetSigla: String;
begin
  Result := FSigla;
end;

procedure TFormaPagamento.SetId(AValue: Integer);
begin
  FId := AValue;
end;

procedure TFormaPagamento.SetNome(AValue: String);
begin
  FNome := AValue;
end;

procedure TFormaPagamento.SetSigla(AValue: String);
begin
  FSigla := AValue;
end;

constructor TFormaPagamento.Create;
begin
  //
end;

destructor TFormaPagamento.Destroy;
begin
  inherited Destroy;
end;

end.

