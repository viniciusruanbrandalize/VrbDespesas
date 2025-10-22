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

unit controller.relatorioparticipante;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LR_View, ComCtrls, StdCtrls, model.report.participante,
  model.dao.padrao;

type

  { TRelatorioParticipanteController }

  TRelatorioParticipanteController = class
  private
    Relatorio: TParticipanteReport;
  public
    {$Region 'Relatórios'}
    function Telemarketing(var Preview: TfrPreview; out Erro: String): Boolean;
    function Completo(var Preview: TfrPreview; out Erro: String): Boolean;
    {$EndRegion}

    {$Region 'Buscas Filtros'}

    {$EndRegion}

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TRelatorioParticipanteController }

function TRelatorioParticipanteController.Telemarketing(
  var Preview: TfrPreview; out Erro: String): Boolean;
begin
  Relatorio.dmRelatorio.frReport.Preview := Preview;
  Result := Relatorio.Telemarketing(Erro);
end;

function TRelatorioParticipanteController.Completo(var Preview: TfrPreview; out
  Erro: String): Boolean;
begin
  Relatorio.dmRelatorio.frReport.Preview := Preview;
  Result := Relatorio.Completo(Erro);
end;

constructor TRelatorioParticipanteController.Create;
begin
  Relatorio := TParticipanteReport.Create;
end;

destructor TRelatorioParticipanteController.Destroy;
begin
  FreeAndNil(Relatorio);
  inherited Destroy;
end;

end.
