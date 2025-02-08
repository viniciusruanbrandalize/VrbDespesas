unit controller.participante;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, model.entity.participante,
  model.dao.participante, model.connection.conexao1;

type

  { TParticipanteController }

  TParticipanteController = class
  private
    ParticipanteDAO: TParticipanteDAO;
  public
    Participante: TParticipante;
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    procedure PesquisarCidade(lbNome, lbId: TListBox; busca: String; out QtdRegistro: Integer);
    procedure PesquisarDonoCadastro(var objParticipante: TParticipante; out Erro: string);
    function BuscarCEP(var objParticipante: TParticipante; out Erro: String): Boolean;
    function BuscarPorId(objParticipante : TParticipante; Id: Integer; out Erro: String): Boolean;
    function Inserir(objParticipante : TParticipante; out Erro: string): Boolean;
    function Editar(objParticipante : TParticipante; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TParticipanteController }

procedure TParticipanteController.Listar(lv: TListView);
begin
  ParticipanteDAO.Listar(lv);
end;

procedure TParticipanteController.Pesquisar(lv: TListView; Campo, Busca: String);
begin
  ParticipanteDAO.Pesquisar(lv, Campo, Busca);
end;

procedure TParticipanteController.PesquisarCidade(lbNome, lbId: TListBox;
  busca: String; out QtdRegistro: Integer);
begin
  ParticipanteDAO.PesquisarCidade(lbNome, lbId, busca, QtdRegistro);
end;

procedure TParticipanteController.PesquisarDonoCadastro(var objParticipante: TParticipante;
  out Erro: string);
begin
  ParticipanteDAO.BuscarPorId(objParticipante, 0, Erro, True);
end;

function TParticipanteController.BuscarCEP(var objParticipante: TParticipante;
  out Erro: String): Boolean;
begin
  //
end;

function TParticipanteController.BuscarPorId(objParticipante: TParticipante; Id: Integer; out
  Erro: String): Boolean;
begin
  Result := ParticipanteDAO.BuscarPorId(objParticipante, Id, Erro);
end;

function TParticipanteController.Inserir(objParticipante: TParticipante; out Erro: string): Boolean;
begin
  objParticipante.Id := ParticipanteDAO.GerarId('gen_id_participante');
  objParticipante.UsuarioCadastro.Id := dmConexao1.IdUsuario;
  Result := ParticipanteDAO.Inserir(objParticipante, Erro);
end;

function TParticipanteController.Editar(objParticipante: TParticipante; out Erro: string): Boolean;
begin
  Result := ParticipanteDAO.Editar(objParticipante, Erro);
end;

function TParticipanteController.Excluir(Id: Integer; out Erro: string): Boolean;
begin
  Result := ParticipanteDAO.Excluir(Id, Erro);
end;

constructor TParticipanteController.Create;
begin
  Participante    := TParticipante.Create;
  ParticipanteDAO := TParticipanteDAO.Create;
end;

destructor TParticipanteController.Destroy;
begin
  Participante.Free;
  ParticipanteDAO.Free;
  inherited Destroy;
end;

end.
