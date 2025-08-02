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

unit model.dao.subtipodespesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, SQLDB, model.entity.subtipodespesa,
  model.connection.conexao1, model.dao.padrao;

type

  { TSubtipoDespesaDAO }

  TSubtipoDespesaDAO = class(TPadraoDAO)
  private

  public
    procedure Listar(lv: TListView); override;
    procedure Pesquisar(lv: TListView; Campo, Busca: String); override;
    function BuscarPorId(SubtipoDespesa : TSubtipoDespesa; Id: Integer; out Erro: String): Boolean;
    function Inserir(SubtipoDespesa: TSubtipoDespesa; out Erro: string): Boolean;
    function Editar(SubtipoDespesa: TSubtipoDespesa; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

{ TSubtipoDespesaDAO }

procedure TSubtipoDespesaDAO.Listar(lv: TListView);
var
  sql: String;
  item : TListItem;
begin
  try

    sql := 'select sd.*, td.nome as nome_tipo from subtipo_despesa sd ' +
           'left join tipo_despesa td on td.id = sd.id_tipo_despesa ' +
           'where sd.excluido = false ' +
           'order by sd.nome';

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
      item.SubItems.Add(qry.FieldByName('nome_tipo').AsString);
      Qry.Next;
    end;

  finally
    Qry.Close;
  end;
end;

procedure TSubtipoDespesaDAO.Pesquisar(lv: TListView; Campo, Busca: String);
var
  sql: String;
  item : TListItem;
  valor: Double;
begin
  try

    if TryStrToFloat(Busca, valor) then
    begin
      sql := 'select sd.*, td.nome as nome_tipo from subtipo_despesa sd ' +
           'left join tipo_despesa td on td.id = sd.id_tipo_despesa ' +
           'where '+campo+' = :busca and sd.excluido = false '+
           'order by sd.nome';
    end
    else
    begin
      sql := 'select sd.*, td.nome as nome_tipo from subtipo_despesa sd ' +
             'left join tipo_despesa td on td.id = sd.id_tipo_despesa ' +
             'where UPPER('+campo+') like :busca and sd.excluido = false '+
             'order by sd.nome';
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
      item.SubItems.Add(qry.FieldByName('nome_tipo').AsString);
      Qry.Next;
    end;

  finally
    qry.Close;
  end;
end;

function TSubtipoDespesaDAO.BuscarPorId(SubtipoDespesa: TSubtipoDespesa; Id: Integer; out Erro: String): Boolean;
var
  sql: String;
begin
  try

    sql := 'select sd.*, td.nome as nome_tipo from subtipo_despesa sd ' +
             'left join tipo_despesa td on td.id = sd.id_tipo_despesa ' +
             'where sd.id = :id and sd.excluido = false '+
             'order by sd.id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger := id;
    Qry.Open;

    if Qry.RecordCount = 1 then
    begin
      SubtipoDespesa.Id               := Qry.FieldByName('id').AsInteger;
      SubtipoDespesa.Nome             := Qry.FieldByName('nome').AsString;
      SubtipoDespesa.TipoDespesa.Id   := Qry.FieldByName('id_tipo_despesa').AsInteger;
      SubtipoDespesa.TipoDespesa.Nome := Qry.FieldByName('nome_tipo').AsString;
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

function TSubtipoDespesaDAO.Inserir(SubtipoDespesa: TSubtipoDespesa; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'insert into subtipo_despesa(id, nome, id_tipo_despesa, excluido) values ' +
           '(:id, :nome, :id_tipo_despesa, :excluido)';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);

    if not AutoInc then
    begin
      SubtipoDespesa.Id := GerarId(SEQ_ID_SUBTIPO_DESPESA);
      Qry.ParamByName('id').AsInteger  := SubtipoDespesa.Id;
    end;

    Qry.ParamByName('nome').AsString := SubtipoDespesa.Nome;
    Qry.ParamByName('excluido').AsBoolean := SubtipoDespesa.Excluido;
    Qry.ParamByName('id_tipo_despesa').AsInteger := SubtipoDespesa.TipoDespesa.Id;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao inserir Subtipo Despesa: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TSubtipoDespesaDAO.Editar(SubtipoDespesa: TSubtipoDespesa; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'update subtipo_despesa set nome = :nome, id_tipo_despesa = :id_tipo_despesa ' +
           'where id = :id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger  := SubtipoDespesa.Id;
    Qry.ParamByName('nome').AsString := SubtipoDespesa.Nome;
    Qry.ParamByName('id_tipo_despesa').AsInteger  := SubtipoDespesa.TipoDespesa.Id;

    //dmConexao1.SQLTransaction.StartTransaction;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      dmConexao1.SQLTransaction.Rollback;
      Erro := 'Ocorreu um erro ao alterar Subtipo de Despesa: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TSubtipoDespesaDAO.Excluir(Id: Integer; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'delete from subtipo_despesa where id = :id';

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

        sql := 'update subtipo_despesa set excluido = true where id = :id';

        Qry.Close;
        Qry.SQL.Clear;
        Qry.SQL.Add(sql);
        Qry.ParamByName('id').AsInteger  := Id;
        Qry.ExecSQL;
        dmConexao1.SQLTransaction.Commit;

        Result := True;

      except on E: Exception do
        begin
          Erro := 'Ocorreu um erro ao excluir Subtipo de Despesa: ' + sLineBreak + E.Message;
          Result := False;
        end;
      end;
    end;
  end;
end;

constructor TSubtipoDespesaDAO.Create;
begin
  inherited;
end;

destructor TSubtipoDespesaDAO.Destroy;
begin
  inherited Destroy;
end;

end.

