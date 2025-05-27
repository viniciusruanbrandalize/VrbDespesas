unit model.dao.usuarioacesso;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, SQLDB, model.dao.padrao, model.entity.uctela,
  model.entity.ucacao, model.connection.conexao1, CheckLst, StdCtrls;

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
      lbNome.Items.Add(qry.FieldByName('nome').AsString);
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

