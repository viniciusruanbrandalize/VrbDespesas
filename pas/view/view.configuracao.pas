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

