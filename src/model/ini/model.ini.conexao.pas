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

    { CONEXAO }
  type
    TConexao = class
    private
      FDriver:   String;
      FServidor: String;
      FPorta:    Integer;
      FBanco:    String;
      FUsuario:  String;
      FSenha:    String;
      FNomeDLL:  String;
      FCharSet:  String;
      FCollate:  String;
      FLogSQL:   Boolean;
      FEsquema:  String;
      FInatividade: Integer;
    published
      property Driver: String read FDriver write FDriver;
      property Servidor: String read FServidor write FServidor;
      property Porta: Integer read FPorta write FPorta;
      property Banco: String read FBanco write FBanco;
      property Usuario: String read FUsuario write FUsuario;
      property Senha: String read FSenha write FSenha;
      property NomeDLL: String read FNomeDLL write FNomeDLL;
      property CharSet: String read FCharSet write FCharSet;
      property Collate: String read FCollate write FCollate;
      property LogSQL: Boolean read FLogSQL write FLogSQL;
      property Esquema: String read FEsquema write FEsquema;
      property Inatividade: Integer read FInatividade write FInatividade;
    end;

  private

    FConexao1: TConexao;
    FConexao2: TConexao;

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
    property Conexao1: TConexao read FConexao1 write FConexao1;
    property Conexao2: TConexao read FConexao2 write FConexao2;
  end;

implementation

{ TConexaoINI }

procedure TConexaoINI.Ler;
begin

  FConexao1.FDriver      := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'DRIVER', '');
  FConexao1.FServidor    := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'SERVIDOR', '');
  FConexao1.FPorta       := lib.cryptini.LerInteger(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'PORTA', 0);
  FConexao1.FBanco       := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'BANCO', '');
  FConexao1.FUsuario     := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'USUARIO', '');
  FConexao1.FSenha       := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'SENHA', '');
  FConexao1.FNomeDLL     := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'BIBLIOTECA', '');
  FConexao1.FCharSet     := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'CHARSET', '');
  FConexao1.FCollate     := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'COLLATE', '');
  FConexao1.FLogSQL      := lib.cryptini.LerBoolean(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'LOG', false);
  FConexao1.FEsquema     := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'ESQUEMA', '');
  FConexao1.FInatividade := lib.cryptini.LerInteger(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'INATIVIDADE', 0);

  FConexao2.FDriver      := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'DRIVER', '');
  FConexao2.FServidor    := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'SERVIDOR', '');
  FConexao2.FPorta       := lib.cryptini.LerInteger(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'PORTA', 0);
  FConexao2.FBanco       := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'BANCO', '');
  FConexao2.FUsuario     := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'USUARIO', '');
  FConexao2.FSenha       := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'SENHA', '');
  FConexao2.FNomeDLL     := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'BIBLIOTECA', '');
  FConexao2.FCharSet     := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'CHARSET', '');
  FConexao2.FCollate     := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'COLLATE', '');
  FConexao2.FLogSQL      := lib.cryptini.LerBoolean(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'LOG', false);
  FConexao2.FEsquema     := lib.cryptini.LerString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'ESQUEMA', '');
  FConexao2.FInatividade := lib.cryptini.LerInteger(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'INATIVIDADE', 0);

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

  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'DRIVER', PChar(FConexao1.FDriver));
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'SERVIDOR',  PChar(FConexao1.FServidor));
  lib.cryptini.EscreverInteger(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'PORTA',  FConexao1.FPorta);
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'BANCO',  PChar(FConexao1.FBanco));
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'USUARIO',  PChar(FConexao1.FUsuario));
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'SENHA',  PChar(FConexao1.FSenha));
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'BIBLIOTECA',  PChar(FConexao1.FNomeDLL));
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'CHARSET', PChar(FConexao1.FCharSet));
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'COLLATE', PChar(FConexao1.FCollate));
  lib.cryptini.EscreverBoolean(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'LOG', FConexao1.FLogSQL);
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'ESQUEMA', PChar(FConexao1.FEsquema));
  lib.cryptini.EscreverInteger(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_1', 'INATIVIDADE', FConexao1.FInatividade);

  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'DRIVER',  PChar(FConexao2.FDriver));
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'SERVIDOR',  PChar(FConexao2.FServidor));
  lib.cryptini.EscreverInteger(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'PORTA',  FConexao2.FPorta);
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'BANCO',  PChar(FConexao2.FBanco));
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'USUARIO',  PChar(FConexao2.FUsuario));
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'SENHA',  PChar(FConexao2.FSenha));
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'BIBLIOTECA',  PChar(FConexao2.FNomeDLL));
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'CHARSET', PChar(FConexao2.FCharSet));
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'COLLATE', PChar(FConexao2.FCollate));
  lib.cryptini.EscreverBoolean(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'LOG', FConexao2.FLogSQL);
  lib.cryptini.EscreverString(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'ESQUEMA', PChar(FConexao2.FEsquema));
  lib.cryptini.EscreverInteger(PChar(FArq), PChar(FKey), Pchar(FMD5), 'CONEXAO_2', 'INATIVIDADE', FConexao2.FInatividade);

end;

constructor TConexaoINI.Create;
begin
  FArq   := ExtractFilePath(ParamStr(0))+'conexao.ini';
  FMD5   := 'compras_laz_2025_MD5';
  FKey   := 'compras_laz_2025_KEY';
  FConexao1 := TConexao.Create;
  FConexao2 := TConexao.Create;
  GravarDefault;
  ler;
end;

destructor TConexaoINI.Destroy;
begin
  FConexao1.Free;
  FConexao2.Free;
  inherited Destroy;
end;

end.

