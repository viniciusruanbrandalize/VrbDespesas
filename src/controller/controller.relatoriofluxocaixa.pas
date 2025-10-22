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

unit controller.relatoriofluxocaixa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LR_View, ComCtrls, StdCtrls, model.report.fluxocaixa,
  model.dao.padrao;

type

  { TRelatorioFluxoCaixaController }

  TRelatorioFluxoCaixaController = class
  private
    Relatorio: TFluxoCaixaReport;
  public
    {$Region 'Relatórios'}
    function PorPeriodo(var Preview: TfrPreview; dInicial, dFinal: TDate;
                          out Erro: String): Boolean;
    {$EndRegion}

    {$Region 'Buscas Filtros'}

    {$EndRegion}

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TRelatorioFluxoCaixaController }

function TRelatorioFluxoCaixaController.PorPeriodo(var Preview: TfrPreview;
  dInicial, dFinal: TDate; out Erro: String): Boolean;
begin
  Relatorio.dmRelatorio.frReport.Preview := Preview;
  Result := Relatorio.PorPeriodo(dInicial, dFinal, Erro);
end;

constructor TRelatorioFluxoCaixaController.Create;
begin
  Relatorio := TFluxoCaixaReport.Create;
end;

destructor TRelatorioFluxoCaixaController.Destroy;
begin
  FreeAndNil(Relatorio);
  inherited Destroy;
end;

end.
