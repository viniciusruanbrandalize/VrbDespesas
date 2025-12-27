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

unit model.ini.conexao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, lib.cryptini;

type

  { TConexaoINI }

  TConexaoINI = class
  private

    { CONEXAO_1 }
    FDriver1:   String;
    FServidor1: String;
    FPorta1:    Integer;
    FBanco1:    String;
    FUsuario1:  String;
    FSenha1:    String;
    FNomeDLL1:  String;
    FCharSet1:  String;
    FCollate1:  String;
    FLogSQL1:   Boolean;
    FEsquema1:  String;
    FInatividade1: Integer;

    { CONEXAO_2 }
    FDriver2:   String;
    FServidor2: String;
    FPorta2:    Integer;
    FBanco2:    String;
    FUsuario2:  String;
    FSenha2:    String;
    FNomeDLL2:  String;
    FCharSet2:  String;
    FCollate2:  String;
    FLogSQL2:   Boolean;
    FEsquema2:  String;
    FInatividade2: Integer;

    FArq:       String;
    FKey:       String;
    FMD5:       String;

    procedure Ler;
    procedure GravarDefault;

  public
    procedure Escrever;
    constructor Create;
    destructor Destroy; override;
  published

    { CONEXAO_1 }
    property Driver1: String read FDriver1 write FDriver1;
    property Servidor1: String read FServidor1 write FServidor1;
    property Porta1: Integer read FPorta1 write FPorta1;
    property Banco1: String read FBanco1 write FBanco1;
    property Usuario1: String read FUsuario1 write FUsuario1;
    property Senha1: String read FSenha1 write FSenha1;
    property NomeDLL1: String read FNomeDLL1 write FNomeDLL1;
    property CharSet1: String read FCharSet1 write FCharSet1;
    property Collate1: String read FCollate1 write FCollate1;
    property LogSQL1: Boolean read FLogSQL1 write FLogSQL1;
    property Esquema1: String read FEsquema1 write FEsquema1;
    property Inatividade1: Integer read FInatividade1 write FInatividade1;

    { CONEXAO_2 }
    property Driver2: String read FDriver2 write FDriver2;
    property Servidor2: String read FServidor2 write FServidor2;
    property Porta2: Integer read FPorta2 write FPorta2;
    property Banco2: String read FBanco2 write FBanco2;
    property Usuario2: String read FUsuario2 write FUsuario2;
    property Senha2: String read FSenha2 write FSenha2;
    property NomeDLL2: String read FNomeDLL2 write FNomeDLL2;
    property CharSet2: String read FCharSet2 write FCharSet2;
    property Collate2: String read FCollate2 write FCollate2;
    property LogSQL2: Boolean read FLogSQL2 write FLogSQL2;
    property Esquema2: String read FEsquema2 write FEsquema2;
    property Inatividade2: Integer read FInatividade2 write FInatividade2;

  end;

implementation

{ TConexaoINI }

procedure TConexaoINI.Ler;
begin

  FDriver1      := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'DRIVER', '');
  FServidor1    := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'SERVIDOR', '');
  FPorta1       := lib.cryptini.LerInteger(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'PORTA', 0);
  FBanco1       := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'BANCO', '');
  FUsuario1     := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'USUARIO', '');
  FSenha1       := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'SENHA', '');
  FNomeDLL1     := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'BIBLIOTECA', '');
  FCharSet1     := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'CHARSET', '');
  FCollate1     := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'COLLATE', '');
  FLogSQL1      := lib.cryptini.LerBoolean(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'LOG', false);
  FEsquema1     := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'ESQUEMA', '');
  FInatividade1 := lib.cryptini.LerInteger(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'INATIVIDADE', 0);

  FDriver2      := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'DRIVER', '');
  FServidor2    := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'SERVIDOR', '');
  FPorta2       := lib.cryptini.LerInteger(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'PORTA', 0);
  FBanco2       := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'BANCO', '');
  FUsuario2     := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'USUARIO', '');
  FSenha2       := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'SENHA', '');
  FNomeDLL2     := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'BIBLIOTECA', '');
  FCharSet2     := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'CHARSET', '');
  FCollate2     := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'COLLATE', '');
  FLogSQL2      := lib.cryptini.LerBoolean(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'LOG', false);
  FEsquema2     := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'ESQUEMA', '');
  FInatividade2 := lib.cryptini.LerInteger(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'INATIVIDADE', 0);

