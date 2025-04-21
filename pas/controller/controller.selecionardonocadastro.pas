unit controller.selecionardonocadastro;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, model.ini.configuracao,
  model.connection.conexao1;

type

  { TSelecionarDonoCadastroController }

  TSelecionarDonoCadastroController = class
  private

  public
    ConfiguracaoINI: TConfiguracaoINI;
    procedure BuscarDonoCadastroPermitidos(var cb: TComboBox);
    procedure SelecionarDonoCadastro(cb: TComboBox);
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TSelecionarDonoCadastroController }

procedure TSelecionarDonoCadastroController.BuscarDonoCadastroPermitidos(
  var cb: TComboBox);
var
  i: Integer;
begin
  cb.Items.Clear;
  for i := 0 to Pred(dmConexao1.UsuarioDC.Count) do
  begin
    cb.Items.Add(dmConexao1.UsuarioDC.Items[i].DonoCadastro.Nome);
  end;
end;

procedure TSelecionarDonoCadastroController.SelecionarDonoCadastro(cb: TComboBox);
begin
  with dmConexao1.UsuarioDC.Items[cb.ItemIndex] do
  begin
    dmConexao1.DonoCadastro.Id   := DonoCadastro.Id;
    dmConexao1.DonoCadastro.Nome := DonoCadastro.Nome;
  end;
  ConfiguracaoINI.DCId := dmConexao1.DonoCadastro.Id;
end;

constructor TSelecionarDonoCadastroController.Create;
begin
  ConfiguracaoINI := TConfiguracaoINI.Create;
end;

destructor TSelecionarDonoCadastroController.Destroy;
begin
  FreeAndNil(ConfiguracaoINI);
  inherited Destroy;
end;

end.
