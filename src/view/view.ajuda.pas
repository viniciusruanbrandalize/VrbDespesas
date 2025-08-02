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

unit view.ajuda;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  StdCtrls, controller.ajuda;

type

  { TfrmAjuda }

  TfrmAjuda = class(TForm)
    imgApoio: TImage;
    imgLogoSobre: TImage;
    lblDoacao: TLabel;
    lblCopySobre: TLabel;
    lblCopyApoio: TLabel;
    lblDescApoio: TLabel;
    lblInfoSoftware: TLabel;
    lblDataVersao: TLabel;
    lblTituloApoio: TLabel;
    lblVersao: TLabel;
    lblDescSobre: TLabel;
    lblTituloSobre: TLabel;
    pnlFundoApoio: TPanel;
    pnlBottomSobre: TPanel;
    pnlFundoSobre: TPanel;
    pgc: TPageControl;
    pnlFundo: TPanel;
    tbsApoio: TTabSheet;
    tbsSobre: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    controller: TAjudaController;
  public

  end;

var
  frmAjuda: TfrmAjuda;

implementation

{$R *.lfm}

{ TfrmAjuda }

procedure TfrmAjuda.FormShow(Sender: TObject);
begin
  pgc.ActivePageIndex := 0;
  lblDataVersao.Caption := 'Data de Release: '+controller.retornarDataVersao;
  lblVersao.Caption := 'Versão: '+controller.retornarVersao;
end;

procedure TfrmAjuda.FormCreate(Sender: TObject);
begin
  pgc.Style := tsButtons;
  controller := TAjudaController.Create;
end;

procedure TfrmAjuda.FormDestroy(Sender: TObject);
begin
  FreeAndNil(controller);
end;

end.

