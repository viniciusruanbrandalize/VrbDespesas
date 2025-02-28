unit model.report.padrao;

{
  Componentes SQLConnector, SQLTransaction, SQLDBLibraryLoader são usados
  apenas para a criação/atualização de relatórios e testes internos de
  conexão do banco.
}

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, SQLDBLib, IBConnection, LR_Class, LR_DBSet,
  LR_E_CSV, LR_E_TXT, lr_e_pdf, model.connection.conexao1;

type

  { TPadraoReport }

  TPadraoReport = class(TDataModule)
    frCSVExport: TfrCSVExport;
    frDBDataSet: TfrDBDataSet;
    frReport: TfrReport;
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
  PadraoReport: TPadraoReport;

implementation

{$R *.lfm}

{ TPadraoReport }

procedure TPadraoReport.DataModuleCreate(Sender: TObject);
begin
  ConfiguraComponentes();
end;

procedure TPadraoReport.ConfiguraComponentes();
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

