unit view.relatoriodespesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  ActnList, view.relatoriopadrao, lib.visual, view.relatorioparametro,
  controller.relatoriodespesa, view.mensagem;

type

  { TfrmRelatorioDespesa }

  TfrmRelatorioDespesa = class(TfrmRelatorioPadrao)
    actComparativoMensal: TAction;
    actPorPeriodo: TAction;
    pnlPeriodo: TPanel;
    pnlComparativoMensal: TPanel;
    procedure actComparativoMensalExecute(Sender: TObject);
    procedure actPorPeriodoExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pnlComparativoMensalClick(Sender: TObject);
    procedure pnlPeriodoClick(Sender: TObject);
  private
    Controller : TRelatorioDespesaController;
  public

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

procedure TfrmRelatorioDespesa.pnlComparativoMensalClick(Sender: TObject);
begin
  actComparativoMensal.Execute;
end;

procedure TfrmRelatorioDespesa.actPorPeriodoExecute(Sender: TObject);
var
  Inicial, Final: TDate;
  Tipo: Integer;
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
      Busca   := frmRelatorioParametro.edtPesquisa0.Text;
      if Controller.PorPeriodo(frPreview, Inicial, Final, Tipo, Busca, Erro) then
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

procedure TfrmRelatorioDespesa.pnlPeriodoClick(Sender: TObject);
begin
  actPorPeriodo.Execute;
end;

end.

