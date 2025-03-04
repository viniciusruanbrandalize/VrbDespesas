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
    cbTipo0: TComboBox;
    cbMes1: TComboBox;
    dtpInicial0: TDateTimePicker;
    dtpFinal0: TDateTimePicker;
    edtPesquisa0: TEdit;
    img: TImageList;
    lblMes1: TLabel;
    lblAnoInicial1: TLabel;
    lblAnoFinal1: TLabel;
    lblPesquisa0: TLabel;
    lblDataInicial0: TLabel;
    lblDataFinal0: TLabel;
    pnlFundo1: TPanel;
    pnlFundo0: TPanel;
    pgc: TPageControl;
    pnlTitulo: TPanel;
    pnlBotoes: TPanel;
    pnlFundo: TPanel;
    btnGerar: TSpeedButton;
    btnCancelar: TSpeedButton;
    edtAnoInicial1: TSpinEdit;
    edtAnoFinal1: TSpinEdit;
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
    procedure cbTipo0Change(Sender: TObject);
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
  end;
end;

procedure TfrmRelatorioParametro.actCancelarExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmRelatorioParametro.actGerarExecute(Sender: TObject);
begin
  //a implementar...
  ModalResult := mrOK;
end;

procedure TfrmRelatorioParametro.cbTipo0Change(Sender: TObject);
begin
  edtPesquisa0.Clear;
end;

end.

