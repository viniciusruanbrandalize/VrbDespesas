unit controller.despesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, model.entity.despesa,
  model.dao.despesa;

type

  { TDespesaController }

  TDespesaController = class
  private
    DespesaDAO: TDespesaDAO;
  public
    Despesa: TDespesa;
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    function BuscarPorId(objDespesa : TDespesa; Id: Integer; out Erro: String): Boolean;
    function Inserir(objDespesa : TDespesa; out Erro: string): Boolean;
    function Editar(objDespesa : TDespesa; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
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

function TDespesaController.BuscarPorId(objDespesa: TDespesa; Id: Integer; out
  Erro: String): Boolean;
begin
  Result := DespesaDAO.BuscarPorId(objDespesa, Id, Erro);
end;

function TDespesaController.Inserir(objDespesa: TDespesa; out Erro: string): Boolean;
begin
  objDespesa.Id := DespesaDAO.GerarId('gen_id_despesa');
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
