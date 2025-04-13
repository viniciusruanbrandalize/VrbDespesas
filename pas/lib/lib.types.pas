unit lib.types;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  TOperacaoCRUD = (opNenhum, opInserir, opEditar, opExcluir, opVisualizar);

type
  TTelaRecebimento = (telaSalario, telaGeral);

type
  TIntegerArray = array[0..100] of Integer;

implementation

end.
