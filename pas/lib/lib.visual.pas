unit lib.visual;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls;


  procedure CampoNumericoExit(Sender: TObject; Formatacao: String = ',#0.00');
  procedure CampoNumericoEnter(Sender: TObject; Formatacao: String = ',#0.00');
  procedure CampoNumericoKeyPress(Sender: TObject; var Key: char);


implementation

procedure CampoNumericoExit(Sender: TObject; Formatacao: String = ',#0.00');
var
  valor: Double;
begin
  if (Sender is TLabeledEdit) then
  begin
    if TryStrToFloat((Sender as TLabeledEdit).Text, valor) then
      (Sender as TLabeledEdit).Text := FormatFloat(',#0.00', valor)
    else
      (Sender as TLabeledEdit).Text := '0,00';
  end;
end;

procedure CampoNumericoEnter(Sender: TObject; Formatacao: String = ',#0.00');
begin
  CampoNumericoExit(Sender,  Formatacao);
end;

procedure CampoNumericoKeyPress(Sender: TObject; var Key: char);
var
  i: Integer;
begin
  if key = ',' then
  begin
    if (Sender is TLabeledEdit) then
    begin
      for i := 0 to Length((Sender as TLabeledEdit).Text) do
      begin
        if (Sender as TLabeledEdit).Text[i] = ',' then
        begin
          Key := #0;
          Break;
        end;
      end;
    end;
  end
  else
    if not (key in ['0'..'9',',',#8]) then
      key := #0;
end;

end.

