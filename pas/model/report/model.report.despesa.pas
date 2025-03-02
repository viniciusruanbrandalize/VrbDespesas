unit model.report.despesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.report.padrao;

type

  { TDespesaReport }

  TDespesaReport = Class
  private
    FSQL: String;
  public
    dmRelatorio: TdmPadraoReport;
    function PorPeriodo(dInicial, dFinal: TDate; Tipo: Integer; Busca: String; out Erro: String): Boolean;
    constructor Create;
    destructor Destroy; override;
end;

implementation

{ TDespesaReport }

function TDespesaReport.PorPeriodo(dInicial, dFinal: TDate; Tipo: Integer;
  Busca: String; out Erro: String): Boolean;
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
            'where d.data between :inicial and :final ';

    dmRelatorio.qryPadrao.Close;
    dmRelatorio.qryPadrao.SQL.Clear;

    case Tipo of
      0: FSQL := FSQL + 'and d.id = :busca ';
      1: FSQL := FSQL + 'and Upper(d.descricao) like :busca ';
      2: FSQL := FSQL + 'and Upper(p.nome) like :busca ';
      3: FSQL := FSQL + 'and Upper(cb.numero) = :busca ';
      4: FSQL := FSQL + 'and Upper(ban.nome) like :busca ';
      5: FSQL := FSQL + 'and Upper(bco.nome) like :busca ';
      6: FSQL := FSQL + 'and Upper(df.chave_pix) like :busca ';
      7: FSQL := FSQL + 'and Upper(f.nome) like :busca ';
    end;

    FSQL := FSQL +
            'order by d.data desc, d.hora desc';

    dmRelatorio.qryPadrao.SQL.Add(FSQL);
    dmRelatorio.qryPadrao.ParamByName('inicial').AsDate  := dInicial;
    dmRelatorio.qryPadrao.ParamByName('final').AsDate    := dFinal;
    dmRelatorio.qryPadrao.ParamByName('busca').AsString  := '%'+UpperCase(Busca)+'%';

    dmRelatorio.qryPadrao.Open;
    dmRelatorio.frReport.LoadFromFile(dmRelatorio.DiretorioRelatorios +
                                         'despesa_periodo.lrf');

    dmRelatorio.frReport.FindObject('mInformacao').Memo.Text := 'Período: '+
                                                   DateToStr(dInicial)+' à '+DateToStr(dFinal);
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

constructor TDespesaReport.Create;
begin
  dmRelatorio := TdmPadraoReport.Create(nil);
  FSQL := '';
end;

destructor TDespesaReport.Destroy;
begin
  FreeAndNil(dmRelatorio);
  inherited Destroy;
end;

end.

