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

unit model.report.fluxocaixa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, StrUtils, StdCtrls, model.report.conexao, model.dao.padrao,
  TAGraph, TASeries, TAFuncSeries;

type

  { TFluxoCaixaReport }

  TFluxoCaixaReport = Class
  private
    DAO: TPadraoDAO;
    FSQL: String;
    const
      NomeMes: array  [1..12] of string = ('Janeiro', 'Fevereiro', 'Março',
      'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro',
      'Novembro', 'Dezembro');
  public
    dmRelatorio: TdmConexaoReport;

    {$Region 'Relatorios'}
    function PorPeriodo(dInicial, dFinal: TDate; out Erro: String): Boolean;
    function TotalMensal(var Grafico: TChart; ano, Tipo: Integer; out Erro: String): Boolean;
    {$EndRegion}

    {$Region 'Buscas Filtros'}
    procedure PesquisaGenerica(Tabela: TTabela; objNome: TObject; lbId: TListBox; busca: String;
                                Limitacao: Integer; out QtdRegistro: Integer);
    {$EndRegion}

    constructor Create;
    destructor Destroy; override;
end;

implementation

{ TFluxoCaixaReport }

function TFluxoCaixaReport.PorPeriodo(dInicial, dFinal: TDate; out Erro: String): Boolean;
begin
  try

    FSQL := 'select data, descricao, nome_participante, total, tipo_saldo, id_dono_cadastro from (' +
            'select d.data, d.descricao, p.nome as nome_participante, d.total*(-1) as total, ' +
            QuotedStr('D')+' as tipo_saldo, d.id_dono_cadastro ' +
            'from despesa d ' +
            'left join participante p on p.id = d.id_fornecedor ' +
            'where d.paga = :paga ' +
            'union all ' +
            'select r.data, r.descricao, p.nome as nome_participante, r.valor_total as total, ' +
            QuotedStr('R')+' as tipo_saldo, r.id_dono_cadastro ' +
            'from recebimento r ' +
            'left join participante p on p.id = r.id_pagador ) s1 ' +
            'where data between :inicial and :final and id_dono_cadastro = :id_dono_cadastro ' +
            'order by data desc';

    dmConexaoReport.qryPadrao.Close;
    dmConexaoReport.qryPadrao.SQL.Clear;
    dmConexaoReport.qryPadrao.SQL.Add(FSQL);
    dmConexaoReport.qryPadrao.ParamByName('inicial').AsDateTime  := dInicial;
    dmConexaoReport.qryPadrao.ParamByName('final').AsDateTime    := dFinal;
    dmConexaoReport.qryPadrao.ParamByName('id_dono_cadastro').AsInteger := dmConexaoReport.IDDonoCadastro;
    dmConexaoReport.qryPadrao.ParamByName('paga').AsBoolean := True;
    dmConexaoReport.qryPadrao.Open;

    dmConexaoReport.frReport.LoadFromFile(dmConexaoReport.DiretorioRelatorios +
                                         'dfc_periodo.lrf');

    dmRelatorio.frReport.FindObject('mInformacao').Memo.Text := 'Período: '+
                                                   DateToStr(dInicial)+' à '+DateToStr(dFinal);
    dmConexaoReport.CarregarLogo();
    dmConexaoReport.frReport.ShowReport;

    Result := True;

  except
    on e: Exception do
    begin
      Erro := 'Erro ao gerar o relatório: ' + e.Message;
      Result := False;
    end;
  end;
end;

function TFluxoCaixaReport.TotalMensal(var Grafico: TChart; ano, Tipo: Integer;
  out Erro: String): Boolean;
