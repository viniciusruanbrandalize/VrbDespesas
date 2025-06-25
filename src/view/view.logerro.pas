unit view.logerro;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls, Menus, ActnList, controller.logerro;

type

  { TfrmLogErro }

  TfrmLogErro = class(TForm)
    actVisualizar: TAction;
    actCopiar: TAction;
    actFecharDetalhe: TAction;
    actList: TActionList;
    imgList: TImageList;
    lv: TListView;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem4: TMenuItem;
    mErro: TMemo;
    pnlFundo: TPanel;
    PopupMenuMemo: TPopupMenu;
    PopupMenuLv: TPopupMenu;
    procedure actCopiarExecute(Sender: TObject);
    procedure actFecharDetalheExecute(Sender: TObject);
    procedure actVisualizarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Controller: TLogErroController;
  public

  end;

var
  frmLogErro: TfrmLogErro;

implementation

{$R *.lfm}

{ TfrmLogErro }

procedure TfrmLogErro.actCopiarExecute(Sender: TObject);
begin
  mErro.CopyToClipboard;
end;

procedure TfrmLogErro.actFecharDetalheExecute(Sender: TObject);
begin
  if mErro.Visible then
    mErro.Visible := False;
end;

procedure TfrmLogErro.actVisualizarExecute(Sender: TObject);
var
  erro: String;
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    mErro.Visible := True;
    controller.BuscarPorId(lv.Selected.Caption, sl, erro);
    mErro.Text := sl.Text;
  finally
    sl.Free;
  end;
end;

procedure TfrmLogErro.FormCreate(Sender: TObject);
begin
  Controller := TLogErroController.Create;
end;

procedure TfrmLogErro.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Controller);
end;

procedure TfrmLogErro.FormShow(Sender: TObject);
begin
  mErro.Lines.Clear;
  lv.Items.Clear;
  controller.Listar(lv);
end;

end.

