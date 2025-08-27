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

unit model.report.despesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, StdCtrls, TAGraph, TASeries, TAFuncSeries,
  model.report.conexao, model.dao.padrao;

type

  { TDespesaReport }

  TDespesaReport = Class
  private
    DAO: TPadraoDAO;
    FSQL: String;
    const
      NomeMes: array  [1..12] of string = ('Janeiro', 'Fevereiro', 'Março',
      'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro',
      'Novembro', 'Dezembro');
    procedure LimparSeriesGrafico(var Grafico: TChart);
  public
    dmRelatorio: TdmConexaoReport;

    {$Region 'Relatorios'}
    function PorPeriodo(dInicial, dFinal: TDate; Tipo, BuscaId: Integer; Busca: String; out Erro: String): Boolean;
    function ComparativoMensal(var Grafico: TChart; anoInicial, anoFinal, mes: Integer; Tipo: Integer; out Erro: String): Boolean;
    function ComparativoAnual(var Grafico: TChart; anoInicial, anoFinal, Tipo: Integer; out Erro: String): Boolean;
    function TotalPorMes(var Grafico: TChart; ano, Tipo: Integer; out Erro: String): Boolean;
    function TotalPorSubtipo(var Grafico: TChart; dInicial, dFinal: TDate; Tipo: Integer; out Erro: String): Boolean;
    function TotalPorTipo(var Grafico: TChart; dInicial, dFinal: TDate; Tipo: Integer; out Erro: String): Boolean;
    function TotalPorFormaPgto(var Grafico: TChart; dInicial, dFinal: TDate; Tipo: Integer; out Erro: String): Boolean;
    {$EndRegion}

    {$Region 'Buscas Filtros'}
    procedure PesquisaGenerica(Tabela: TTabela; objNome: TObject; lbId: TListBox; busca: String;
                                Limitacao: Integer; out QtdRegistro: Integer);
    {$EndRegion}

    constructor Create;
    destructor Destroy; override;
end;

implementation

{ TDespesaReport }

procedure TDespesaReport.LimparSeriesGrafico(var Grafico: TChart);
begin
  TBarSeries(Grafico.Series.Items[0]).ListSource.Clear;
  TLineSeries(Grafico.Series.Items[1]).ListSource.Clear;
  TAreaSeries(Grafico.Series.Items[2]).ListSource.Clear;
  TPieSeries(Grafico.Series.Items[3]).ListSource.Clear;
  Grafico.Legend.Visible := False;
end;

function TDespesaReport.PorPeriodo(dInicial, dFinal: TDate; Tipo, BuscaId: Integer;
  Busca: String; out Erro: String): Boolean;
var
  TipoDeBusca: String;
