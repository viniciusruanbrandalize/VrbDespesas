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

unit model.entity.banco;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TBanco }

  TBanco = class
  private
    FId:   Integer;
    FNome: String;
    FNumero: Integer;
    FExcluido: Boolean;
    function GetExcluido: Boolean;
    function GetId: Integer;
    function GetNome: String;
    function GetNumero: Integer;
    procedure SetExcluido(AValue: Boolean);
    procedure SetId(AValue: Integer);
    procedure SetNome(AValue: String);
    procedure SetNumero(AValue: Integer);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Nome: String read GetNome write SetNome;
    property Numero: Integer read GetNumero write SetNumero;
    property Excluido: Boolean read GetExcluido write SetExcluido;
  end;

implementation

{ TBanco }

function TBanco.GetId: Integer;
begin
  Result := FId;
end;

function TBanco.GetExcluido: Boolean;
begin
  Result := FExcluido;
end;

function TBanco.GetNome: String;
begin
  Result := FNome;
end;

function TBanco.GetNumero: Integer;
begin
  Result := FNumero;
end;

procedure TBanco.SetExcluido(AValue: Boolean);
begin
  FExcluido := AValue;
end;

procedure TBanco.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Id" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TBanco.SetNome(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Nome" precisa ser preenchido!')
  else
    FNome := AValue;
end;

procedure TBanco.SetNumero(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Número" precisa ser preenchido!')
  else
    FNumero := AValue;
end;

constructor TBanco.Create;
begin
  //
end;

destructor TBanco.Destroy;
begin
  inherited Destroy;
end;

end.

