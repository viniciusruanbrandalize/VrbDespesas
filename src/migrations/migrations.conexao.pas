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

unit migrations.conexao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, SQLDBLib;

type

  { TdmMigration }

  TdmMigration = class(TDataModule)
    SQLConnector: TSQLConnector;
    SQLDBLibraryLoader: TSQLDBLibraryLoader;
    SQLQuery: TSQLQuery;       { Busca dados / Atualiza a estrutura }
    qryAtualizacao: TSQLQuery; { Atualiza dados UPDATE }
    SQLTransaction: TSQLTransaction;
    SQLTransactionAtualizacao: TSQLTransaction;
    procedure DataModuleDestroy(Sender: TObject);
  private
    FDriver: String;
  public
    constructor Create(AOwner: TComponent; AConnection: TSQLConnector; ALibraryLoader: TSQLDBLibraryLoader; Driver: String);
    property Driver: String read FDriver write FDriver;
  end;

var
  dmMigration: TdmMigration;

implementation

{$R *.lfm}

{ TdmMigration }

procedure TdmMigration.DataModuleDestroy(Sender: TObject);
begin
  SQLConnector.Connected  := False;
end;

constructor TdmMigration.Create(AOwner: TComponent; AConnection: TSQLConnector;
  ALibraryLoader: TSQLDBLibraryLoader; Driver: String);
begin
  inherited Create(AOwner);

  with SQLDBLibraryLoader do
  begin
    try
      Enabled            := False;
      ConnectionType     := ALibraryLoader.ConnectionType;
      LibraryName        := ALibraryLoader.LibraryName;
      Enabled            := True;
    except

    end;
  end;

  with SQLConnector do
  begin
    CharSet               := AConnection.CharSet;
    ConnectorType         := AConnection.ConnectorType;
    DatabaseName          := AConnection.DatabaseName;
    HostName              := AConnection.HostName;
    UserName              := AConnection.UserName;
    Password              := AConnection.Password;
    Params                := AConnection.Params;
  end;

  try
    SQLConnector.Connected  := True;
  except

  end;

  FDriver := UpperCase(Driver);
end;

end.

