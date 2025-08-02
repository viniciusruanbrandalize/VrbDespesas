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

unit view.configuracao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  StdCtrls, Buttons, controller.configuracao;

type

  { TfrmConfiguracao }

  TfrmConfiguracao = class(TForm)
    btnSelDirPgDumpBkp: TSpeedButton;
    btnSelDirMysqlDumpBkp: TSpeedButton;
    Edit1: TEdit;
    edtPgDump: TLabeledEdit;
    edtMySQLDump: TLabeledEdit;
    gbBackup: TGroupBox;
    imgList: TImageList;
    edtGbak: TLabeledEdit;
    openDlg: TOpenDialog;
    pnlFundoGeral: TPanel;
    pnlFundoLocal: TPanel;
    pnlBotoes: TPanel;
    pgc: TPageControl;
    pnlFundo: TPanel;
    btnSelDirGbakBkp: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    SpeedButton1: TSpeedButton;
    tbsGeral: TTabSheet;
    tbsLocal: TTabSheet;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnSelDirGbakBkpClick(Sender: TObject);
    procedure btnSelDirMysqlDumpBkpClick(Sender: TObject);
    procedure btnSelDirPgDumpBkpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Controller: TConfiguracaoController;
    procedure LimparCampos();
    procedure CarregarConfiguracoes();
    procedure Salvar();
  public

  end;

var
  frmConfiguracao: TfrmConfiguracao;

implementation

{$R *.lfm}

{ TfrmConfiguracao }

procedure TfrmConfiguracao.btnSelDirGbakBkpClick(Sender: TObject);
begin
  if openDlg.Execute then
    edtGbak.Text := openDlg.FileName;
end;

procedure TfrmConfiguracao.btnSalvarClick(Sender: TObject);
begin
  Salvar();
end;

procedure TfrmConfiguracao.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConfiguracao.btnSelDirMysqlDumpBkpClick(Sender: TObject);
begin
  if openDlg.Execute then
    edtMySQLDump.Text := openDlg.FileName;
end;

procedure TfrmConfiguracao.btnSelDirPgDumpBkpClick(Sender: TObject);
begin
  if openDlg.Execute then
    edtPgDump.Text := openDlg.FileName;
end;

procedure TfrmConfiguracao.FormCreate(Sender: TObject);
begin
  pgc.Style := tsButtons;
  Controller := TConfiguracaoController.Create;
end;

procedure TfrmConfiguracao.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmConfiguracao.FormShow(Sender: TObject);
begin
  pgc.ActivePageIndex := 0;
  LimparCampos();
  CarregarConfiguracoes();
  {$IFDEF MSWINDOWS}
  openDlg.Filter := 'Executáveis|*.exe';
  {$ENDIF}
end;

procedure TfrmConfiguracao.LimparCampos();
begin
  edtGbak.Clear;
  edtPgDump.Clear;
  edtMySQLDump.Clear;
end;

procedure TfrmConfiguracao.CarregarConfiguracoes();
begin
  edtGbak.Text      := Controller.ConfiguracaoINI.GBak;
  edtMySQLDump.Text := Controller.ConfiguracaoINI.MySQLDump;
  edtPgDump.Text    := Controller.ConfiguracaoINI.PGDump;
end;

procedure TfrmConfiguracao.Salvar();
begin
  Controller.ConfiguracaoINI.GBak      := edtGbak.Text;
  Controller.ConfiguracaoINI.MySQLDump := edtMySQLDump.Text;
  Controller.ConfiguracaoINI.PGDump    := edtPgDump.Text;
  Controller.ConfiguracaoINI.Escrever;
end;

end.