begin
  try

    FSQL := 'select d.id, d.data, d.hora, d.descricao, f.nome as nome_fpgto, ' +
            'd.total from despesa d ' +
            'left join participante p on p.id = d.id_fornecedor ' +
            'left join despesa_forma_pgto df on df.id_despesa = d.id ' +
            'left join forma_pgto f on f.id = df.id_forma_pgto ' +
            'left join conta_bancaria cb on cb.id = df.id_conta_bancaria ' +
            'left join cartao card on card.id_conta_bancaria = cb.id ' +
            'left join bandeira ban on ban.id = card.id_bandeira ' +
            'left join banco bco on bco.id = cb.id_banco ' +
            'left join subtipo_despesa sd on sd.id = d.id_subtipo ' +
            'left join tipo_despesa td on td.id = sd.id_tipo_despesa ' +
            'where d.paga = true and d.data between :inicial and :final and ' +
            'd.id_dono_cadastro = :id_dono_cadastro ';

    dmRelatorio.qryPadrao.Close;
    dmRelatorio.qryPadrao.SQL.Clear;

    case Tipo of
      0:
      begin
        FSQL := FSQL + 'and d.id = :busca ';
        TipoDeBusca := 'Código';
      end;
      1:
      begin
        FSQL := FSQL + 'and Upper(d.descricao) like :busca ';
        TipoDeBusca := 'Descrição';
      end;
      2:
      begin
        FSQL := FSQL + 'and Upper(p.nome) like :busca ';
        TipoDeBusca := 'Fornecedor';
      end;
      3:
      begin
        FSQL := FSQL + 'and Upper(cb.numero) = :busca ';
        TipoDeBusca := 'Conta Bancária';
      end;
      4:
      begin
        FSQL := FSQL + 'and Upper(ban.nome) like :busca ';
        TipoDeBusca := 'Bandeira';
      end;
      5:
      begin
        FSQL := FSQL + 'and Upper(bco.nome) like :busca ';
        TipoDeBusca := 'Banco';
      end;
      6:
      begin
        FSQL := FSQL + 'and Upper(df.chave_pix) like :busca ';
        TipoDeBusca := 'Chave PIX';
      end;
      7:
      begin
        FSQL := FSQL + 'and f.id = :busca ';
        TipoDeBusca := 'Forma de Pagamento';
      end;
      8:
      begin
        FSQL := FSQL + 'and sd.id = :busca ';
        TipoDeBusca := 'Subtipo de despesa';
      end;
      9:
      begin
        FSQL := FSQL + 'and td.id = :busca ';
        TipoDeBusca := 'Tipo de despesa';
      end;
    end;

    FSQL := FSQL +
            'order by d.data desc, d.hora desc';

    dmRelatorio.qryPadrao.SQL.Add(FSQL);
    dmRelatorio.qryPadrao.ParamByName('inicial').AsDate  := dInicial;
    dmRelatorio.qryPadrao.ParamByName('final').AsDate    := dFinal;
    dmRelatorio.qryPadrao.ParamByName('id_dono_cadastro').AsInteger := dmRelatorio.IDDonoCadastro;

    if BuscaId > 0 then
      dmRelatorio.qryPadrao.ParamByName('busca').AsInteger := BuscaId
    else
      dmRelatorio.qryPadrao.ParamByName('busca').AsString  := '%'+UpperCase(Busca)+'%';

    dmRelatorio.qryPadrao.Open;
    dmRelatorio.frReport.LoadFromFile(dmRelatorio.DiretorioRelatorios +
                                         'despesa_periodo.lrf');

    dmRelatorio.frReport.FindObject('mInformacao').Memo.Text := 'Período: '+
                                                   DateToStr(dInicial)+' à '+DateToStr(dFinal)+
                                                   '     busca por '+TipoDeBusca+': '+Busca;
    dmRelatorio.CarregarLogo();
    dmRelatorio.frReport.ShowReport;

    Result := True;

  except
    on e: Exception do
    begin
      Erro := 'Erro ao gerar o relatório: ' + e.Message;
      Result := False;
    end;
  end;
end;

function TDespesaReport.ComparativoMensal(var Grafico: TChart; anoInicial, anoFinal,
  mes: Integer; Tipo: Integer; out Erro: String): Boolean;
