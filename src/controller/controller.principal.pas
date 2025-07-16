unit controller.principal;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, controls, controller.erro, lib.util, lib.types,
  model.connection.conexao1, model.connection.conexao2, view.participante,
  view.recebimento, model.dao.configuracao, model.entity.configuracao,
  lib.version;

type

  { TPrincipalController }

  TPrincipalController = class
  private
    ControllerErro: TErroController;
  public
    procedure TratarErros(Sender: TObject; E: Exception);
    procedure AbrirTela(Formulario: TForm; ClasseForm: TFormClass; Modal: Boolean; AParent: TWinControl; FormularioPai: TForm);
    procedure AbrirTelaParticipante(Formulario: TfrmParticipante; AParent: TWinControl; FormularioPai: TForm; DonoCadastro: Boolean);
    procedure AbrirTelaRecebimento(Formulario: TfrmRecebimento; AParent: TWinControl; FormularioPai: TForm; Tipo: TTelaRecebimento);
    function RetornarNomeUsuario: String;
    function RetornarVersao: String;
    function TestarConexao: Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TPrincipalController }

procedure TPrincipalController.TratarErros(Sender: TObject; E: Exception);
begin
  ControllerErro.TrataException(Sender, E);
end;

procedure TPrincipalController.AbrirTela(Formulario: TForm; ClasseForm: TFormClass;
  Modal: Boolean; AParent: TWinControl; FormularioPai: TForm);
begin
  CriarForm(Formulario, ClasseForm, Modal, AParent, FormularioPai);
end;

procedure TPrincipalController.AbrirTelaParticipante(
  Formulario: TfrmParticipante; AParent: TWinControl; FormularioPai: TForm;
  DonoCadastro: Boolean);
begin
  Formulario := TfrmParticipante.Create(FormularioPai);
  Formulario.EhDonoCadastro := DonoCadastro;
  if AParent <> nil then
  begin
    Formulario.Parent := AParent;
    Formulario.Align  := alClient;
  end;
  Formulario.Show;
end;

procedure TPrincipalController.AbrirTelaRecebimento(
  Formulario: TfrmRecebimento; AParent: TWinControl; FormularioPai: TForm;
  Tipo: TTelaRecebimento);
begin
  Formulario := TfrmRecebimento.Create(FormularioPai);
  Formulario.Tipo := Tipo;
  if AParent <> nil then
  begin
    Formulario.Parent := AParent;
    Formulario.Align  := alClient;
  end;
  Formulario.Show;
end;

function TPrincipalController.RetornarNomeUsuario: String;
begin
  Result := dmConexao1.Usuario.Nome;
end;

function TPrincipalController.RetornarVersao: String;
var
  Erro,
  Versao: String;
  Conf: TConfiguracao;
  ConfDao: TConfiguracaoDAO;
begin
  Conf := TConfiguracao.Create;
  try
    ConfDAO := TConfiguracaoDAO.Create;
    try
      {if ConfDAO.BuscarPorNome(Conf, 'NUMERO_VERSAO', Erro) then
        Versao := Conf.Valor;
      if ConfDAO.BuscarPorNome(Conf, 'DATA_VERSAO', Erro) then
        Versao := Versao +' '+ Conf.Valor;}
      Versao := NUMERO_VERSAO;
      Result := Versao;
    finally
      FreeAndNil(ConfDAO);
    end;
  finally
    FreeAndNil(Conf);
  end;
end;

function TPrincipalController.TestarConexao: Boolean;
begin
  dmConexao1.TestarConexao;
  dmConexao2.TestarConexao;
  Result := True;
end;

constructor TPrincipalController.Create;
begin
  ControllerErro := TErroController.Create;
end;

destructor TPrincipalController.Destroy;
begin
  FreeAndNil(ControllerErro);
  inherited Destroy;
end;

end.

