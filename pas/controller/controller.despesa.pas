unit controller.despesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, model.entity.despesa, model.dao.padrao,
  model.dao.despesa, model.entity.despesaformapagamento, model.connection.conexao1;

type

  { TDespesaController }

  TDespesaController = class
  private
    DespesaDAO: TDespesaDAO;
  public
    Despesa: TDespesa;
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    procedure PesquisarSubtipo(lbNome, lbId: TListBox; busca: String; out QtdRegistro: Integer);
    procedure PesquisarFornecedor(lbNome, lbId: TListBox; busca: String; out QtdRegistro: Integer);
    procedure PesquisarFormaPagamento(lbNome, lbId: TListBox; busca: String; out QtdRegistro: Integer);
    function BuscarPorId(objDespesa : TDespesa; Id: Integer; out Erro: String): Boolean;
    function Inserir(objDespesa : TDespesa; out Erro: string): Boolean;
    function Editar(objDespesa : TDespesa; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;

    procedure ListarPagamento(lv: TListView; IdDespesa: Integer);
    function BuscarPagamentoPorId(objPagamento : TDespesaFormaPagamento; Id: Integer; out Erro: String): Boolean;
    procedure CriarPagamento();
    procedure DestruirUltimoPagamento();
    function ExcluirPagamento(Id: Integer): Boolean;
    function CalcularValorTotal(Valor, Desconto, Frete, Outros: Currency): Currency;
    function ValorPagoEhValido(Total: Double): Boolean;

    procedure ListarArquivos(lv: TListView; IdDespesa: Integer);

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TDespesaController }

procedure TDespesaController.Listar(lv: TListView);
begin
  DespesaDAO.Listar(lv);
end;

procedure TDespesaController.Pesquisar(lv: TListView; Campo, Busca: String);
begin
  DespesaDAO.Pesquisar(lv, Campo, Busca);
end;

procedure TDespesaController.PesquisarSubtipo(lbNome, lbId: TListBox;
  busca: String; out QtdRegistro: Integer);
begin
  DespesaDAO.PesquisaGenerica(TB_SUBTIPO_DESPESA, lbNome, lbId, busca, 10, QtdRegistro);
end;

procedure TDespesaController.PesquisarFornecedor(lbNome, lbId: TListBox;
  busca: String; out QtdRegistro: Integer);
begin
  DespesaDAO.PesquisaGenerica(TB_PARTICIPANTE, lbNome, lbId, busca, 10, QtdRegistro);
end;

procedure TDespesaController.PesquisarFormaPagamento(lbNome, lbId: TListBox;
  busca: String; out QtdRegistro: Integer);
begin
  DespesaDAO.PesquisaGenerica(TB_FORMA_PGTO, lbNome, lbId, busca, 10, QtdRegistro);
end;

function TDespesaController.BuscarPorId(objDespesa: TDespesa; Id: Integer; out
  Erro: String): Boolean;
begin
  Result := DespesaDAO.BuscarPorId(objDespesa, Id, Erro);
end;

function TDespesaController.Inserir(objDespesa: TDespesa; out Erro: string): Boolean;
begin
  objDespesa.DonoCadastro.Id    := 77;  //alterar
  objDespesa.UsuarioCadastro.Id := dmConexao1.IdUsuario;
  objDespesa.Id := DespesaDAO.GerarId(SEQ_ID_DESPESA);
  Result := DespesaDAO.Inserir(objDespesa, Erro);
end;

function TDespesaController.Editar(objDespesa: TDespesa; out Erro: string): Boolean;
begin
  Result := DespesaDAO.Editar(objDespesa, Erro);
end;

function TDespesaController.Excluir(Id: Integer; out Erro: string): Boolean;
begin
  Result := DespesaDAO.Excluir(Id, Erro);
end;

procedure TDespesaController.ListarPagamento(lv: TListView; IdDespesa: Integer);
begin
  DespesaDAO.ListarPagamento(lv, IdDespesa);
end;

function TDespesaController.BuscarPagamentoPorId(
  objPagamento: TDespesaFormaPagamento; Id: Integer; out Erro: String): Boolean;
begin
  Result := DespesaDAO.BuscarPagamentoPorId(objPagamento, Id, Erro);
end;

procedure TDespesaController.CriarPagamento();
begin
  Despesa.DespesaFormaPagamento.Add(TDespesaFormaPagamento.Create);
end;

procedure TDespesaController.DestruirUltimoPagamento();
begin
  Despesa.DespesaFormaPagamento.Delete(Despesa.DespesaFormaPagamento.Count-1);
end;

function TDespesaController.ExcluirPagamento(Id: Integer): Boolean;
begin
  Despesa.DespesaFormaPagamento.Delete(id);
  Result := True;
end;

function TDespesaController.CalcularValorTotal(Valor, Desconto, Frete,
  Outros: Currency): Currency;
begin
  Result := (Valor + Outros + Frete) - Desconto;
end;

function TDespesaController.ValorPagoEhValido(Total: Double): Boolean;
var
  i: Integer;
  Pago: Double;
begin
  Pago := 0;

  for i := 0 to Despesa.DespesaFormaPagamento.Count-1 do
  begin
    Pago := Pago + Despesa.DespesaFormaPagamento[i].Valor;
  end;

  Result := Pago < Total;
end;

procedure TDespesaController.ListarArquivos(lv: TListView; IdDespesa: Integer);
begin
  DespesaDAO.ListarArquivos(lv, IdDespesa);
end;

constructor TDespesaController.Create;
begin
  Despesa    := TDespesa.Create;
  DespesaDAO := TDespesaDAO.Create;
end;

destructor TDespesaController.Destroy;
begin
  Despesa.Free;
  DespesaDAO.Free;
  inherited Destroy;
end;

end.
