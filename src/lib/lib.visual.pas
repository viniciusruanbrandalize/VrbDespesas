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

unit lib.visual;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls, Controls, Forms, LCLType, LCLIntf;


  procedure CampoNumericoExit(Sender: TObject; Formatacao: String = ',#0.00');
  procedure CampoNumericoEnter(Sender: TObject; Formatacao: String = ',#0.00');
  procedure CampoNumericoKeyPress(Sender: TObject; var Key: char);
  procedure ArredondarComponente(Control: TWinControl);
  procedure CentralizarComponente(Form: TForm; Control: TWinControl);
  procedure BotaoVerdeMouseEnter(Sender: TObject);
  procedure BotaoVerdeMouseLeave(Sender: TObject);


implementation

procedure CampoNumericoExit(Sender: TObject; Formatacao: String = ',#0.00');
var
  valor: Double;
begin
  if (Sender is TLabeledEdit) then
  begin
    if TryStrToFloat((Sender as TLabeledEdit).Text, valor) then
      (Sender as TLabeledEdit).Text := FormatFloat(',#0.00', valor)
    else
      (Sender as TLabeledEdit).Text := '0,00';
  end;
end;

procedure CampoNumericoEnter(Sender: TObject; Formatacao: String = ',#0.00');
begin
  CampoNumericoExit(Sender,  Formatacao);
end;

procedure CampoNumericoKeyPress(Sender: TObject; var Key: char);
var
  i: Integer;
begin
  if key = ',' then
  begin
    if (Sender is TLabeledEdit) then
    begin
      for i := 0 to Length((Sender as TLabeledEdit).Text) do
      begin
        if (Sender as TLabeledEdit).Text[i] = ',' then
        begin
          Key := #0;
          Break;
        end;
      end;
    end;
  end
  else
    if not (key in ['0'..'9',',',#8]) then
      key := #0;
end;

procedure ArredondarComponente(Control: TWinControl);
var
  R: TRect;
  Rgn: HRGN;
begin
  with Control do
  begin
    R := ClientRect;
    rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 20, 20);
    Perform(178, 0 , lParam(@r));
    InflateRect(R, -5, -5);
    Perform(180, 0, lParam(@r));
    SetWindowRgn(Handle, rgn, True);
    Invalidate;
  end;
end;

procedure CentralizarComponente(Form: TForm; Control: TWinControl);
begin
  Control.Left := (Form.ClientWidth div 2) - (Control.Width div 2);
  Control.Top :=  (Form.ClientHeight div 2) - (Control.Height div 2);
end;

procedure BotaoVerdeMouseEnter(Sender: TObject);
begin
  if (Sender is TPanel) then
  begin
    (Sender as TPanel).Color      := $00FFFFFF; { Branco }
    (Sender as TPanel).Font.Color := $002D6D01; { Verde }
  end;
end;

procedure BotaoVerdeMouseLeave(Sender: TObject);
begin
  if (Sender is TPanel) then
  begin
    (Sender as TPanel).Color      := $002D6D01; { Verde }
    (Sender as TPanel).Font.Color := $00FFFFFF; { Branco }
  end;
end;

end.

