unit controller.relatoriodespesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LR_View, ComCtrls, StdCtrls, model.report.despesa,
  model.dao.padrao;

type

  { TRelatorioDespesaController }

  TRelatorioDespesaController = class
  private
    Relatorio: TDespesaReport;
  public
    {$Region 'Relatórios'}
    function PorPeriodo(var Preview: TfrPreview; dInicial, dFinal: TDate; Tipo, BuscaId: Integer;
                          Busca: String; out Erro: String): Boolean;
    function ComparativoMensal(var Preview: TfrPreview; anoInicial, anoFinal, mes: Integer;
                          out Erro: String): Boolean;
    function ComparativoAnual(var Preview: TfrPreview; anoInicial, anoFinal: Integer;
                          out Erro: String): Boolean;
    function TotalPorMes(var Preview: TfrPreview; ano: Integer; out Erro: String): Boolean;
    {$EndRegion}

    {$Region 'Buscas Filtros'}
    procedure PesquisarSubtipo(CbNome: TComboBox; lbId: TListBox; out QtdRegistro: Integer);
    procedure PesquisarTipo(CbNome: TComboBox; lbId: TListBox; out QtdRegistro: Integer);
    procedure PesquisarFormaPagamento(CbNome: TComboBox; lbId: TListBox; out QtdRegistro: Integer);
    {$EndRegion}

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TRelatorioDespesaController }

function TRelatorioDespesaController.PorPeriodo(var Preview: TfrPreview;
  dInicial, dFinal: TDate; Tipo, BuscaId: Integer; Busca: String; out Erro: String): Boolean;
begin
  Relatorio.dmRelatorio.frReport.Preview := Preview;
  Result := Relatorio.PorPeriodo(dInicial, dFinal, Tipo, BuscaId, Busca, Erro);
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

procedure TRelatorioDespesaController.PesquisarSubtipo(CbNome: TComboBox;
  lbId: TListBox; out QtdRegistro: Integer);
begin
  Relatorio.PesquisaGenerica(TB_SUBTIPO_DESPESA, CbNome, lbId, '', -1, QtdRegistro);
end;

procedure TRelatorioDespesaController.PesquisarTipo(CbNome: TComboBox;
  lbId: TListBox; out QtdRegistro: Integer);
begin
  Relatorio.PesquisaGenerica(TB_TIPO_DESPESA, CbNome, lbId, '', -1, QtdRegistro);
end;

procedure TRelatorioDespesaController.PesquisarFormaPagamento(
  CbNome: TComboBox; lbId: TListBox; out QtdRegistro: Integer);
begin
  Relatorio.PesquisaGenerica(TB_FORMA_PGTO, CbNome, lbId, '', -1, QtdRegistro);
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

