unit controller.usuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, model.entity.usuario, lib.bcrypt, lib.types,
  model.dao.padrao, model.dao.usuario, csvdataset, CheckLst, StdCtrls,
  model.entity.uctela, model.entity.ucacao;

type

  { TUsuarioController }

  TUsuarioController = class
  private
    UsuarioDAO: TUsuarioDAO;
  public
    Usuario: TUsuario;
    procedure Listar(lv: TListView);
    procedure Pesquisar(lv: TListView; Campo, Busca: String);
    function BuscarPorId(objUsuario : TUsuario; Id: Integer; out Erro: String): Boolean;
    function Inserir(objUsuario : TUsuario; out Erro: string): Boolean;
    function Editar(objUsuario : TUsuario; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    function ValidarSenha(Senha1, Senha2 : String; Operacao: TOperacaoCRUD; out Erro: String): Boolean;
    function CriptografarSenha(Senha: String): String;
    procedure ListarTelas(var lbNome: TListBox; var lbTitulo: TCheckListBox);
    procedure ListarAcoes(var lbNome: TListBox; var lbTitulo: TCheckListBox; Tela: String);
    function CarregarArquivosDeAcoes(out Erro: String): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TUsuarioController }

procedure TUsuarioController.Listar(lv: TListView);
begin
  UsuarioDAO.Listar(lv);
end;

procedure TUsuarioController.Pesquisar(lv: TListView; Campo, Busca: String);
begin
  UsuarioDAO.Pesquisar(lv, Campo, Busca);
end;

function TUsuarioController.BuscarPorId(objUsuario: TUsuario; Id: Integer; out
  Erro: String): Boolean;
begin
  Result := UsuarioDAO.BuscarPorId(objUsuario, Id, Erro);
end;

function TUsuarioController.Inserir(objUsuario: TUsuario; out Erro: string): Boolean;
begin
  Result := UsuarioDAO.Inserir(objUsuario, Erro);
end;

function TUsuarioController.Editar(objUsuario: TUsuario; out Erro: string): Boolean;
begin
  Result := UsuarioDAO.Editar(objUsuario, Erro);
end;

function TUsuarioController.Excluir(Id: Integer; out Erro: string): Boolean;
begin
  Result := UsuarioDAO.Excluir(Id, Erro);
end;

function TUsuarioController.ValidarSenha(Senha1, Senha2: String; Operacao: TOperacaoCRUD;
  out Erro: String): Boolean;
var
  UsuarioBusca: TUsuario;
  SenhaValida: Boolean;
begin
  UsuarioBusca := TUsuario.Create;
  SenhaValida := False;
  try
    if (Trim(Senha1) <> '') and (Trim(Senha2) <> '') then
    begin
      case Operacao of
        opInserir:
        begin
          SenhaValida := (Senha1 = Senha2);
          if not SenhaValida then
            Erro := 'Senha difere da confirmação de senha!';
        end;
        opEditar:
        begin
          if BuscarPorId(UsuarioBusca, Usuario.Id, Erro) then
          begin
            lib.bcrypt.compareHashBCrypt(Pchar(Senha1),
                                       Pchar(UsuarioBusca.Senha),
                                       SenhaValida);
            if not SenhaValida then
              Erro := 'Nova Senha difere da senha atual!';
          end;
        end;
      end;
    end
    else
    begin
      Erro := 'Verifique se os campos de senhas estão preenchidos!';
      SenhaValida := False;
    end;
    Result := SenhaValida;
  finally
    UsuarioBusca.Free;
  end;
end;

function TUsuarioController.CriptografarSenha(Senha: String): String;
var
  SenhaCriptografada: PChar;
begin
  lib.bcrypt.encryptBCrypt(PChar(Senha), SenhaCriptografada);
  Result := SenhaCriptografada;
end;

procedure TUsuarioController.ListarTelas(var lbNome: TListBox;
  var lbTitulo: TCheckListBox);
begin
  UsuarioDAO.ListarTelas(lbNome, lbTitulo);
end;

procedure TUsuarioController.ListarAcoes(var lbNome: TListBox;
  var lbTitulo: TCheckListBox; Tela: String);
begin
  UsuarioDAO.ListarAcoes(lbNome, lbTitulo, Tela);
end;

function TUsuarioController.CarregarArquivosDeAcoes(out Erro: String): Boolean;
var
  CSV: TCSVDataset;
  DirTela, DirAcao: String;
  UCTela: TUcTela;
  UCAcao: TUcAcao;
begin
  CSV := TCSVDataset.Create(nil);
  try
    CSV.CSVOptions.Delimiter := ',';
    CSV.CSVOptions.FirstLineAsFieldNames := True;
    DirTela := ExtractFilePath(ParamStr(0))+'permission\UC_TELA.DB';
    DirAcao := ExtractFilePath(ParamStr(0))+'permission\UC_ACAO.DB';

    CSV.LoadFromCSVFile(DirTela);

    CSV.First;

    UCTela := TUcTela.Create;
    try
      while not CSV.EOF do
      begin

        UCTela.Nome   := CSV.FieldByName('nome').AsString;
        UCTela.Titulo := CSV.FieldByName('titulo').AsString;

        if not UsuarioDAO.BuscarTelaPorNome(UCTela, UCTela.Nome, Erro) then
          UsuarioDAO.InserirTela(UCTela, Erro);

        CSV.Next;
      end;
    finally
      FreeAndNil(UCTela);
    end;

    Result := True;

  finally
    FreeAndNil(CSV);
  end;
end;

constructor TUsuarioController.Create;
begin
  Usuario    := TUsuario.Create;
  UsuarioDAO := TUsuarioDAO.Create;
end;

destructor TUsuarioController.Destroy;
begin
  Usuario.Free;
  UsuarioDAO.Free;
  inherited Destroy;
end;

end.
