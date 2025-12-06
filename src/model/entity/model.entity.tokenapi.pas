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

unit model.entity.tokenapi;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TTokenApi }

  TTokenApi = class
  private
    FId:   Integer;
    FToken: String;
    FGeracao: TDateTime;
    FValidade: TDateTime;
    FExcluido: Boolean;
    function GetId: Integer;
    function GetToken: String;
    function GetGeracao: TDateTime;
    function GetValidade: TDateTime;
    function GetExcluido: Boolean;
    procedure SetId(AValue: Integer);
    procedure SetToken(AValue: String);
    procedure SetGeracao(AValue: TDateTime);
    procedure SetValidade(AValue: TDateTime);
    procedure SetExcluido(AValue: Boolean);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Token: String read GetToken write SetToken;
    property Geracao: TDateTime read GetGeracao write SetGeracao;
    property Validade: TDateTime read GetValidade write SetValidade;
    property Excluido: Boolean read GetExcluido write SetExcluido;
  end;

implementation

{ TTokenApi }

function TTokenApi.GetId: Integer;
begin
  Result := FId;
end;

function TTokenApi.GetToken: String;
begin
  Result := FNome;
end;

function TTokenApi.GetGeracao: TDateTime;
begin
  Result := FGeracao;
end;

function TTokenApi.GetValidade: TDateTime;
begin
  Result := FValidade;
end;

function TTokenApi.GetExcluido: Boolean;
begin
  Result := FExcluido;
end;

procedure TTokenApi.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Id" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TTokenApi.SetToken(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Token" precisa ser preenchido!')
  else
    FNome := AValue;
end;

procedure TTokenApi.SetGeracao(AValue: TDateTime);
begin
  FGeracao := AValue;
end;

procedure TTokenApi.SetValidade(AValue: TDateTime);
begin
  FValidade := AValue;
end;

procedure TTokenApi.SetExcluido(AValue: Boolean);
begin
  FExcluido := AValue;
end;

constructor TTokenApi.Create;
begin
  //
end;

destructor TTokenApi.Destroy;
begin
  inherited Destroy;
end;

end.

