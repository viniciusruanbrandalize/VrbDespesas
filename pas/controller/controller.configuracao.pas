unit controller.configuracao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, model.dao.configuracao,
  model.entity.configuracao, model.ini.configuracao;

type

  { TConfiguracaoController }

  TConfiguracaoController = class
  private
    DAO: TConfiguracaoDAO;
  public
    Configuracao:    TConfiguracao;
    ConfiguracaoINI: TConfiguracaoINI;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TConfiguracaoController }

constructor TConfiguracaoController.Create;
begin
  Configuracao := TConfiguracao.Create;
  ConfiguracaoINI := TConfiguracaoINI.Create;
  DAO := TConfiguracaoDAO.Create;
end;

destructor TConfiguracaoController.Destroy;
begin
  FreeAndNil(Configuracao);
  FreeAndNil(ConfiguracaoINI);
  FreeAndNil(DAO);
  inherited Destroy;
end;

end.
