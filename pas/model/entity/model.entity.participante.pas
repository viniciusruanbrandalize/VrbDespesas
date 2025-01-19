unit model.entity.participante;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, model.entity.cidade, model.entity.usuario;

type
  IParticipante = interface
  ['{13C3526D-E306-4A53-80BC-839A6C80258F}']

    function GetId: Integer;
    function GetNome: String;
    procedure SetId(AValue: Integer);
    procedure SetNome(AValue: String);

  end;


implementation

end.
