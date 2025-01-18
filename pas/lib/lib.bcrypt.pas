unit lib.bcrypt;

{$mode ObjFPC}{$H+}

interface

  procedure compareHashBCrypt(textoPuro, textoHash: PChar; out Valido: Boolean); stdcall;
  external
   {$IFDEF WIN32}
  'libvrbbcrypt32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbbcrypt64.dll'
  {$ENDIF}
  {$IFDEF LINUX32}
  'libvrbbcrypt32.so'
  {$ENDIF}
  {$IFDEF LINUX64}
  'libvrbbcrypt64.so'
  {$ENDIF}
  name 'compareHashBCrypt';

  procedure encryptBCrypt(texto: PChar; out TextoEncriptado: PChar); stdcall;
  external
   {$IFDEF WIN32}
  'libvrbbcrypt32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbbcrypt64.dll'
  {$ENDIF}
  {$IFDEF LINUX32}
  'libvrbbcrypt32.so'
  {$ENDIF}
  {$IFDEF LINUX64}
  'libvrbbcrypt64.so'
  {$ENDIF}
  name 'encryptBCrypt';


implementation

end.

