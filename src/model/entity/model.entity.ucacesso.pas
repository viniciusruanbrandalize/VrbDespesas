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

unit model.entity.ucacesso;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.entity.ucacao, model.entity.usuario;

type

  { TUcAcesso }

  TUcAcesso = class
  private
    FId: Integer;
    FUcAcao: TUcAcao;
    FUsuario: TUsuario;
    function GetId: Integer;
    function GetUcAcao: TUcAcao;
    function GetUsuario: TUsuario;
    procedure SetId(AValue: Integer);
    procedure SetUcAcao(AValue: TUcAcao);
    procedure SetUsuario(AValue: TUsuario);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property UcAcao: TUcAcao read GetUcAcao write SetUcAcao;
    property Usuario: TUsuario read GetUsuario write SetUsuario;
  end;

implementation

{ TUcAcesso }

function TUcAcesso.GetId: Integer;
begin
  Result := FId;
end;

function TUcAcesso.GetUcAcao: TUcAcao;
begin
  Result := FUcAcao;
end;

function TUcAcesso.GetUsuario: TUsuario;
begin
  Result := FUsuario;
end;

procedure TUcAcesso.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "ID" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TUcAcesso.SetUcAcao(AValue: TUcAcao);
begin
  if AValue = nil then
    raise Exception.Create('O campo "UcAcao" precisa ser preenchido!')
  else
    FUcAcao := AValue;
end;

procedure TUcAcesso.SetUsuario(AValue: TUsuario);
begin
  if AValue = nil then
    raise Exception.Create('O campo "Usuário" precisa ser preenchido!')
  else
    FUsuario := AValue;
end;

constructor TUcAcesso.Create;
begin
  FUcAcao  := TUcAcao.Create;
  FUsuario := TUsuario.Create;
end;

destructor TUcAcesso.Destroy;
begin
  FreeAndNil(FUcAcao);
  FreeAndNil(FUsuario);
  inherited Destroy;
end;

end.

