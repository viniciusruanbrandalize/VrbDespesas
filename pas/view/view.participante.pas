unit view.participante;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, view.cadastropadrao, lib.types, controller.participante,
  view.mensagem, LCLType, ActnList;

type

  { TfrmParticipante }

  TfrmParticipante = class(TfrmCadastroPadrao)
    actBuscarCep: TAction;
    cbPessoa: TComboBox;
    edtUf: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtIe: TLabeledEdit;
    edtTelefone: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtFantasia: TLabeledEdit;
    edtCnpj: TLabeledEdit;
    edtCelular: TLabeledEdit;
    edtEmail: TLabeledEdit;
    edtCep: TLabeledEdit;
    edtRua: TLabeledEdit;
    edtNumero: TLabeledEdit;
    edtComplemento: TLabeledEdit;
    edtBairro: TLabeledEdit;
    lblObs: TLabel;
    lblPessoa: TLabel;
    btnBuscaCep: TSpeedButton;
    lbPessoaValues: TListBox;
    lbCidadeId: TListBox;
    lbCidadeNome: TListBox;
    mObs: TMemo;
    procedure actBuscarCepExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure cbPessoaChange(Sender: TObject);
    procedure edtCidadeExit(Sender: TObject);
    procedure edtCidadeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbCidadeNomeDblClick(Sender: TObject);
    procedure lbCidadeNomeKeyPress(Sender: TObject; var Key: char);
    procedure lbCidadeNomeSelectionChange(Sender: TObject; User: boolean);
  private
    FEhDonoCadastro: Boolean;  {Abrir form de devedor/participantes}
    Controller: TParticipanteController;
    procedure SetEhDonoCadastro(AValue: Boolean);
  public
    procedure CarregarDados; override;
    procedure LimparCampos; override;
    procedure CarregarSelecionado; override;
    property EhDonoCadastro: Boolean read FEhDonoCadastro write SetEhDonoCadastro;
  end;

var
  frmParticipante: TfrmParticipante;

implementation

uses
  view.principal;

{$R *.lfm}

{ TfrmParticipante }

procedure TfrmParticipante.FormCreate(Sender: TObject);
begin
  inherited;
  Controller := TParticipanteController.Create;
end;

procedure TfrmParticipante.actSalvarExecute(Sender: TObject);
var
  erro: String;
