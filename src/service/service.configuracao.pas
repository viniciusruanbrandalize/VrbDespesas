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

unit service.configuracao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.entity.configuracao, model.dao.configuracao;

type

  { TConfiguracaoService }

  TConfiguracaoService = class
  private
    FNumeroVersao: String;
    FDataVersao: TDate;
    FUsarCartaoVale: Boolean;
    FInserirFornecedorXML: Boolean;
    class var FInstance: TConfiguracaoService;
    constructor CreatePrivate;
    destructor Destroy;
  public
    class function Instance: TConfiguracaoService;
    class procedure Release;
    procedure Ler;
    procedure Gravar;
    property NumeroVersao: String read FNumeroVersao write FNumeroVersao;
    property DataVersao: TDate read FDataVersao write FDataVersao;
    property UsarCartaoVale: Boolean read FUsarCartaoVale write FUsarCartaoVale;
    property InserirFornecedorXML: Boolean read FInserirFornecedorXML write FInserirFornecedorXML;
  end;


implementation

{ TConfiguracaoService }

constructor TConfiguracaoService.CreatePrivate;
begin
  inherited Create;
end;

destructor TConfiguracaoService.Destroy;
begin
  inherited Destroy;
end;

class function TConfiguracaoService.Instance: TConfiguracaoService;
begin
  if not Assigned(FInstance) then
    FInstance := TConfiguracaoService.CreatePrivate;
  Result := FInstance;
end;

class procedure TConfiguracaoService.Release;
begin
  FreeAndNil(FInstance);
end;

procedure TConfiguracaoService.Ler;
var
  DAO: TConfiguracaoDAO;
  FConfig: TConfiguracao;
  Erro: String;
  Data: TDate;
  Inteiro: Integer;
begin
  FConfig := TConfiguracao.Create;
  DAO := TConfiguracaoDAO.Create;
  try
    if DAO.BuscarPorNome(FConfig, 'NUMERO_VERSAO', Erro) then
      FNumeroVersao := FConfig.Valor;
    if DAO.BuscarPorNome(FConfig, 'DATA_VERSAO', Erro) and TryStrToDate(FConfig.Valor, Data) then
      FDataVersao := Data;
    if DAO.BuscarPorNome(FConfig, 'USAR_CARTAO_VALE', Erro) and TryStrToInt(FConfig.Valor, Inteiro) then
      FUsarCartaoVale := Inteiro = 1;
    if DAO.BuscarPorNome(FConfig, 'INSERIR_FORNECEDOR_XML', Erro) and TryStrToInt(FConfig.Valor, Inteiro) then
      FInserirFornecedorXML := Inteiro = 1;
  finally
    FConfig.Free;
    DAO.Free;
  end;
end;

procedure TConfiguracaoService.Gravar;
var
  DAO: TConfiguracaoDAO;
  FConfig: TConfiguracao;
  Erro: String;
begin
  FConfig := TConfiguracao.Create;
  DAO := TConfiguracaoDAO.Create;
  try
    if DAO.BuscarPorNome(FConfig, 'NUMERO_VERSAO', Erro) then
    begin
      FConfig.Valor := FNumeroVersao;
      Dao.Editar(FConfig, Erro);
    end;
    if DAO.BuscarPorNome(FConfig, 'DATA_VERSAO', Erro) then
    begin
      FConfig.Valor := DateToStr(FDataVersao);
      Dao.Editar(FConfig, Erro);
    end;
    if DAO.BuscarPorNome(FConfig, 'USAR_CARTAO_VALE', Erro) then
    begin
      FConfig.Valor := FUsarCartaoVale.ToString();
      Dao.Editar(FConfig, Erro);
    end;
    if DAO.BuscarPorNome(FConfig, 'INSERIR_FORNECEDOR_XML', Erro) then
    begin
      FConfig.Valor := FInserirFornecedorXML.ToString();
      Dao.Editar(FConfig, Erro);
    end;
  finally
    FConfig.Free;
    DAO.Free;
  end;
end;

end.