begin
  try

    if DAO.Driver = DRV_FIREBIRD then
    begin
      FSQL := 'select sum(total) as med_diaria, avg(total) as media, '+
              'sum(total) as total, extract(month from data) as mes, '+
              'extract(year from data) as ano, count(id) as qtd_despesa, '+
              '(case when extract(month from data) = ''1'' then ''Janeiro'' else '+
              '(case when extract(month from data) = ''2'' then ''Fevereiro'' else '+
              '(case when extract(month from data) = ''3'' then ''Março'' else '+
              '(case when extract(month from data) = ''4'' then ''Abril'' else '+
              '(case when extract(month from data) = ''5'' then ''Maio'' else '+
              '(case when extract(month from data) = ''6'' then ''Junho'' else '+
              '(case when extract(month from data) = ''7'' then ''Julho'' else '+
              '(case when extract(month from data) = ''8'' then ''Agosto'' else '+
              '(case when extract(month from data) = ''9'' then ''Setembro'' else '+
              '(case when extract(month from data) = ''10'' then ''Outubro'' else '+
              '(case when extract(month from data) = ''11'' then ''Novembro'' else '+
              '(case when extract(month from data) = ''12'' then ''Dezembro'' '+
              ' end) end) end) end) end) end) end) end) end) end) end) end) as nome_mes from despesa '+
              'group by mes, ano, paga, id_dono_cadastro '+
              'having extract(year from data) between :ano_inicial and :ano_final ' +
              'and extract(month from data) = :mes_informado and ' +
              'paga = true and id_dono_cadastro = :id_dono_cadastro '+
              'order by ano desc, mes desc';
    end
    else
    if DAO.Driver in [DRV_MYSQL, DRV_MARIADB, DRV_POSTGRESQL] then
    begin
      FSQL := 'select sum(total) as med_diaria, avg(total) as media, '+
              'sum(total) as total, extract(month from data) as mes, '+
              'extract(year from data) as ano, count(id) as qtd_despesa, '+
              '(case when extract(month from data) = ''1'' then ''Janeiro'' else '+
              '(case when extract(month from data) = ''2'' then ''Fevereiro'' else '+
              '(case when extract(month from data) = ''3'' then ''Março'' else '+
              '(case when extract(month from data) = ''4'' then ''Abril'' else '+
              '(case when extract(month from data) = ''5'' then ''Maio'' else '+
              '(case when extract(month from data) = ''6'' then ''Junho'' else '+
              '(case when extract(month from data) = ''7'' then ''Julho'' else '+
              '(case when extract(month from data) = ''8'' then ''Agosto'' else '+
              '(case when extract(month from data) = ''9'' then ''Setembro'' else '+
              '(case when extract(month from data) = ''10'' then ''Outubro'' else '+
              '(case when extract(month from data) = ''11'' then ''Novembro'' else '+
              '(case when extract(month from data) = ''12'' then ''Dezembro'' '+
              ' end) end) end) end) end) end) end) end) end) end) end) end) as nome_mes from despesa '+
              'group by mes, ano, paga, id_dono_cadastro '+
              'having ano between :ano_inicial and :ano_final ' +
              'and mes = :mes_informado and ' +
              'paga = true and id_dono_cadastro = :id_dono_cadastro '+
              'order by ano desc, mes desc';
    end;

    dmRelatorio.qryPadrao.Close;
    dmRelatorio.qryPadrao.SQL.Clear;
    dmRelatorio.qryPadrao.SQL.Add(FSQL);
    dmRelatorio.qryPadrao.ParamByName('ano_inicial').AsInteger  := anoInicial;
    dmRelatorio.qryPadrao.ParamByName('ano_final').AsInteger    := anoFinal;
    dmRelatorio.qryPadrao.ParamByName('mes_informado').AsString := FormatFloat('00', mes);
    dmRelatorio.qryPadrao.ParamByName('id_dono_cadastro').AsInteger := dmRelatorio.IDDonoCadastro;
    dmRelatorio.qryPadrao.Open;
    dmRelatorio.qryPadrao.First;

    LimparSeriesGrafico(Grafico);

    case Tipo of
      0:
      begin
        dmRelatorio.frReport.LoadFromFile(dmRelatorio.DiretorioRelatorios +
                                         'despesa_comparativo_mensal.lrf');
      end;
      1:
      begin
        while not dmRelatorio.qryPadrao.EOF do
        begin
          TBarSeries(Grafico.Series.Items[0]).ListSource.Add(dmRelatorio.qryPadrao.FieldByName('ano').AsInteger,
                                                             dmRelatorio.qryPadrao.FieldByName('total').AsFloat,
                                                             '', Random($FFFFFF));
          dmRelatorio.qryPadrao.Next;
        end;

        dmRelatorio.frReport.LoadFromFile(dmRelatorio.DiretorioRelatorios +
                                           'despesa_grafico.lrf');
      end;
      2:
      begin
        while not dmRelatorio.qryPadrao.EOF do
        begin
          TLineSeries(Grafico.Series.Items[1]).ListSource.Add(dmRelatorio.qryPadrao.FieldByName('ano').AsInteger,
                                                             dmRelatorio.qryPadrao.FieldByName('total').AsFloat);
          dmRelatorio.qryPadrao.Next;
        end;

        dmRelatorio.frReport.LoadFromFile(dmRelatorio.DiretorioRelatorios +
                                           'despesa_grafico.lrf');
      end;
      3:
      begin
        while not dmRelatorio.qryPadrao.EOF do
        begin
          TAreaSeries(Grafico.Series.Items[2]).ListSource.Add(dmRelatorio.qryPadrao.FieldByName('ano').AsInteger,
                                                             dmRelatorio.qryPadrao.FieldByName('total').AsFloat);
          dmRelatorio.qryPadrao.Next;
        end;

        dmRelatorio.frReport.LoadFromFile(dmRelatorio.DiretorioRelatorios +
                                           'despesa_grafico.lrf');
      end;
    end;


    dmRelatorio.frReport.FindObject('mInformacao').Memo.Text := 'Período: '+anoInicial.ToString+
                                                                ' à '+anoFinal.ToString+' - '+
                                                                NomeMes[mes];
    dmRelatorio.CarregarLogo();
    dmRelatorio.frReport.ShowReport;

    Result := True;

  except
    on e: Exception do
    begin
      Erro := 'Erro ao gerar o relatório: ' + e.Message;
      Result := False;
    end;
  end;
