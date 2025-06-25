unit view.ajuda;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  StdCtrls, controller.ajuda;

type

  { TfrmAjuda }

  TfrmAjuda = class(TForm)
    imgLogoSobre: TImage;
    lblDataVersao: TLabel;
    lblVersao: TLabel;
    lblDescSobre: TLabel;
    lblTituloSobre: TLabel;
    pnlBottomSobre: TPanel;
    pnlFundoSobre: TPanel;
    pgc: TPageControl;
    pnlFundo: TPanel;
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

