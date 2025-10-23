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

unit controller.relatoriorecebimento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LR_View, ComCtrls, StdCtrls, model.report.recebimento,
  model.dao.padrao;

type

  { TRelatorioRecebimentoController }

  TRelatorioRecebimentoController = class
  private
    Relatorio: TRecebimentoReport;
  public
    {$Region 'Relatórios'}
    function DeclaracaoDeRenda(var Preview: TfrPreview; ano, TipoRece: Integer;
                          out Erro: String): Boolean;
    function PorPeriodo(var Preview: TfrPreview; dInicial, dFinal: TDate; Busca: String;
                          Tipo, TipoRece: Integer; out Erro: String): Boolean;
    function PorPeriodoSalario(var Preview: TfrPreview; dInicial, dFinal: TDate;
                          out Erro: String): Boolean;
    {$EndRegion}

    {$Region 'Buscas Filtros'}
    
    {$EndRegion}

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TRelatorioRecebimentoController }

function TRelatorioRecebimentoController.DeclaracaoDeRenda(var Preview: TfrPreview;
  ano, TipoRece: Integer; out Erro: String): Boolean;
begin
  Relatorio.dmRelatorio.frReport.Preview := Preview;
  Result := Relatorio.DeclaracaoDeRenda(ano, TipoRece, Erro);
end;

function TRelatorioRecebimentoController.PorPeriodo(var Preview: TfrPreview;
  dInicial, dFinal: TDate; Busca: String; Tipo, TipoRece: Integer; out Erro: String): Boolean;
begin
  Relatorio.dmRelatorio.frReport.Preview := Preview;
  Result := Relatorio.PorPeriodo(dInicial, dFinal, Busca, Tipo, TipoRece, Erro);
end;

function TRelatorioRecebimentoController.PorPeriodoSalario(
  var Preview: TfrPreview; dInicial, dFinal: TDate; out Erro: String): Boolean;
begin
  Relatorio.dmRelatorio.frReport.Preview := Preview;
  Result := Relatorio.PorPeriodoSalario(dInicial, dFinal, Erro);
end;

constructor TRelatorioRecebimentoController.Create;
begin
  Relatorio := TRecebimentoReport.Create;
end;

destructor TRelatorioRecebimentoController.Destroy;
begin
  FreeAndNil(Relatorio);
  inherited Destroy;
end;

end.
