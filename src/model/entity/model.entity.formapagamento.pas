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

unit model.entity.formapagamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TFormaPagamento }

  TFormaPagamento = class
  private
    FId:   Integer;
    FNome: String;
    FSigla: String;
    FExcluido: Boolean;
    function GetExcluido: Boolean;
    function GetId: Integer;
    function GetNome: String;
    function GetSigla: String;
    procedure SetExcluido(AValue: Boolean);
    procedure SetId(AValue: Integer);
    procedure SetNome(AValue: String);
    procedure SetSigla(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Nome: String read GetNome write SetNome;
    property Sigla: String read GetSigla write SetSigla;
    property Excluido: Boolean read GetExcluido write SetExcluido;
  end;

implementation

{ TFormaPagamento }

function TFormaPagamento.GetId: Integer;
begin
  Result := FId;
end;

function TFormaPagamento.GetExcluido: Boolean;
begin
  Result := FExcluido;
end;

function TFormaPagamento.GetNome: String;
begin
  Result := FNome;
end;

function TFormaPagamento.GetSigla: String;
begin
  Result := FSigla;
end;

procedure TFormaPagamento.SetExcluido(AValue: Boolean);
begin
  FExcluido := AValue;
end;

procedure TFormaPagamento.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Id" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TFormaPagamento.SetNome(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Nome" precisa ser preenchido!')
  else
    FNome := AValue;
end;

procedure TFormaPagamento.SetSigla(AValue: String);
begin
  FSigla := AValue;
end;

constructor TFormaPagamento.Create;
begin
  //
end;

destructor TFormaPagamento.Destroy;
begin
  inherited Destroy;
end;

end.

