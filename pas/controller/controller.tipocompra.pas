unit controller.tipocompra;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, model.entity.tipocompra,
  model.dao.tipocompra;

type

  { TTipoCompraController }

  TTipoCompraController = class
  private
    TipoCompraDAO: TTipoCompraDAO;
  public
    TipoCompra: TTipoCompra;
    procedure Listar(lv: TListView);
    function BuscarPorId(objTipoCompra : TTipoCompra; Id: Integer; out Erro: String): Boolean;
    function Inserir(objTipoCompra : TTipoCompra; out Erro: string): Boolean;
    function Editar(objTipoCompra : TTipoCompra; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TTipoCompraController }

procedure TTipoCompraController.Listar(lv: TListView);
begin
  TipoCompraDAO.Listar(lv);
end;

function TTipoCompraController.BuscarPorId(objTipoCompra: TTipoCompra; Id: Integer; out
  Erro: String): Boolean;
begin
  Result := TipoCompraDAO.BuscarPorId(objTipoCompra, Id, Erro);
end;

function TTipoCompraController.Inserir(objTipoCompra: TTipoCompra; out Erro: string): Boolean;
begin
  Result := TipoCompraDAO.Inserir(objTipoCompra, Erro);
end;

function TTipoCompraController.Editar(objTipoCompra: TTipoCompra; out Erro: string): Boolean;
begin
  Result := TipoCompraDAO.Editar(objTipoCompra, Erro);
end;

function TTipoCompraController.Excluir(Id: Integer; out Erro: string): Boolean;
begin
  Result := TipoCompraDAO.Excluir(Id, Erro);
end;

constructor TTipoCompraController.Create;
begin
  TipoCompra    := TTipoCompra.Create;
  TipoCompraDAO := TTipoCompraDAO.Create;
end;

destructor TTipoCompraController.Destroy;
begin
  TipoCompra.Free;
  TipoCompraDAO.Free;
  inherited Destroy;
end;

end.