end;

procedure TConexaoINI.GravarDefault;
begin
  if not FileExists(FArq) then
  begin

    lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'DRIVER', 'Firebird');
    lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'SERVIDOR', '127.0.0.1');
    lib.cryptini.EscreverInteger(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'PORTA', 3050);
    lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'BANCO', PChar(ExtractFilePath(ParamStr(0))+'Database\DESPESAS.FDB'));
    lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'USUARIO', 'SYSDBA');
    lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'SENHA', 'masterkey');
    lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'BIBLIOTECA', 'fbclient.dll');
    lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'CHARSET', 'UTF8');
    lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'COLLATE', 'UNICODE_CI_AI');
    lib.cryptini.EscreverBoolean(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'LOG', false);
    lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'ESQUEMA', '');
    lib.cryptini.EscreverInteger(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'INATIVIDADE', 43200);

    lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'DRIVER', 'SQLite3');
    lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'SERVIDOR', '127.0.0.1');
    lib.cryptini.EscreverInteger(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'PORTA', 0);
    lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'BANCO', PChar(ExtractFilePath(ParamStr(0))+'Database\ARQUIVOS.DB'));
    lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'USUARIO', 'root');
    lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'SENHA', 'senha');
    lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'BIBLIOTECA', 'SQLite.dll');
    lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'CHARSET', 'UTF8');
    lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'COLLATE', 'UNICODE_CI_AI');
    lib.cryptini.EscreverBoolean(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'LOG', false);
    lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'ESQUEMA', '');
    lib.cryptini.EscreverInteger(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'INATIVIDADE', 43200);

  end;
end;

procedure TConexaoINI.Escrever;
begin

  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'DRIVER', PChar(FDriver1));
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'SERVIDOR',  PChar(FServidor1));
  lib.cryptini.EscreverInteger(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'PORTA',  FPorta1);
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'BANCO',  PChar(FBanco1));
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'USUARIO',  PChar(FUsuario1));
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'SENHA',  PChar(FSenha1));
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'BIBLIOTECA',  PChar(FNomeDLL1));
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'CHARSET', PChar(FCharSet1));
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'COLLATE', PChar(FCollate1));
  lib.cryptini.EscreverBoolean(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'LOG', FLogSQL1);
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'ESQUEMA', PChar(FEsquema1));
  lib.cryptini.EscreverInteger(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'INATIVIDADE', FInatividade1);

  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'DRIVER',  PChar(FDriver2));
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'SERVIDOR',  PChar(FServidor2));
  lib.cryptini.EscreverInteger(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'PORTA',  FPorta2);
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'BANCO',  PChar(FBanco2));
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'USUARIO',  PChar(FUsuario2));
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'SENHA',  PChar(FSenha2));
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'BIBLIOTECA',  PChar(FNomeDLL2));
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'CHARSET', PChar(FCharSet2));
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'COLLATE', PChar(FCollate2));
  lib.cryptini.EscreverBoolean(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'LOG', FLogSQL2);
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'ESQUEMA', PChar(FEsquema2));
  lib.cryptini.EscreverInteger(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'INATIVIDADE', FInatividade2);

end;

constructor TConexaoINI.Create;
begin
  FArq   := ExtractFilePath(ParamStr(0))+'conexao.ini';
  FMD5   := 'compras_laz_2025_MD5';
  FKey   := 'compras_laz_2025_KEY';
  GravarDefault;
  ler;
end;

destructor TConexaoINI.Destroy;
begin
  inherited Destroy;
end;

end.