end;

function TDespesaReport.ComparativoAnual(var Grafico: TChart; anoInicial, anoFinal, Tipo: Integer; out
  Erro: String): Boolean;
begin
  try
    if DAO.Driver = DRV_FIREBIRD then
    begin
      FSQL := 'select sum(total) as med_diaria, avg(total) as media, '+
              'sum(total) as total, extract(year from data) as ano, ' +
              'count(id) as qtd_despesa from despesa '+
              'group by ano, paga, id_dono_cadastro '+
              'having extract(year from data) between :ano_inicial and :ano_final ' +
              'and paga = true and id_dono_cadastro = :id_dono_cadastro ' +
              'order by ano desc';
    end
    else
    if DAO.Driver in [DRV_MYSQL, DRV_MARIADB, DRV_POSTGRESQL] then
    begin
      FSQL := 'select sum(total) as med_diaria, avg(total) as media, '+
              'sum(total) as total, extract(year from data) as ano, ' +
              'count(id) as qtd_despesa from despesa '+
              'group by ano, paga, id_dono_cadastro '+
              'having ano between :ano_inicial and :ano_final ' +
              'and paga = true and id_dono_cadastro = :id_dono_cadastro ' +
              'order by ano desc';
    end;

    dmRelatorio.qryPadrao.Close;
    dmRelatorio.qryPadrao.SQL.Clear;
    dmRelatorio.qryPadrao.SQL.Add(FSQL);
    dmRelatorio.qryPadrao.ParamByName('ano_inicial').AsInteger  := anoInicial;
    dmRelatorio.qryPadrao.ParamByName('ano_final').AsInteger    := anoFinal;
    dmRelatorio.qryPadrao.ParamByName('id_dono_cadastro').AsInteger := dmRelatorio.IDDonoCadastro;
    dmRelatorio.qryPadrao.Open;
    dmRelatorio.qryPadrao.First;

    LimparSeriesGrafico(Grafico);

    case Tipo of
      0:
      begin
        dmRelatorio.frReport.LoadFromFile(dmRelatorio.DiretorioRelatorios +
                                           'despesa_comparativo_anual.lrf');
      end;
      1:
      begin
        while not dmRelatorio.qryPadrao.EOF do
        begin
          TBarSeries(Grafico.Series.Items[0]).ListSource.Add(dmRelatorio.qryPadrao.FieldByName('ano').AsInteger,
                                                             dmRelatorio.qryPadrao.FieldByName('total').AsFloat,
                                                             '', Random($FFFFFF));
          dmRelatorio.qryPadrao.Next;
        end;

        dmRelatorio.frReport.LoadFromFile(dmRelatorio.DiretorioRelatorios +
                                           'despesa_grafico.lrf');
      end;
      2:
      begin
        while not dmRelatorio.qryPadrao.EOF do
        begin
          TLineSeries(Grafico.Series.Items[1]).ListSource.Add(dmRelatorio.qryPadrao.FieldByName('ano').AsInteger,
                                                             dmRelatorio.qryPadrao.FieldByName('total').AsFloat);
          dmRelatorio.qryPadrao.Next;
        end;

        dmRelatorio.frReport.LoadFromFile(dmRelatorio.DiretorioRelatorios +
                                           'despesa_grafico.lrf');
      end;
      3:
      begin
        while not dmRelatorio.qryPadrao.EOF do
        begin
          TAreaSeries(Grafico.Series.Items[2]).ListSource.Add(dmRelatorio.qryPadrao.FieldByName('ano').AsInteger,
                                                             dmRelatorio.qryPadrao.FieldByName('total').AsFloat);
          dmRelatorio.qryPadrao.Next;
        end;

        dmRelatorio.frReport.LoadFromFile(dmRelatorio.DiretorioRelatorios +
                                           'despesa_grafico.lrf');
      end;
    end;

    dmRelatorio.frReport.FindObject('mInformacao').Memo.Text := 'Período: '+anoInicial.ToString+
                                                                ' à '+anoFinal.ToString;
    dmRelatorio.CarregarLogo();
    dmRelatorio.frReport.ShowReport;

    Result := True;

  except
    on e: Exception do
    begin
      Erro := 'Erro ao gerar o relatório: ' + e.Message;
      Result := False;
    end;
  end;
