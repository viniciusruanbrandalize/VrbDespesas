unit controller.banco;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, model.entity.banco, model.dao.banco,
  model.dao.padrao;

type

  { TBancoController }

  TBancoController = class
  private
    BancoDao: TBancoDAO;
  public
    Banco: TBanco;
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    function BuscarPorId(objBanco : TBanco; Id: Integer; out Erro: String): Boolean;
    function Inserir(objBanco: TBanco; out Erro: string): Boolean;
    function Editar(objBanco: TBanco; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TBancoController }

procedure TBancoController.Listar(lv: TListView);
begin
  BancoDao.Listar(lv);
end;

procedure TBancoController.Pesquisar(lv: TListView; Campo, Busca: String);
begin
  BancoDao.Pesquisar(lv, campo, busca);
end;

function TBancoController.BuscarPorId(objBanco: TBanco; Id: Integer; out
  Erro: String): Boolean;
begin
  Result := BancoDao.BuscarPorId(objBanco, Id, Erro);
end;

function TBancoController.Inserir(objBanco: TBanco; out Erro: string): Boolean;
begin
  objBanco.Id := BancoDao.GerarId(SEQ_ID_BANCO);
  Result := BancoDao.Inserir(objBanco, Erro);
end;

function TBancoController.Editar(objBanco: TBanco; out Erro: string): Boolean;
begin
  Result := BancoDao.Editar(objBanco, Erro);
end;

function TBancoController.Excluir(Id: Integer; out Erro: string): Boolean;
begin
  Result := BancoDao.Excluir(Id, Erro);
end;

constructor TBancoController.Create;
begin
  Banco    := TBanco.Create;
  BancoDao := TBancoDAO.Create;
end;

destructor TBancoController.Destroy;
begin
  Banco.Free;
  BancoDao.Free;
  inherited Destroy;
end;

end.

