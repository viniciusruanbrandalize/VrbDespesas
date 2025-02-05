unit controller.contabancaria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, model.entity.contabancaria,
  model.entity.cartao, model.entity.pix, model.dao.contabancaria,
  model.connection.conexao1;

type

  { TContaBancariaController }

  TContaBancariaController = class
  private
    ContaBancariaDAO: TContaBancariaDAO;
  public
    ContaBancaria: TContaBancaria;
    Pix: TPix;
    Cartao: TCartao;
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    procedure PesquisarBanco(lbNome, lbId: TListBox; busca: String; out QtdRegistro: Integer);
    function BuscarPorId(objContaBancaria : TContaBancaria; Id: Integer; out Erro: String): Boolean;
    function Inserir(objContaBancaria : TContaBancaria; out Erro: string): Boolean;
    function Editar(objContaBancaria : TContaBancaria; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;

    {$Region ''}
    procedure ListarPix(lv: TListView; IdConta: Integer);
    function BuscarPixPorId(objPix : TPix; Id: String; out Erro: String): Boolean;
    function InserirPix(objPix : TPix; out Erro: string): Boolean;
    function EditarPix(objPix : TPix; out Erro: string): Boolean;

    {$EndRegion}

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

procedure TContaBancariaController.ListarPix(lv: TListView; IdConta: Integer);
begin
  ContaBancariaDAO.ListarPix(lv, IdConta);
end;

function TContaBancariaController.BuscarPixPorId(objPix: TPix; Id: String; out
  Erro: String): Boolean;
begin
  Result := ContaBancariaDAO.BuscarPixPorId(objPix, id, erro);
end;

function TContaBancariaController.InserirPix(objPix: TPix; out Erro: string
  ): Boolean;
begin
  objPix.UsuarioCadastro.Id := dmConexao1.IdUsuario;
  Result := ContaBancariaDAO.InserirPix(objPix, Erro);
end;

function TContaBancariaController.EditarPix(objPix: TPix; out Erro: string
  ): Boolean;
begin
  Result := ContaBancariaDAO.EditarPix(objPix, Erro);
end;

constructor TContaBancariaController.Create;
begin
  ContaBancaria    := TContaBancaria.Create;
  ContaBancariaDAO := TContaBancariaDAO.Create;
  Pix              := TPix.Create;
  Cartao           := TCartao.Create;
end;

destructor TContaBancariaController.Destroy;
begin
  ContaBancaria.Free;
  ContaBancariaDAO.Free;
  Pix.Free;
  Cartao.Free;
  inherited Destroy;
end;

end.
