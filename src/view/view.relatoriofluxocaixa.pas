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

unit view.relatoriofluxocaixa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ActnList,
  view.relatoriopadrao, view.relatorioparametro, view.mensagem,
  view.carregamento, controller.relatoriofluxocaixa;

type

  { TfrmRelatorioFluxoCaixa }

  TfrmRelatorioFluxoCaixa = class(TfrmRelatorioPadrao)
    actPorPeriodo: TAction;
    pnlPorPeriodo: TPanel;
    procedure actPorPeriodoExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlPorPeriodoClick(Sender: TObject);
  private

  public
    Controller: TRelatorioFluxoCaixaController;
  end;

var
  frmRelatorioFluxoCaixa: TfrmRelatorioFluxoCaixa;

implementation

uses
  view.principal;

{$R *.lfm}

{ TfrmRelatorioFluxoCaixa }

procedure TfrmRelatorioFluxoCaixa.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  TfrmPrincipal(Owner).BarraLateralVazia(TfrmPrincipal(Owner).pnlMenuRelatorio, True);
  CloseAction := caFree;
end;

procedure TfrmRelatorioFluxoCaixa.actPorPeriodoExecute(Sender: TObject);
var
  DataInicial, DataFinal: TDate;
  Erro: String;
begin
  frmRelatorioParametro := TfrmRelatorioParametro.Create(Self);
  try
    frmRelatorioParametro.IndiceTab := 4;
    frmRelatorioParametro.cbTipo4.Visible  := False;
    frmRelatorioParametro.lblTipo4.Visible := False;
    if frmRelatorioParametro.ShowModal = mrOK then
    begin
      DataInicial := frmRelatorioParametro.dtpInicial4.Date;
      DataFinal   := frmRelatorioParametro.dtpFinal4.Date;
      TfrmCarregamento.Carregar('Gerando relatório...', 'Gerando Relatório');
      try
        if Controller.PorPeriodo(frPreview, DataInicial, DataFinal, Erro) then
        begin
          pgc.ActivePage := tbsDesigner;
          actFechar.ImageIndex := 1;
        end
        else
          TfrmMessage.Mensagem(Erro, 'Erro', 'E', [mbOk]);
      finally
        TfrmCarregamento.Destruir();
      end;
    end;
  finally
    FreeAndNil(frmRelatorioParametro);
  end;
end;

procedure TfrmRelatorioFluxoCaixa.FormCreate(Sender: TObject);
begin
  inherited;
  Controller := TRelatorioFluxoCaixaController.Create;
end;

procedure TfrmRelatorioFluxoCaixa.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmRelatorioFluxoCaixa.FormShow(Sender: TObject);
begin
  LiberarBloquearAcessos(Self.actList, Self.Name);
  inherited;
end;

procedure TfrmRelatorioFluxoCaixa.pnlPorPeriodoClick(Sender: TObject);
begin
  actPorPeriodo.Execute;
end;

end.

