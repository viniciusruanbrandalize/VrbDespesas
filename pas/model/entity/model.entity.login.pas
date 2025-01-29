unit model.entity.login;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.entity.usuario;

type

  { TLogin }

  TLogin = class
  private
    FId:   Integer;
    FNomePC: String;
    FIPPC: String;
    FData: TDate;
    FHora: TTime;
    FUsuario: TUsuario;
    function GetData: TDate;
    function GetHora: TTime;
    function GetId: Integer;
    function GetIPPC: String;
    function GetNomePC: String;
    function GetUsuario: TUsuario;
    procedure SetData(AValue: TDate);
    procedure SetHora(AValue: TTime);
    procedure SetId(AValue: Integer);
    procedure SetIPPC(AValue: String);
    procedure SetNomePC(AValue: String);
    procedure SetUsuario(AValue: TUsuario);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property NomePC: String read GetNomePC write SetNomePC;
    property IPPC: String read GetIPPC write SetIPPC;
    property Data: TDate read GetData write SetData;
    property Hora: TTime read GetHora write SetHora;
    property Usuario: TUsuario read GetUsuario write SetUsuario;
  end;

implementation

{ TLogin }

function TLogin.GetId: Integer;
begin
  Result := FId;
end;

function TLogin.GetData: TDate;
begin
  Result := FData;
end;

function TLogin.GetHora: TTime;
begin
  Result := FHora;
end;

function TLogin.GetIPPC: String;
begin
  Result := FIPPC;
end;

function TLogin.GetNomePC: String;
begin
  Result := FNomePC;
end;

function TLogin.GetUsuario: TUsuario;
begin
  Result := FUsuario;
end;

procedure TLogin.SetData(AValue: TDate);
begin
  FData := AValue;
end;

procedure TLogin.SetHora(AValue: TTime);
begin
  FHora := AValue;
end;

procedure TLogin.SetId(AValue: Integer);
begin
  FId := AValue;
end;

procedure TLogin.SetIPPC(AValue: String);
begin
  FIPPC := AValue;
end;

procedure TLogin.SetNomePC(AValue: String);
begin
  FNomePC := AValue;
end;

procedure TLogin.SetUsuario(AValue: TUsuario);
begin
  FUsuario := AValue;
end;

constructor TLogin.Create;
begin
  //
end;

destructor TLogin.Destroy;
begin
  inherited Destroy;
end;

end.

