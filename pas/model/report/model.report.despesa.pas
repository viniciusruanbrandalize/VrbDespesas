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
            'where d.data between :inicial and :final ';

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
        FSQL := FSQL + 'and Upper(f.nome) like :busca ';
        TipoDeBusca := 'Forma de Pagamento';
      end;
      8:
      begin
        FSQL := FSQL + 'and Upper(sd.nome) like :busca ';
        TipoDeBusca := 'Subtipo de despesa';
      end;
      9:
      begin
        FSQL := FSQL + 'and Upper(td.nome) like :busca ';
        TipoDeBusca := 'Tipo de despesa';
      end;
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

