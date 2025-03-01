unit view.relatoriopadrao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ActnList,
  ComCtrls, Buttons, LR_View, lib.visual;

type

  { TfrmRelatorioPadrao }

  TfrmRelatorioPadrao = class(TForm)
    actFechar: TAction;
    actProcurar: TAction;
    actMaisZoom: TAction;
    actMenosZoom: TAction;
    actPdf: TAction;
    actCsv: TAction;
    actTxt: TAction;
    actList: TActionList;
    btnFechar: TSpeedButton;
    fpnlOpcoes: TFlowPanel;
    frPreview: TfrPreview;
    img: TImageList;
    pnlTopoDesigner: TPanel;
    pnlFundoDesigner: TPanel;
    pnlOpcoes: TPanel;
    pnlFundoTbs1: TPanel;
    pgc: TPageControl;
    pnlFundo: TPanel;
    pnlTitulo: TPanel;
    btnPdf: TSpeedButton;
    btnTxt: TSpeedButton;
    btnCsv: TSpeedButton;
    btnProcurar: TSpeedButton;
    tbsDesigner: TTabSheet;
    tbsPrincipal: TTabSheet;
    procedure actCsvExecute(Sender: TObject);
    procedure actFecharExecute(Sender: TObject);
    procedure actPdfExecute(Sender: TObject);
    procedure actProcurarExecute(Sender: TObject);
    procedure actTxtExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure EventosMouseOpcoes();
    procedure PnlBotaoVerdeMouseEnter(Sender: TObject);
    procedure PnlBotaoVerdeMouseLeave(Sender: TObject);
  public

  end;

var
  frmRelatorioPadrao: TfrmRelatorioPadrao;

implementation

{$R *.lfm}

{ TfrmRelatorioPadrao }

procedure TfrmRelatorioPadrao.actFecharExecute(Sender: TObject);
begin
  if pgc.ActivePage = tbsPrincipal then
    Close
  else
  if pgc.ActivePage = tbsDesigner then
    pgc.ActivePage := tbsPrincipal;
end;

procedure TfrmRelatorioPadrao.actCsvExecute(Sender: TObject);
begin
  //
end;

procedure TfrmRelatorioPadrao.actPdfExecute(Sender: TObject);
begin
  //
end;

procedure TfrmRelatorioPadrao.actProcurarExecute(Sender: TObject);
begin
  //
end;

procedure TfrmRelatorioPadrao.actTxtExecute(Sender: TObject);
begin
  //
end;

procedure TfrmRelatorioPadrao.FormCreate(Sender: TObject);
begin
  pgc.ShowTabs        := False;
  pgc.Style           := tsButtons;
  pgc.ActivePageIndex := 0;
  fpnlOpcoes.Align    := alClient;
end;

procedure TfrmRelatorioPadrao.FormResize(Sender: TObject);
begin
  CentralizarComponente(Self, pnlOpcoes);
end;

procedure TfrmRelatorioPadrao.FormShow(Sender: TObject);
begin
  pnlTitulo.Caption  := self.Caption;
  pnlOpcoes.Caption  := '';
  fpnlOpcoes.Caption := '';
  frPreview.Caption  := '';
  EventosMouseOpcoes();
end;

procedure TfrmRelatorioPadrao.EventosMouseOpcoes();
var
  i: Integer;
begin
  for i := 0 to fpnlOpcoes.ControlCount-1 do
  begin
    if ( fpnlOpcoes.Controls[i] is TPanel ) then
    begin
      TPanel(fpnlOpcoes.Controls[i]).OnMouseEnter := @PnlBotaoVerdeMouseEnter;
      TPanel(fpnlOpcoes.Controls[i]).OnMouseLeave := @PnlBotaoVerdeMouseLeave;
      ArredondarComponente(TPanel(fpnlOpcoes.Controls[i]));
    end;
  end;
end;

procedure TfrmRelatorioPadrao.PnlBotaoVerdeMouseEnter(Sender: TObject);
begin
  BotaoVerdeMouseEnter(Sender);
end;

procedure TfrmRelatorioPadrao.PnlBotaoVerdeMouseLeave(Sender: TObject);
begin
  BotaoVerdeMouseLeave(Sender);
end;

end.

