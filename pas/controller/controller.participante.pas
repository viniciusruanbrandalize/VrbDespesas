unit controller.participante;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, model.entity.participante,
  model.dao.participante, model.dao.padrao, model.connection.conexao1, lib.cep;

type

  { TParticipanteController }

  TParticipanteController = class
  private
    ParticipanteDAO: TParticipanteDAO;
  public
    Participante: TParticipante;
    procedure Listar(lv: TListView; DonoCadastro: Boolean);
    procedure Pesquisar(lv: TListView; Campo, Busca: String; DonoCadastro: Boolean);
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

procedure TParticipanteController.Listar(lv: TListView; DonoCadastro: Boolean);
begin
  ParticipanteDAO.Listar(lv, DonoCadastro);
end;

procedure TParticipanteController.Pesquisar(lv: TListView; Campo, Busca: String;
  DonoCadastro: Boolean);
begin
  ParticipanteDAO.Pesquisar(lv, Campo, Busca, DonoCadastro);
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
var
  LibCEP: TLibCep;
  consultou: Boolean;
begin
  LibCEP := TLibCep.Create;
  try
    consultou := LibCEP.BuscarPorCep(objParticipante.CEP, Erro);
    if consultou then
    begin
      objParticipante.CEP              := LibCEP.Endereco[0].CEP;
      objParticipante.Rua              := LibCEP.Endereco[0].Logradouro;
      objParticipante.Complemento      := LibCEP.Endereco[0].Complemento;
      objParticipante.Bairro           := LibCEP.Endereco[0].Bairro;
      objParticipante.Cidade.Nome      := LibCEP.Endereco[0].Cidade;
      objParticipante.Cidade.Estado.UF := LibCEP.Endereco[0].UF;
    end;
  finally
    Result := consultou;
    FreeAndNil(LibCEP);
  end;
end;

function TParticipanteController.BuscarPorId(objParticipante: TParticipante; Id: Integer; out
  Erro: String): Boolean;
begin
  Result := ParticipanteDAO.BuscarPorId(objParticipante, Id, Erro);
end;

function TParticipanteController.Inserir(objParticipante: TParticipante; out Erro: string): Boolean;
begin
  objParticipante.UsuarioCadastro.Id := dmConexao1.Usuario.Id;
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