end;

function TDespesaReport.TotalPorMes(var Grafico: TChart; ano, Tipo: Integer; out Erro: String): Boolean;
begin
  try

    if DAO.Driver = DRV_FIREBIRD then
    begin
      FSQL := 'select sum(total) as med_diaria, avg(total) as media, '+
              'sum(total) as total, extract(month from data) as mes, '+
              'extract(year from data) as ano, count(id) as qtd_despesa, '+
              '(case when extract(month from data) = ''1'' then ''Janeiro'' else '+
              '(case when extract(month from data) = ''2'' then ''Fevereiro'' else '+
              '(case when extract(month from data) = ''3'' then ''Março'' else '+
              '(case when extract(month from data) = ''4'' then ''Abril'' else '+
              '(case when extract(month from data) = ''5'' then ''Maio'' else '+
              '(case when extract(month from data) = ''6'' then ''Junho'' else '+
              '(case when extract(month from data) = ''7'' then ''Julho'' else '+
              '(case when extract(month from data) = ''8'' then ''Agosto'' else '+
              '(case when extract(month from data) = ''9'' then ''Setembro'' else '+
              '(case when extract(month from data) = ''10'' then ''Outubro'' else '+
              '(case when extract(month from data) = ''11'' then ''Novembro'' else '+
              '(case when extract(month from data) = ''12'' then ''Dezembro'' '+
              ' end) end) end) end) end) end) end) end) end) end) end) end) as nome_mes from despesa '+
              'group by mes, ano, paga, id_dono_cadastro '+
              'having extract(year from data) = :ano_informado and ' +
              'paga = true and id_dono_cadastro = :id_dono_cadastro ' +
              'order by mes asc';
    end
    else
    if DAO.Driver in [DRV_MYSQL, DRV_MARIADB, DRV_POSTGRESQL] then
    begin
      FSQL := 'select sum(total) as med_diaria, avg(total) as media, '+
              'sum(total) as total, extract(month from data) as mes, '+
              'extract(year from data) as ano, count(id) as qtd_despesa, '+
              '(case when extract(month from data) = ''1'' then ''Janeiro'' else '+
              '(case when extract(month from data) = ''2'' then ''Fevereiro'' else '+
              '(case when extract(month from data) = ''3'' then ''Março'' else '+
              '(case when extract(month from data) = ''4'' then ''Abril'' else '+
              '(case when extract(month from data) = ''5'' then ''Maio'' else '+
              '(case when extract(month from data) = ''6'' then ''Junho'' else '+
              '(case when extract(month from data) = ''7'' then ''Julho'' else '+
              '(case when extract(month from data) = ''8'' then ''Agosto'' else '+
              '(case when extract(month from data) = ''9'' then ''Setembro'' else '+
              '(case when extract(month from data) = ''10'' then ''Outubro'' else '+
              '(case when extract(month from data) = ''11'' then ''Novembro'' else '+
              '(case when extract(month from data) = ''12'' then ''Dezembro'' '+
              ' end) end) end) end) end) end) end) end) end) end) end) end) as nome_mes from despesa '+
              'group by mes, ano, paga, id_dono_cadastro '+
              'having ano = :ano_informado and ' +
              'paga = true and id_dono_cadastro = :id_dono_cadastro ' +
              'order by mes asc';
    end;

    dmRelatorio.qryPadrao.Close;
    dmRelatorio.qryPadrao.SQL.Clear;
    dmRelatorio.qryPadrao.SQL.Add(FSQL);
    dmRelatorio.qryPadrao.ParamByName('ano_informado').AsInteger  := ano;
    dmRelatorio.qryPadrao.ParamByName('id_dono_cadastro').AsInteger := dmRelatorio.IDDonoCadastro;
    dmRelatorio.qryPadrao.Open;
    dmRelatorio.qryPadrao.First;

    LimparSeriesGrafico(Grafico);

    case Tipo of
      0:
      begin
        dmRelatorio.frReport.LoadFromFile(dmRelatorio.DiretorioRelatorios +
                                         'despesa_comparativo_mensal.lrf');
      end;
      1:
      begin
        while not dmRelatorio.qryPadrao.EOF do
        begin
          TBarSeries(Grafico.Series.Items[0]).ListSource.Add(dmRelatorio.qryPadrao.FieldByName('mes').AsInteger,
                                                             dmRelatorio.qryPadrao.FieldByName('total').AsFloat, '',
                                                             Random($FFFFFF));
          dmRelatorio.qryPadrao.Next;
        end;

        dmRelatorio.frReport.LoadFromFile(dmRelatorio.DiretorioRelatorios +
                                           'despesa_grafico.lrf');
      end;
      2:
      begin
        while not dmRelatorio.qryPadrao.EOF do
        begin
          TLineSeries(Grafico.Series.Items[1]).ListSource.Add(dmRelatorio.qryPadrao.FieldByName('mes').AsInteger,
                                                             dmRelatorio.qryPadrao.FieldByName('total').AsFloat);
          dmRelatorio.qryPadrao.Next;
        end;

        dmRelatorio.frReport.LoadFromFile(dmRelatorio.DiretorioRelatorios +
                                           'despesa_grafico.lrf');
      end;
      3:
      begin
        while not dmRelatorio.qryPadrao.EOF do
        begin
          TAreaSeries(Grafico.Series.Items[2]).ListSource.Add(dmRelatorio.qryPadrao.FieldByName('mes').AsInteger,
                                                             dmRelatorio.qryPadrao.FieldByName('total').AsFloat);
          dmRelatorio.qryPadrao.Next;
        end;

        dmRelatorio.frReport.LoadFromFile(dmRelatorio.DiretorioRelatorios +
                                           'despesa_grafico.lrf');
      end;
    end;

    dmRelatorio.frReport.FindObject('mInformacao').Memo.Text := 'Ano: '+ano.ToString;
    dmRelatorio.CarregarLogo();
    dmRelatorio.frReport.ShowReport;

    Result := True;

  except
    on e: Exception do
    begin
      Erro := 'Erro ao gerar o relatório: ' + e.Message;
      Result := False;
    end;
  end;
