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

unit view.relatoriodespesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  ActnList, view.relatoriopadrao, lib.visual, view.relatorioparametro,
  controller.relatoriodespesa, view.mensagem, TAGraph, TASeries, TACustomSource;

type

  { TfrmRelatorioDespesa }

  TfrmRelatorioDespesa = class(TfrmRelatorioPadrao)
    actComparativoMensal: TAction;
    actComparativoAnual: TAction;
    actTotalFPgto: TAction;
    actTotalTipo: TAction;
    actTotalSubtipo: TAction;
    actTotalPorMes: TAction;
    actPorPeriodo: TAction;
    chGraficoBarSeries1: TBarSeries;
    pnlComparativoAnual: TPanel;
    pnlTotalPorMes: TPanel;
    pnlPeriodo: TPanel;
    pnlComparativoMensal: TPanel;
    pnlTotalPorSubtipo: TPanel;
    pnlTotalPorSubtipo1: TPanel;
    pnlTotalPorFormaPgto: TPanel;
    procedure actComparativoAnualExecute(Sender: TObject);
    procedure actComparativoMensalExecute(Sender: TObject);
    procedure actPorPeriodoExecute(Sender: TObject);
    procedure actTotalFPgtoExecute(Sender: TObject);
    procedure actTotalPorMesExecute(Sender: TObject);
    procedure actTotalSubtipoExecute(Sender: TObject);
    procedure actTotalTipoExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlComparativoAnualClick(Sender: TObject);
    procedure pnlComparativoMensalClick(Sender: TObject);
    procedure pnlPeriodoClick(Sender: TObject);
    procedure pnlTotalPorFormaPgtoClick(Sender: TObject);
    procedure pnlTotalPorMesClick(Sender: TObject);
    procedure pnlTotalPorSubtipo1Click(Sender: TObject);
    procedure pnlTotalPorSubtipoClick(Sender: TObject);
  private

  public
    Controller : TRelatorioDespesaController;
  end;

var
  frmRelatorioDespesa: TfrmRelatorioDespesa;

implementation

uses
  view.principal;

{$R *.lfm}

{ TfrmRelatorioDespesa }

procedure TfrmRelatorioDespesa.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  TfrmPrincipal(Owner).BarraLateralVazia(TfrmPrincipal(Owner).pnlMenuRelatorio, True);
  CloseAction := caFree;
end;

procedure TfrmRelatorioDespesa.FormCreate(Sender: TObject);
begin
  inherited;
  Controller := TRelatorioDespesaController.Create;
end;

procedure TfrmRelatorioDespesa.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmRelatorioDespesa.FormShow(Sender: TObject);
begin
  LiberarBloquearAcessos(Self.actList, Self.Name);
  inherited;
end;

procedure TfrmRelatorioDespesa.pnlComparativoAnualClick(Sender: TObject);
begin
  actComparativoAnual.Execute;
end;

procedure TfrmRelatorioDespesa.pnlComparativoMensalClick(Sender: TObject);
begin
  actComparativoMensal.Execute;
end;

procedure TfrmRelatorioDespesa.actPorPeriodoExecute(Sender: TObject);
var
  Inicial, Final: TDate;
  Tipo, BuscaId: Integer;
  Busca, Erro: String;
