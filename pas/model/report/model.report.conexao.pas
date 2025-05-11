unit model.report.conexao;

{
  Componentes SQLConnector, SQLTransaction, SQLDBLibraryLoader são usados
  apenas para a criação/atualização de relatórios e testes internos de
  conexão com o banco de dados.
}

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, SQLDBLib, IBConnection, LR_Class, LR_DBSet,
  LR_E_CSV, LR_E_TXT, LR_Desgn, LR_Shape, lr_e_pdf, model.connection.conexao1,
  LR_View;

type

  { TdmConexaoReport }

  TdmConexaoReport = class(TDataModule)
    frCSVExport: TfrCSVExport;
    frDBDataSet: TfrDBDataSet;
    frDesigner: TfrDesigner;
    frReport: TfrReport;
    frShapeObject: TfrShapeObject;
    frTextExport: TfrTextExport;
    frTNPDFExport: TfrTNPDFExport;
    qryPadrao: TSQLQuery;
    SQLConnector: TSQLConnector;
    SQLDBLibraryLoader: TSQLDBLibraryLoader;
    SQLTransaction: TSQLTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    FDir: String;
    FIDDonoCadastro: Integer;
    procedure ConfiguraComponentes();
  public
    procedure CarregarLogo();
    property DiretorioRelatorios: String read FDir write FDir;
    property IDDonoCadastro: Integer read FIDDonoCadastro write FIDDonoCadastro;
  end;

var
  dmConexaoReport: TdmConexaoReport;

implementation

{$R *.lfm}

{ TdmConexaoReport }

procedure TdmConexaoReport.DataModuleCreate(Sender: TObject);
begin
  ConfiguraComponentes();
end;

procedure TdmConexaoReport.ConfiguraComponentes();
begin
  FDir := ExtractFilePath(ParamStr(0))+'reports\';
  FIDDonoCadastro := dmConexao1.DonoCadastro.Id;
  if qryPadrao.Active then
    qryPadrao.Active := False;
  qryPadrao.SQL.Clear;
  qryPadrao.DataBase   := dmConexao1.SQLConnector;
  frDBDataSet.DataSet  := qryPadrao;
  frReport.Dataset     := frDBDataSet;
end;

procedure TdmConexaoReport.CarregarLogo();
begin
  if Assigned(frReport.FindObject('imgLogo')) then
    TfrPictureView(frReport.FindObject('imgLogo')).Picture.LoadFromFile(FDir+'logo.ico');
end;

end.

