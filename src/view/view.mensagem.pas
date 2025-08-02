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

unit view.mensagem;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons;

type
  TMyButtons = (mbSim, mbNao, mbOk);

type
  TAlinhamento = (AEsquerda, ADireita, ACentro);

type

		{ TfrmMessage }

  TfrmMessage = class(TForm)
    btnNao: TBitBtn;
    btnOk: TBitBtn;
    btnSim: TBitBtn;
    imgCuidado: TImage;
    imgDeletar: TImage;
    imgErro: TImage;
    imgInformacao: TImage;
	ImgList: TImageList;
    imgQuestao: TImage;
    imgSucesso: TImage;
    lblMensagem: TLabel;
    Panel1: TPanel;
    pnlBotoes: TPanel;
    pnlIcones: TPanel;
    pnlMensagem: TPanel;
    scboxMensagem: TScrollBox;
    procedure FormShow(Sender: TObject);
  private
    BotaoFocado: Integer;
  public
    function AjustarTexto(Texto: String; Alinhamento: TAlinhamento=ACentro): String;
    class function Mensagem(Texto, Titulo: String; Tipo: Char; Botoes: array of TMyButtons;
            BotaoSetado: TMyButtons=mbOk; TamanhoFonte: Integer=10; Altura: Integer=200;
            Largura: Integer=500): Boolean;
  end;

var
  frmMessage: TfrmMessage;

const
   LEFTBUTTONS : array[0..2] of integer = (258, 178, 97);

implementation

{$R *.lfm}

{ TfrmMessage }

procedure TfrmMessage.FormShow(Sender: TObject);
begin
  case BotaoFocado of
    0:
    begin
      if btnSim.CanFocus then
      begin
        btnSim.SetFocus;
      end;
    end;
    1:
    begin
      if btnNao.CanFocus then
      begin
        btnNao.SetFocus;
      end;
    end;
    2:
    begin
      if btnOk.CanFocus then
      begin
        btnOk.SetFocus;
      end;
    end;
  end;
end;

function TfrmMessage.AjustarTexto(Texto: String;
  Alinhamento: TAlinhamento=ACentro): String;
var
  tamanho: Integer;
  msn: String;
begin
  tamanho := Texto.Length;
  msn:=Texto;
  case Alinhamento of
    ACentro:
    begin
      while tamanho < 26 do
      begin
        if (tamanho mod 2) = 0 then
        begin
          msn := ' '+msn;
        end
        else
        begin
          msn := msn+' ';
        end;
        Inc(tamanho, 1);
      end;
    end;
  end;
  Result := msn;
end;

class function TfrmMessage.Mensagem(Texto, Titulo: String; Tipo: Char; Botoes: array of TMyButtons;
        BotaoSetado: TMyButtons=mbOk; TamanhoFonte: Integer=10; Altura: Integer=200;
        Largura: Integer=500): Boolean;
var
  i : Integer;
  frm : TfrmMessage;
begin
  frm := TfrmMessage.Create(nil);

  try
    frm.lblMensagem.Font.Size := TamanhoFonte;
    frm.Height := Altura;
    frm.Width := Largura;
    frm.lblMensagem.Caption := Texto;
    frm.Caption := Titulo;

    for i:=0 to Length(Botoes)-1 do
    begin
      case (Botoes[i]) of
        mbOk: begin
                frm.BtnOK.Visible := True;
                frm.BtnOK.Left := LEFTBUTTONS[i];
              end;

        mbSim: begin
                 frm.btnSim.Visible := True;
                 frm.btnSim.Left := LEFTBUTTONS[i];
               end;

        mbNao: begin
                 frm.BtnNao.Visible := True;
                 frm.BtnNao.Left := LEFTBUTTONS[i];
               end;

        else
        begin
          frm.BtnOK.Visible := True;
          frm.BtnOK.Left := LEFTBUTTONS[i];
        end;
      end;
    end;

     case (Tipo) of
      'I': begin
             frm.imgInformacao.Visible := True;
             frm.imgInformacao.Align := alClient;
           end;
      'D': begin
             frm.imgDeletar.Visible := True;
             frm.imgDeletar.Align := alClient;
           end;
      'Q': begin
             frm.imgQuestao.Visible := True;
             frm.imgQuestao.Align := alClient;
           end;
      'C': begin
             frm.imgCuidado.Visible := True;
             frm.imgCuidado.Align := alClient;
           end;
      'E': begin
             frm.BorderStyle := bsSizeable;
             frm.imgErro.Visible := True;
             frm.imgErro.Align := alClient;
           end;
      'S': begin
             frm.imgSucesso.Visible := True;
             frm.imgSucesso.Align := alClient;
           end
      else
      begin
        frm.imgInformacao.Visible := True;
        frm.imgInformacao.Align := alClient;
      end;

    end;

    case BotaoSetado of
      mbOk:  frm.BotaoFocado := 2;
      mbSim: frm.BotaoFocado := 0;
      mbNao: frm.BotaoFocado := 1;
    end;

    frm.ShowModal;

    case (frm.ModalResult) of
      mrOk, mrYes : result := True;
    else
      result := False;
    end;
  finally
    if (frm <> nil) then
      FreeAndNil(frm);
    end;
  end;
end.

end.