end;

function TDespesaReport.TotalPorSubtipo(var Grafico: TChart; dInicial, dFinal: TDate;
  Tipo: Integer; out Erro: String): Boolean;
begin
  try

      FSQL := 'select sd.nome as nome_subtipo, ' +
              '(select coalesce(avg(d.total), 0) from despesa d ' +
              'where d.id_subtipo = sd.id and d.paga = true and ' +
              'd.data between :data_inicial and :data_final and ' +
              'd.id_dono_cadastro = :id_dono_cadastro) as media, ' +
              '(select coalesce(sum(d.total), 0) from despesa d ' +
              'where d.id_subtipo = sd.id and d.paga = true and ' +
              'd.data between :data_inicial and :data_final and ' +
              'd.id_dono_cadastro = :id_dono_cadastro) as total, ' +
              '(select coalesce(count(d.id), 0) from despesa d ' +
              'where d.id_subtipo = sd.id and d.paga = true and ' +
              'd.data between :data_inicial and :data_final and ' +
              'd.id_dono_cadastro = :id_dono_cadastro) as qtd_despesa ' +
              'from subtipo_despesa sd ' +
              'order by sd.nome';

    dmRelatorio.qryPadrao.Close;
    dmRelatorio.qryPadrao.SQL.Clear;
    dmRelatorio.qryPadrao.SQL.Add(FSQL);
    dmRelatorio.qryPadrao.ParamByName('data_inicial').AsDate  := dInicial;
    dmRelatorio.qryPadrao.ParamByName('data_final').AsDate    := dFinal;
    dmRelatorio.qryPadrao.ParamByName('id_dono_cadastro').AsInteger := dmRelatorio.IDDonoCadastro;
    dmRelatorio.qryPadrao.Open;
    dmRelatorio.qryPadrao.First;

    LimparSeriesGrafico(Grafico);

    case Tipo of
      0:
      begin
        dmRelatorio.frReport.LoadFromFile(dmRelatorio.DiretorioRelatorios +
                                         'despesa_total_subtipo.lrf');
      end;
      1:
      begin

        while not dmRelatorio.qryPadrao.EOF do
        begin
          if dmRelatorio.qryPadrao.FieldByName('total').AsFloat > 0 then
          begin
            TPieSeries(Grafico.Series.Items[3]).add(dmRelatorio.qryPadrao.FieldByName('total').AsFloat,
                                                  dmRelatorio.qryPadrao.FieldByName('nome_subtipo').AsString,
                                                  Random($FFFFFF));
          end;
          dmRelatorio.qryPadrao.Next;
        end;

        dmRelatorio.frReport.LoadFromFile(dmRelatorio.DiretorioRelatorios +
                                           'despesa_grafico.lrf');
      end;
    end;

    dmRelatorio.frReport.FindObject('mInformacao').Memo.Text := 'Período: '+
                                                   DateToStr(dInicial)+' à '+DateToStr(dFinal);

    dmRelatorio.CarregarLogo();
    dmRelatorio.frReport.ShowReport;

    Result := True;

  except
    on e: Exception do
    begin
      Erro := 'Erro ao gerar o relatório: ' + e.Message;
      Result := False;
    end;
  end;
