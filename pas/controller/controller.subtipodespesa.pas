unit controller.subtipodespesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, model.entity.subtipodespesa,
  model.dao.subtipodespesa;

type

  { TSubtipoDespesaController }

  TSubtipoDespesaController = class
  private
    SubtipoDespesaDAO: TSubtipoDespesaDAO;
  public
    SubtipoDespesa: TSubtipoDespesa;
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    procedure PesquisarTipoDespesa(lbNome, lbId: TListBox; busca: String; out QtdRegistro: Integer);
    function BuscarPorId(objSubtipoDespesa : TSubtipoDespesa; Id: Integer; out Erro: String): Boolean;
    function Inserir(objSubtipoDespesa : TSubtipoDespesa; out Erro: string): Boolean;
    function Editar(objSubtipoDespesa : TSubtipoDespesa; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TSubtipoDespesaController }

procedure TSubtipoDespesaController.Listar(lv: TListView);
begin
  SubtipoDespesaDAO.Listar(lv);
end;

procedure TSubtipoDespesaController.Pesquisar(lv: TListView; Campo, Busca: String);
begin
  SubtipoDespesaDAO.Pesquisar(lv, Campo, Busca);
end;

procedure TSubtipoDespesaController.PesquisarTipoDespesa(lbNome, lbId: TListBox; busca: String;
  out QtdRegistro: Integer);
begin
  SubtipoDespesaDAO.PesquisarTipoDespesa(lbNome, lbId, busca, QtdRegistro);
end;

function TSubtipoDespesaController.BuscarPorId(objSubtipoDespesa: TSubtipoDespesa; Id: Integer; out
  Erro: String): Boolean;
begin
  Result := SubtipoDespesaDAO.BuscarPorId(objSubtipoDespesa, Id, Erro);
end;

function TSubtipoDespesaController.Inserir(objSubtipoDespesa: TSubtipoDespesa; out Erro: string): Boolean;
begin
  objSubtipoDespesa.Id := SubtipoDespesaDAO.GerarId('gen_id_subtipo_despesa');
  Result := SubtipoDespesaDAO.Inserir(objSubtipoDespesa, Erro);
end;

function TSubtipoDespesaController.Editar(objSubtipoDespesa: TSubtipoDespesa; out Erro: string): Boolean;
begin
  Result := SubtipoDespesaDAO.Editar(objSubtipoDespesa, Erro);
end;

function TSubtipoDespesaController.Excluir(Id: Integer; out Erro: string): Boolean;
begin
  Result := SubtipoDespesaDAO.Excluir(Id, Erro);
end;

constructor TSubtipoDespesaController.Create;
begin
  SubtipoDespesa    := TSubTipoDespesa.Create;
  SubtipoDespesaDAO := TSubTipoDespesaDAO.Create;
end;

destructor TSubtipoDespesaController.Destroy;
begin
  SubtipoDespesa.Free;
  SubtipoDespesaDAO.Free;
  inherited Destroy;
end;

end.
