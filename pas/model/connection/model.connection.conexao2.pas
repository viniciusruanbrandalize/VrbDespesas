unit model.connection.conexao2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, SQLDBLib, SQLite3Conn;

type

  { TdmConexao2 }

  TdmConexao2 = class(TDataModule)
    SQLConnector: TSQLConnector;
    SQLDBLibraryLoader: TSQLDBLibraryLoader;
    SQLQuery1: TSQLQuery;
    SQLTransaction: TSQLTransaction;
  private

  public

  end;

var
  dmConexao2: TdmConexao2;

implementation

{$R *.lfm}

end.

