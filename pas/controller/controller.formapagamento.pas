unit controller.formapagamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, model.entity.formapagamento, model.dao.padrao,
  model.dao.formapagamento;

type

  { TFormaPagamentoController }

  TFormaPagamentoController = class
  private
    FormaPagamentoDAO: TFormaPagamentoDAO;
  public
    FormaPagamento: TFormaPagamento;
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    function BuscarPorId(objFormaPagamento : TFormaPagamento; Id: Integer; out Erro: String): Boolean;
    function Inserir(objFormaPagamento: TFormaPagamento; out Erro: string): Boolean;
    function Editar(objFormaPagamento: TFormaPagamento; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TFormaPagamentoController }

procedure TFormaPagamentoController.Listar(lv: TListView);
begin
  FormaPagamentoDAO.Listar(lv);
end;

procedure TFormaPagamentoController.Pesquisar(lv: TListView; Campo,
  Busca: String);
begin
  FormaPagamentoDAO.Pesquisar(lv, Campo, Busca);
end;

function TFormaPagamentoController.BuscarPorId(objFormaPagamento: TFormaPagamento; Id: Integer; out
  Erro: String): Boolean;
begin
  Result := FormaPagamentoDAO.BuscarPorId(objFormaPagamento, Id, Erro);
end;

function TFormaPagamentoController.Inserir(objFormaPagamento: TFormaPagamento; out Erro: string): Boolean;
begin
  Result := FormaPagamentoDAO.Inserir(objFormaPagamento, Erro);
end;

function TFormaPagamentoController.Editar(objFormaPagamento: TFormaPagamento; out Erro: string): Boolean;
begin
  Result := FormaPagamentoDAO.Editar(objFormaPagamento, Erro);
end;

function TFormaPagamentoController.Excluir(Id: Integer; out Erro: string): Boolean;
begin
  Result := FormaPagamentoDAO.Excluir(Id, Erro);
end;

constructor TFormaPagamentoController.Create;
begin
  FormaPagamento    := TFormaPagamento.Create;
  FormaPagamentoDAO := TFormaPagamentoDAO.Create;
end;

destructor TFormaPagamentoController.Destroy;
begin
  FormaPagamento.Free;
  FormaPagamentoDAO.Free;
  inherited Destroy;
end;

end.

