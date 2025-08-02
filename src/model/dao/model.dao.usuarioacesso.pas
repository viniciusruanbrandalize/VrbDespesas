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

unit model.dao.usuarioacesso;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, SQLDB, model.dao.padrao, model.entity.uctela,
  model.entity.ucacao, model.entity.ucacesso, model.connection.conexao1,
  CheckLst, StdCtrls;

type

  { TUsuarioAcessoDAO }

  TUsuarioAcessoDAO = class(TPadraoDAO)
  private

  public
    procedure Listar(lv: TListView); override;
    procedure Pesquisar(lv: TListView; Campo, Busca: String); override;
    procedure ListarTelas(var lbNome: TListBox; var lbTitulo: TCheckListBox);
    procedure ListarAcoes(var lbNome: TListBox; var lbTitulo: TCheckListBox; Tela: String; IdUsuario: Integer);
    function InserirTela(Tela: TUcTela; out Erro: string): Boolean;
    function EditarTela(Tela: TUcTela; out Erro: string): Boolean;
    function BuscarTelaPorNome(Tela: TUcTela; Nome: String; out Erro: String): Boolean;
    function InserirAcao(Acao: TUcAcao; out Erro: string): Boolean;
    function EditarAcao(Acao: TUcAcao; out Erro: string): Boolean;
    function BuscarAcaoPorNome(Acao: TUcAcao; out Erro: String): Boolean;
    function InserirAcesso(Acesso: TUcAcesso; out Erro: string): Boolean;
    function RemoverAcesso(Id: Integer; out Erro: string): Boolean;
    function BuscarAcessoPorId(Acesso: TUcAcesso; out Erro: String): Boolean;
    function MarcarAcessos(var lbTitulo: TCheckListBox; IdAcao, IdUsuario: Integer; out Erro: String): Boolean;
    function BuscarAcessoPorNomeEUsuarioLogado(Nome, Tela: String; out Erro: String): Boolean;
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

{ TUsuarioAcessoDAO }

procedure TUsuarioAcessoDAO.Listar(lv: TListView);
begin
  //
end;

procedure TUsuarioAcessoDAO.Pesquisar(lv: TListView; Campo, Busca: String);
begin
  //
end;

procedure TUsuarioAcessoDAO.ListarTelas(var lbNome: TListBox;
  var lbTitulo: TCheckListBox);
var
  sql: String;
begin
  try

    sql := 'select * from uc_tela ' +
           'order by titulo';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.Open;

    Qry.First;

    lbNome.Items.Clear;
    lbTitulo.Items.Clear;

    while not Qry.EOF do
    begin
      lbNome.Items.Add(qry.FieldByName('nome').AsString);
      lbTitulo.Items.Add(qry.FieldByName('titulo').AsString);
      Qry.Next;
    end;

  finally
    Qry.Close;
  end;
end;

procedure TUsuarioAcessoDAO.ListarAcoes(var lbNome: TListBox;
  var lbTitulo: TCheckListBox; Tela: String; IdUsuario: Integer);
var
  sql, Erro: String;
begin
  try

    sql := 'select * from uc_acao ' +
           'where nome_uc_tela = :nome_uc_tela ' +
           'order by nome_uc_tela, titulo';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('nome_uc_tela').AsString := Tela;
    Qry.Open;

    Qry.First;

    lbNome.Items.Clear;
    lbTitulo.Items.Clear;

    while not Qry.EOF do
    begin
      lbNome.Items.Add(qry.FieldByName('id').AsString);
      lbTitulo.Items.Add(qry.FieldByName('titulo').AsString);
      MarcarAcessos(lbTitulo, Qry.FieldByName('id').AsInteger, IdUsuario, Erro);
      Qry.Next;
    end;

  finally
    Qry.Close;
  end;
end;

function TUsuarioAcessoDAO.InserirTela(Tela: TUcTela; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'insert into uc_tela(nome, titulo) values (:nome, :titulo)';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);

    Qry.ParamByName('nome').AsString   := Tela.Nome;
    Qry.ParamByName('titulo').AsString := Tela.Titulo;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao inserir tela: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TUsuarioAcessoDAO.EditarTela(Tela: TUcTela; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'update uc_tela set titulo = :titulo where nome = :nome';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);

    Qry.ParamByName('nome').AsString   := Tela.Nome;
    Qry.ParamByName('titulo').AsString := Tela.Titulo;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao alterar tela: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TUsuarioAcessoDAO.BuscarTelaPorNome(Tela: TUcTela; Nome: String; out
  Erro: String): Boolean;
var
  sql: String;
begin
  try

    sql := 'select * from uc_tela ' +
           'where nome = :nome ' +
           'order by titulo';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('nome').AsString := Nome;
    Qry.Open;

    if Qry.RecordCount = 1 then
    begin
      Tela.Nome    := Qry.FieldByName('nome').AsString;
      Tela.Titulo  := Qry.FieldByName('titulo').AsString;
      Result := True;
    end
    else
    if Qry.RecordCount > 1 then
    begin
      Erro := 'Mais de um objeto foi retornado na busca por Nome!';
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

