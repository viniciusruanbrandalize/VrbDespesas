unit controller.bandeira;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, model.entity.bandeira, model.dao.bandeira;

type

  { TBandeiraController }

  TBandeiraController = class
  private
    BandeiraDAO: TBandeiraDAO;
  public
    Bandeira: TBandeira;
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    function BuscarPorId(objBandeira : TBandeira; Id: Integer; out Erro: String): Boolean;
    function Inserir(objBandeira: TBandeira; out Erro: string): Boolean;
    function Editar(objBandeira: TBandeira; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TBandeiraController }

procedure TBandeiraController.Listar(lv: TListView);
begin
  BandeiraDAO.Listar(lv);
end;

procedure TBandeiraController.Pesquisar(lv: TListView; Campo, Busca: String);
begin
  BandeiraDAO.Pesquisar(lv, campo, busca);
end;

function TBandeiraController.BuscarPorId(objBandeira: TBandeira; Id: Integer; out
  Erro: String): Boolean;
begin
  Result := BandeiraDAO.BuscarPorId(objBandeira, Id, Erro);
end;

function TBandeiraController.Inserir(objBandeira: TBandeira; out Erro: string): Boolean;
begin
  objBandeira.Id := BandeiraDAO.GerarId('gen_id_bandeira');
  Result := BandeiraDAO.Inserir(objBandeira, Erro);
end;

function TBandeiraController.Editar(objBandeira: TBandeira; out Erro: string): Boolean;
begin
  Result := BandeiraDAO.Editar(objBandeira, Erro);
end;

function TBandeiraController.Excluir(Id: Integer; out Erro: string): Boolean;
begin
  Result := BandeiraDAO.Excluir(Id, Erro);
end;

constructor TBandeiraController.Create;
begin
  Bandeira    := TBandeira.Create;
  BandeiraDAO := TBandeiraDAO.Create;
end;

destructor TBandeiraController.Destroy;
begin
  Bandeira.Free;
  BandeiraDAO.Free;
  inherited Destroy;
end;

end.

