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

unit model.report.recebimento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, StrUtils, StdCtrls, model.report.conexao, model.dao.padrao;

type

  { TRecebimentoReport }

  TRecebimentoReport = Class
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
    function DeclaracaoDeRenda(ano, tipoRece: Integer; out Erro: String): Boolean;
    {$EndRegion}

    {$Region 'Buscas Filtros'}
    procedure PesquisaGenerica(Tabela: TTabela; objNome: TObject; lbId: TListBox; busca: String;
                                Limitacao: Integer; out QtdRegistro: Integer);
    {$EndRegion}

    constructor Create;
    destructor Destroy; override;
end;

implementation

{ TRecebimentoReport }

function TRecebimentoReport.DeclaracaoDeRenda(ano, tipoRece: Integer; out Erro: String): Boolean;
begin
  try

    FSQL := 'select sum(hora_extra) as hre, sum(inss) AS inss, sum(ir) AS ir , ' +
            'sum(valor_total) as liquido, sum(valor_base) as bruto, ' +
            'extract(month from data) as mes, extract(year from data) as ano, '+
            '(case when extract(month from data) = 1 then ''Janeiro'' else '+
            '(case when extract(month from data) = 2 then ''Fevereiro'' else '+
            '(case when extract(month from data) = 3 then ''Março'' else '+
            '(case when extract(month from data) = 4 then ''Abril'' else '+
            '(case when extract(month from data) = 5 then ''Maio'' else '+
            '(case when extract(month from data) = 6 then ''Junho'' else '+
            '(case when extract(month from data) = 7 then ''Julho'' else '+
            '(case when extract(month from data) = 8 then ''Agosto'' else '+
            '(case when extract(month from data) = 9 then ''Setembro'' else '+
            '(case when extract(month from data) = 10 then ''Outubro'' else '+
            '(case when extract(month from data) = 11 then ''Novembro'' else '+
            '(case when extract(month from data) = 12 THEN ''Dezembro'' '+
            ' end) end) end) end) end) end) end) end) end) end) end) END) as mes_nome '+
            'from recebimento '+
            'where extract(year from data) = :ano and ' +
            'id_dono_cadastro = :id_dono_cadastro ' +
            IfThen(tipoRece<>2, 'and tipo = :tipo ') +
            'group by mes, ano '+
            'order by mes desc';

    dmConexaoReport.qryPadrao.Close;
    dmConexaoReport.qryPadrao.SQL.Clear;
    dmConexaoReport.qryPadrao.SQL.Add(FSQL);
    dmConexaoReport.qryPadrao.ParamByName('ano').AsInteger  := ano;
    dmConexaoReport.qryPadrao.ParamByName('id_dono_cadastro').AsInteger := dmConexaoReport.IDDonoCadastro;

    case tipoRece of
      0: dmConexaoReport.qryPadrao.ParamByName('tipo').AsInteger := 1;
      1: dmConexaoReport.qryPadrao.ParamByName('tipo').AsInteger := 0;
    end;

    dmConexaoReport.qryPadrao.Open;

    dmConexaoReport.frReport.LoadFromFile(dmConexaoReport.DiretorioRelatorios +
                                         'recebimento_salario_anual.lrf');

    dmConexaoReport.frReport.FindObject('mInformacao').Memo.Text := 'Ano: '+ano.ToString;
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

procedure TRecebimentoReport.PesquisaGenerica(Tabela: TTabela; objNome: TObject;
  lbId: TListBox; busca: String; Limitacao: Integer; out QtdRegistro: Integer);
begin
  DAO.PesquisaGenerica(Tabela, objNome, lbId, busca, Limitacao, QtdRegistro);
end;

constructor TRecebimentoReport.Create;
begin
  DAO := TPadraoDAO.Create;
  FSQL := '';
  dmRelatorio := dmConexaoReport;
end;

destructor TRecebimentoReport.Destroy;
begin
  FreeAndNil(DAO);
  inherited Destroy;
end;

end.