begin
  frmRelatorioParametro := TfrmRelatorioParametro.Create(Self);
  try
    frmRelatorioParametro.IndiceTab := 0;
    if frmRelatorioParametro.ShowModal = mrOK then
    begin
      Inicial := frmRelatorioParametro.dtpInicial0.date;
      Final   := frmRelatorioParametro.dtpFinal0.date;
      Tipo    := frmRelatorioParametro.cbTipo0.ItemIndex;
      BuscaId := 0;

      if frmRelatorioParametro.cbPesquisa0.Items.Count > 0 then
      begin
        TryStrToInt(frmRelatorioParametro.lbPesquisaId0.Items[
                     frmRelatorioParametro.cbPesquisa0.ItemIndex], BuscaId);
      end;

      if BuscaId > 0 then
        Busca := frmRelatorioParametro.cbPesquisa0.Items[frmRelatorioParametro.cbPesquisa0.ItemIndex]
      else
        Busca := frmRelatorioParametro.edtPesquisa0.Text;

      if Controller.PorPeriodo(frPreview, Inicial, Final, Tipo, BuscaId, Busca, Erro) then
      begin
        pgc.ActivePage := tbsDesigner;
        actFechar.ImageIndex := 1;
      end
      else
        TfrmMessage.Mensagem(Erro, 'Erro', 'E', [mbOk]);
    end;
  finally
    FreeAndNil(frmRelatorioParametro);
  end;
end;

procedure TfrmRelatorioDespesa.actTotalFPgtoExecute(Sender: TObject);
var
  Inicial, Final: TDate;
  Erro: String;
begin
  frmRelatorioParametro := TfrmRelatorioParametro.Create(Self);
  try
    frmRelatorioParametro.IndiceTab := 4;
    if frmRelatorioParametro.ShowModal = mrOK then
    begin
      Inicial := frmRelatorioParametro.dtpInicial4.date;
      Final   := frmRelatorioParametro.dtpFinal4.date;

      if Controller.TotalPorFormaPgto(frPreview, Inicial, Final, Erro) then
      begin
        pgc.ActivePage := tbsDesigner;
        actFechar.ImageIndex := 1;
      end
      else
        TfrmMessage.Mensagem(Erro, 'Erro', 'E', [mbOk]);
    end;
  finally
    FreeAndNil(frmRelatorioParametro);
  end;
end;

procedure TfrmRelatorioDespesa.actTotalPorMesExecute(Sender: TObject);
var
  Ano: Integer;
  Erro: String;
begin
  frmRelatorioParametro := TfrmRelatorioParametro.Create(Self);
  try
    frmRelatorioParametro.IndiceTab := 3;
    if frmRelatorioParametro.ShowModal = mrOK then
    begin
      Ano := frmRelatorioParametro.edtAno3.Value;
      if Controller.TotalPorMes(frPreview, Ano, Erro) then
      begin
        pgc.ActivePage := tbsDesigner;
        actFechar.ImageIndex := 1;
      end
      else
        TfrmMessage.Mensagem(Erro, 'Erro', 'E', [mbOk]);
    end;
  finally
    FreeAndNil(frmRelatorioParametro);
  end;
end;

procedure TfrmRelatorioDespesa.actTotalSubtipoExecute(Sender: TObject);
var
  Inicial, Final: TDate;
  Erro: String;
begin
  frmRelatorioParametro := TfrmRelatorioParametro.Create(Self);
  try
    frmRelatorioParametro.IndiceTab := 4;
    if frmRelatorioParametro.ShowModal = mrOK then
    begin
      Inicial := frmRelatorioParametro.dtpInicial4.date;
      Final   := frmRelatorioParametro.dtpFinal4.date;

      if Controller.TotalPorSubtipo(frPreview, Inicial, Final, Erro) then
      begin
        pgc.ActivePage := tbsDesigner;
        actFechar.ImageIndex := 1;
      end
      else
        TfrmMessage.Mensagem(Erro, 'Erro', 'E', [mbOk]);
    end;
  finally
    FreeAndNil(frmRelatorioParametro);
  end;
end;

procedure TfrmRelatorioDespesa.actTotalTipoExecute(Sender: TObject);
var
  Inicial, Final: TDate;
  Erro: String;
