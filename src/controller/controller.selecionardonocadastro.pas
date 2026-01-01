{
*******************************************************************************
*   VRBDespesas                                                               *
*   Controle e gerenciamento de despesas.                                     *
*                                                                             *
*   Copyright (C) 2025 Vinícius Ruan Brandalize.                              *
*                                                                             *
*   This program is free software: you can redistribute it and/or modify      *
*   it under the terms of the GNU General Public License as published by      *
*   the Free Software Foundation, either version 3 of the License, or         *
*   (at your option) any later version.                                       *
*                                                                             *
*   This program is distributed in the hope that it will be useful,           *
*   but WITHOUT ANY WARRANTY; without even the implied warranty of            *
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             *
*   GNU General Public License for more details.                              *
*                                                                             *
*   You should have received a copy of the GNU General Public License         *
*   along with this program.  If not, see <https://www.gnu.org/licenses/>.    *
*                                                                             *
*   Contact: viniciusbrandalize2@gmail.com.                                   *
*                                                                             *
*******************************************************************************
}

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
    procedure SelecionarDonoCadastroPadrao();
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

procedure TSelecionarDonoCadastroController.SelecionarDonoCadastroPadrao();
begin
  dmConexao1.DonoCadastro.Id := ConfiguracaoINI.DCId;
end;

constructor TSelecionarDonoCadastroController.Create;
begin
  ConfiguracaoINI := TConfiguracaoINI.Create;
  SelecionarDonoCadastroPadrao();
end;

destructor TSelecionarDonoCadastroController.Destroy;
begin
  FreeAndNil(ConfiguracaoINI);
  inherited Destroy;
end;

end.
