unit controller.principal;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, controls, controller.erro, lib.util, lib.types,
  model.connection.conexao1, view.participante, view.recebimento;

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