begin
  frmRelatorioParametro := TfrmRelatorioParametro.Create(Self);
  try
    frmRelatorioParametro.IndiceTab := 4;
    if frmRelatorioParametro.ShowModal = mrOK then
    begin
      Inicial := frmRelatorioParametro.dtpInicial4.date;
      Final   := frmRelatorioParametro.dtpFinal4.date;

      if Controller.TotalPorTipo(frPreview, Inicial, Final, Erro) then
      begin
        pgc.ActivePage := tbsDesigner;
        actFechar.ImageIndex := 1;
      end
      else
        TfrmMessage.Mensagem(Erro, 'Erro', 'E', [mbOk]);
    end;
  finally
    FreeAndNil(frmRelatorioParametro);
  end;
end;

procedure TfrmRelatorioDespesa.actComparativoMensalExecute(Sender: TObject);
var
  Inicial, Final: Integer;
  Mes: Integer;
  Erro: String;
begin
  frmRelatorioParametro := TfrmRelatorioParametro.Create(Self);
  try
    frmRelatorioParametro.IndiceTab := 1;
    if frmRelatorioParametro.ShowModal = mrOK then
    begin
      Inicial := frmRelatorioParametro.edtAnoInicial1.Value;
      Final   := frmRelatorioParametro.edtAnoFinal1.Value;
      Mes     := frmRelatorioParametro.cbMes1.ItemIndex+1;
      if Controller.ComparativoMensal(frPreview, Inicial, Final, Mes, Erro) then
      begin
        pgc.ActivePage := tbsDesigner;
        actFechar.ImageIndex := 1;
      end
      else
        TfrmMessage.Mensagem(Erro, 'Erro', 'E', [mbOk]);
    end;
  finally
    FreeAndNil(frmRelatorioParametro);
  end;
end;

procedure TfrmRelatorioDespesa.actComparativoAnualExecute(Sender: TObject);
var
  Inicial, Final, Tipo: Integer;
  Erro: String;
begin
  frmRelatorioParametro := TfrmRelatorioParametro.Create(Self);
  try
    frmRelatorioParametro.IndiceTab := 2;
    if frmRelatorioParametro.ShowModal = mrOK then
    begin
      Inicial := frmRelatorioParametro.edtAnoInicial2.Value;
      Final   := frmRelatorioParametro.edtAnoFinal2.Value;
      Tipo    := frmRelatorioParametro.cbTipo2.ItemIndex;
      if Controller.ComparativoAnual(frPreview, chGrafico, Inicial, Final, Tipo, Erro) then
      begin
        if Tipo = 0 then
          pgc.ActivePage := tbsDesigner
        else
        begin
          chGrafico.Title.Text.Clear;
          chGrafico.Title.Text.Add('Comparativo Anual de '+Inicial.ToString+' à '+Final.ToString);
          chGrafico.AxisList.Axes[1].Title.Caption := 'Ano';
          chGrafico.AxisList.Axes[0].Title.Caption := 'Total (R$)';
          chGrafico.AxisList.Axes[1].Intervals.Options := [aipInteger, aipUseMaxLength, aipUseMinLength, aipUseNiceSteps];
          pgc.ActivePage := tbsGrafico;
        end;
        actFechar.ImageIndex := 1;
      end
      else
        TfrmMessage.Mensagem(Erro, 'Erro', 'E', [mbOk]);
    end;
  finally
    FreeAndNil(frmRelatorioParametro);
  end;
end;

procedure TfrmRelatorioDespesa.pnlPeriodoClick(Sender: TObject);
begin
  actPorPeriodo.Execute;
end;

procedure TfrmRelatorioDespesa.pnlTotalPorFormaPgtoClick(Sender: TObject);
begin
  actTotalFPgto.Execute;
end;

procedure TfrmRelatorioDespesa.pnlTotalPorMesClick(Sender: TObject);
begin
  actTotalPorMes.Execute;
end;

procedure TfrmRelatorioDespesa.pnlTotalPorSubtipo1Click(Sender: TObject);
begin
  actTotalTipo.Execute;
end;

procedure TfrmRelatorioDespesa.pnlTotalPorSubtipoClick(Sender: TObject);
begin
  actTotalSubtipo.Execute;
end;

end.

