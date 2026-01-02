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
  StdCtrls, Buttons, controller.configuracao, view.mensagem;

type

  { TfrmConfiguracao }

  TfrmConfiguracao = class(TForm)
    btnSelDirSQLite3Bkp: TSpeedButton;
    btnSelDirPgDumpBkp: TSpeedButton;
    btnSelDirMysqlDumpBkp: TSpeedButton;
    edtSQLite3: TLabeledEdit;
    edtPesquisa: TEdit;
    edtPgDump: TLabeledEdit;
    edtMySQLDump: TLabeledEdit;
    gbBackup: TGroupBox;
    imgList: TImageList;
    edtGbak: TLabeledEdit;
    openDlg: TOpenDialog;
    pnlConfiguracaoGeral: TPanel;
    pnlFundoGeral: TPanel;
    pnlFundoLocal: TPanel;
    pnlBotoes: TPanel;
    pgc: TPageControl;
    pnlFundo: TPanel;
    btnSelDirGbakBkp: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnPesquisar: TSpeedButton;
    tbsGeral: TTabSheet;
    tbsLocal: TTabSheet;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnSelDirGbakBkpClick(Sender: TObject);
    procedure btnSelDirMysqlDumpBkpClick(Sender: TObject);
    procedure btnSelDirPgDumpBkpClick(Sender: TObject);
    procedure btnSelDirSQLite3BkpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Controller: TConfiguracaoController;
    procedure LimparCampos();
    procedure CarregarConfiguracoes();
    procedure Salvar();
    procedure SalvarConfGeral();
    procedure CriarComponentes();
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

procedure TfrmConfiguracao.btnSelDirSQLite3BkpClick(Sender: TObject);
begin
  if openDlg.Execute then
    edtSQLite3.Text := openDlg.FileName;
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
  pnlConfiguracaoGeral.Caption := '';
  pgc.ActivePageIndex := 0;
  LimparCampos();
  CarregarConfiguracoes();
  {$IFDEF MSWINDOWS}
  openDlg.Filter := 'Executáveis|*.exe';
  {$ENDIF}
  CriarComponentes();
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
  edtSQLite3.Text   := Controller.ConfiguracaoINI.SQLite3;
end;

procedure TfrmConfiguracao.Salvar();
begin
  SalvarConfGeral();
  Controller.ConfiguracaoINI.GBak      := edtGbak.Text;
  Controller.ConfiguracaoINI.MySQLDump := edtMySQLDump.Text;
  Controller.ConfiguracaoINI.PGDump    := edtPgDump.Text;
  Controller.ConfiguracaoINI.SQLite3   := edtSQLite3.Text;
  Controller.ConfiguracaoINI.Escrever;
end;

procedure TfrmConfiguracao.SalvarConfGeral();
var
  i, id: Integer;
  Erro: String;
begin
  for i := 0 to Pred(pnlConfiguracaoGeral.ControlCount) do
  begin
    if pnlConfiguracaoGeral.Controls[i] is TCheckBox then
    begin
      id := TCheckBox(pnlConfiguracaoGeral.Controls[i]).Tag;
      if Controller.BuscarPorId(Controller.Configuracao, id, Erro) then
      begin
        if TCheckBox(pnlConfiguracaoGeral.Controls[i]).Checked then
          Controller.Configuracao.Valor := '1'
        else
          Controller.Configuracao.Valor := '0';
        if not Controller.Editar(Controller.Configuracao, Erro) then
        begin
          TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
          Abort;
        end;
      end
      else
        TfrmMessage.Mensagem(erro, 'Erro', 'E', [mbOk]);
    end;
  end;
end;

procedure TfrmConfiguracao.CriarComponentes();
var
  Erro: String;
  i, topo, esquerda: Integer;
  ckb: TCheckBox;
begin
  if Controller.BuscarTodos(Controller.ListaConfiguracao, Erro) then
  begin
    topo     := 5;
    esquerda := 5;
    for i := 0 to Pred(Controller.ListaConfiguracao.Count) do
    begin
      with Controller.ListaConfiguracao[i] do
      begin
        if Trim(Componente) <> '' then
        begin
          if UpperCase(Trim(Componente)) = 'TCHECKBOX' then
          begin
            ckb          := TCheckBox.Create(Self);
            ckb.Parent   := pnlConfiguracaoGeral;
            ckb.Name     := 'ckb'+Nome;
            ckb.Tag      := Id;
            ckb.Caption  := Descricao;
            ckb.Hint     := Uso;
            ckb.ShowHint := True;
            ckb.Top      := topo;
            ckb.Left     := esquerda;
            ckb.Checked  := Valor = '1';
          end;
          topo     := topo + 10;
          esquerda := esquerda + 10;
        end;
      end;
    end;
  end
  else
    TfrmMessage.Mensagem(Erro, 'Erro', 'E', [mbOk]);
end;

end.