function TUsuarioAcessoDAO.InserirAcao(Acao: TUcAcao; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'insert into uc_acao(id, nome, titulo, nome_uc_tela) values ' +
           '(:id, :nome, :titulo, :nome_uc_tela)';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);

    if not AutoInc then
    begin
      Acao.Id := GerarId(SEQ_ID_UC_ACAO);
      Qry.ParamByName('id').AsInteger := Acao.Id;
    end;

    Qry.ParamByName('nome').AsString         := Acao.Nome;
    Qry.ParamByName('titulo').AsString       := Acao.Titulo;
    Qry.ParamByName('nome_uc_tela').AsString := Acao.UcTela.Nome;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao inserir ação: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TUsuarioAcessoDAO.EditarAcao(Acao: TUcAcao; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'update uc_acao set titulo = :titulo ' +
           'where nome_uc_tela = :nome_uc_tela and nome = :nome ';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);

    Qry.ParamByName('nome').AsString         := Acao.Nome;
    Qry.ParamByName('titulo').AsString       := Acao.Titulo;
    Qry.ParamByName('nome_uc_tela').AsString := Acao.UcTela.Nome;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao alterar ação: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TUsuarioAcessoDAO.BuscarAcaoPorNome(Acao: TUcAcao; out Erro: String
  ): Boolean;
var
  sql: String;
begin
  try

    sql := 'select * from uc_acao ' +
           'where nome = :nome and nome_uc_tela = :nome_uc_tela ' +
           'order by id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('nome').AsString         := Acao.Nome;
    Qry.ParamByName('nome_uc_tela').AsString := Acao.UcTela.Nome;
    Qry.Open;

    if Qry.RecordCount = 1 then
    begin
      Acao.Id          := Qry.FieldByName('id').AsInteger;
      Acao.Nome        := Qry.FieldByName('nome').AsString;
      Acao.UcTela.Nome := Qry.FieldByName('nome_uc_tela').AsString;
      Result := True;
    end
    else
    if Qry.RecordCount > 1 then
    begin
      Erro := 'Mais de um objeto foi retornado na busca por Nome!';
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

function TUsuarioAcessoDAO.InserirAcesso(Acesso: TUcAcesso; out Erro: string
  ): Boolean;
var
  sql: String;
begin
  try

    sql := 'insert into uc_acesso(id, id_acao, id_usuario) values ' +
           '(:id, :id_acao, :id_usuario)';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);

    if not AutoInc then
    begin
      Acesso.Id := GerarId(SEQ_ID_UC_ACESSO);
      Qry.ParamByName('id').AsInteger := Acesso.Id;
    end;

    Qry.ParamByName('id_acao').AsInteger    := Acesso.UcAcao.Id;
    Qry.ParamByName('id_usuario').AsInteger := Acesso.Usuario.Id;

    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao inserir acesso: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TUsuarioAcessoDAO.RemoverAcesso(Id: Integer; out Erro: string
  ): Boolean;
var
  sql: String;
begin
  try

    sql := 'delete from uc_acesso where id = :id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger  := Id;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao remover acesso: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TUsuarioAcessoDAO.BuscarAcessoPorId(Acesso: TUcAcesso; out Erro: String
  ): Boolean;
var
  sql: String;
begin
  try

    sql := 'select * from uc_acesso ' +
           'where id_acao = :id_acao and id_usuario = :id_usuario ' +
           'order by id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id_acao').AsInteger := Acesso.UcAcao.Id;
    Qry.ParamByName('id_usuario').AsInteger := Acesso.Usuario.Id;
    Qry.Open;

    if Qry.RecordCount = 1 then
    begin
      Acesso.Id          := Qry.FieldByName('id').AsInteger;
      Acesso.Usuario.Id  := Qry.FieldByName('id_usuario').AsInteger;
      Acesso.UcAcao.Id   := Qry.FieldByName('id_acao').AsInteger;
      Result := True;
    end
    else
    if Qry.RecordCount > 1 then
    begin
      Erro := 'Mais de um objeto foi retornado na busca por Nome!';
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

function TUsuarioAcessoDAO.MarcarAcessos(var lbTitulo: TCheckListBox; IdAcao,
  IdUsuario: Integer; out Erro: String): Boolean;
var
  qryTemp: TSQLQuery;
  sql: String;
begin

  sql := 'select * from uc_acesso ' +
         'where id_acao = :id_acao and id_usuario = :id_usuario ' +
         'order by id';

  CriarQuery(qryTemp, dmConexao1.SQLConnector);
  try
    try
      qryTemp.Close;
      qryTemp.SQL.Clear;
      qryTemp.SQL.Add(sql);
      qryTemp.ParamByName('id_acao').AsInteger    := IdAcao;
      qryTemp.ParamByName('id_usuario').AsInteger := IdUsuario;
      qryTemp.Open;

      if qryTemp.RecordCount > 0 Then
      begin
        lbTitulo.Checked[Pred(lbTitulo.Items.Count)] := True;
      end
      else
      begin
        Erro := 'Nenhum objeto foi encontrado!';
        Result := False;
      end;

    except on E: Exception do
      begin
        Erro := 'Ocorreu um erro ao marcar acesso: ' + sLineBreak + E.Message;
        Result := False;
      end;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function TUsuarioAcessoDAO.BuscarAcessoPorNomeEUsuarioLogado(Nome, Tela: String; out
  Erro: String): Boolean;
var
  sql: String;
begin
  try

    sql := 'select acesso.id as id_acesso from uc_acesso acesso ' +
           'left join uc_acao acao on acao.id = acesso.id_acao ' +
           'where acao.nome = :nome_acao and acesso.id_usuario = :id_usuario ' +
           'and acao.nome_uc_tela = :nome_uc_tela';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('nome_acao').AsString    := Nome;
    Qry.ParamByName('nome_uc_tela').AsString := Tela;
    Qry.ParamByName('id_usuario').AsInteger  := dmConexao1.Usuario.Id;
    Qry.Open;

    Result := Qry.RecordCount > 0;

  finally
    Qry.Close;
  end;
end;

constructor TUsuarioAcessoDAO.Create;
begin
  inherited;
end;

destructor TUsuarioAcessoDAO.Destroy;
begin
  inherited Destroy;
end;

end.

