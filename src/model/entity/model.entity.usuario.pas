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

unit model.entity.usuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TUsuario }

  TUsuario = class
  private
    FId:   Integer;
    FNome: String;
    FSenha: String;
    FEmail: String;
    FCadastro: TDateTime;
    FAlteracao: TDateTime;
    FExcluido: Boolean;
    function GetAlteracao: TDateTime;
    function GetCadastro: TDateTime;
    function GetEmail: String;
    function GetExcluido: Boolean;
    function GetId: Integer;
    function GetNome: String;
    function GetSenha: String;
    procedure SetAlteracao(AValue: TDateTime);
    procedure SetCadastro(AValue: TDateTime);
    procedure SetEmail(AValue: String);
    procedure SetExcluido(AValue: Boolean);
    procedure SetId(AValue: Integer);
    procedure SetNome(AValue: String);
    procedure SetSenha(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property Nome: String read GetNome write SetNome;
    property Senha: String read GetSenha write SetSenha;
    property Email: String read GetEmail write SetEmail;
    property Cadastro: TDateTime read GetCadastro write SetCadastro;
    property Alteracao: TDateTime read GetAlteracao write SetAlteracao;
    property Excluido: Boolean read GetExcluido write SetExcluido;
  end;

implementation

{ TUsuario }

function TUsuario.GetEmail: String;
begin
  Result := FEmail;
end;

function TUsuario.GetExcluido: Boolean;
begin
  Result := FExcluido;
end;

function TUsuario.GetAlteracao: TDateTime;
begin
  Result := FAlteracao;
end;

function TUsuario.GetCadastro: TDateTime;
begin
  Result := FCadastro;
end;

function TUsuario.GetSenha: String;
begin
  Result := FSenha;
end;

procedure TUsuario.SetAlteracao(AValue: TDateTime);
begin
  FAlteracao := AValue;
end;

procedure TUsuario.SetCadastro(AValue: TDateTime);
begin
  FCadastro := AValue;
end;

procedure TUsuario.SetEmail(AValue: String);
begin
  FEmail := AValue;
end;

procedure TUsuario.SetExcluido(AValue: Boolean);
begin
  FExcluido := AValue;
end;

procedure TUsuario.SetSenha(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Senha" precisa ser preenchido!')
  else
    FSenha := AValue;
end;

function TUsuario.GetId: Integer;
begin
  Result := FId;
end;

function TUsuario.GetNome: String;
begin
  Result := FNome;
end;

procedure TUsuario.SetId(AValue: Integer);
begin
  if AValue = 0 then
    raise Exception.Create('O campo "Id" precisa ser preenchido!')
  else
    FId := AValue;
end;

procedure TUsuario.SetNome(AValue: String);
begin
  if AValue = EmptyStr then
    raise Exception.Create('O campo "Nome" precisa ser preenchido!')
  else
    FNome := AValue;
end;

constructor TUsuario.Create;
begin
  //
end;

destructor TUsuario.Destroy;
begin
  inherited Destroy;
end;

end.
