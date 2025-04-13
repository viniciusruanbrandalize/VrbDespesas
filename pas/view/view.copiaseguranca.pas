unit view.copiaseguranca;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  Buttons, StdCtrls, controller.copiaseguranca, view.mensagem;

type

  { TfrmCopiaSeguranca }

  TfrmCopiaSeguranca = class(TForm)
    imgList: TImageList;
    img: TImage;
    edtDir: TLabeledEdit;
    Label1: TLabel;
    lblStatus: TLabel;
    pgb: TProgressBar;
    btnIniciarBkp: TSpeedButton;
    btnSelecionar: TSpeedButton;
    DirDlg: TSelectDirectoryDialog;
    procedure btnIniciarBkpClick(Sender: TObject);
    procedure btnSelecionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Controller: TCopiaSegurancaController;
  public

  end;

var
  frmCopiaSeguranca: TfrmCopiaSeguranca;

implementation

{$R *.lfm}

{ TfrmCopiaSeguranca }

procedure TfrmCopiaSeguranca.btnSelecionarClick(Sender: TObject);
begin
  if DirDlg.Execute then
    edtDir.Text := DirDlg.FileName;
end;

procedure TfrmCopiaSeguranca.FormCreate(Sender: TObject);
begin
  Controller := TCopiaSegurancaController.Create;
end;

procedure TfrmCopiaSeguranca.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmCopiaSeguranca.btnIniciarBkpClick(Sender: TObject);
begin
  if edtDir.Text <> EmptyStr then
  begin
    try
      lblStatus.Caption := '';
      btnIniciarBkp.Enabled := False;
      lblStatus.Visible := True;
      Application.ProcessMessages;
      if Controller.IniciarBackup(edtDir.Text, pgb, lblStatus) then
        TfrmMessage.Mensagem('Backup realizado com sucesso!', 'Aviso', 'S', [mbOk]);
    finally
      btnIniciarBkp.Enabled := True;
      lblStatus.Visible := false;
      pgb.Position := 0;
    end;
  end
  else
    TfrmMessage.Mensagem('Selecione o diretório de destino!', 'Aviso', 'C', [mbOk]);
end;

end.

