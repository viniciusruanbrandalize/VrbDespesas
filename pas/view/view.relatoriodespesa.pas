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
    actPorPeriodo: TAction;
    actPorSubtipo: TAction;
    actPorTipo: TAction;
    pnlPeriodo: TPanel;
    pnlSubtipo: TPanel;
    pnlTipo: TPanel;
    procedure actPorPeriodoExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
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
      if Controller.PorPeriodo(Inicial, Final, Tipo, Busca, Erro) then
        pgc.ActivePage := tbsDesigner
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

