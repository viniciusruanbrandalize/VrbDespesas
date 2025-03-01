unit controller.relatoriodespesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.report.despesa;

type

  { TRelatorioDespesaController }

  TRelatorioDespesaController = class
  private
    Relatorio: TDespesaReport;
  public
    function PorPeriodo(dInicial, dFinal: TDate; Tipo: Integer; Busca: String; out Erro: String): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TRelatorioDespesaController }

function TRelatorioDespesaController.PorPeriodo(dInicial, dFinal: TDate;
  Tipo: Integer; Busca: String; out Erro: String): Boolean;
begin
  Result := Relatorio.PorPeriodo(dInicial, dFinal, Tipo, Busca, Erro);
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

