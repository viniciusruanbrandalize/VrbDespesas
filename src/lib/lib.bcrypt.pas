unit lib.bcrypt;

{$mode ObjFPC}{$H+}

interface

  function compareHashBCrypt(textoPuro, textoHash: PChar): Boolean; stdcall;
  external
   {$IFDEF WIN32}
  'libvrbbcrypt32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbbcrypt64.dll'
  {$ENDIF}
  {$IFDEF LINUX}
    {$IFDEF CPU32}
      'libvrbbcrypt32.so'
    {$ENDIF}
    {$IFDEF CPU64}
      'libvrbbcrypt64.so'
    {$ENDIF}
  {$ENDIF}
  name 'compareHashBCrypt';

  function encryptBCrypt(texto: PChar): PChar; stdcall;
  external
   {$IFDEF WIN32}
  'libvrbbcrypt32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbbcrypt64.dll'
  {$ENDIF}
  {$IFDEF LINUX}
    {$IFDEF CPU32}
      'libvrbbcrypt32.so'
    {$ENDIF}
    {$IFDEF CPU64}
      'libvrbbcrypt64.so'
    {$ENDIF}
  {$ENDIF}
  name 'encryptBCrypt';


implementation

end.

