unit controller.relatoriorecebimento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LR_View, ComCtrls, StdCtrls, model.report.recebimento,
  model.dao.padrao;

type

  { TRelatorioRecebimentoController }

  TRelatorioRecebimentoController = class
  private
    Relatorio: TRecebimentoReport;
  public
    {$Region 'Relatórios'}
    function DeclaracaoDeRenda(var Preview: TfrPreview; ano: Integer;
                          out Erro: String): Boolean;
    {$EndRegion}

    {$Region 'Buscas Filtros'}
    
    {$EndRegion}

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TRelatorioRecebimentoController }

function TRelatorioRecebimentoController.DeclaracaoDeRenda(var Preview: TfrPreview;
  ano: Integer; out Erro: String): Boolean;
begin
  Relatorio.dmRelatorio.frReport.Preview := Preview;
  Result := Relatorio.DeclaracaoDeRenda(ano, Erro);
end;

constructor TRelatorioRecebimentoController.Create;
begin
  Relatorio := TRecebimentoReport.Create;
end;

destructor TRelatorioRecebimentoController.Destroy;
begin
  FreeAndNil(Relatorio);
  inherited Destroy;
end;

end.
