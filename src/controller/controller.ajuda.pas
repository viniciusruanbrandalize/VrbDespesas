unit controller.ajuda;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, model.dao.configuracao,
  model.entity.configuracao, lib.version;

type

  { TAjudaController }

  TAjudaController = class
  private

  public
    function retornarVersao: String;
    function retornarDataVersao: String;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TAjudaController }

function TAjudaController.retornarVersao: String;
var
  conf:    TConfiguracao;
  ConfDao: TConfiguracaoDAO;
  Erro: String;
begin
  Conf := TConfiguracao.Create;
  try
    ConfDAO := TConfiguracaoDAO.Create;
    try
      //if ConfDAO.BuscarPorNome(Conf, 'NUMERO_VERSAO', Erro) then
      //  Result := Conf.Valor;
      Result := NUMERO_VERSAO;
    finally
      FreeAndNil(ConfDao);
    end;
  finally
    FreeAndNil(conf);
  end;
end;

function TAjudaController.retornarDataVersao: String;
var
  conf:    TConfiguracao;
  ConfDao: TConfiguracaoDAO;
  StrData: String;
  Data: TDate;
  Erro: String;
begin
  Conf := TConfiguracao.Create;
  try
    ConfDAO := TConfiguracaoDAO.Create;
    try
      //if ConfDAO.BuscarPorNome(Conf, 'DATA_VERSAO', Erro) then
      //  StrData := Conf.Valor;
      StrData := DATA_VERSA0;
      if TryStrToDate(StrData, Data) then
        Result := FormatDateTime('dddddd', Data)
      else
        Result := '';
    finally
      FreeAndNil(ConfDao);
    end;
  finally
    FreeAndNil(conf);
  end;
end;

constructor TAjudaController.Create;
begin
  //
end;

destructor TAjudaController.Destroy;
begin
  inherited Destroy;
end;

end.
