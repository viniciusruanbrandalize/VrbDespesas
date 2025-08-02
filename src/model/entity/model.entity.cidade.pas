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

unit model.entity.cidade;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.entity.estado;

type

  { TCidade }

  TCidade = class
  private
    FId:   Integer;
    FNome: String;
    FIBGE: Integer;
    FEstado: TEstado;
    function GetEstado: TEstado;
    function GetIBGE: Integer;
    function GetId: Integer;
    function GetNome: String;
    procedure SetEstado(AValue: TEstado);
    procedure SetIBGE(AValue: Integer);
    procedure SetId(AValue: Integer);
    procedure SetNome(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Nome: String read GetNome write SetNome;
    property IBGE: Integer read GetIBGE write SetIBGE;
    property Estado: TEstado read GetEstado write SetEstado;
  end;

implementation

{ TCidade }

function TCidade.GetId: Integer;
begin
  Result := FId;
end;

function TCidade.GetEstado: TEstado;
begin
  Result := FEstado;
end;

function TCidade.GetIBGE: Integer;
begin
  Result := FIBGE;
end;

function TCidade.GetNome: String;
begin
  Result := FNome;
end;

procedure TCidade.SetEstado(AValue: TEstado);
begin
  if AValue = nil then
    raise Exception.Create('O campo "UF" precisa ser preenchido!')
  else
    FEstado := AValue;
end;

procedure TCidade.SetIBGE(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "IBGE" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TCidade.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Id" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TCidade.SetNome(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Nome" precisa ser preenchido!')
  else
    FNome := AValue;
end;

constructor TCidade.Create;
begin
  FEstado := TEstado.Create;
end;

destructor TCidade.Destroy;
begin
  FreeAndNil(FEstado);
  inherited Destroy;
end;

end.

