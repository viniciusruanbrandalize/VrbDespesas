unit view.principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, SQLite3Conn, PQConnection, oracleconnection,
  odbcconn, mysql40conn, mysql41conn, mysql50conn, mysql51conn, mysql55conn,
  mysql56conn, mysql57conn, mysql80conn, MSSQLConn, IBConnection, Forms,
  Controls, Graphics, Dialogs, ExtCtrls, ComCtrls, Buttons, StdCtrls,
  controller.principal, view.mensagem;

type

  { TfrmPrincipal }

  TfrmPrincipal = class(TForm)
    btnDir: TButton;
    btnDir1: TButton;
    btnVisualizarSenha2: TSpeedButton;
    cbDriver1: TComboBox;
    cbDriver2: TComboBox;
    ckbLogSql1: TCheckBox;
    ckbLogSql2: TCheckBox;
    edtBanco2: TEdit;
    edtCharset2: TEdit;
    edtPorta2: TEdit;
    edtCharset1: TEdit;
    edtSenha2: TEdit;
    edtServidor1: TEdit;
    edtPorta1: TEdit;
    edtBanco1: TEdit;
    edtServidor2: TEdit;
    edtUsuario1: TEdit;
    edtSenha1: TEdit;
    edtUsuario2: TEdit;
    img: TImageList;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    OpenDlg: TOpenDialog;
    pnlCon1: TPanel;
    pnlCon2: TPanel;
    pgc: TPageControl;
    pnlBotao: TPanel;
    pnlTop: TPanel;
    pnlFundo: TPanel;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnVisualizarSenha1: TSpeedButton;
    SQLConnector: TSQLConnector;
    tbsConexao1: TTabSheet;
    tbsConexao2: TTabSheet;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnDir1Click(Sender: TObject);
    procedure btnDirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnVisualizarSenha2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnVisualizarSenha1Click(Sender: TObject);
  private
    Controller: TPrincipalController;
    procedure iniciarForm;
    procedure Salvar;
    Procedure Cancelar;
  public

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.lfm}

{ TfrmPrincipal }

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  iniciarForm;
end;

procedure TfrmPrincipal.btnVisualizarSenha1Click(Sender: TObject);
begin
  if edtSenha1.PasswordChar = Char('#') then
    edtSenha1.PasswordChar := Char('')
  else
    edtSenha1.PasswordChar := '#';
end;

procedure TfrmPrincipal.btnDirClick(Sender: TObject);
begin
  if OpenDlg.Execute then
  begin
    edtBanco1.Text := OpenDlg.FileName;
  end;
end;

procedure TfrmPrincipal.btnSalvarClick(Sender: TObject);
begin
  Salvar;
end;

procedure TfrmPrincipal.btnVisualizarSenha2Click(Sender: TObject);
begin
  if edtSenha2.PasswordChar = Char('#') then
    edtSenha2.PasswordChar := Char('')
  else
    edtSenha2.PasswordChar := '#';
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  Controller := TPrincipalController.Create;
  pgc.Style := tsButtons;
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmPrincipal.btnDir1Click(Sender: TObject);
begin
  if OpenDlg.Execute then
  begin
    edtBanco2.Text := OpenDlg.FileName;
  end;
end;

procedure TfrmPrincipal.btnCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TfrmPrincipal.iniciarForm;
begin

  pgc.ActivePageIndex := 0;

  cbDriver1.Items.Clear;
  GetConnectionList(cbDriver1.Items);
  cbDriver2.Items.Clear;
  GetConnectionList(cbDriver2.Items);

  cbDriver1.ItemIndex := cbDriver1.Items.IndexOf(Controller.INI.Driver1);
  edtServidor1.Text   := Controller.INI.Servidor1;
  edtPorta1.Text      := Controller.INI.Porta1.ToString;
  edtBanco1.Text      := Controller.INI.Banco1;
  edtUsuario1.Text    := Controller.INI.Usuario1;
  edtSenha1.Text      := Controller.INI.Senha1;
  edtCharset1.Text    := Controller.INI.CharSet1;
  ckbLogSql1.Checked  := Controller.INI.LogSQL1;

  cbDriver2.ItemIndex := cbDriver2.Items.IndexOf(Controller.INI.Driver2);
  edtServidor2.Text   := Controller.INI.Servidor2;
  edtPorta2.Text      := Controller.INI.Porta2.ToString;
  edtBanco2.Text      := Controller.INI.Banco2;
  edtUsuario2.Text    := Controller.INI.Usuario2;
  edtSenha2.Text      := Controller.INI.Senha2;
  edtCharset2.Text    := Controller.INI.CharSet2;
  ckbLogSql2.Checked  := Controller.INI.LogSQL2;

end;

procedure TfrmPrincipal.Salvar;
begin

  Controller.INI.Driver1   := cbDriver1.Text;
  Controller.INI.Servidor1 := edtServidor1.Text ;
  Controller.INI.Porta1    := StrToInt(edtPorta1.Text);
  Controller.INI.Banco1    := edtBanco1.Text;
  Controller.INI.Usuario1  := edtUsuario1.Text;
  Controller.INI.Senha1    := edtSenha1.Text;
  Controller.INI.CharSet1  := edtCharset1.Text;
  Controller.INI.LogSQL1   := ckbLogSql1.Checked;

  Controller.INI.Driver2   := cbDriver2.Text;
  Controller.INI.Servidor2 := edtServidor2.Text ;
  Controller.INI.Porta2    := StrToInt(edtPorta2.Text);
  Controller.INI.Banco2    := edtBanco2.Text;
  Controller.INI.Usuario2  := edtUsuario2.Text;
  Controller.INI.Senha2    := edtSenha2.Text;
  Controller.INI.CharSet2  := edtCharset2.Text;
  Controller.INI.LogSQL2   := ckbLogSql2.Checked;

  Controller.INI.Escrever;

  TfrmMessage.Mensagem('Configurações salvas com sucesso!', 'Aviso', 'S', [mbOk]);

end;

procedure TfrmPrincipal.Cancelar;
begin
  Close;
end;

end.

