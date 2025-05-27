unit controller.usuarioacesso;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, model.entity.usuario, model.entity.ucacao,
  model.entity.uctela, model.dao.usuarioacesso, model.dao.padrao,
  CheckLst, StdCtrls, csvdataset;

type

  { TUsuarioAcessoController }

  TUsuarioAcessoController = class
  private
    UsuarioAcessoDAO: TUsuarioAcessoDAO;
  public

    procedure ListarTelas(var lbNome: TListBox; var lbTitulo: TCheckListBox);
    procedure ListarAcoes(var lbNome: TListBox; var lbTitulo: TCheckListBox; Tela: String);
    function CarregarArquivosDeAcoes(out Erro: String): Boolean;

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

    Result := True;

  finally
    FreeAndNil(CSV);
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

