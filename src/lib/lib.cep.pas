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

unit lib.cep;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, view.mensagem, vrbViaCep;

type

  { TLibCep }

  TLibCep = class
  private
    FVrbViaCep: TVrbViaCep;
    function GetEndereco: TListaVrbEndereco;
  public
    function BuscarPorCep(CEP: String; out Erro: String): Boolean;
    function BuscarPorLogradouro(Logradouro, Cidade, UF: String; out Erro: String): Boolean;
    constructor Create;
    destructor Destroy; override;
    property Endereco: TListaVrbEndereco read GetEndereco;
  end;

implementation

{ TLibCep }

function TLibCep.GetEndereco: TListaVrbEndereco;
begin
  Result := FVrbViaCep.Endereco;
end;

function TLibCep.BuscarPorCep(CEP: String; out Erro: String): Boolean;
begin
  FVrbViaCep.TipoBusca := bCep;
  FVrbViaCep.CEP := CEP;
  Result := FVrbViaCep.Buscar;
  Erro := FVrbViaCep.Erro;
end;

function TLibCep.BuscarPorLogradouro(Logradouro, Cidade, UF: String; out Erro: String): Boolean;
begin
  FVrbViaCep.TipoBusca := bLogradouro;
  FVrbViaCep.Logradouro := Logradouro;
  FVrbViaCep.Cidade     := Cidade;
  FVrbViaCep.UF         := UF;
  Result := FVrbViaCep.Buscar;
  Erro := FVrbViaCep.Erro;
end;

constructor TLibCep.Create;
begin
  FVrbViaCep := TVrbViaCep.Create(nil);
end;

destructor TLibCep.Destroy;
begin
  FreeAndNil(FVrbViaCep);
  Inherited Destroy;
end;

end.

