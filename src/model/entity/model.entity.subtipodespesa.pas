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

unit model.entity.subtipodespesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.entity.tipodespesa;

type

  { TSubtipoDespesa }

  TSubtipoDespesa = class
  private
    FId:   Integer;
    FNome: String;
    FExcluido: Boolean;
    FTipoDespesa: TTipoDespesa;
    function GetExcluido: Boolean;
    function GetId: Integer;
    function GetNome: String;
    function GetTipoDespesa: TTipoDespesa;
    procedure SetExcluido(AValue: Boolean);
    procedure SetId(AValue: Integer);
    procedure SetNome(AValue: String);
    procedure SetTipoDespesa(AValue: TTipoDespesa);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Nome: String read GetNome write SetNome;
    property Excluido: Boolean read GetExcluido write SetExcluido;
    property TipoDespesa: TTipoDespesa read GetTipoDespesa write SetTipoDespesa;
  end;

implementation

{ TSubtipoDespesa }

function TSubtipoDespesa.GetId: Integer;
begin
  Result := FId;
end;

function TSubtipoDespesa.GetExcluido: Boolean;
begin
  Result := FExcluido;
end;

function TSubtipoDespesa.GetNome: String;
begin
  Result := FNome;
end;

function TSubtipoDespesa.GetTipoDespesa: TTipoDespesa;
begin
  Result := FTipoDespesa;
end;

procedure TSubtipoDespesa.SetExcluido(AValue: Boolean);
begin
  FExcluido := AValue;
end;

procedure TSubtipoDespesa.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Id" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TSubtipoDespesa.SetNome(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Nome" precisa ser preenchido!')
  else
    FNome := AValue;
end;

procedure TSubtipoDespesa.SetTipoDespesa(AValue: TTipoDespesa);
begin
  if AValue = nil then
    raise Exception.Create('O campo "Tipo de despesa" precisa ser preenchido!')
  else
    FTipoDespesa := AValue;
end;

constructor TSubtipoDespesa.Create;
begin
  FTipoDespesa := TTipoDespesa.Create;
end;

destructor TSubtipoDespesa.Destroy;
begin
  FTipoDespesa.Free;
  inherited Destroy;
end;

end.

