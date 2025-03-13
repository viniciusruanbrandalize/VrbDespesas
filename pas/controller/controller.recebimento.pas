unit controller.recebimento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, model.entity.recebimento,
  model.dao.recebimento, model.dao.padrao, model.connection.conexao1;

type

  { TRecebimentoController }

  TRecebimentoController = class
  private
    RecebimentoDao: TRecebimentoDAO;
  public
    Recebimento: TRecebimento;
    procedure Listar(lv: TListView; Tipo: Integer);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    procedure PesquisarPagador(lbNome, lbId: TListBox; busca: String; out QtdRegistro: Integer);
    procedure PesquisarFormaPagamento(lbNome, lbId: TListBox; busca: String; out QtdRegistro: Integer);
    procedure PesquisarContaBancaria(CbNome: TComboBox; lbId: TListBox; out QtdRegistro: Integer);
    function BuscarPorId(objRecebimento : TRecebimento; Id: Integer; out Erro: String): Boolean;
    function Inserir(objRecebimento: TRecebimento; out Erro: string): Boolean;
    function Editar(objRecebimento: TRecebimento; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    function CalcularValorTotal(INSS, IR, HE, Outros, ValorBase: Currency): Currency;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TRecebimentoController }

procedure TRecebimentoController.Listar(lv: TListView; Tipo: Integer);
begin
  RecebimentoDao.Listar(lv, Tipo);
end;

procedure TRecebimentoController.Pesquisar(lv: TListView; Campo, Busca: String);
begin
  RecebimentoDao.Pesquisar(lv, campo, busca);
end;

procedure TRecebimentoController.PesquisarPagador(lbNome, lbId: TListBox;
  busca: String; out QtdRegistro: Integer);
begin
  RecebimentoDao.PesquisaGenerica(TB_PARTICIPANTE, lbNome, lbId, busca, 10, QtdRegistro);
end;

procedure TRecebimentoController.PesquisarFormaPagamento(lbNome,
  lbId: TListBox; busca: String; out QtdRegistro: Integer);
begin
  RecebimentoDao.PesquisaGenerica(TB_FORMA_PGTO, lbNome, lbId, busca, 10, QtdRegistro);
end;

procedure TRecebimentoController.PesquisarContaBancaria(CbNome: TComboBox;
  lbId: TListBox; out QtdRegistro: Integer);
begin
  RecebimentoDao.PesquisarContaBancaria(CbNome, lbId, '', -1, QtdRegistro);
end;

function TRecebimentoController.BuscarPorId(objRecebimento: TRecebimento; Id: Integer; out
  Erro: String): Boolean;
begin
  Result := RecebimentoDao.BuscarPorId(objRecebimento, Id, Erro);
end;

function TRecebimentoController.Inserir(objRecebimento: TRecebimento; out Erro: string): Boolean;
begin
  objRecebimento.Id := RecebimentoDao.GerarId(SEQ_ID_Recebimento);
  objRecebimento.UsuarioCadastro.Id := dmConexao1.IdUsuario;
  Result := RecebimentoDao.Inserir(objRecebimento, Erro);
end;

function TRecebimentoController.Editar(objRecebimento: TRecebimento; out Erro: string): Boolean;
begin
  Result := RecebimentoDao.Editar(objRecebimento, Erro);
end;

function TRecebimentoController.Excluir(Id: Integer; out Erro: string): Boolean;
begin
  Result := RecebimentoDao.Excluir(Id, Erro);
end;

function TRecebimentoController.CalcularValorTotal(INSS, IR, HE, Outros,
  ValorBase: Currency): Currency;
begin
  Result := (ValorBase + HE + Outros) - (INSS + IR);
end;

constructor TRecebimentoController.Create;
begin
  Recebimento    := TRecebimento.Create;
  RecebimentoDao := TRecebimentoDAO.Create;
end;

destructor TRecebimentoController.Destroy;
begin
  Recebimento.Free;
  RecebimentoDao.Free;
  inherited Destroy;
end;

end.

