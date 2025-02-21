unit model.entity.arquivo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Generics.Collections;

type

  { TArquivo }

  TArquivo = class
  private
    FId:   Integer;
    FNome: String;
    FExtensao: String;
    FBase64: TStream;
    FDataHoraUpload: TDateTime;
    FIdDespesa: Integer;
    function GetBase64: TStream;
    function GetDataHoraUpload: TDateTime;
    function GetExtensao: String;
    function GetId: Integer;
    function GetIdDespesa: Integer;
    function GetNome: String;
    procedure SetBase64(AValue: TStream);
    procedure SetDataHoraUpload(AValue: TDateTime);
    procedure SetExtensao(AValue: String);
    procedure SetId(AValue: Integer);
    procedure SetIdDespesa(AValue: Integer);
    procedure SetNome(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Nome: String read GetNome write SetNome;
    property Extensao: String read GetExtensao write SetExtensao;
    property Base64: TStream read GetBase64 write SetBase64;
    property DataHoraUpload: TDateTime read GetDataHoraUpload write SetDataHoraUpload;
    property IdDespesa: Integer read GetIdDespesa write SetIdDespesa;
  end;

type
  TArquivoLista = specialize TObjectList<TArquivo>;

implementation

{ TArquivo }

function TArquivo.GetId: Integer;
begin
  Result := FId;
end;

function TArquivo.GetDataHoraUpload: TDateTime;
begin
  Result := FDataHoraUpload;
end;

function TArquivo.GetBase64: TStream;
begin
  Result := FBase64;
end;

function TArquivo.GetExtensao: String;
begin
  Result := FExtensao;
end;

function TArquivo.GetIdDespesa: Integer;
begin
  Result := FIdDespesa;
end;

function TArquivo.GetNome: String;
begin
  Result := FNome;
end;

procedure TArquivo.SetBase64(AValue: TStream);
begin
  if AValue = nil then
    raise Exception.Create('O campo "Arquivo" precisa ser preenchido!')
  else
    FBase64 := AValue;
end;

procedure TArquivo.SetDataHoraUpload(AValue: TDateTime);
begin
  FDataHoraUpload := AValue;
end;

procedure TArquivo.SetExtensao(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Extensão" precisa ser preenchido!')
  else
    FExtensao := AValue;
end;

procedure TArquivo.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Id" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TArquivo.SetIdDespesa(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Id Despesa" precisa ser preenchido!')
  else
    FIdDespesa := AValue;
end;

procedure TArquivo.SetNome(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Nome" precisa ser preenchido!')
  else
    FNome := AValue;
end;

constructor TArquivo.Create;
begin
  //
end;

destructor TArquivo.Destroy;
begin
  inherited Destroy;
end;

end.

