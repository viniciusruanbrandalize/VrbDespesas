unit controller.usuarioacesso;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, model.entity.usuario, model.entity.ucacao,
  model.entity.uctela, model.dao.usuarioacesso, model.dao.padrao,
  CheckLst, StdCtrls, csvdataset, model.entity.ucacesso;

type

  { TUsuarioAcessoController }

  TUsuarioAcessoController = class
  private
    UsuarioAcessoDAO: TUsuarioAcessoDAO;
  public

    procedure ListarTelas(var lbNome: TListBox; var lbTitulo: TCheckListBox);
    procedure ListarAcoes(var lbNome: TListBox; var lbTitulo: TCheckListBox; Tela: String);
    function CarregarArquivosDeAcoes(out Erro: String): Boolean;
    function RemoverOuInserirAcesso(IdUsuario: Integer; idAcao: Integer; Marcado: Boolean; out Erro: String): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TUsuarioAcessoController }

procedure TUsuarioAcessoController.ListarTelas(var lbNome: TListBox;
  var lbTitulo: TCheckListBox);
begin
  UsuarioAcessoDAO.ListarTelas(lbNome, lbTitulo);
end;

procedure TUsuarioAcessoController.ListarAcoes(var lbNome: TListBox;
  var lbTitulo: TCheckListBox; Tela: String);
begin
  UsuarioAcessoDAO.ListarAcoes(lbNome, lbTitulo, Tela);
end;

function TUsuarioAcessoController.CarregarArquivosDeAcoes(out Erro: String): Boolean;
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

        if not UsuarioAcessoDAO.BuscarTelaPorNome(UCTela, UCTela.Nome, Erro) then
          UsuarioAcessoDAO.InserirTela(UCTela, Erro);

        CSV.Next;
      end;
    finally
      FreeAndNil(UCTela);
    end;

    CSV.Close;
    CSV.Clear;
    CSV.LoadFromCSVFile(DirAcao);

    CSV.First;

    UCAcao := TUcAcao.Create;
    try
      while not CSV.EOF do
      begin

        UCAcao.Nome        := CSV.FieldByName('nome').AsString;
        UCAcao.Titulo      := CSV.FieldByName('titulo').AsString;
        UCAcao.UcTela.Nome := CSV.FieldByName('nome_uc_tela').AsString;

        if not UsuarioAcessoDAO.BuscarAcaoPorNome(UCAcao, Erro) then
          UsuarioAcessoDAO.InserirAcao(UCAcao, Erro);

        CSV.Next;
      end;
    finally
      FreeAndNil(UCAcao);
    end;

    Result := True;

  finally
    FreeAndNil(CSV);
  end;
end;

function TUsuarioAcessoController.RemoverOuInserirAcesso(IdUsuario: Integer;
  idAcao: Integer; Marcado: Boolean; out Erro: String): Boolean;
var
  Acesso: TUcAcesso;
begin
  Acesso := TUcAcesso.Create;
  try
    Acesso.UcAcao.Id  := idAcao;
    Acesso.Usuario.Id := idUsuario;

    if Marcado and (not UsuarioAcessoDAO.BuscarAcessoPorId(Acesso, Erro)) then
      Result := UsuarioAcessoDAO.InserirAcesso(Acesso, Erro)
    else
      Result := UsuarioAcessoDAO.RemoverAcesso(Acesso.Id, Erro);

  finally
    FreeAndNil(Acesso);
  end;
end;

constructor TUsuarioAcessoController.Create;
begin
  UsuarioAcessoDAO := TUsuarioAcessoDAO.Create;
end;

destructor TUsuarioAcessoController.Destroy;
begin
  UsuarioAcessoDAO.Free;
  inherited Destroy;
end;

end.

