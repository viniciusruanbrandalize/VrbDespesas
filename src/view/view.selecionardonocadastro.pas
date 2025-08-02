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

unit view.selecionardonocadastro;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, controller.selecionardonocadastro;

type

  { TfrmSelecionarDonoCadastro }

  TfrmSelecionarDonoCadastro = class(TForm)
    cbDonoCadastro: TComboBox;
    ckbNaoPerguntar: TCheckBox;
    imgList: TImageList;
    lblInfo: TLabel;
    lblDonoCadastro: TLabel;
    pnlBotoes: TPanel;
    pnlFundo: TPanel;
    btnAvancar: TSpeedButton;
    tmrFechar: TTimer;
    procedure btnAvancarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrFecharTimer(Sender: TObject);
  private
    Controller: TSelecionarDonoCadastroController;
  public

  end;

var
  frmSelecionarDonoCadastro: TfrmSelecionarDonoCadastro;

implementation

{$R *.lfm}

{ TfrmSelecionarDonoCadastro }

procedure TfrmSelecionarDonoCadastro.btnAvancarClick(Sender: TObject);
begin
  Controller.SelecionarDonoCadastro(cbDonoCadastro);
  Controller.ConfiguracaoINI.DCNaoPerguntar := ckbNaoPerguntar.Checked;
  Controller.ConfiguracaoINI.Escrever;
  Close;
end;

procedure TfrmSelecionarDonoCadastro.FormCreate(Sender: TObject);
begin
  Controller := TSelecionarDonoCadastroController.Create;
end;

procedure TfrmSelecionarDonoCadastro.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmSelecionarDonoCadastro.FormShow(Sender: TObject);
begin
  if Controller.ConfiguracaoINI.DCNaoPerguntar then
  begin
    Controller.SelecionarDonoCadastroPadrao();
    tmrFechar.Enabled := True;
  end
  else
  begin
    Controller.BuscarDonoCadastroPermitidos(cbDonoCadastro);
    if cbDonoCadastro.Items.Count > 0 then
      cbDonoCadastro.ItemIndex := 0;
  end;
end;

procedure TfrmSelecionarDonoCadastro.tmrFecharTimer(Sender: TObject);
begin
  Close;
end;

end.

