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

unit view.relatoriorecebimento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ActnList, ExtCtrls,
  view.relatoriopadrao, controller.relatoriorecebimento, view.relatorioparametro,
  view.mensagem, view.carregamento;

type

  { TfrmRelatorioRecebimento }

  TfrmRelatorioRecebimento = class(TfrmRelatorioPadrao)
    actDeclaracaoRenda: TAction;
    actPorPeriodoSalario: TAction;
    actPorPeriodo: TAction;
    pnlPorPeriodo: TPanel;
    pnlDeclaracaoRenda: TPanel;
    pnlPorPeriodoSalario: TPanel;
    procedure actDeclaracaoRendaExecute(Sender: TObject);
    procedure actPorPeriodoExecute(Sender: TObject);
    procedure actPorPeriodoSalarioExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlDeclaracaoRendaClick(Sender: TObject);
    procedure pnlPorPeriodoClick(Sender: TObject);
    procedure pnlPorPeriodoSalarioClick(Sender: TObject);
  private

  public
    Controller : TRelatorioRecebimentoController;
  end;

var
  frmRelatorioRecebimento: TfrmRelatorioRecebimento;

implementation

uses
  view.principal;

{$R *.lfm}

{ TfrmRelatorioRecebimento }

procedure TfrmRelatorioRecebimento.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  TfrmPrincipal(Owner).BarraLateralVazia(TfrmPrincipal(Owner).pnlMenuRelatorio, True);
  CloseAction := caFree;
end;

procedure TfrmRelatorioRecebimento.actDeclaracaoRendaExecute(Sender: TObject);
var
  Ano, TipoRece: Integer;
  Erro: String;
begin
  frmRelatorioParametro := TfrmRelatorioParametro.Create(Self);
  try
    frmRelatorioParametro.IndiceTab := 3;
    frmRelatorioParametro.cbTipo3.Visible  := False;
    frmRelatorioParametro.lblTipo3.Visible := False;
    frmRelatorioParametro.rgTipoRec3.Visible := True;
    if frmRelatorioParametro.ShowModal = mrOK then
    begin
      Ano   := frmRelatorioParametro.edtAno3.Value;
      TipoRece := frmRelatorioParametro.rgTipoRec3.ItemIndex;
      TfrmCarregamento.Carregar('Gerando relatório...', 'Gerando Relatório');
      try
        if Controller.DeclaracaoDeRenda(frPreview, Ano, TipoRece, Erro) then
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

procedure TfrmRelatorioRecebimento.actPorPeriodoExecute(Sender: TObject);
var
  Tipo, TipoRece: Integer;
  DataInicial, DataFinal: TDate;
  Erro, Busca: String;
begin
  frmRelatorioParametro := TfrmRelatorioParametro.Create(Self);
  try
    frmRelatorioParametro.IndiceTab := 5;
    if frmRelatorioParametro.ShowModal = mrOK then
    begin
      DataInicial := frmRelatorioParametro.dtpInicial5.Date;
      DataFinal   := frmRelatorioParametro.dtpFinal5.Date;
      TipoRece    := frmRelatorioParametro.rgTipoRec5.ItemIndex;
      Tipo        := frmRelatorioParametro.cbTipoPesquisa5.ItemIndex;
      Busca       := frmRelatorioParametro.edtPesquisa5.Text;
      TfrmCarregamento.Carregar('Gerando relatório...', 'Gerando Relatório');
      try
        if Controller.PorPeriodo(frPreview, DataInicial, DataFinal, Busca, Tipo, TipoRece, Erro) then
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

procedure TfrmRelatorioRecebimento.actPorPeriodoSalarioExecute(Sender: TObject);
var
  DataInicial, DataFinal: TDate;
  Erro: String;
begin
  frmRelatorioParametro := TfrmRelatorioParametro.Create(Self);
  try
    frmRelatorioParametro.IndiceTab := 4;
    frmRelatorioParametro.lblTipo4.Visible := False;
    frmRelatorioParametro.cbTipo4.Visible  := False;
    if frmRelatorioParametro.ShowModal = mrOK then
    begin
      DataInicial := frmRelatorioParametro.dtpInicial4.Date;
      DataFinal   := frmRelatorioParametro.dtpFinal4.Date;
      TfrmCarregamento.Carregar('Gerando relatório...', 'Gerando Relatório');
      try
        if Controller.PorPeriodoSalario(frPreview, DataInicial, DataFinal, Erro) then
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

procedure TfrmRelatorioRecebimento.FormCreate(Sender: TObject);
begin
  inherited;
  Controller := TRelatorioRecebimentoController.Create;
end;

procedure TfrmRelatorioRecebimento.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmRelatorioRecebimento.FormShow(Sender: TObject);
begin
  LiberarBloquearAcessos(Self.actList, Self.Name);
  inherited;
end;

procedure TfrmRelatorioRecebimento.pnlDeclaracaoRendaClick(Sender: TObject);
begin
  actDeclaracaoRenda.Execute;
end;

procedure TfrmRelatorioRecebimento.pnlPorPeriodoClick(Sender: TObject);
begin
  actPorPeriodo.Execute;
end;

procedure TfrmRelatorioRecebimento.pnlPorPeriodoSalarioClick(Sender: TObject);
begin
  actPorPeriodoSalario.Execute;
end;

end.