begin
  if TfrmMessage.Mensagem('Deseja salvar ?', 'Aviso', 'Q', [mbNao, mbSim], mbNao) then
  begin

    Controller.Participante.Nome  := edtNome.Text;
    Controller.Participante.Pessoa := lbPessoaValues.Items[cbPessoa.ItemIndex];
    Controller.Participante.CNPJ   := edtCnpj.Text;
    if Trim( edtIe.Text ) <> EmptyStr then
      Controller.Participante.IE     := StrToInt(edtIe.Text)
    else
      Controller.Participante.IE     := 0;
    Controller.Participante.Fantasia := edtFantasia.Text;
    Controller.Participante.Telefone := edtTelefone.Text;
    Controller.Participante.Celular  := edtCelular.Text;
    Controller.Participante.Email    := edtEmail.Text;
    Controller.Participante.CEP      := edtCep.Text;
    Controller.Participante.Rua      := edtRua.Text;
    if Trim( edtNumero.Text ) <> EmptyStr then
      Controller.Participante.Numero   := StrToInt(edtNumero.Text)
    else
      Controller.Participante.Numero   := 0;
    Controller.Participante.Complemento := edtComplemento.Text;
    Controller.Participante.Bairro   := edtBairro.Text;
    Controller.Participante.Obs      := mObs.Lines.Text;
    Controller.Participante.EhDonoCadastro := False;

    if Operacao = opInserir then
    begin
      Controller.Participante.Cadastro := Now;
      if not Controller.Inserir(Controller.Participante, erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;
    if Operacao = opEditar then
    begin
      Controller.Participante.Alteracao := Now;
      if not Controller.Editar(Controller.Participante, erro) then
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;
    inherited;
  end;
end;

procedure TfrmParticipante.cbPessoaChange(Sender: TObject);
begin
  //
end;

procedure TfrmParticipante.edtCidadeExit(Sender: TObject);
begin
  if not lbCidadeNome.Focused then
  begin
    if lbCidadeNome.Visible then
      lbCidadeNome.Visible := false;
  end;
end;

procedure TfrmParticipante.edtCidadeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  qtdReg: Integer;
begin
  qtdReg := 0;
  if (Length(edtCidade.Text) > 3) then
  begin
    controller.PesquisarCidade(lbCidadeNome, lbCidadeId, edtCidade.Text, qtdReg);
    lbCidadeNome.Visible := qtdReg > 0;
    if Key = VK_DOWN then
    begin
      if lbCidadeNome.CanFocus then
        lbCidadeNome.SetFocus;
    end;
  end
  else
  begin
    lbCidadeNome.Items.Clear;
    lbCidadeNome.Visible := False;
  end;
end;

procedure TfrmParticipante.actExcluirExecute(Sender: TObject);
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

procedure TfrmParticipante.actBuscarCepExecute(Sender: TObject);
var
  Erro: string;
begin
  if Trim( edtCep.Text ) <> EmptyStr then
  begin
    Controller.Participante.CEP := edtCep.Text;
    if Controller.BuscarCEP(Controller.Participante, Erro) then
    begin
      edtCep.Text         := Controller.Participante.CEP;
      edtBairro.Text      := Controller.Participante.Bairro;
      edtRua.Text         := Controller.Participante.Rua;
      edtComplemento.Text := Controller.Participante.Complemento;
      edtCidade.Text      := Controller.Participante.Cidade.Nome;
      edtUf.Text          := Controller.Participante.Cidade.Estado.UF;
    end
    else
      TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
  end;
end;

procedure TfrmParticipante.actPesquisarExecute(Sender: TObject);
begin
  lvPadrao.Items.Clear;
  Controller.Pesquisar(lvPadrao, lbPesquisa.Items[cbPesquisa.ItemIndex],
                        edtPesquisa.Text, FEhDonoCadastro);
end;

procedure TfrmParticipante.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  TfrmPrincipal(Owner).BarraLateralVazia(TfrmPrincipal(Owner).pnlMenuCadastro, True);
  CloseAction := caFree;
end;

procedure TfrmParticipante.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmParticipante.FormShow(Sender: TObject);
begin
  LiberarBloquearAcessos(Self.actList, Self.Name);
  inherited;
end;

procedure TfrmParticipante.lbCidadeNomeDblClick(Sender: TObject);
begin
  if lbCidadeNome.ItemIndex <> -1 then
  begin
    edtCidade.Text := lbCidadeNome.Items[lbCidadeNome.ItemIndex];
    controller.Participante.Cidade.Id := StrToInt(lbCidadeId.Items[lbCidadeNome.ItemIndex]);
    lbCidadeNome.Visible := False;
  end
  else
  begin
    edtCidade.Text := '';
    controller.Participante.Cidade.Id := 0;
  end;
end;

procedure TfrmParticipante.lbCidadeNomeKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
  begin
    lbCidadeNome.OnDblClick(nil);
  end;
end;

procedure TfrmParticipante.lbCidadeNomeSelectionChange(Sender: TObject;
  User: boolean);
begin
  edtCidade.Text := lbcidadeNome.Items[lbCidadeNome.ItemIndex];
  //edtUf.Text     := Copy(edtCidade.Text, Pos(edtCidade.Text, '-'), Length(edtCidade.Text));
end;

procedure TfrmParticipante.SetEhDonoCadastro(AValue: Boolean);
begin
  if FEhDonoCadastro = AValue then
    Exit;
  FEhDonoCadastro := AValue;
end;

procedure TfrmParticipante.CarregarDados;
begin
  lvPadrao.Items.Clear;
  Controller.Listar(lvPadrao, FEhDonoCadastro);
end;

procedure TfrmParticipante.LimparCampos;
begin
  cbPessoa.ItemIndex := 0;
  edtCnpj.Clear;
  edtIe.Clear;
  edtNome.Clear;
  edtFantasia.Clear;
  edtTelefone.Clear;
  edtCelular.Clear;
  edtEmail.Clear;
  edtCep.Clear;
  edtRua.Clear;
  edtNumero.Clear;
  edtComplemento.Clear;
  edtBairro.Clear;
  edtCidade.Clear;
  edtUf.Clear;
  mObs.Lines.Clear;
end;

procedure TfrmParticipante.CarregarSelecionado;
var
  id: Integer;
  erro: String;
begin
  id := StrToInt(lvPadrao.Selected.Caption);
  if Controller.BuscarPorId(controller.Participante, id, erro) then
  begin
    cbPessoa.ItemIndex := lbPessoaValues.Items.IndexOf(Controller.Participante.Pessoa);
    edtCnpj.Text       := Controller.Participante.CNPJ;
    edtIe.Text         := Controller.Participante.IE.ToString;
    edtNome.Text       := Controller.Participante.Nome;
    edtFantasia.Text   := Controller.Participante.Fantasia;
    edtTelefone.Text   := Controller.Participante.Telefone;
    edtCelular.Text    := Controller.Participante.Celular;
    edtEmail.Text      := Controller.Participante.Email;
    edtCep.Text        := Controller.Participante.CEP;
    edtRua.Text        := Controller.Participante.Rua;
    edtNumero.Text     := Controller.Participante.Numero.ToString;
    edtComplemento.Text := Controller.Participante.Complemento;
    edtBairro.Text     := Controller.Participante.Bairro;
    edtCidade.Text     := Controller.Participante.Cidade.Nome;
    edtUf.Text         := Controller.Participante.Cidade.Estado.UF;
    mObs.Lines.Text    := Controller.Participante.Obs;
  end
  else
  begin
    TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    Abort;
  end;
end;

end.

