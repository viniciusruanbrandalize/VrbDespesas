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

unit model.entity.pais;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TPais }

  TPais = class
  private
    FId:   Integer;
    FNome: String;
    FSiscomex: String;
    FSped: String;
    function GetId: Integer;
    function GetNome: String;
    function GetSiscomex: String;
    function GetSped: String;
    procedure SetId(AValue: Integer);
    procedure SetNome(AValue: String);
    procedure SetSiscomex(AValue: String);
    procedure SetSped(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Nome: String read GetNome write SetNome;
    property Siscomex: String read GetSiscomex write SetSiscomex;
    property Sped: String read GetSped write SetSped;
  end;

implementation

{ TPais }

function TPais.GetId: Integer;
begin
  Result := FId;
end;

function TPais.GetNome: String;
begin
  Result := FNome;
end;

function TPais.GetSiscomex: String;
begin
  Result := FSiscomex;
end;

function TPais.GetSped: String;
begin
  Result := FSped;
end;

procedure TPais.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Id" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TPais.SetNome(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Nome" precisa ser preenchido!')
  else
    FNome := AValue;
end;

procedure TPais.SetSiscomex(AValue: String);
begin
  FSiscomex := AValue;
end;

procedure TPais.SetSped(AValue: String);
begin
  FSped := AValue;
end;

constructor TPais.Create;
begin
  //
end;

destructor TPais.Destroy;
begin
  inherited Destroy;
end;

end.

