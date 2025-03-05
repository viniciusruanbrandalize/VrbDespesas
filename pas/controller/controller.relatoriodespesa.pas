unit controller.relatoriodespesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LR_View, model.report.despesa;

type

  { TRelatorioDespesaController }

  TRelatorioDespesaController = class
  private
    Relatorio: TDespesaReport;
  public
    function PorPeriodo(var Preview: TfrPreview; dInicial, dFinal: TDate; Tipo: Integer;
                          Busca: String; out Erro: String): Boolean;
    function ComparativoMensal(var Preview: TfrPreview; anoInicial, anoFinal, mes: Integer;
                          out Erro: String): Boolean;
    function ComparativoAnual(var Preview: TfrPreview; anoInicial, anoFinal: Integer;
                          out Erro: String): Boolean;
    function TotalPorMes(var Preview: TfrPreview; ano: Integer; out Erro: String): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TRelatorioDespesaController }

function TRelatorioDespesaController.PorPeriodo(var Preview: TfrPreview;
  dInicial, dFinal: TDate; Tipo: Integer; Busca: String; out Erro: String): Boolean;
begin
  Relatorio.dmRelatorio.frReport.Preview := Preview;
  Result := Relatorio.PorPeriodo(dInicial, dFinal, Tipo, Busca, Erro);
end;

function TRelatorioDespesaController.ComparativoMensal(var Preview: TfrPreview;
  anoInicial, anoFinal, mes: Integer; out Erro: String): Boolean;
begin
  Relatorio.dmRelatorio.frReport.Preview := Preview;
  Result := Relatorio.ComparativoMensal(anoInicial, anoFinal, mes, Erro);
end;

function TRelatorioDespesaController.ComparativoAnual(var Preview: TfrPreview;
  anoInicial, anoFinal: Integer; out Erro: String): Boolean;
begin
  Relatorio.dmRelatorio.frReport.Preview := Preview;
  Result := Relatorio.ComparativoAnual(anoInicial, anoFinal, Erro);
end;

function TRelatorioDespesaController.TotalPorMes(var Preview: TfrPreview;
  ano: Integer; out Erro: String): Boolean;
begin
  Relatorio.dmRelatorio.frReport.Preview := Preview;
  Result := Relatorio.TotalPorMes(ano, Erro);
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