end;

function TDespesaReport.TotalPorTipo(var Grafico: TChart; dInicial, dFinal: TDate;
  Tipo: Integer; out Erro: String): Boolean;
begin
  try

    FSQL := 'select td.nome as nome_tipo, '+
            '(select coalesce(avg(d.total), 0) from despesa d ' +
            'left join subtipo_despesa sd on sd.id = d.id_subtipo '+
            'where td.id = sd.id_tipo_despesa and d.paga = true and '+
            'd.data between :data_inicial and :data_final and ' +
            'd.id_dono_cadastro = :id_dono_cadastro) as media, '+
            '(select coalesce(sum(d.total), 0) from despesa d ' +
            'left join subtipo_despesa sd on sd.id = d.id_subtipo '+
            'where td.id = sd.id_tipo_despesa and d.paga = true and '+
            'd.data between :data_inicial and :data_final and ' +
            'd.id_dono_cadastro = :id_dono_cadastro) as total, '+
            '(select coalesce(count(d.id), 0) from despesa d '+
            'left join subtipo_despesa sd on sd.id = d.id_subtipo '+
            'where td.id = sd.id_tipo_despesa and d.paga = true and '+
            'd.data between :data_inicial and :data_final and ' +
            'd.id_dono_cadastro = :id_dono_cadastro) as qtd_despesa '+
            'from tipo_despesa td '+
            'order by td.nome';

    dmRelatorio.qryPadrao.Close;
    dmRelatorio.qryPadrao.SQL.Clear;
    dmRelatorio.qryPadrao.SQL.Add(FSQL);
    dmRelatorio.qryPadrao.ParamByName('data_inicial').AsDate  := dInicial;
    dmRelatorio.qryPadrao.ParamByName('data_final').AsDate    := dFinal;
    dmRelatorio.qryPadrao.ParamByName('id_dono_cadastro').AsInteger := dmRelatorio.IDDonoCadastro;
    dmRelatorio.qryPadrao.Open;
    dmRelatorio.qryPadrao.First;

    LimparSeriesGrafico(Grafico);

    case Tipo of
      0:
      begin
        dmRelatorio.frReport.LoadFromFile(dmRelatorio.DiretorioRelatorios +
                                         'despesa_total_tipo.lrf');
      end;
      1:
      begin

        while not dmRelatorio.qryPadrao.EOF do
        begin
          if dmRelatorio.qryPadrao.FieldByName('total').AsFloat > 0 then
          begin
            TPieSeries(Grafico.Series.Items[3]).add(dmRelatorio.qryPadrao.FieldByName('total').AsFloat,
                                                  dmRelatorio.qryPadrao.FieldByName('nome_tipo').AsString,
                                                  Random($FFFFFF));
          end;
          dmRelatorio.qryPadrao.Next;
        end;

        dmRelatorio.frReport.LoadFromFile(dmRelatorio.DiretorioRelatorios +
                                           'despesa_grafico.lrf');
      end;
    end;

    dmRelatorio.frReport.FindObject('mInformacao').Memo.Text := 'Período: '+
                                                   DateToStr(dInicial)+' à '+DateToStr(dFinal);

    dmRelatorio.CarregarLogo();
    dmRelatorio.frReport.ShowReport;

    Result := True;

  except
    on e: Exception do
    begin
      Erro := 'Erro ao gerar o relatório: ' + e.Message;
      Result := False;
    end;
  end;
