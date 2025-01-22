unit controller.tipodespesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, model.entity.tipodespesa,
  model.dao.tipodespesa;

type

  { TTipoDespesaController }

  TTipoDespesaController = class
  private
    TipoDespesaDAO: TTipoDespesaDAO;
  public
    TipoDespesa: TTipoDespesa;
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    function BuscarPorId(objTipoDespesa : TTipoDespesa; Id: Integer; out Erro: String): Boolean;
    function Inserir(objTipoDespesa : TTipoDespesa; out Erro: string): Boolean;
    function Editar(objTipoDespesa : TTipoDespesa; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TTipoDespesaController }

procedure TTipoDespesaController.Listar(lv: TListView);
begin
  TipoDespesaDAO.Listar(lv);
end;

procedure TTipoDespesaController.Pesquisar(lv: TListView; Campo, Busca: String);
begin
  TipoDespesaDAO.Pesquisar(lv, Campo, Busca);
end;

function TTipoDespesaController.BuscarPorId(objTipoDespesa: TTipoDespesa; Id: Integer; out
  Erro: String): Boolean;
begin
  Result := TipoDespesaDAO.BuscarPorId(objTipoDespesa, Id, Erro);
end;

function TTipoDespesaController.Inserir(objTipoDespesa: TTipoDespesa; out Erro: string): Boolean;
begin
  objTipoDespesa.Id := TipoDespesaDAO.GerarId('gen_id_tipo_despesa');
  Result := TipoDespesaDAO.Inserir(objTipoDespesa, Erro);
end;

function TTipoDespesaController.Editar(objTipoDespesa: TTipoDespesa; out Erro: string): Boolean;
begin
  Result := TipoDespesaDAO.Editar(objTipoDespesa, Erro);
end;

function TTipoDespesaController.Excluir(Id: Integer; out Erro: string): Boolean;
begin
  Result := TipoDespesaDAO.Excluir(Id, Erro);
end;

constructor TTipoDespesaController.Create;
begin
  TipoDespesa    := TTipoDespesa.Create;
  TipoDespesaDAO := TTipoDespesaDAO.Create;
end;

destructor TTipoDespesaController.Destroy;
begin
  TipoDespesa.Free;
  TipoDespesaDAO.Free;
  inherited Destroy;
end;

end.
