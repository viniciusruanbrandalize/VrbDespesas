unit controller.copiaseguranca;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, model.dao.copiaseguranca, lib.types;

type

  { TCopiaSegurancaController }

  TCopiaSegurancaController = class
  private
    DAO: TCopiaSegurancaDAO;
  public
    function IniciarBackup(Destino: String; var pgb: TProgressBar; var lblStatus: TLabel; var mLog: TMemo): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TCopiaSegurancaController }

function TCopiaSegurancaController.IniciarBackup(Destino: String;
  var pgb: TProgressBar; var lblStatus: TLabel; var mLog: TMemo): Boolean;
begin
  Result := DAO.FazerBackup(Destino, pgb, lblStatus, mLog, bkpDump);
end;

constructor TCopiaSegurancaController.Create;
begin
  DAO := TCopiaSegurancaDAO.Create;
end;

destructor TCopiaSegurancaController.Destroy;
begin
  FreeAndNil(DAO);
  inherited Destroy;
end;

end.
