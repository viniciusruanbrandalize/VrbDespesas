unit controller.principal;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, controls, controller.erro, lib.util,
  model.connection.conexao1;

type

  { TPrincipalController }

  TPrincipalController = class
  private
    ControllerErro: TErroController;
  public
    procedure TratarErros(Sender: TObject; E: Exception);
    procedure AbrirTela(Formulario: TForm; ClasseForm: TFormClass; Modal: Boolean; AParent: TWinControl; FormularioPai: TForm);
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

function TPrincipalController.RetornarNomeUsuario: String;
begin
  Result := dmConexao1.NomeUsuario;
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

