unit view.relatoriorecebimento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ActnList, ExtCtrls,
  view.relatoriopadrao, controller.relatoriorecebimento, view.relatorioparametro,
  view.mensagem;

type

  { TfrmRelatorioRecebimento }

  TfrmRelatorioRecebimento = class(TfrmRelatorioPadrao)
    actDeclaracaoRenda: TAction;
    pnlDeclaracaoRenda: TPanel;
    procedure actDeclaracaoRendaExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pnlDeclaracaoRendaClick(Sender: TObject);
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
end;

procedure TfrmRelatorioRecebimento.actDeclaracaoRendaExecute(Sender: TObject);
var
  Ano: Integer;
  Erro: String;
begin
  frmRelatorioParametro := TfrmRelatorioParametro.Create(Self);
  try
    frmRelatorioParametro.IndiceTab := 3;
    if frmRelatorioParametro.ShowModal = mrOK then
    begin
      Ano   := frmRelatorioParametro.edtAno3.Value;

      if Controller.DeclaracaoDeRenda(frPreview, Ano, Erro) then
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

procedure TfrmRelatorioRecebimento.FormCreate(Sender: TObject);
begin
  inherited;
  Controller := TRelatorioRecebimentoController.Create;
end;

procedure TfrmRelatorioRecebimento.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmRelatorioRecebimento.pnlDeclaracaoRendaClick(Sender: TObject);
begin
  actDeclaracaoRenda.Execute;
end;

end.

