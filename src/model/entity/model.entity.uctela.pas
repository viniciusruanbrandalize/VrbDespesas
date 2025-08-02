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

unit model.entity.uctela;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TUcTela }

  TUcTela = class
  private
    FNome: String;
    FTitulo: String;
    function GetNome: String;
    function GetTitulo: String;
    procedure SetNome(AValue: String);
    procedure SetTitulo(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Nome: String read GetNome write SetNome;
    property Titulo: String read GetTitulo write SetTitulo;
  end;

implementation

{ TUcTela }

function TUcTela.GetNome: String;
begin
  Result := FNome;
end;

function TUcTela.GetTitulo: String;
begin
  Result := FTitulo;
end;

procedure TUcTela.SetNome(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Nome" precisa ser preenchido!')
  else
    FNome := AValue;
end;

procedure TUcTela.SetTitulo(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Titulo" precisa ser preenchido!')
  else
    FTitulo := AValue;
end;

constructor TUcTela.Create;
begin
  //
end;

destructor TUcTela.Destroy;
begin
  inherited Destroy;
end;

end.

