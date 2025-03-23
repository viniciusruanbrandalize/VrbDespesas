unit model.report.recebimento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, StdCtrls, model.report.conexao, model.dao.padrao;

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
    function DeclaracaoDeRenda(ano: Integer; out Erro: String): Boolean;
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

function TRecebimentoReport.DeclaracaoDeRenda(ano: Integer; out Erro: String): Boolean;
begin
  try
    if DAO.Driver = DRV_FIREBIRD then
    begin
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
              'where extract(year from data) = :ano '+
              'group by mes, ano '+
              'order by mes desc';
    end
    else
    if DAO.Driver in [DRV_MYSQL, DRV_MARIADB, DRV_POSTGRESQL] then
    begin
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
              'where ano = :ano '+
              'group by mes, ano '+
              'order by mes desc';
    end;

    dmConexaoReport.qryPadrao.Close;
    dmConexaoReport.qryPadrao.SQL.Clear;
    dmConexaoReport.qryPadrao.SQL.Add(FSQL);
    dmConexaoReport.qryPadrao.ParamByName('ano').AsInteger  := ano;
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

