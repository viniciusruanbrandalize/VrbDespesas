unit view.recebimento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, Calendar,
  StdCtrls, ExtCtrls, DateTimePicker, view.cadastropadrao,
  controller.recebimento, lib.types, view.mensagem, LCLType;

type

  { TfrmRecebimento }

  TfrmRecebimento = class(TfrmCadastroPadrao)
    calData: TCalendar;
    cbContaBancariaSal: TComboBox;
    cbContaBancariaRec: TComboBox;
    cbFormaPagamentoRec: TComboBox;
    cbPagadorSal: TComboBox;
    cbFormaPagamentoSal: TComboBox;
    cbPagadorRec: TComboBox;
    dtpData: TDateTimePicker;
    edtHE: TLabeledEdit;
    edt13: TLabeledEdit;
    edtValorBaseSal: TLabeledEdit;
    edtFerias: TLabeledEdit;
    edtValorTotalSal: TLabeledEdit;
    edtOutros: TLabeledEdit;
    gbDescontos: TGroupBox;
    edtINSS: TLabeledEdit;
    edtIR: TLabeledEdit;
    gbAdc: TGroupBox;
    gbTotal: TGroupBox;
    gbExtra: TGroupBox;
    edtDescricao: TLabeledEdit;
    edtValorTotalRec: TLabeledEdit;
    lblFormaPagamentoRec: TLabel;
    lblPagadorSal: TLabel;
    lblPagadorRec: TLabel;
    lblFormaPagamentoSal: TLabel;
    lbPagadorIdSal: TListBox;
    lbFormaPagamentoIdSal: TListBox;
    lbPagadorIdRec: TListBox;
    lbFormaPagamentoIdRec: TListBox;
    lblContaBancariaSal: TLabel;
    lblContaBancariaRec: TLabel;
    lblDataRec: TLabel;
    lblData: TLabel;
    lbContaBancariaSalId: TListBox;
    lbContaBancariaRecId: TListBox;
    pnlFundoRecGeral: TPanel;
    pgcCadastro: TPageControl;
    pnlFundoSalario: TPanel;
    rg13: TRadioGroup;
    rgFerias: TRadioGroup;
    tbsSalario: TTabSheet;
    tbsRecGeral: TTabSheet;
    procedure actEditarExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure actIncluirExecute(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure cbContaBancariaRecChange(Sender: TObject);
    procedure cbContaBancariaSalChange(Sender: TObject);
    procedure cbFormaPagamentoRecKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbFormaPagamentoRecSelect(Sender: TObject);
    procedure cbFormaPagamentoSalKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbFormaPagamentoSalSelect(Sender: TObject);
    procedure cbPagadorRecKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbPagadorRecSelect(Sender: TObject);
    procedure cbPagadorSalKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbPagadorSalSelect(Sender: TObject);
    procedure edtDescricaoChange(Sender: TObject);
    procedure edtDescricaoExit(Sender: TObject);
    procedure edtHEChange(Sender: TObject);
    procedure edtINSSChange(Sender: TObject);
    procedure edtIRChange(Sender: TObject);
    procedure edtOutrosChange(Sender: TObject);
    procedure edtValorBaseSalChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Controller: TRecebimentoController;
    FTipo: TTelaRecebimento;
    procedure AjustarListView();
    procedure AjustarCbLbPesquisa();
    procedure CalcularTotal();
  public
    procedure CarregarDados; override;
    procedure LimparCampos; override;
    procedure CarregarSelecionado; override;
    function CamposEstaoPreenchidos: Boolean; override;
    property Tipo: TTelaRecebimento read FTipo write FTipo;
  end;

var
  frmRecebimento: TfrmRecebimento;

implementation

uses
  view.principal;

{$R *.lfm}

{ TfrmRecebimento }

procedure TfrmRecebimento.actPesquisarExecute(Sender: TObject);
begin
  lvPadrao.Items.Clear;
  Controller.Pesquisar(lvPadrao, lbPesquisa.Items[cbPesquisa.ItemIndex], edtPesquisa.Text);
end;

procedure TfrmRecebimento.actSalvarExecute(Sender: TObject);
var
  erro: String;
  valor: Double;
begin
  if TfrmMessage.Mensagem('Deseja salvar ?', 'Aviso', 'Q', [mbNao, mbSim], mbNao) then
  begin

    case FTipo of
      telaSalario:
      begin
        Controller.Recebimento.Data := calData.DateTime;
        Controller.Recebimento.Tipo := 0;
        Controller.Recebimento.Descricao := 'Recebimento Salarial referente ao mês de '+
                                             FormatDateTime('mmmm/yyyy', Controller.Recebimento.Data);
        Controller.Recebimento.Ferias := rgFerias.ItemIndex = 0;
        Controller.Recebimento.DecimoTerceiro := rg13.ItemIndex = 0;
        if not TryStrToFloat(edtINSS.Text, valor) then
          valor := 0;
        Controller.Recebimento.INSS := valor;
        if not TryStrToFloat(edtIR.Text, valor) then
          valor := 0;
        Controller.Recebimento.IR := valor;
        if not TryStrToFloat(edtHE.Text, valor) then
          valor := 0;
        Controller.Recebimento.HoraExtra := valor;
        if not TryStrToFloat(edtOutros.Text, valor) then
          valor := 0;
        Controller.Recebimento.Antecipacao := valor;
        if not TryStrToFloat(edt13.Text, valor) then
          valor := 0;
        Controller.Recebimento.ValorDecimoTerceiro := valor;
        if not TryStrToFloat(edtFerias.Text, valor) then
          valor := 0;
        Controller.Recebimento.ValorFerias := valor;
        if not TryStrToFloat(edtValorBaseSal.Text, valor) then
          valor := 0;
        Controller.Recebimento.ValorBase := valor;
        if not TryStrToFloat(edtValorTotalSal.Text, valor) then
          valor := 0;
        Controller.Recebimento.ValorTotal := valor;
      end;
      telaGeral:
      begin
        Controller.Recebimento.Data := dtpData.Date;
        Controller.Recebimento.Tipo := 1;
        Controller.Recebimento.Descricao := edtDescricao.Text;
        if not TryStrToFloat(edtValorTotalRec.Text, valor) then
          valor := 0;
        Controller.Recebimento.ValorBase  := valor;
        Controller.Recebimento.ValorTotal := valor;
        Controller.Recebimento.Ferias         := False;
        Controller.Recebimento.DecimoTerceiro := False;
        Controller.Recebimento.INSS           := 0;
        Controller.Recebimento.IR             := 0;
        Controller.Recebimento.HoraExtra      := 0;
        Controller.Recebimento.Antecipacao    := 0;
        Controller.Recebimento.ValorDecimoTerceiro := 0;
        Controller.Recebimento.ValorFerias    := 0;
      end;
    end;

    if Operacao = opInserir then
    begin
      Controller.Recebimento.Cadastro := Now;
      if not Controller.Inserir(Controller.Recebimento, erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;
    if Operacao = opEditar then
    begin
      Controller.Recebimento.Alteracao := Now;
      if not Controller.Editar(Controller.Recebimento, erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;
    inherited;
  end;
end;

procedure TfrmRecebimento.cbContaBancariaRecChange(Sender: TObject);
var
  id: Integer;
begin
  if not TryStrToInt(lbContaBancariaRecId.Items[cbContaBancariaRec.ItemIndex], id) then
    Controller.Recebimento.ContaBancaria.Id := -1
  else
    Controller.Recebimento.ContaBancaria.Id := id;
end;

procedure TfrmRecebimento.cbContaBancariaSalChange(Sender: TObject);
var
  id: Integer;
begin
  if not TryStrToInt(lbContaBancariaSalId.Items[cbContaBancariaSal.ItemIndex], id) then
    Controller.Recebimento.ContaBancaria.Id := -1
  else
    Controller.Recebimento.ContaBancaria.Id := id;
end;

procedure TfrmRecebimento.cbFormaPagamentoRecKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  qtdReg: Integer;
begin
  qtdReg := 0;
  if not (key in [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT]) then
  begin
    if (Length((Sender as TComboBox).Text) >= 3) then
    begin
      controller.PesquisarFormaPagamento((Sender as TComboBox), lbFormaPagamentoIdRec, (Sender as TComboBox).Text, qtdReg);
      (Sender as TComboBox).DroppedDown := qtdReg > 1;
    end
    else
    begin
      (Sender as TComboBox).Items.Clear;
    end;
  end;
end;

procedure TfrmRecebimento.cbFormaPagamentoRecSelect(Sender: TObject);
begin
  if (Sender as TComboBox).ItemIndex <> -1 then
    controller.Recebimento.FormaPagamento.Id :=
      StrToInt(lbFormaPagamentoIdRec.Items[(Sender as TComboBox).ItemIndex]);
end;

procedure TfrmRecebimento.cbFormaPagamentoSalKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  qtdReg: Integer;
begin
  qtdReg := 0;
  if not (key in [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT]) then
  begin
    if (Length((Sender as TComboBox).Text) >= 3) then
    begin
      controller.PesquisarFormaPagamento((Sender as TComboBox), lbFormaPagamentoIdSal, (Sender as TComboBox).Text, qtdReg);
      (Sender as TComboBox).DroppedDown := qtdReg > 1;
    end
    else
    begin
      (Sender as TComboBox).Items.Clear;
    end;
  end;
end;

procedure TfrmRecebimento.cbFormaPagamentoSalSelect(Sender: TObject);
begin
  if (Sender as TComboBox).ItemIndex <> -1 then
    controller.Recebimento.FormaPagamento.Id :=
      StrToInt(lbFormaPagamentoIdSal.Items[(Sender as TComboBox).ItemIndex]);
end;

procedure TfrmRecebimento.cbPagadorRecKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  qtdReg: Integer;
begin
  qtdReg := 0;
  if not (key in [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT]) then
  begin
    if (Length((Sender as TComboBox).Text) >= 3) then
    begin
      controller.PesquisarPagador((Sender as TComboBox), lbPagadorIdRec, (Sender as TComboBox).Text, qtdReg);
      (Sender as TComboBox).DroppedDown := qtdReg > 1;
    end
    else
    begin
      (Sender as TComboBox).Items.Clear;
    end;
  end;
end;

procedure TfrmRecebimento.cbPagadorRecSelect(Sender: TObject);
begin
  if (Sender as TComboBox).ItemIndex <> -1 then
    controller.Recebimento.Pagador.Id :=
      StrToInt(lbPagadorIdRec.Items[(Sender as TComboBox).ItemIndex]);
end;

procedure TfrmRecebimento.cbPagadorSalKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  qtdReg: Integer;
begin
  qtdReg := 0;
  if not (key in [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT]) then
  begin
    if (Length((Sender as TComboBox).Text) >= 3) then
    begin
      controller.PesquisarPagador((Sender as TComboBox), lbPagadorIdSal, (Sender as TComboBox).Text, qtdReg);
      (Sender as TComboBox).DroppedDown := qtdReg > 1;
    end
    else
    begin
      (Sender as TComboBox).Items.Clear;
    end;
  end;
end;

procedure TfrmRecebimento.cbPagadorSalSelect(Sender: TObject);
begin
  if (Sender as TComboBox).ItemIndex <> -1 then
    controller.Recebimento.Pagador.Id :=
      StrToInt(lbPagadorIdSal.Items[(Sender as TComboBox).ItemIndex]);
end;

procedure TfrmRecebimento.edtDescricaoChange(Sender: TObject);
begin
  ValidarObrigatorioChange(Sender);
end;

procedure TfrmRecebimento.edtDescricaoExit(Sender: TObject);
begin
  ValidarObrigatorioExit(Sender);
end;

procedure TfrmRecebimento.edtHEChange(Sender: TObject);
begin
  CalcularTotal();
end;

procedure TfrmRecebimento.edtINSSChange(Sender: TObject);
begin
  CalcularTotal();
end;

procedure TfrmRecebimento.edtIRChange(Sender: TObject);
begin
  CalcularTotal();
end;

procedure TfrmRecebimento.edtOutrosChange(Sender: TObject);
begin
  CalcularTotal();
end;

procedure TfrmRecebimento.edtValorBaseSalChange(Sender: TObject);
begin
  CalcularTotal();
end;

procedure TfrmRecebimento.actIncluirExecute(Sender: TObject);
var
  qtd: Integer;
begin
  inherited;
  case FTipo of
    telaSalario:
    begin
      pgcCadastro.ActivePage := tbsSalario;
      controller.PesquisarContaBancaria(cbContaBancariaSal, lbContaBancariaSalId, qtd);
      lblContaBancariaSal.Visible := False;
      cbContaBancariaSal.Visible := False;
    end;
    telaGeral:
    begin
      pgcCadastro.ActivePage := tbsRecGeral;
      controller.PesquisarContaBancaria(cbContaBancariaRec, lbContaBancariaRecId, qtd);
      lblContaBancariaRec.Visible := False;
      cbContaBancariaRec.Visible := False;
    end;
  end;
end;

procedure TfrmRecebimento.actEditarExecute(Sender: TObject);
begin
  inherited;
  case FTipo of
    telaSalario: pgcCadastro.ActivePage := tbsSalario;
    telaGeral:   pgcCadastro.ActivePage := tbsRecGeral;
  end;
end;

procedure TfrmRecebimento.actExcluirExecute(Sender: TObject);
var
  erro: String;
  id: Integer;
begin
  if TfrmMessage.Mensagem('Deseja excluir o item selecionado ?', 'Aviso', 'D',
                           [mbNao, mbSim], mbNao) then
  begin
    id := StrToInt(lvPadrao.Selected.Caption);
    if Controller.Excluir(id, erro) then
      inherited
    else
      TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    Operacao := opNenhum;
  end;
end;

procedure TfrmRecebimento.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  TfrmPrincipal(Owner).BarraLateralVazia(TfrmPrincipal(Owner).pnlMenuOperacao, True);
  CloseAction := caFree;
end;

procedure TfrmRecebimento.FormCreate(Sender: TObject);
begin
  inherited;
  Controller := TRecebimentoController.Create;
  AjustarCbLbPesquisa();
  pgcCadastro.ShowTabs := False;
  pgcCadastro.Style    := tsButtons;
  edtINSS.OnExit       := @NumericoExit;
  edtINSS.OnEnter      := @NumericoEnter;
  edtINSS.OnKeyPress   := @NumericoKeyPress;
  edtIR.OnExit         := @NumericoExit;
  edtIR.OnEnter        := @NumericoEnter;
  edtIR.OnKeyPress     := @NumericoKeyPress;
  edtHE.OnExit         := @NumericoExit;
  edtHE.OnEnter        := @NumericoEnter;
  edtHE.OnKeyPress     := @NumericoKeyPress;
  edtOutros.OnExit     := @NumericoExit;
  edtOutros.OnEnter    := @NumericoEnter;
  edtOutros.OnKeyPress := @NumericoKeyPress;
  edt13.OnExit         := @NumericoExit;
  edt13.OnEnter        := @NumericoEnter;
  edt13.OnKeyPress     := @NumericoKeyPress;
  edtFerias.OnExit     := @NumericoExit;
  edtFerias.OnEnter    := @NumericoEnter;
  edtFerias.OnKeyPress := @NumericoKeyPress;
  edtValorBaseSal.OnExit      := @NumericoExit;
  edtValorBaseSal.OnEnter     := @NumericoEnter;
  edtValorBaseSal.OnKeyPress  := @NumericoKeyPress;
  edtValorTotalSal.OnExit     := @NumericoExit;
  edtValorTotalSal.OnEnter    := @NumericoEnter;
  edtValorTotalSal.OnKeyPress := @NumericoKeyPress;
  edtValorTotalRec.OnExit     := @NumericoExit;
  edtValorTotalRec.OnEnter    := @NumericoEnter;
  edtValorTotalRec.OnKeyPress := @NumericoKeyPress;
end;

procedure TfrmRecebimento.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmRecebimento.FormShow(Sender: TObject);
begin
  LiberarBloquearAcessos(Self.actList, Self.Name);
  AjustarListView();
  inherited;
end;

procedure TfrmRecebimento.AjustarListView();
var
  coluna: TListColumn;
begin

  coluna := lvPadrao.Columns.Add;
  coluna.Caption   := 'Código';
  coluna.Width     := 0;
  coluna.Alignment := taLeftJustify;

  coluna := lvPadrao.Columns.Add;
  coluna.Caption   := 'Data';
  coluna.Width     := 80;
  coluna.Alignment := taLeftJustify;

  coluna := lvPadrao.Columns.Add;
  coluna.Caption := 'Pagador';
  coluna.Width   := 250;
  coluna.Alignment := taLeftJustify;

  case FTipo of
    telaSalario:
    begin

      coluna := lvPadrao.Columns.Add;
      coluna.Caption   := 'Hora Extra (R$)';
      coluna.Width     := 100;
      coluna.Alignment := taRightJustify;

      coluna := lvPadrao.Columns.Add;
      coluna.Caption   := 'INSS (R$)';
      coluna.Width     := 100;
      coluna.Alignment := taRightJustify;

      coluna := lvPadrao.Columns.Add;
      coluna.Caption   := 'IR (R$)';
      coluna.Width     := 100;
      coluna.Alignment := taRightJustify;

      coluna := lvPadrao.Columns.Add;
      coluna.Caption   := 'Valor Base (R$)';
      coluna.Width     := 150;
      coluna.Alignment := taRightJustify;

    end;
    telaGeral:
    begin
      coluna := lvPadrao.Columns.Add;
      coluna.Caption   := 'Descrição';
      coluna.Width     := 450;
      coluna.Alignment := taLeftJustify;
    end;
  end;

  coluna := lvPadrao.Columns.Add;
  coluna.Caption   := 'Total (R$)';
  coluna.Width     := 150;
  coluna.Alignment := taRightJustify;

end;

procedure TfrmRecebimento.AjustarCbLbPesquisa();
begin
  case FTipo of
    telaSalario:
    begin
      //lbPesquisa.Items.Clear;
      //cbPesquisa.Items.Clear;
      //cbPesquisa.Items.Add('');
      //lbPesquisa.Items.Add('');
    end;
    telaGeral:
    begin
      //
    end;
  end;
end;

procedure TfrmRecebimento.CalcularTotal();
var
  inss, ir, outros, he, base, total: Double;
begin
  if not TryStrToFloat(edtINSS.Text, inss) then
    inss := 0;
  if not TryStrToFloat(edtIR.Text, ir) then
    ir := 0;
  if not TryStrToFloat(edtOutros.Text, outros) then
    outros := 0;
  if not TryStrToFloat(edtHE.Text, he) then
    he := 0;
  if not TryStrToFloat(edtValorBaseSal.Text, base) then
    base := 0;
  total := Controller.CalcularValorTotal(inss, ir, he, outros, base);
  edtValorTotalSal.Text := FormatFloat(',#0.00', total);
end;

procedure TfrmRecebimento.CarregarDados;
begin
  lvPadrao.Items.Clear;
  case FTipo of
    telaSalario: Controller.Listar(lvPadrao, 0);
    telaGeral:   Controller.Listar(lvPadrao, 1);
  end;
end;

procedure TfrmRecebimento.LimparCampos;
begin
  calData.DateTime      := Now;
  rgFerias.ItemIndex    := 1;
  rg13.ItemIndex        := 1;
  edtINSS.Text          := '0,00';
  edtIR.Text            := '0,00';
  edtHE.Text            := '0,00';
  edtOutros.Text        := '0,00';
  edt13.Text            := '0,00';
  edtFerias.Text        := '0,00';
  edtValorBaseSal.Text  := '0,00';
  edtValorTotalSal.Text := '0,00';
  cbPagadorSal.Clear;
  cbPagadorSal.Items.Clear;
  cbFormaPagamentoSal.Clear;
  cbFormaPagamentoSal.Items.Clear;
  cbContaBancariaSal.Items.Clear;
  dtpData.Date          := now;
  edtDescricao.Clear;
  cbPagadorRec.Clear;
  cbPagadorRec.Items.Clear;
  cbFormaPagamentoRec.Clear;
  cbFormaPagamentoRec.Items.Clear;
  edtValorTotalRec.Text := '0,00';
  cbContaBancariaRec.Items.Clear;
end;

procedure TfrmRecebimento.CarregarSelecionado;
var
  id, qtd: Integer;
  erro: String;
begin
  id := StrToInt(lvPadrao.Selected.Caption);
  if Controller.BuscarPorId(controller.Recebimento, id, erro) then
  begin
    if FTipo = telaSalario then
    begin
      calData.DateTime := controller.Recebimento.Data;
      if Controller.Recebimento.Ferias then
        rgFerias.ItemIndex := 0
      else
        rgFerias.ItemIndex := 1;
      if Controller.Recebimento.DecimoTerceiro then
        rg13.ItemIndex := 0
      else
        rg13.ItemIndex := 1;
      edtINSS.Text   := FormatFloat(',#0.00', Controller.Recebimento.INSS);
      edtIR.Text     := FormatFloat(',#0.00', Controller.Recebimento.IR);
      edtHE.Text     := FormatFloat(',#0.00', Controller.Recebimento.HoraExtra);
      edtOutros.Text := FormatFloat(',#0.00', Controller.Recebimento.Antecipacao);
      edt13.Text     := FormatFloat(',#0.00', Controller.Recebimento.ValorDecimoTerceiro);
      edtFerias.Text := FormatFloat(',#0.00', Controller.Recebimento.ValorFerias);
      edtValorBaseSal.Text  := FormatFloat(',#0.00', Controller.Recebimento.ValorBase);
      edtValorTotalSal.Text := FormatFloat(',#0.00', Controller.Recebimento.ValorTotal);
      cbPagadorSal.Text := Controller.Recebimento.Pagador.Nome;
      cbFormaPagamentoSal.Text := Controller.Recebimento.FormaPagamento.Nome;
      cbContaBancariaSal.Visible := Controller.Recebimento.FormaPagamento.Id in [4, 5, 6, 7];
      lblContaBancariaSal.Visible := Controller.Recebimento.FormaPagamento.Id in [4, 5, 6, 7];
      if cbContaBancariaSal.Visible then
      begin
        controller.PesquisarContaBancaria(cbContaBancariaSal, lbContaBancariaSalId, qtd);
        cbContaBancariaSal.ItemIndex := lbContaBancariaSalId.Items.IndexOf(
                                         Controller.Recebimento.ContaBancaria.Id.ToString);
      end;
    end
    else
    if FTipo = telaGeral then
    begin
      dtpData.Date       := Controller.Recebimento.Data;
      edtDescricao.Text  := Controller.Recebimento.Descricao;
      cbPagadorRec.Text  := Controller.Recebimento.Pagador.Nome;
      cbFormaPagamentoRec.Text := Controller.Recebimento.FormaPagamento.Nome;
      edtValorTotalRec.Text     := FormatFloat(',#0.00', Controller.Recebimento.ValorTotal);
      cbContaBancariaRec.Visible := Controller.Recebimento.FormaPagamento.Id in [4, 5, 6, 7];
      lblContaBancariaRec.Visible := Controller.Recebimento.FormaPagamento.Id in [4, 5, 6, 7];
      if cbContaBancariaRec.Visible then
      begin
        controller.PesquisarContaBancaria(cbContaBancariaRec, lbContaBancariaRecId, qtd);
        cbContaBancariaRec.ItemIndex := lbContaBancariaRecId.Items.IndexOf(
                                         Controller.Recebimento.ContaBancaria.Id.ToString);
      end;
    end;
  end
  else
  begin
    TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    Abort;
  end;
end;

function TfrmRecebimento.CamposEstaoPreenchidos: Boolean;
begin
  Result := False;
  case FTipo of
    telaSalario:
    begin
      if cbPagadorSal.ItemIndex = -1 then
        ValidarObrigatorioExit(cbPagadorSal)
      else
      if cbFormaPagamentoSal.ItemIndex = -1 then
        ValidarObrigatorioExit(cbFormaPagamentoSal)
      else
        Result := True;
    end;
    telaGeral:
    begin
      if Trim(edtDescricao.Text) = EmptyStr then
        ValidarObrigatorioExit(edtDescricao)
      else
      if cbPagadorRec.ItemIndex = -1 then
        ValidarObrigatorioExit(cbPagadorRec)
      else
      if cbFormaPagamentoRec.ItemIndex = -1 then
        ValidarObrigatorioExit(cbFormaPagamentoRec)
      else
        Result := True;
    end;
  end;
end;

end.

