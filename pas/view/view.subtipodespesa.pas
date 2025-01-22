unit view.subtipodespesa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, view.cadastropadrao;

type

  { TfrmSubtipoDespesa }

  TfrmSubtipoDespesa = class(TfrmCadastroPadrao)
  private

  public
    procedure CarregarDados; override;
    procedure LimparCampos; override;
    procedure CarregarSelecionado; override;
  end;

var
  frmSubtipoDespesa: TfrmSubtipoDespesa;

implementation

{$R *.lfm}

{ TfrmSubtipoDespesa }

procedure TfrmSubtipoDespesa.CarregarDados;
begin
  lvPadrao.Items.Clear;
  Controller.Listar(lvPadrao);
end;

procedure TfrmSubtipoDespesa.LimparCampos;
begin

end;

procedure TfrmSubtipoDespesa.CarregarSelecionado;
begin

end;

end.

