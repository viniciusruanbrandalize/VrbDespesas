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

unit model.entity.usuariodonocadastro;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Generics.Collections, model.entity.usuario,
  model.entity.participante;

type

  { TUsuarioDonoCadastro }

  TUsuarioDonoCadastro = class
  private
    FCadastro: TDateTime;
    FDonoCadastro: TParticipante;
    FId:   Integer;
    FUsuario: TUsuario;
    function GetCadastro: TDateTime;
    function GetDonoCadastro: TParticipante;
    function GetId: Integer;
    function GetUsuario: TUsuario;
    procedure SetCadastro(AValue: TDateTime);
    procedure SetDonoCadastro(AValue: TParticipante);
    procedure SetId(AValue: Integer);
    procedure SetUsuario(AValue: TUsuario);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Usuario: TUsuario read GetUsuario write SetUsuario;
    property DonoCadastro: TParticipante read GetDonoCadastro write SetDonoCadastro;
    property Cadastro: TDateTime read GetCadastro write SetCadastro;
  end;

type
  TUsuarioDonoCadastroLista = specialize TObjectList<TUsuarioDonoCadastro>;

implementation

{ TUsuarioDonoCadastro }

function TUsuarioDonoCadastro.GetId: Integer;
begin
  Result := FId;
end;

function TUsuarioDonoCadastro.GetCadastro: TDateTime;
begin
  Result := FCadastro;
end;

function TUsuarioDonoCadastro.GetDonoCadastro: TParticipante;
begin
  Result := FDonoCadastro;
end;

function TUsuarioDonoCadastro.GetUsuario: TUsuario;
begin
  Result := FUsuario;
end;

procedure TUsuarioDonoCadastro.SetCadastro(AValue: TDateTime);
begin
  FCadastro := AValue;
end;

procedure TUsuarioDonoCadastro.SetDonoCadastro(AValue: TParticipante);
begin
  if AValue = nil then
    raise Exception.Create('O campo "Dono do Cadastro" precisa ser preenchido!')
  else
    FDonoCadastro := AValue;
end;

procedure TUsuarioDonoCadastro.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Id" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TUsuarioDonoCadastro.SetUsuario(AValue: TUsuario);
begin
  if AValue = nil then
    raise Exception.Create('O campo "Usuário" precisa ser preenchido!')
  else
    FUsuario:=AValue;
end;

constructor TUsuarioDonoCadastro.Create;
begin
  FUsuario      := TUsuario.Create;
  FDonoCadastro := TParticipante.Create;
end;

destructor TUsuarioDonoCadastro.Destroy;
begin
  FUsuario.Free;
  FDonoCadastro.Free;
  inherited Destroy;
end;

end.

