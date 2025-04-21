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
    procedure btnAvancarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
  Controller.BuscarDonoCadastroPermitidos(cbDonoCadastro);
  if cbDonoCadastro.Items.Count > 0 then
    cbDonoCadastro.ItemIndex := 0;
end;

end.

