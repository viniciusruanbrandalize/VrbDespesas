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

unit controller.principal;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, controls, controller.erro, lib.util, lib.types,
  model.connection.conexao1, view.participante, view.recebimento,
  model.dao.configuracao, model.entity.configuracao, lib.version,
  model.ini.conexao;

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
    function RetornarInfoConexao(Conexao: Integer): String;
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

function TPrincipalController.RetornarInfoConexao(Conexao: Integer): String;
var
  ConexaoINI: TConexaoINI;
begin
  ConexaoINI := TConexaoINI.Create;
  try
    case Conexao of
      1: Result := 'Conn 1: Driver=' + ConexaoINI.Driver1 + ';Server=' + ConexaoINI.Servidor1 +
                   ';Port=' + IntToStr(ConexaoINI.Porta1) + ';Database=' + ConexaoINI.Banco1 + ';';
      2: Result := 'Conn 2: Driver=' + ConexaoINI.Driver2 + ';Server=' + ConexaoINI.Servidor2 +
                   ';Port=' + IntToStr(ConexaoINI.Porta2) + ';Database=' + ConexaoINI.Banco2 +';';
    end;
  finally
    FreeAndNil(ConexaoINI);
  end;
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