end;

function TDespesaReport.TotalPorFormaPgto(var Grafico: TChart; dInicial, dFinal: TDate;
  Tipo: Integer; out Erro: String): Boolean;
begin
  try

    FSQL := 'select fp.nome as nome_forma_pagamento, '+
            '(select coalesce(avg(dfp.valor), 0) from despesa_forma_pgto dfp ' +
            'left join despesa d on d.id = dfp.id_despesa ' +
            'where dfp.id_forma_pgto = fp.id and d.paga = true and '+
            'd.data between :data_inicial and :data_final and ' +
            'd.id_dono_cadastro = :id_dono_cadastro) as media, '+
            '(select coalesce(sum(dfp.valor), 0) from despesa_forma_pgto dfp ' +
            'left join despesa d on d.id = dfp.id_despesa ' +
            'where dfp.id_forma_pgto = fp.id and d.paga = true and '+
            'd.data between :data_inicial and :data_final and ' +
            'd.id_dono_cadastro = :id_dono_cadastro) as total, '+
            '(select coalesce(count(dfp.id), 0) from despesa_forma_pgto dfp ' +
            'left join despesa d on d.id = dfp.id_despesa ' +
            'where dfp.id_forma_pgto = fp.id and d.paga = true and '+
            'd.data between :data_inicial and :data_final and ' +
            'd.id_dono_cadastro = :id_dono_cadastro) as qtd_despesa '+
            'from forma_pgto fp '+
            'order by fp.nome';

    dmRelatorio.qryPadrao.Close;
    dmRelatorio.qryPadrao.SQL.Clear;
    dmRelatorio.qryPadrao.SQL.Add(FSQL);
    dmRelatorio.qryPadrao.ParamByName('data_inicial').AsDate  := dInicial;
    dmRelatorio.qryPadrao.ParamByName('data_final').AsDate    := dFinal;
    dmRelatorio.qryPadrao.ParamByName('id_dono_cadastro').AsInteger := dmRelatorio.IDDonoCadastro;
    dmRelatorio.qryPadrao.Open;
    dmRelatorio.qryPadrao.First;

    LimparSeriesGrafico(Grafico);

    case Tipo of
      0:
      begin
        dmRelatorio.frReport.LoadFromFile(dmRelatorio.DiretorioRelatorios +
                                         'despesa_total_forma_pgto.lrf');
      end;
      1:
      begin

        while not dmRelatorio.qryPadrao.EOF do
        begin
          if dmRelatorio.qryPadrao.FieldByName('total').AsFloat > 0 then
          begin
            TPieSeries(Grafico.Series.Items[3]).add(dmRelatorio.qryPadrao.FieldByName('total').AsFloat,
                                                  dmRelatorio.qryPadrao.FieldByName('nome_forma_pagamento').AsString,
                                                  Random($FFFFFF));
          end;
          dmRelatorio.qryPadrao.Next;
        end;

        dmRelatorio.frReport.LoadFromFile(dmRelatorio.DiretorioRelatorios +
                                           'despesa_grafico.lrf');
      end;
    end;

    dmRelatorio.frReport.FindObject('mInformacao').Memo.Text := 'Período: '+
                                                   DateToStr(dInicial)+' à '+DateToStr(dFinal);

    dmRelatorio.CarregarLogo();
    dmRelatorio.frReport.ShowReport;

    Result := True;

  except
    on e: Exception do
    begin
      Erro := 'Erro ao gerar o relatório: ' + e.Message;
      Result := False;
    end;
  end;
end;

procedure TDespesaReport.PesquisaGenerica(Tabela: TTabela; objNome: TObject;
  lbId: TListBox; busca: String; Limitacao: Integer; out QtdRegistro: Integer);
begin
  DAO.PesquisaGenerica(Tabela, objNome, lbId, busca, Limitacao, QtdRegistro);
end;

constructor TDespesaReport.Create;
begin
  DAO := TPadraoDAO.Create;
  dmRelatorio := dmConexaoReport;
  FSQL := '';
end;

destructor TDespesaReport.Destroy;
begin
  FreeAndNil(DAO);
  inherited Destroy;
end;

end.

