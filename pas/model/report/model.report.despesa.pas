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
            'where d.data between :inicial and :final ';

    dmPadraoReport.qryPadrao.Close;
    dmPadraoReport.qryPadrao.SQL.Clear;

    case Tipo of
      0:
      begin
        FSQL := FSQL +
                'and d.id = :id ';
        dmPadraoReport.qryPadrao.ParamByName('id').AsString := Busca;
      end;
    end;

    FSQL := FSQL +
            'order by d.data desc, d.hora desc';

    dmPadraoReport.qryPadrao.ParamByName('inicial').AsDate := dInicial;
    dmPadraoReport.qryPadrao.ParamByName('final').AsDate   := dFinal;

    dmPadraoReport.qryPadrao.SQL.Add(FSQL);
    dmPadraoReport.qryPadrao.Open;

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
  dmPadraoReport := TdmPadraoReport.Create(nil);
  FSQL := '';
end;

destructor TDespesaReport.Destroy;
begin
  FreeAndNil(dmPadraoReport);
  inherited Destroy;
end;

end.

