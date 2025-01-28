unit view.login;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, controller.login, view.mensagem;

type

  { TfrmLogin }

  TfrmLogin = class(TForm)
    edtUsuario: TEdit;
    edtSenha: TEdit;
    ImgList: TImageList;
    imgLogo: TImage;
    lblEsqueciSenha: TLabel;
    lblBemVindo: TLabel;
    lblInfoDev: TLabel;
    lblCkb: TLabel;
    lblUsuario: TLabel;
    lblSenha: TLabel;
    lblErro: TLabel;
    lblTitulo: TLabel;
    pnlLinhaSenha: TPanel;
    pnlLinhaUsuario: TPanel;
    pnlDireito: TPanel;
    pnlEsquerdo: TPanel;
    pnlFundo: TPanel;
    btnAcessar: TSpeedButton;
    btnMostrarSenha: TSpeedButton;
    procedure btnAcessarClick(Sender: TObject);
    procedure btnMostrarSenhaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lblCkbClick(Sender: TObject);
    procedure lblEsqueciSenhaMouseEnter(Sender: TObject);
    procedure lblEsqueciSenhaMouseLeave(Sender: TObject);
  private
    controller : TLoginController;
    procedure fazerLogin();
    procedure MudaVisualizacaoCampoSenha();
  public

  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.lfm}

{ TfrmLogin }

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  edtSenha.Text := '';
  edtUsuario.Text := '';
  lblErro.Caption := '';
  edtUsuario.SetFocus;
end;

procedure TfrmLogin.lblCkbClick(Sender: TObject);
begin
  MudaVisualizacaoCampoSenha();
end;

procedure TfrmLogin.lblEsqueciSenhaMouseEnter(Sender: TObject);
begin
  lblEsqueciSenha.Font.Style := [fsUnderline];
end;

procedure TfrmLogin.lblEsqueciSenhaMouseLeave(Sender: TObject);
begin
  lblEsqueciSenha.Font.Style := [];
end;

procedure TfrmLogin.fazerLogin;
begin
  //dtsLogin.DataSet := TControllerLogin(controller).Filtrar('nome', edtUsuario.Text);
  //
  //if TControllerLogin(controller).TotalRegistro(dtsLogin.DataSet) = 1 then
  //begin
  //  if compareHashBCrypt(edtSenha.Text, dtsLogin.DataSet.FieldByName('senha').AsString) then
  //  begin
  //    TControllerLogin(controller).GravarLogin(dtsLogin.DataSet.FieldByName('id').AsInteger);
  //    ModalResult := mrOK;
  //  end
  //  else
  //  begin
  //    TfrmMessage.Mensagem('A Senha está incorreta!', 'Aviso', 'C', [mbOk]);
  //  end;
  //end
  //else
  //begin
  //  TfrmMessage.Mensagem('Usuário não existe!', 'Aviso', 'C', [mbOk]);
  //end;
end;

procedure TfrmLogin.MudaVisualizacaoCampoSenha;
begin
  if btnMostrarSenha.ImageIndex = -1 then
  begin
    btnMostrarSenha.ImageIndex := 0;
    edtSenha.PasswordChar := #0;
  end
  else
  begin
    btnMostrarSenha.ImageIndex := -1;
    edtSenha.PasswordChar := '*';
  end;
end;

procedure TfrmLogin.btnAcessarClick(Sender: TObject);
begin
  fazerLogin();
end;

procedure TfrmLogin.btnMostrarSenhaClick(Sender: TObject);
begin
  MudaVisualizacaoCampoSenha();
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  controller := TLoginController.Create;
end;

procedure TfrmLogin.FormDestroy(Sender: TObject);
begin
  FreeAndNil(controller);
end;

end.

