unit controller.contabancaria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, model.entity.contabancaria,
  model.dao.contabancaria, model.connection.conexao1;

type

  { TContaBancariaController }

  TContaBancariaController = class
  private
    ContaBancariaDAO: TContaBancariaDAO;
  public
    ContaBancaria: TContaBancaria;
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    procedure PesquisarBanco(lbNome, lbId: TListBox; busca: String; out QtdRegistro: Integer);
    function BuscarPorId(objContaBancaria : TContaBancaria; Id: Integer; out Erro: String): Boolean;
    function Inserir(objContaBancaria : TContaBancaria; out Erro: string): Boolean;
    function Editar(objContaBancaria : TContaBancaria; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TContaBancariaController }

procedure TContaBancariaController.Listar(lv: TListView);
begin
  ContaBancariaDAO.Listar(lv);
end;

procedure TContaBancariaController.Pesquisar(lv: TListView; Campo, Busca: String);
begin
  ContaBancariaDAO.Pesquisar(lv, Campo, Busca);
end;

procedure TContaBancariaController.PesquisarBanco(lbNome, lbId: TListBox;
  busca: String; out QtdRegistro: Integer);
begin
  ContaBancariaDAO.PesquisarBanco(lbNome, lbId, busca, QtdRegistro);
end;

function TContaBancariaController.BuscarPorId(objContaBancaria: TContaBancaria; Id: Integer; out
  Erro: String): Boolean;
begin
  Result := ContaBancariaDAO.BuscarPorId(objContaBancaria, Id, Erro);
end;

function TContaBancariaController.Inserir(objContaBancaria: TContaBancaria; out Erro: string): Boolean;
begin
  objContaBancaria.Id := ContaBancariaDAO.GerarId('gen_id_conta_bancaria');
  objContaBancaria.UsuarioCadastro.Id := dmConexao1.IdUsuario;
  Result := ContaBancariaDAO.Inserir(objContaBancaria, Erro);
end;

function TContaBancariaController.Editar(objContaBancaria: TContaBancaria; out Erro: string): Boolean;
begin
  Result := ContaBancariaDAO.Editar(objContaBancaria, Erro);
end;

function TContaBancariaController.Excluir(Id: Integer; out Erro: string): Boolean;
begin
  Result := ContaBancariaDAO.Excluir(Id, Erro);
end;

constructor TContaBancariaController.Create;
begin
  ContaBancaria    := TContaBancaria.Create;
  ContaBancariaDAO := TContaBancariaDAO.Create;
end;

destructor TContaBancariaController.Destroy;
begin
  ContaBancaria.Free;
  ContaBancariaDAO.Free;
  inherited Destroy;
end;

end.
