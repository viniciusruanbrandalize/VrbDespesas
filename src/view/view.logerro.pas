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

unit view.logerro;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls, Menus, ActnList, controller.logerro, view.mensagem;

type

  { TfrmLogErro }

  TfrmLogErro = class(TForm)
    actVisualizar: TAction;
    actCopiar: TAction;
    actFecharDetalhe: TAction;
    actList: TActionList;
    imgList: TImageList;
    lv: TListView;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem4: TMenuItem;
    mErro: TMemo;
    pnlFundo: TPanel;
    PopupMenuMemo: TPopupMenu;
    PopupMenuLv: TPopupMenu;
    procedure actCopiarExecute(Sender: TObject);
    procedure actFecharDetalheExecute(Sender: TObject);
    procedure actVisualizarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Controller: TLogErroController;
  public

  end;

var
  frmLogErro: TfrmLogErro;

implementation

{$R *.lfm}

{ TfrmLogErro }

procedure TfrmLogErro.actCopiarExecute(Sender: TObject);
begin
  mErro.CopyToClipboard;
end;

procedure TfrmLogErro.actFecharDetalheExecute(Sender: TObject);
begin
  if mErro.Visible then
    mErro.Visible := False;
end;

procedure TfrmLogErro.actVisualizarExecute(Sender: TObject);
var
  erro: String;
  sl: TStringList;
begin
  if Assigned(lv.Selected) then
  begin
    sl := TStringList.Create;
    try
      mErro.Visible := True;
      controller.BuscarPorId(lv.Selected.Caption, sl, erro);
      mErro.Text := sl.Text;
    finally
      sl.Free;
    end;
  end
  else
    TfrmMessage.Mensagem('Nenhum registro foi selecionado!', 'Aviso', 'C', [mbOk]);
end;

procedure TfrmLogErro.FormCreate(Sender: TObject);
begin
  Controller := TLogErroController.Create;
end;

procedure TfrmLogErro.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmLogErro.FormShow(Sender: TObject);
begin
  mErro.Lines.Clear;
  lv.Items.Clear;
  controller.Listar(lv);
end;

end.

