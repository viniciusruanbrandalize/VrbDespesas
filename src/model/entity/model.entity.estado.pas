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

unit model.entity.estado;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.entity.pais;

type

  { TEstado }

  TEstado = class
  private
    FUF:   String;
    FNome: String;
    FIBGE: Integer;
    FPais: TPais;
    function GetIBGE: Integer;
    function GetPais: TPais;
    function GetUF: String;
    function GetNome: String;
    procedure SetIBGE(AValue: Integer);
    procedure SetNome(AValue: String);
    procedure SetPais(AValue: TPais);
    procedure SetUF(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property UF: String read GetUF write SetUF;
    property Nome: String read GetNome write SetNome;
    property IBGE: Integer read GetIBGE write SetIBGE;
    property Pais: TPais read GetPais write SetPais;
  end;

implementation

{ TEstado }

function TEstado.GetUF: String;
begin
  Result := FUF;
end;

function TEstado.GetIBGE: Integer;
begin
  Result := FIBGE;
end;

function TEstado.GetPais: TPais;
begin
  Result := FPais;
end;

function TEstado.GetNome: String;
begin
  Result := FNome;
end;

procedure TEstado.SetIBGE(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "IBGE" precisa ser preenchido!')
  else
    FIBGE := AValue;
end;

procedure TEstado.SetUF(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "UF" precisa ser preenchido!')
  else
    FUF := AValue;
end;

procedure TEstado.SetNome(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Nome" precisa ser preenchido!')
  else
    FNome := AValue;
end;

procedure TEstado.SetPais(AValue: TPais);
begin
  if AValue = nil then
    raise Exception.Create('O campo "Pais" precisa ser preenchido!')
  else
    FPais := AValue;
end;

constructor TEstado.Create;
begin
  FPais := TPais.Create;
end;

destructor TEstado.Destroy;
begin
  FreeAndNil(FPais);
  inherited Destroy;
end;

end.

