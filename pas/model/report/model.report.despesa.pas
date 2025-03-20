unit model.report.despesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, StdCtrls, model.report.conexao, model.dao.padrao;

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
  public
    dmRelatorio: TdmConexaoReport;

    {$Region 'Relatorios'}
    function PorPeriodo(dInicial, dFinal: TDate; Tipo, BuscaId: Integer; Busca: String; out Erro: String): Boolean;
    function ComparativoMensal(anoInicial, anoFinal, mes: Integer; out Erro: String): Boolean;
    function ComparativoAnual(anoInicial, anoFinal: Integer; out Erro: String): Boolean;
    function TotalPorMes(ano: Integer; out Erro: String): Boolean;
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
            'where d.paga = true and d.data between :inicial and :final ';

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

function TDespesaReport.ComparativoMensal(anoInicial, anoFinal, mes: Integer; out
  Erro: String): Boolean;
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
              'group by mes, ano, paga '+
              'having extract(year from data) between :ano_inicial and :ano_final ' +
              'and extract(month from data) = :mes_informado and ' +
              'paga = true '+
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
              'group by mes, ano, paga '+
              'having ano between :ano_inicial and :ano_final ' +
              'and mes = :mes_informado and ' +
              'paga = true '+
              'order by ano desc, mes desc';
    end;

    dmRelatorio.qryPadrao.Close;
    dmRelatorio.qryPadrao.SQL.Clear;
    dmRelatorio.qryPadrao.SQL.Add(FSQL);
    dmRelatorio.qryPadrao.ParamByName('ano_inicial').AsInteger  := anoInicial;
    dmRelatorio.qryPadrao.ParamByName('ano_final').AsInteger    := anoFinal;
    dmRelatorio.qryPadrao.ParamByName('mes_informado').AsString := FormatFloat('00', mes);
    dmRelatorio.qryPadrao.Open;

    dmRelatorio.frReport.LoadFromFile(dmRelatorio.DiretorioRelatorios +
                                         'despesa_comparativo_mensal.lrf');

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

function TDespesaReport.ComparativoAnual(anoInicial, anoFinal: Integer; out
  Erro: String): Boolean;
begin
  try
    if DAO.Driver = DRV_FIREBIRD then
    begin
      FSQL := 'select sum(total) as med_diaria, avg(total) as media, '+
              'sum(total) as total, extract(year from data) as ano, ' +
              'count(id) as qtd_despesa from despesa '+
              'group by ano, paga '+
              'having extract(year from data) between :ano_inicial and :ano_final ' +
              'and paga = true ' +
              'order by ano desc';
    end
    else
    if DAO.Driver in [DRV_MYSQL, DRV_MARIADB, DRV_POSTGRESQL] then
    begin
      FSQL := 'select sum(total) as med_diaria, avg(total) as media, '+
              'sum(total) as total, extract(year from data) as ano, ' +
              'count(id) as qtd_despesa from despesa '+
              'group by ano, paga '+
              'having ano between :ano_inicial and :ano_final ' +
              'and paga = true ' +
              'order by ano desc';
    end;

    dmRelatorio.qryPadrao.Close;
    dmRelatorio.qryPadrao.SQL.Clear;
    dmRelatorio.qryPadrao.SQL.Add(FSQL);
    dmRelatorio.qryPadrao.ParamByName('ano_inicial').AsInteger  := anoInicial;
    dmRelatorio.qryPadrao.ParamByName('ano_final').AsInteger    := anoFinal;
    dmRelatorio.qryPadrao.Open;

    dmRelatorio.frReport.LoadFromFile(dmRelatorio.DiretorioRelatorios +
                                         'despesa_comparativo_anual.lrf');

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

function TDespesaReport.TotalPorMes(ano: Integer; out Erro: String): Boolean;
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
              'group by mes, ano, paga '+
              'having extract(year from data) = :ano_informado and ' +
              'paga = true ' +
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
              'group by mes, ano, paga '+
              'having ano = :ano_informado and ' +
              'paga = true ' +
              'order by mes asc';
    end;

    dmRelatorio.qryPadrao.Close;
    dmRelatorio.qryPadrao.SQL.Clear;
    dmRelatorio.qryPadrao.SQL.Add(FSQL);
    dmRelatorio.qryPadrao.ParamByName('ano_informado').AsInteger  := ano;
    dmRelatorio.qryPadrao.Open;

    dmRelatorio.frReport.LoadFromFile(dmRelatorio.DiretorioRelatorios +
                                         'despesa_comparativo_mensal.lrf');

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

procedure TDespesaReport.PesquisaGenerica(Tabela: TTabela; objNome: TObject;
  lbId: TListBox; busca: String; Limitacao: Integer; out QtdRegistro: Integer);
begin
  DAO.PesquisaGenerica(Tabela, objNome, lbId, busca, Limitacao, QtdRegistro);
end;

constructor TDespesaReport.Create;
begin
  DAO := TPadraoDAO.Create;
  dmRelatorio := TdmConexaoReport.Create(nil);
  FSQL := '';
end;

destructor TDespesaReport.Destroy;
begin
  FreeAndNil(DAO);
  FreeAndNil(dmRelatorio);
  inherited Destroy;
end;

end.

