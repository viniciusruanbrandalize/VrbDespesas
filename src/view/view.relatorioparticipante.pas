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

unit view.relatorioparticipante;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ActnList, ExtCtrls,
  view.relatoriopadrao, view.mensagem, view.carregamento,
  controller.relatorioparticipante;

type

  { TfrmRelatorioParticipante }

  TfrmRelatorioParticipante = class(TfrmRelatorioPadrao)
    actCompletoTodos: TAction;
    actTelemarketing: TAction;
    pnlCompletoTodos: TPanel;
    pnlTelemarketing: TPanel;
    procedure actCompletoTodosExecute(Sender: TObject);
    procedure actTelemarketingExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlCompletoTodosClick(Sender: TObject);
    procedure pnlTelemarketingClick(Sender: TObject);
  private

  public
    Controller: TRelatorioParticipanteController;
  end;

var
  frmRelatorioParticipante: TfrmRelatorioParticipante;

implementation

uses
  view.principal;

{$R *.lfm}

{ TfrmRelatorioParticipante }

procedure TfrmRelatorioParticipante.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  TfrmPrincipal(Owner).BarraLateralVazia(TfrmPrincipal(Owner).pnlMenuRelatorio, True);
  CloseAction := caFree;
end;

procedure TfrmRelatorioParticipante.actTelemarketingExecute(Sender: TObject);
var
  Erro: String;
begin
  TfrmCarregamento.Carregar('Gerando relatório...', 'Gerando Relatório');
  try
    if Controller.Telemarketing(frPreview, Erro) then
    begin
      pgc.ActivePage := tbsDesigner;
      actFechar.ImageIndex := 1;
    end
    else
      TfrmMessage.Mensagem(Erro, 'Erro', 'E', [mbOk]);
  finally
    TfrmCarregamento.Destruir();
  end;
end;

procedure TfrmRelatorioParticipante.actCompletoTodosExecute(Sender: TObject);
var
  Erro: String;
begin
  TfrmCarregamento.Carregar('Gerando relatório...', 'Gerando Relatório');
  try
    if Controller.Completo(frPreview, Erro) then
    begin
      pgc.ActivePage := tbsDesigner;
      actFechar.ImageIndex := 1;
    end
    else
      TfrmMessage.Mensagem(Erro, 'Erro', 'E', [mbOk]);
  finally
    TfrmCarregamento.Destruir();
  end;
end;

procedure TfrmRelatorioParticipante.FormCreate(Sender: TObject);
begin
  inherited;
  Controller := TRelatorioParticipanteController.Create;
end;

procedure TfrmRelatorioParticipante.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmRelatorioParticipante.FormShow(Sender: TObject);
begin
  LiberarBloquearAcessos(Self.actList, Self.Name);
  inherited;
end;

procedure TfrmRelatorioParticipante.pnlCompletoTodosClick(Sender: TObject);
begin
  actCompletoTodos.Execute;
end;

procedure TfrmRelatorioParticipante.pnlTelemarketingClick(Sender: TObject);
begin
  actTelemarketing.Execute;
end;

end.

