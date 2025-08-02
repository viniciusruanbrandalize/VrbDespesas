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

unit view.loglogin;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  controller.loglogin;

type

  { TfrmLogLogin }

  TfrmLogLogin = class(TForm)
    lv: TListView;
    pnlFundo: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    controller: TLogLoginController;
  public

  end;

var
  frmLogLogin: TfrmLogLogin;

implementation

{$R *.lfm}

{ TfrmLogLogin }

procedure TfrmLogLogin.FormCreate(Sender: TObject);
begin
  controller := TLogLoginController.Create;
end;

procedure TfrmLogLogin.FormDestroy(Sender: TObject);
begin
  FreeAndNil(controller);
end;

procedure TfrmLogLogin.FormShow(Sender: TObject);
begin
  lv.Items.Clear;
  controller.Listar(lv);
end;

end.

