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

unit view.relatoriopadrao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ActnList,
  ComCtrls, Buttons, LR_View, TAGraph, TATools, lib.visual,
  controller.usuarioacesso;

type

  { TfrmRelatorioPadrao }

  TfrmRelatorioPadrao = class(TForm)
    actFechar: TAction;
    actImprimir: TAction;
    actImagemGrafico: TAction;
    actPdfGrafico: TAction;
    actProcurar: TAction;
    actMaisZoom: TAction;
    actMenosZoom: TAction;
    actPdf: TAction;
    actCsv: TAction;
    actTxt: TAction;
    actList: TActionList;
    btnImgGrafico: TSpeedButton;
    btnFechar: TSpeedButton;
    btnImprimir: TSpeedButton;
    btnImprimirGrafico: TSpeedButton;
    btnPdfGrafico: TSpeedButton;
    chGrafico: TChart;
    fpnlOpcoes: TFlowPanel;
    frPreview: TfrPreview;
    img: TImageList;
    pnlFundoGrafico: TPanel;
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
    pnlTopoGrafico: TPanel;
    SaveDlg: TSaveDialog;
    tbsGrafico: TTabSheet;
    tbsDesigner: TTabSheet;
    tbsPrincipal: TTabSheet;
    procedure actCsvExecute(Sender: TObject);
    procedure actFecharExecute(Sender: TObject);
    procedure actImprimirExecute(Sender: TObject);
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
    procedure LiberarBloquearAcessos(var ListaDeAcoes: TActionList; Tela: String);
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
  if (pgc.ActivePage = tbsDesigner) or (pgc.ActivePage = tbsGrafico) then
  begin
    pgc.ActivePage := tbsPrincipal;
    actFechar.ImageIndex := 0;
  end;
end;

procedure TfrmRelatorioPadrao.actImprimirExecute(Sender: TObject);
begin
  frPreview.Print;
end;

procedure TfrmRelatorioPadrao.actCsvExecute(Sender: TObject);
begin
  SaveDlg.Filter := 'CSV|.csv';
  SaveDlg.FileName := 'despesaporperido_'+FormatDateTime('ddmmyyyy_hhnnss', now);
  if SaveDlg.Execute then
    frPreview.ExportTo(SaveDlg.FileName);
end;

procedure TfrmRelatorioPadrao.actPdfExecute(Sender: TObject);
begin
  SaveDlg.Filter := 'PDF|.pdf';
  SaveDlg.FileName := 'despesaporperido_'+FormatDateTime('ddmmyyyy_hhnnss', now);
  if SaveDlg.Execute then
    frPreview.ExportTo(SaveDlg.FileName);
end;

procedure TfrmRelatorioPadrao.actProcurarExecute(Sender: TObject);
begin
  frPreview.Find;
end;

procedure TfrmRelatorioPadrao.actTxtExecute(Sender: TObject);
begin
  SaveDlg.Filter := 'Arquivo de Texto|.txt';
  SaveDlg.FileName := 'despesaporperido_'+FormatDateTime('ddmmyyyy_hhnnss', now);
  if SaveDlg.Execute then
    frPreview.ExportTo(SaveDlg.FileName);
end;

procedure TfrmRelatorioPadrao.FormCreate(Sender: TObject);
begin
  pgc.ShowTabs        := False;
  pgc.Style           := tsButtons;
  pgc.ActivePageIndex := 0;
  fpnlOpcoes.Align    := alClient;
  SaveDlg.InitialDir  := ExtractFilePath(ParamStr(0));
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

procedure TfrmRelatorioPadrao.LiberarBloquearAcessos(
  var ListaDeAcoes: TActionList; Tela: String);
var
  ControleAcesso: TUsuarioAcessoController;
begin
  ControleAcesso := TUsuarioAcessoController.Create;
  try
    ControleAcesso.LiberarBloquearAcessos(ListaDeAcoes, Tela);
  finally
    FreeAndNil(ControleAcesso);
  end;
end;

end.

