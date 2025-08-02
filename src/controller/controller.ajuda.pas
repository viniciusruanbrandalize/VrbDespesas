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

unit controller.ajuda;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, model.dao.configuracao,
  model.entity.configuracao, lib.version;

type

  { TAjudaController }

  TAjudaController = class
  private

  public
    function retornarVersao: String;
    function retornarDataVersao: String;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TAjudaController }

function TAjudaController.retornarVersao: String;
var
  conf:    TConfiguracao;
  ConfDao: TConfiguracaoDAO;
  Erro: String;
begin
  Conf := TConfiguracao.Create;
  try
    ConfDAO := TConfiguracaoDAO.Create;
    try
      //if ConfDAO.BuscarPorNome(Conf, 'NUMERO_VERSAO', Erro) then
      //  Result := Conf.Valor;
      Result := NUMERO_VERSAO;
    finally
      FreeAndNil(ConfDao);
    end;
  finally
    FreeAndNil(conf);
  end;
end;

function TAjudaController.retornarDataVersao: String;
var
  conf:    TConfiguracao;
  ConfDao: TConfiguracaoDAO;
  StrData: String;
  Data: TDate;
  Erro: String;
begin
  Conf := TConfiguracao.Create;
  try
    ConfDAO := TConfiguracaoDAO.Create;
    try
      //if ConfDAO.BuscarPorNome(Conf, 'DATA_VERSAO', Erro) then
      //  StrData := Conf.Valor;
      StrData := DATA_VERSA0;
      if TryStrToDate(StrData, Data) then
        Result := FormatDateTime('dddddd', Data)
      else
        Result := '';
    finally
      FreeAndNil(ConfDao);
    end;
  finally
    FreeAndNil(conf);
  end;
end;

constructor TAjudaController.Create;
begin
  //
end;

destructor TAjudaController.Destroy;
begin
  inherited Destroy;
end;

end.
