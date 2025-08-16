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

unit controller.despesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, model.entity.despesa, model.dao.padrao,
  model.dao.despesa, model.entity.despesaformapagamento, model.entity.arquivo,
  model.connection.conexao1, Dialogs, model.dao.configuracao,
  model.entity.configuracao;

type

  { TDespesaController }

  TDespesaController = class
  private
    DespesaDAO: TDespesaDAO;
  public
    Despesa: TDespesa;
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String; DataInicial, DataFinal: TDateTime);
    procedure PesquisarSubtipo(lbNome: TComboBox; lbId: TListBox; busca: String; out QtdRegistro: Integer);
    procedure PesquisarFornecedor(lbNome: TComboBox; lbId: TListBox; busca: String; out QtdRegistro: Integer);
    procedure PesquisarFormaPagamento(lbNome: TComboBox; lbId: TListBox; busca: String; out QtdRegistro: Integer);
    function BuscarPorId(objDespesa : TDespesa; Id: Integer; out Erro: String): Boolean;
    function Inserir(objDespesa : TDespesa; out Erro: string): Boolean;
    function Editar(objDespesa : TDespesa; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    function BuscarConfiguracaoPorNome(Nome: String; out Erro: String): String;

    procedure ListarPagamento(lv: TListView; IdDespesa: Integer);
    function BuscarPagamentoPorId(objPagamento : TDespesaFormaPagamento; Id: Integer; out Erro: String): Boolean;
    procedure AdicionarPagamento();
    procedure DeletarUltimoPagamento();
    function ExcluirPagamento(Id: Integer): Boolean;
    function CalcularValorTotal(Valor, Desconto, Frete, Outros: Currency): Currency;
    function ValorPagoEhValido(Total: Double): Boolean;
    procedure PesquisarCartao(CbNome: TComboBox; lbId: TListBox; out QtdRegistro: Integer);
    procedure PesquisarPix(CbNome: TComboBox; lbId: TListBox; out QtdRegistro: Integer);
    procedure PesquisarContaBancaria(CbNome: TComboBox; lbId: TListBox; out QtdRegistro: Integer);

    procedure ListarArquivos(lv: TListView; objDespesa: TDespesa);
    procedure AdicionarArquivo(objDespesa: TDespesa);
    function ExcluirArquivo(objDespesa: TDespesa; Id, Index: Integer; out Erro: String): Boolean;
    procedure CancelarAtualizacaoArquivo();

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TDespesaController }

procedure TDespesaController.Listar(lv: TListView);
begin
  DespesaDAO.Listar(lv);
end;

procedure TDespesaController.Pesquisar(lv: TListView; Campo, Busca: String; DataInicial, DataFinal: TDateTime);
begin
  DespesaDAO.Pesquisar(lv, Campo, Busca, DataInicial, DataFinal);
end;

procedure TDespesaController.PesquisarSubtipo(lbNome: TComboBox; lbId: TListBox;
  busca: String; out QtdRegistro: Integer);
begin
  DespesaDAO.PesquisaGenerica(TB_SUBTIPO_DESPESA, lbNome, lbId, busca, 10, QtdRegistro);
end;

procedure TDespesaController.PesquisarFornecedor(lbNome: TComboBox; lbId: TListBox;
  busca: String; out QtdRegistro: Integer);
begin
  DespesaDAO.PesquisaGenerica(TB_PARTICIPANTE, lbNome, lbId, busca, 10, QtdRegistro);
end;

procedure TDespesaController.PesquisarFormaPagamento(lbNome: TComboBox; lbId: TListBox;
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
  objDespesa.DonoCadastro.Id    := dmConexao1.DonoCadastro.Id;
  objDespesa.UsuarioCadastro.Id := dmConexao1.Usuario.Id;
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

function TDespesaController.BuscarConfiguracaoPorNome(Nome: String; out Erro: String): String;
var
  ConfigDAO: TConfiguracaoDAO;
  Configuracao: TConfiguracao;
begin
  Configuracao := TConfiguracao.Create;
  try
    ConfigDAO := TConfiguracaoDAO.Create;
    try
      if ConfigDAO.BuscarPorNome(Configuracao, Nome, Erro) then
        Result := Configuracao.Valor
      else
        Result := '';
    finally
      ConfigDAO.Free;
    end;
  finally
    Configuracao.Free;
  end;
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

procedure TDespesaController.AdicionarPagamento();
begin
  Despesa.DespesaFormaPagamento.Add(TDespesaFormaPagamento.Create);
end;

procedure TDespesaController.DeletarUltimoPagamento();
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

procedure TDespesaController.PesquisarCartao(CbNome: TComboBox; lbId: TListBox;
  out QtdRegistro: Integer);
begin
  DespesaDAO.PesquisarCartao(CbNome, lbId, '', -1, QtdRegistro);
end;

procedure TDespesaController.PesquisarPix(CbNome: TComboBox; lbId: TListBox;
  out QtdRegistro: Integer);
begin
  DespesaDAO.PesquisarPix(CbNome, lbId, '', -1, QtdRegistro);
end;

procedure TDespesaController.PesquisarContaBancaria(CbNome: TComboBox;
  lbId: TListBox; out QtdRegistro: Integer);
begin
  DespesaDAO.PesquisarContaBancaria(CbNome, lbId, '', -1, QtdRegistro);
end;

procedure TDespesaController.ListarArquivos(lv: TListView; objDespesa: TDespesa);
var
  i: Integer;
  item: TListItem;
begin
  for i := 0 to Despesa.Arquivo.Count-1 do
  begin
    item := lv.Items.Add;
    item.Caption := objDespesa.Arquivo[i].Id.ToString;
    item.SubItems.Add(objDespesa.Arquivo[i].Nome);
    item.SubItems.Add(objDespesa.Arquivo[i].Extensao);
    item.SubItems.Add(DateTimeToStr(objDespesa.Arquivo[i].DataHoraUpload));
  end;
end;

procedure TDespesaController.AdicionarArquivo(objDespesa: TDespesa);
begin
  objDespesa.Arquivo.Add(TArquivo.Create);
end;

function TDespesaController.ExcluirArquivo(objDespesa: TDespesa; Id, Index: Integer;
  out Erro: String): Boolean;
begin
  objDespesa.Arquivo.Delete(Index);
  if not (id = 0) then
    Result := DespesaDAO.ExcluirArquivo(Id, Erro);
end;

procedure TDespesaController.CancelarAtualizacaoArquivo();
begin
  DespesaDAO.Roolback(2);
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
