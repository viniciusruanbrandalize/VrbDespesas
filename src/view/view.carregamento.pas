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

unit view.carregamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  StdCtrls;

type

  { TfrmCarregamento }

  TfrmCarregamento = class(TForm)
    lblCarregando: TLabel;
    pnlPrincipal: TPanel;
    pgb: TProgressBar;
  private

  public
    class procedure Carregar(Texto: String = ''; Titulo: String = '');
    class procedure Destruir;
  end;

var
  frmCarregamento: TfrmCarregamento;
  frm: TfrmCarregamento;

implementation

{$R *.lfm}

{ TfrmCarregamento }

class procedure TfrmCarregamento.Carregar(Texto: String; Titulo: String);
begin
  frm := TfrmCarregamento.Create(nil);
  if Trim(Texto) <> EmptyStr then
    frm.lblCarregando.Caption := Texto;
  if Trim(Titulo) <> EmptyStr then
    frm.Caption := Titulo;
  frm.Show;
  Application.ProcessMessages;
end;

class procedure TfrmCarregamento.Destruir;
begin
  if Assigned(frm) then
    FreeAndNil(frm);
end;

end.

