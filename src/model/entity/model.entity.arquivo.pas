{
*******************************************************************************
*   VRBDespesas                                                               *
*   Controle e gerenciamento de despesas.                                     *
*                                                                             *
*   Copyright (C) 2025 Vinícius Ruan Brandalize.                              *
*                                                                             *
*   This program is free software: you can redistribute it and/or modify      *
*   it under the terms of the GNU General Public License as published by      *
*   the Free Software Foundation, either version 3 of the License, or         *
*   (at your option) any later version.                                       *
*                                                                             *
*   This program is distributed in the hope that it will be useful,           *
*   but WITHOUT ANY WARRANTY; without even the implied warranty of            *
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             *
*   GNU General Public License for more details.                              *
*                                                                             *
*   You should have received a copy of the GNU General Public License         *
*   along with this program.  If not, see <https://www.gnu.org/licenses/>.    *
*                                                                             *
*   Contact: viniciusbrandalize2@gmail.com.                                   *
*                                                                             *
*******************************************************************************
}

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
    FBinario: TStringStream;
    FDataHoraUpload: TDateTime;
    FIdDespesa: Integer;
    function GetBinario: TStringStream;
    function GetDataHoraUpload: TDateTime;
    function GetExtensao: String;
    function GetId: Integer;
    function GetIdDespesa: Integer;
    function GetNome: String;
    procedure SetBinario(AValue: TStringStream);
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
    property Binario: TStringStream read GetBinario write SetBinario;
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

function TArquivo.GetBinario: TStringStream;
begin
  Result := FBinario;
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

procedure TArquivo.SetBinario(AValue: TStringStream);
begin
  if AValue = nil then
    raise Exception.Create('O campo "Arquivo" precisa ser preenchido!')
  else
    FBinario := AValue;
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
  FBinario := TStringStream.Create;
end;

destructor TArquivo.Destroy;
begin
  FBinario.Free;
  inherited Destroy;
end;

end.

