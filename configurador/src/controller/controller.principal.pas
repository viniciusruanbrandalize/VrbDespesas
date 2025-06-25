unit controller.principal;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.ini.conexao;

type

  { TPrincipalController }

  TPrincipalController = class
  private
    FINI: TConexaoINI;
  public
    property INI: TConexaoINI read FINI write FINI;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TPrincipalController }

constructor TPrincipalController.Create;
begin
  FINI := TConexaoINI.Create;
end;

destructor TPrincipalController.Destroy;
begin
  inherited Destroy;
  FreeAndNil(FINI);
end;

end.

