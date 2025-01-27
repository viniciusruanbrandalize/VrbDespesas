unit view.loglogin;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  controller.loglogin;

type

  { TfrmLogLogin }

  TfrmLogLogin = class(TForm)
    lv: TListView;
    pnlFundo: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    controller: TLogLoginController;
  public

  end;

var
  frmLogLogin: TfrmLogLogin;

implementation

{$R *.lfm}

{ TfrmLogLogin }

procedure TfrmLogLogin.FormCreate(Sender: TObject);
begin
  controller := TLogLoginController.Create;
end;

procedure TfrmLogLogin.FormDestroy(Sender: TObject);
begin
  FreeAndNil(controller);
end;

procedure TfrmLogLogin.FormShow(Sender: TObject);
begin
  lv.Items.Clear;
  controller.Listar(lv);
end;

end.

