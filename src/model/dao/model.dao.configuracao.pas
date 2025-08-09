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

unit model.dao.configuracao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, SQLDB, model.entity.configuracao,
  model.dao.padrao, model.connection.conexao1;

type

  { TConfiguracaoDAO }

  TConfiguracaoDAO = class(TPadraoDAO)
  private

  public
    procedure Listar(lv: TListView); override;
    procedure Pesquisar(lv: TListView; Campo, Busca: String); override;
    function BuscarTodos(ListaConfiguracao: TListaConfiguracao; out Erro: String): Boolean;
    function BuscarPorId(Configuracao : TConfiguracao; Id: Integer; out Erro: String): Boolean;
    function BuscarPorNome(Configuracao : TConfiguracao; Nome: String; out Erro: String): Boolean;
    function Inserir(Configuracao : TConfiguracao; out Erro: string): Boolean;
    function Editar(Configuracao : TConfiguracao; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

{ TConfiguracaoDAO }

procedure TConfiguracaoDAO.Listar(lv: TListView);
var
  sql: String;
  item : TListItem;
begin
  try

    sql := 'select * from configuracao where excluido = false order by nome';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.Open;

    Qry.First;

    while not Qry.EOF do
    begin
      item := lv.Items.Add;
      item.Caption := Qry.FieldByName('id').AsString;
      item.SubItems.Add(qry.FieldByName('nome').AsString);
      item.SubItems.Add(qry.FieldByName('descricao').AsString);
      item.SubItems.Add(qry.FieldByName('valor').AsString);
      Qry.Next;
    end;
    //dmConexao1.SQLTransaction.Commit;
  finally
    Qry.Close;
  end;
end;

procedure TConfiguracaoDAO.Pesquisar(lv: TListView; Campo, Busca: String);
var
  sql: String;
  item : TListItem;
  valor: Double;
begin
  try

    if TryStrToFloat(Busca, valor) then
    begin
      sql := 'select * from configuracao ' +
             'where '+campo+' = :busca and excluido = false '+
             'order by nome';
    end
    else
    begin
      sql := 'select * from configuracao ' +
             'where UPPER('+campo+') like :busca and excluido = false '+
             'order by nome';
    end;

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('busca').AsString := '%'+UpperCase(Busca)+'%';
    Qry.Open;

    Qry.First;

    while not Qry.EOF do
    begin
      item := lv.Items.Add;
      item.Caption := Qry.FieldByName('id').AsString;
      item.SubItems.Add(qry.FieldByName('nome').AsString);
      item.SubItems.Add(qry.FieldByName('descricao').AsString);
      item.SubItems.Add(qry.FieldByName('valor').AsString);
      Qry.Next;
    end;

  finally
    qry.Close;
  end;
end;

function TConfiguracaoDAO.BuscarTodos(ListaConfiguracao: TListaConfiguracao;
  out Erro: String): Boolean;
var
  sql: String;
  i: Integer;
begin
  try

    sql := 'select * from configuracao ' +
           'where excluido = false ' +
           'order by descricao';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.Open;
    Qry.First;

    ListaConfiguracao.Clear;

    while not Qry.EOF do
    begin

      ListaConfiguracao.Add(TConfiguracao.Create);
      i := Pred(ListaConfiguracao.Count);

      with ListaConfiguracao.Items[i] do
      begin
        Id         := Qry.FieldByName('id').AsInteger;
        Nome       := Qry.FieldByName('nome').AsString;
        Descricao  := Qry.FieldByName('descricao').AsString;
        Uso        := Qry.FieldByName('uso').AsString;
        Valor      := Qry.FieldByName('valor').AsString;
        Componente := Qry.FieldByName('componente').AsString;
      end;

      Qry.Next;

    end;

    Result := True;

  finally
    Qry.Close;
  end;
end;

function TConfiguracaoDAO.BuscarPorId(Configuracao : TConfiguracao; Id: Integer; out Erro: String): Boolean;
var
  sql: String;
begin
  try

    sql := 'select * from configuracao ' +
           'where id = :id and excluido = false ' +
           'order by id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger := id;
    Qry.Open;

    if Qry.RecordCount = 1 then
    begin
      Configuracao.Id        := Qry.FieldByName('id').AsInteger;
      Configuracao.Nome      := Qry.FieldByName('nome').AsString;
      Configuracao.Descricao := Qry.FieldByName('descricao').AsString;
      Configuracao.Uso       := Qry.FieldByName('uso').AsString;
      Configuracao.Valor     := Qry.FieldByName('valor').AsString;
      Configuracao.Componente:= Qry.FieldByName('componente').AsString;
      Result := True;
    end
    else
    if Qry.RecordCount > 1 then
    begin
      Erro := 'Mais de um objeto foi retornado na busca por código!';
      Result := False;
    end
    else
    begin
      Erro := 'Nenhum objeto foi encontrado!';
      Result := False;
    end;

  finally
    Qry.Close;
  end;
end;

function TConfiguracaoDAO.BuscarPorNome(Configuracao: TConfiguracao;
  Nome: String; out Erro: String): Boolean;
var
  sql: String;
begin
  try

    sql := 'select * from configuracao ' +
           'where nome = :nome and excluido = false ' +
           'order by id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('nome').AsString := Nome;
    Qry.Open;
    Qry.First;

    if Qry.RecordCount = 1 then
    begin
      Configuracao.Id        := Qry.FieldByName('id').AsInteger;
      Configuracao.Nome      := Qry.FieldByName('nome').AsString;
      Configuracao.Descricao := Qry.FieldByName('descricao').AsString;
      Configuracao.Uso       := Qry.FieldByName('uso').AsString;
      Configuracao.Valor     := Qry.FieldByName('valor').AsString;
      Configuracao.Componente:= Qry.FieldByName('componente').AsString;
      Result := True;
    end
    else
    if Qry.RecordCount > 1 then
    begin
      Erro := 'Mais de um objeto foi retornado na busca por código!';
      Result := False;
    end
    else
    begin
      Erro := 'Nenhum objeto foi encontrado!';
      Result := False;
    end;

  finally
    Qry.Close;
  end;
end;

function TConfiguracaoDAO.Inserir(Configuracao : TConfiguracao; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'insert into configuracao(id, nome, descricao, uso, valor, excluido, componente) values ' +
           '(:id, :nome, :descricao, :uso, :valor, :excluido, :componente)';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);

    if not AutoInc then
    begin
      Configuracao.Id := GerarId(SEQ_ID_FORMA_PGTO);
      Qry.ParamByName('id').AsInteger := Configuracao.Id;
    end;

    Qry.ParamByName('nome').AsString      := Configuracao.Nome;
    Qry.ParamByName('descricao').AsString := Configuracao.Descricao;
    if Trim(Configuracao.Uso) <> EmptyStr then
      Qry.ParamByName('uso').AsString     := Configuracao.Uso;
    Qry.ParamByName('valor').AsString     := Configuracao.Valor;
    if Trim(Configuracao.Componente) <> EmptyStr then
      Qry.ParamByName('componente').AsString := Configuracao.Componente;
    Qry.ParamByName('excluido').AsBoolean := Configuracao.Excluido;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao inserir configuração: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TConfiguracaoDAO.Editar(Configuracao : TConfiguracao; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'update configuracao set nome = :nome, ' +
           'descricao = :descricao, uso = :uso, valor = :valor, componente = :componente ' +
           'where id = :id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger       := Configuracao.Id;
    Qry.ParamByName('nome').AsString      := Configuracao.Nome;
    Qry.ParamByName('descricao').AsString := Configuracao.Descricao;
    if Trim(Configuracao.Uso) <> EmptyStr then
      Qry.ParamByName('uso').AsString     := Configuracao.Uso;
    Qry.ParamByName('valor').AsString     := Configuracao.Valor;
    if Trim(Configuracao.Componente) <> EmptyStr then
      Qry.ParamByName('componente').AsString := Configuracao.Componente;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      dmConexao1.SQLTransaction.Rollback;
      Erro := 'Ocorreu um erro ao alterar configuração: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TConfiguracaoDAO.Excluir(Id: Integer; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'delete from configuracao where id = :id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger  := Id;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      try

        sql := 'update configuracao set excluido = true where id = :id';

        Qry.Close;
        Qry.SQL.Clear;
        Qry.SQL.Add(sql);
        Qry.ParamByName('id').AsInteger  := Id;
        Qry.ExecSQL;
        dmConexao1.SQLTransaction.Commit;

        Result := True;

      except on E: Exception do
        begin
          Erro := 'Ocorreu um erro ao excluir configuração: ' + sLineBreak + E.Message;
          Result := False;
        end;
      end;
    end;
  end;
end;

constructor TConfiguracaoDAO.Create;
begin
  inherited;
end;

destructor TConfiguracaoDAO.Destroy;
begin
  inherited Destroy;
end;

end.