begin
  try

    FSQL := 'select cast(coalesce(sum(total_despesa),0) as decimal(15,2)) as total_despesa, ' +
            'cast(coalesce(sum(total_recebimento),0) as decimal(15,2)) as total_recebimento, ' +
            'cast(coalesce(sum(total_recebimento),0) - coalesce(sum(total_despesa),0) as decimal(15,2)) as total_saldo, ' +
            'mes, ano, id_dono_cadastro, ' +
            '(case when mes = 1 then ''Janeiro'' '+
            'when mes = 2 then ''Fevereiro'' '+
            'when mes = 3 then ''Março'' '+
            'when mes = 4 then ''Abril'' '+
            'when mes = 5 then ''Maio'' '+
            'when mes = 6 then ''Junho'' '+
            'when mes = 7 then ''Julho'' '+
            'when mes = 8 then ''Agosto'' '+
            'when mes = 9 then ''Setembro'' '+
            'when mes = 10 then ''Outubro'' '+
            'when mes = 11 then ''Novembro'' '+
            'when mes = 12 then ''Dezembro'' '+
            'end) as nome_mes from ' +
            '(select cast(sum(total) as decimal(15,2)) as total_despesa, ' +
            'cast(0 as decimal(15,2)) as total_recebimento, '+DAO.ExtractData(EXT_MES, 'data')+' as mes, ' +
            DAO.ExtractData(EXT_ANO, 'data')+' as ano, id_dono_cadastro from despesa ' +
            'where paga = :paga ' +
            'group by '+IfThen(DAO.Driver = DRV_MSSQLSERVER, DAO.ExtractData(EXT_MES, 'data'), 'mes')+
            ', '+IfThen(DAO.Driver = DRV_MSSQLSERVER, DAO.ExtractData(EXT_ANO, 'data'), 'ano')+', id_dono_cadastro ' +
            'union all ' +
            'select cast(0 as decimal(15,2)) as total_despesa, ' +
            'cast(sum(valor_total) as decimal(15,2)) as total_recebimento, '+DAO.ExtractData(EXT_MES, 'data')+' as mes, ' +
            DAO.ExtractData(EXT_ANO, 'data')+' as ano, id_dono_cadastro from recebimento ' +
            'group by '+IfThen(DAO.Driver = DRV_MSSQLSERVER, DAO.ExtractData(EXT_MES, 'data'), 'mes')+
            ', '+IfThen(DAO.Driver = DRV_MSSQLSERVER, DAO.ExtractData(EXT_ANO, 'data'), 'ano')+', id_dono_cadastro ) s1 ' +
            'group by mes, ano, id_dono_cadastro ' +
            'having ano = :ano_informado and id_dono_cadastro = :id_dono_cadastro ' +
            'order by mes asc';

    dmConexaoReport.qryPadrao.Close;
    dmConexaoReport.qryPadrao.SQL.Clear;
    dmConexaoReport.qryPadrao.SQL.Add(FSQL);
    dmConexaoReport.qryPadrao.ParamByName('ano_informado').AsInteger := ano;
    dmConexaoReport.qryPadrao.ParamByName('id_dono_cadastro').AsInteger := dmConexaoReport.IDDonoCadastro;
    dmConexaoReport.qryPadrao.ParamByName('paga').AsBoolean := True;
    dmConexaoReport.qryPadrao.Open;

    dmConexaoReport.frReport.LoadFromFile(dmConexaoReport.DiretorioRelatorios +
                                         'dfc_total_mensal.lrf');

    dmRelatorio.frReport.FindObject('mInformacao').Memo.Text := 'Ano: '+ano.ToString;
    dmConexaoReport.CarregarLogo();
    dmConexaoReport.frReport.ShowReport;

    Result := True;

  except
    on e: Exception do
    begin
      Erro := 'Erro ao gerar o relatório: ' + e.Message;
      Result := False;
    end;
  end;
end;

procedure TFluxoCaixaReport.PesquisaGenerica(Tabela: TTabela; objNome: TObject;
  lbId: TListBox; busca: String; Limitacao: Integer; out QtdRegistro: Integer);
begin
  DAO.PesquisaGenerica(Tabela, objNome, lbId, busca, Limitacao, QtdRegistro);
end;

constructor TFluxoCaixaReport.Create;
begin
  DAO := TPadraoDAO.Create;
  FSQL := '';
  dmRelatorio := dmConexaoReport;
end;

destructor TFluxoCaixaReport.Destroy;
begin
  FreeAndNil(DAO);
  inherited Destroy;
end;

end.

