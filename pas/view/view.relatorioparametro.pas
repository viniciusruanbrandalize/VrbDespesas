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
    cbPesquisa0: TComboBox;
    dtpInicial0: TDateTimePicker;
    dtpFinal0: TDateTimePicker;
    edtAnoFinal2: TSpinEdit;
    edtAnoInicial2: TSpinEdit;
    edtAno3: TSpinEdit;
    edtPesquisa0: TEdit;
    img: TImageList;
    lblAnoFinal2: TLabel;
    lblAnoInicial2: TLabel;
    lblAno3: TLabel;
    lblMes1: TLabel;
    lblAnoInicial1: TLabel;
    lblAnoFinal1: TLabel;
    lblPesquisa0: TLabel;
    lblDataInicial0: TLabel;
    lblDataFinal0: TLabel;
    lbPesquisaId0: TListBox;
    pnlFundo3: TPanel;
    pnlFundo2: TPanel;
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

procedure TfrmRelatorioParametro.cbTipo0Change(Sender: TObject);
var
  qtdRegistro: Integer;
begin
  edtPesquisa0.Clear;
  cbPesquisa0.Items.Clear;
  lbPesquisaId0.Items.Clear;

  cbPesquisa0.Left := edtPesquisa0.Left;
  cbPesquisa0.Top  := edtPesquisa0.Top;

  edtPesquisa0.Visible := False;

  case cbTipo0.ItemIndex of
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

  cbPesquisa0.Visible := (cbTipo0.ItemIndex in [7, 8, 9]);
end;

end.

