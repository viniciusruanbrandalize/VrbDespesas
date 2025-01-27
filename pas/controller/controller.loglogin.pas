unit controller.loglogin;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, model.dao.login, model.entity.login;

type

  { TLogLoginController }

  TLogLoginController = class
  private
    LoginDAO: TLoginDAO;
  public
    Login: TLogin;
    procedure Listar(lv: TListView);
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TLogLoginController }

procedure TLogLoginController.Listar(lv: TListView);
begin
  LoginDAO.Listar(lv);
end;

constructor TLogLoginController.Create;
begin
  LoginDAO := TLoginDAO.Create;
end;

destructor TLogLoginController.Destroy;
begin
  LoginDAO.Free;
  inherited Destroy;
end;

end.
