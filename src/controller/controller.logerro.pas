{
*******************************************************************************
*   VRBDespesas                                                               *
*   Controle e gerenciamento de despesas.                                     *
*                                                                             *
*   Copyright (C) 2025 Vinícius Ruan Brandalize.                              *
*                                                                             *
*   This program is free software: you can redistribute it and/or modify      *
*   it under the terms of the GNU General Public License as published by      *
*   the Free Software Foundation, either version 3 of the License, or         *
*   (at your option) any later version.                                       *
*                                                                             *
*   This program is distributed in the hope that it will be useful,           *
*   but WITHOUT ANY WARRANTY; without even the implied warranty of            *
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             *
*   GNU General Public License for more details.                              *
*                                                                             *
*   You should have received a copy of the GNU General Public License         *
*   along with this program.  If not, see <https://www.gnu.org/licenses/>.    *
*                                                                             *
*   Contact: viniciusbrandalize2@gmail.com.                                   *
*                                                                             *
*******************************************************************************
}

unit controller.logerro;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, model.ini.erro;

type

  { TLogErroController }

  TLogErroController = class
  private
    ErroINI: TErroINI;
  public
    procedure Listar(lv: TListView);
    function BuscarPorId(Id: String; out Lista: TStringList; out Erro: String): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TLogErroController }

procedure TLogErroController.Listar(lv: TListView);
var
  cod: Integer;
  Item: TListItem;
  ID : String;
begin

  lv.Items.Clear;
  cod := 1;
  ID := FormatFloat('000000', cod);

  while ErroINI.ExisteSecaoIni(ID) do
  begin
    ErroINI.CarregarPorSecao(ID);
    Item := lv.Items.Add;
    Item.Caption := ErroINI.ID;
    Item.SubItems.Add(ErroINI.ID);
    Item.SubItems.Add(DateToStr(ErroINI.Data));
    Item.SubItems.Add(TimeToStr(ErroINI.Hora));
    Item.SubItems.Add(ErroINI.MensagemTratada);
    cod := cod + 1;
    ID := FormatFloat('000000', cod);
  end;

end;

function TLogErroController.BuscarPorId(Id: String; out Lista: TStringList;
  out Erro: String): Boolean;
begin
  try
    Lista.Clear;
    ErroINI.CarregarPorSecao(Id);
    Lista.Add('ID ['+ErroINI.ID+']');
    Lista.Add('  DATA                        : '+ DateToStr(ErroINI.Data) );
    Lista.Add('  HORA                        : '+ TimeToStr(ErroINI.Hora) );
    Lista.Add('  MENSAGEM                    : '+ ErroINI.Mensagem );
    Lista.Add('  MENSAGEM TRATADA            : '+ ErroINI.MensagemTratada );
    Lista.Add('  NOME DO COMPUTADOR          : '+ ErroINI.NomeComputador );
    Lista.Add('  IP DO COMPUTADOR            : '+ ErroINI.IPComputador );
    Lista.Add('  USUARIO DO SISTEMA          : '+ ErroINI.Usuario );
    Lista.Add('  CLASSE DO ERROINI           : '+ ErroINI.ClasseErro );
    Lista.Add('  UNIDADE DO ERROINI          : '+ ErroINI.UnidadeErro );
    Lista.Add('  NOME DA TELA ATIVA          : '+ ErroINI.NomeFormAtivo );
    Lista.Add('  TITULO DA TELA ATIVA        : '+ ErroINI.TituloFormAtivo );
    Lista.Add('  UNIDADE DA TELA ATIVA       : '+ ErroINI.UnidadeFormAtivo );
    Lista.Add('  NOME DO OBJETO ATIVO        : '+ ErroINI.NomeObjAtivo );
    Lista.Add('  TITULO DO OBJETO ATIVO      : '+ ErroINI.TituloObjAtivo );
    Lista.Add('  UNIDADE DO OBJETO ATIVO     : '+ ErroINI.UnidadeObjAtivo );
    Lista.Add('  NOME DO OBJETO DO ERROINI   : '+ ErroINI.NomeObjErro );
    Lista.Add('  TITULO DO OBJETO DO ERROINI : '+ ErroINI.TituloObjErro );
    Lista.Add('  UNIDADE DO OBJETO DO ERROINI: '+ ErroINI.UnidadeObjErro );
    Lista.Add('  FUNCAO QUE CAUSOU O ERROINI : '+ ErroINI.FuncaoErro );
    Lista.Add('  LINHA DO ERROINI            : '+ IntToStr(ErroINI.LinhaErro) );
    Lista.Add('  VERSAO DO EXECUTAVEL        : '+ ErroINI.VersaoExe+' -> '+DateToStr(eRROINI.DataVersaoExe) );
    Lista.Add('  ARQUITETURA DO EXECUTAVEL   : '+ ErroINI.ArquiteturaExe );
    Lista.Add('  DIRETORIO DO EXECUTAVEL     : '+ ErroINI.DiretorioExe );
    Lista.Add('  EXECUTANDO EM MODO          : '+ ErroINI.ModoExe );
    Lista.Add('  INFO DO SISTEMA OPERACIONAL : '+ ErroINI.SistemaOperacional );
    Lista.Add('');
    Result := True;
  except on e: Exception do
    begin
      Erro   := e.Message;
      Result := False;
    end;
  end;
end;

constructor TLogErroController.Create;
begin
  ErroINI := TErroINI.Create;
end;

destructor TLogErroController.Destroy;
begin
  ErroINI.Free;
  inherited Destroy;
end;

end.
