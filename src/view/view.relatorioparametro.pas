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

unit view.relatorioparametro;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ActnList,
  Buttons, ComCtrls, StdCtrls, Spin, DateTimePicker, DateUtils;

type

  { TfrmRelatorioParametro }

  TfrmRelatorioParametro = class(TForm)
    actGerar: TAction;
    actCancelar: TAction;
    actList: TActionList;
    cbTipo4: TComboBox;
    cbTipoPesquisa0: TComboBox;
    cbMes1: TComboBox;
    cbPesquisa0: TComboBox;
    cbTipo2: TComboBox;
    cbTipo3: TComboBox;
    cbTipo1: TComboBox;
    cbTipoPesquisa5: TComboBox;
    dtpFinal5: TDateTimePicker;
    dtpFinal4: TDateTimePicker;
    dtpInicial0: TDateTimePicker;
    dtpFinal0: TDateTimePicker;
    dtpInicial5: TDateTimePicker;
    dtpInicial4: TDateTimePicker;
    edtAnoFinal2: TSpinEdit;
    edtAnoInicial2: TSpinEdit;
    edtAno3: TSpinEdit;
    edtPesquisa0: TEdit;
    edtPesquisa5: TEdit;
    img: TImageList;
    lblDataFinal5: TLabel;
    lblDataInicial5: TLabel;
    lblPesquisa5: TLabel;
    lblTipo2: TLabel;
    lblAnoFinal2: TLabel;
    lblAnoInicial2: TLabel;
    lblAno3: TLabel;
    lblDataFinal4: TLabel;
    lblDataInicial4: TLabel;
    lblMes1: TLabel;
    lblAnoInicial1: TLabel;
    lblAnoFinal1: TLabel;
    lblPesquisa0: TLabel;
    lblDataInicial0: TLabel;
    lblDataFinal0: TLabel;
    lblTipo3: TLabel;
    lblTipo1: TLabel;
    lblTipo4: TLabel;
    lbPesquisaId0: TListBox;
    pnlFundo5: TPanel;
    pnlFundo3: TPanel;
    pnlFundo2: TPanel;
    pnlFundo1: TPanel;
    pnlFundo0: TPanel;
    pgc: TPageControl;
    pnlFundo4: TPanel;
    pnlTitulo: TPanel;
    pnlBotoes: TPanel;
    pnlFundo: TPanel;
    btnGerar: TSpeedButton;
    btnCancelar: TSpeedButton;
    edtAnoInicial1: TSpinEdit;
    edtAnoFinal1: TSpinEdit;
    rgTipoRec3: TRadioGroup;
    rgTipoRec5: TRadioGroup;
    tbs6: TTabSheet;
    tbs7: TTabSheet;
    tbs8: TTabSheet;
    tbs2: TTabSheet;
    tbs1: TTabSheet;
    tbs3: TTabSheet;
    tbs4: TTabSheet;
    tbs5: TTabSheet;
    tbs0: TTabSheet;
    procedure actCancelarExecute(Sender: TObject);
    procedure actGerarExecute(Sender: TObject);
    procedure cbTipoPesquisa0Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FIndiceTab: Integer;
    procedure prepararTela();
  public
    property IndiceTab: Integer read FIndiceTab write FIndiceTab;
  end;

var
  frmRelatorioParametro: TfrmRelatorioParametro;

implementation

uses
  view.relatoriodespesa;

{$R *.lfm}

{ TfrmRelatorioParametro }

procedure TfrmRelatorioParametro.FormCreate(Sender: TObject);
begin
  pgc.ShowTabs        := False;
  pgc.Style           := tsButtons;
  FIndiceTab          := -1;
end;

procedure TfrmRelatorioParametro.FormShow(Sender: TObject);
begin
  prepararTela();
end;

procedure TfrmRelatorioParametro.prepararTela();
begin
  pgc.ActivePageIndex := FIndiceTab;
  case FIndiceTab of
    0:
    begin
      dtpFinal0.Date   := Now;
      dtpInicial0.Date := Now;
      edtPesquisa0.Clear;
      if dtpInicial0.CanFocus then
        dtpInicial0.SetFocus;
    end;
    1:
    begin
      edtAnoInicial1.Value := YearOf(Now);
      edtAnoFinal1.Value   := YearOf(Now);
    end;
    2:
    begin
      edtAnoInicial2.Value := YearOf(Now);
      edtAnoFinal2.Value   := YearOf(Now);
    end;
    3:
    Begin
      edtAno3.Value := YearOf(Now);
    end;
    4:
    begin
      dtpFinal4.Date   := Now;
      dtpInicial4.Date := Now;
      if dtpInicial4.CanFocus then
        dtpInicial4.SetFocus;
    end;
    5:
    begin
      dtpFinal5.Date   := Now;
      dtpInicial5.Date := Now;
      edtPesquisa5.Clear;
      if dtpInicial5.CanFocus then
        dtpInicial5.SetFocus;
    end;
  end;
end;

procedure TfrmRelatorioParametro.actCancelarExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmRelatorioParametro.actGerarExecute(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TfrmRelatorioParametro.cbTipoPesquisa0Change(Sender: TObject);
var
  qtdRegistro: Integer;
begin
  edtPesquisa0.Clear;
  cbPesquisa0.Items.Clear;
  lbPesquisaId0.Items.Clear;

  cbPesquisa0.Left := edtPesquisa0.Left;
  cbPesquisa0.Top  := edtPesquisa0.Top;

  edtPesquisa0.Visible := False;

  case cbTipoPesquisa0.ItemIndex of
    7:
    begin
      TfrmRelatorioDespesa(Self.Owner).Controller.PesquisarFormaPagamento(cbPesquisa0,
                                                    lbPesquisaId0, qtdRegistro);
    end;
    8:
    begin
      TfrmRelatorioDespesa(Self.Owner).Controller.PesquisarSubtipo(cbPesquisa0,
                                                    lbPesquisaId0, qtdRegistro);
    end;
    9:
    begin
      TfrmRelatorioDespesa(Self.Owner).Controller.PesquisarTipo(cbPesquisa0,
                                                    lbPesquisaId0, qtdRegistro);
    end
    else
    begin
      edtPesquisa0.Visible := True;
    end;
  end;

  if cbPesquisa0.Items.Count > 0 then
    cbPesquisa0.ItemIndex := 0;

  cbPesquisa0.Visible := (cbTipoPesquisa0.ItemIndex in [7, 8, 9]);
end;

end.

