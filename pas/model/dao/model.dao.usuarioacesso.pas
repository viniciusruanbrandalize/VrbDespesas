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
    procedure ListarAcoes(var lbNome: TListBox; var lbTitulo: TCheckListBox; Tela: String);
    function InserirTela(Tela: TUcTela; out Erro: string): Boolean;
    function BuscarTelaPorNome(Tela: TUcTela; Nome: String; out Erro: String): Boolean;
    function InserirAcao(Acao: TUcAcao; out Erro: string): Boolean;
    function BuscarAcaoPorNome(Acao: TUcAcao; out Erro: String): Boolean;
    function InserirAcesso(Acesso: TUcAcesso; out Erro: string): Boolean;
    function RemoverAcesso(Id: Integer; out Erro: string): Boolean;
    function BuscarAcessoPorId(Acesso: TUcAcesso; out Erro: String): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
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
  var lbTitulo: TCheckListBox; Tela: String);
var
  sql: String;
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

function TUsuarioAcessoDAO.Excluir(Id: Integer; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'delete from banco where id = :id';

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
        sql := 'update banco set excluido = true ' +
               'where id = :id';

        Qry.Close;
        Qry.SQL.Clear;
        Qry.SQL.Add(sql);
        Qry.ParamByName('id').AsInteger  := Id;
        Qry.ExecSQL;
        dmConexao1.SQLTransaction.Commit;

      except on E: Exception do
        begin
          Erro := 'Ocorreu um erro ao excluir banco: ' + sLineBreak + E.Message;
          Result := False;
        end;
      end;
    end;
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

