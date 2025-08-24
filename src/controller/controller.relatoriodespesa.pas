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

unit controller.relatoriodespesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LR_View, ComCtrls, StdCtrls, model.report.despesa,
  model.dao.padrao, TAGraph;

type

  { TRelatorioDespesaController }

  TRelatorioDespesaController = class
  private
    Relatorio: TDespesaReport;
  public
    {$Region 'Relatórios'}
    function PorPeriodo(var Preview: TfrPreview; dInicial, dFinal: TDate; Tipo, BuscaId: Integer;
                          Busca: String; out Erro: String): Boolean;
    function ComparativoMensal(var Preview: TfrPreview; anoInicial, anoFinal, mes: Integer;
                          out Erro: String): Boolean;
    function ComparativoAnual(var Preview: TfrPreview; var Grafico: TChart; anoInicial, anoFinal, Tipo: Integer;
                          out Erro: String): Boolean;
    function TotalPorMes(var Preview: TfrPreview; var Grafico: TChart; ano, Tipo: Integer; out Erro: String): Boolean;
    function TotalPorSubtipo(var Preview: TfrPreview; dInicial, dFinal: TDate;
                          out Erro: String): Boolean;
    function TotalPorTipo(var Preview: TfrPreview; dInicial, dFinal: TDate;
                          out Erro: String): Boolean;
    function TotalPorFormaPgto(var Preview: TfrPreview; dInicial, dFinal: TDate;
                          out Erro: String): Boolean;
    {$EndRegion}

    {$Region 'Buscas Filtros'}
    procedure PesquisarSubtipo(CbNome: TComboBox; lbId: TListBox; out QtdRegistro: Integer);
    procedure PesquisarTipo(CbNome: TComboBox; lbId: TListBox; out QtdRegistro: Integer);
    procedure PesquisarFormaPagamento(CbNome: TComboBox; lbId: TListBox; out QtdRegistro: Integer);
    {$EndRegion}

    {$Region 'Utils'}
    procedure GerarImagemGrafico(Grafico: TChart; SalvarImg: Boolean = False);
    {$EndRegion}

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TRelatorioDespesaController }

function TRelatorioDespesaController.PorPeriodo(var Preview: TfrPreview;
  dInicial, dFinal: TDate; Tipo, BuscaId: Integer; Busca: String; out Erro: String): Boolean;
begin
  Relatorio.dmRelatorio.frReport.Preview := Preview;
  Result := Relatorio.PorPeriodo(dInicial, dFinal, Tipo, BuscaId, Busca, Erro);
end;

function TRelatorioDespesaController.ComparativoMensal(var Preview: TfrPreview;
  anoInicial, anoFinal, mes: Integer; out Erro: String): Boolean;
begin
  Relatorio.dmRelatorio.frReport.Preview := Preview;
  Result := Relatorio.ComparativoMensal(anoInicial, anoFinal, mes, Erro);
end;

function TRelatorioDespesaController.ComparativoAnual(var Preview: TfrPreview;
  var Grafico: TChart; anoInicial, anoFinal, Tipo: Integer; out Erro: String): Boolean;
begin
  Relatorio.dmRelatorio.frReport.Preview := Preview;
  Result := Relatorio.ComparativoAnual(Grafico, anoInicial, anoFinal, Tipo,  Erro);
end;

function TRelatorioDespesaController.TotalPorMes(var Preview: TfrPreview;
  var Grafico: TChart; ano, Tipo: Integer; out Erro: String): Boolean;
begin
  Relatorio.dmRelatorio.frReport.Preview := Preview;
  Result := Relatorio.TotalPorMes(Grafico, ano, Tipo, Erro);
end;

function TRelatorioDespesaController.TotalPorSubtipo(var Preview: TfrPreview;
  dInicial, dFinal: TDate; out Erro: String): Boolean;
begin
  Relatorio.dmRelatorio.frReport.Preview := Preview;
  Result := Relatorio.TotalPorSubtipo(dInicial, dFinal, Erro);
end;

function TRelatorioDespesaController.TotalPorTipo(var Preview: TfrPreview;
  dInicial, dFinal: TDate; out Erro: String): Boolean;
begin
  Relatorio.dmRelatorio.frReport.Preview := Preview;
  Result := Relatorio.TotalPorTipo(dInicial, dFinal, Erro);
end;

function TRelatorioDespesaController.TotalPorFormaPgto(var Preview: TfrPreview;
  dInicial, dFinal: TDate; out Erro: String): Boolean;
begin
  Relatorio.dmRelatorio.frReport.Preview := Preview;
  Result := Relatorio.TotalPorFormaPgto(dInicial, dFinal, Erro);
end;

procedure TRelatorioDespesaController.PesquisarSubtipo(CbNome: TComboBox;
  lbId: TListBox; out QtdRegistro: Integer);
begin
  Relatorio.PesquisaGenerica(TB_SUBTIPO_DESPESA, CbNome, lbId, '', -1, QtdRegistro);
end;

procedure TRelatorioDespesaController.PesquisarTipo(CbNome: TComboBox;
  lbId: TListBox; out QtdRegistro: Integer);
begin
  Relatorio.PesquisaGenerica(TB_TIPO_DESPESA, CbNome, lbId, '', -1, QtdRegistro);
end;

procedure TRelatorioDespesaController.PesquisarFormaPagamento(
  CbNome: TComboBox; lbId: TListBox; out QtdRegistro: Integer);
begin
  Relatorio.PesquisaGenerica(TB_FORMA_PGTO, CbNome, lbId, '', -1, QtdRegistro);
end;

procedure TRelatorioDespesaController.GerarImagemGrafico(Grafico: TChart; SalvarImg: Boolean = False);
begin
  Relatorio.dmRelatorio.GerarImagemGrafico(Grafico, SalvarImg);
end;

constructor TRelatorioDespesaController.Create;
begin
  Relatorio := TDespesaReport.Create;
end;

destructor TRelatorioDespesaController.Destroy;
begin
  FreeAndNil(Relatorio);
  inherited Destroy;
end;

end.

