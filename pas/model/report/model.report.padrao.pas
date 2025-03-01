unit model.report.padrao;

{
  Componentes SQLConnector, SQLTransaction, SQLDBLibraryLoader são usados
  apenas para a criação/atualização de relatórios e testes internos de
  conexão com o banco de dados.
}

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, SQLDBLib, IBConnection, LR_Class, LR_DBSet,
  LR_E_CSV, LR_E_TXT, LR_Desgn, LR_Shape, lr_e_pdf, model.connection.conexao1;

type

  { TdmPadraoReport }

  TdmPadraoReport = class(TDataModule)
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
    procedure ConfiguraComponentes();
  public
    property DiretorioRelatorios: String read FDir write FDir;
  end;

var
  dmPadraoReport: TdmPadraoReport;

implementation

{$R *.lfm}

{ TdmPadraoReport }

procedure TdmPadraoReport.DataModuleCreate(Sender: TObject);
begin
  ConfiguraComponentes();
end;

procedure TdmPadraoReport.ConfiguraComponentes();
begin
  FDir := ExtractFilePath(ParamStr(0))+'reports\';
  if qryPadrao.Active then
    qryPadrao.Active := False;
  qryPadrao.SQL.Clear;
  qryPadrao.DataBase   := dmConexao1.SQLConnector;
  frDBDataSet.DataSet  := qryPadrao;
  frReport.Dataset     := frDBDataSet;
end;

end.

