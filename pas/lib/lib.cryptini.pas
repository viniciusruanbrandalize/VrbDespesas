unit lib.cryptini;

{$mode ObjFPC}{$H+}

interface

  procedure inicializar(Arquivo, key, MD5: PChar); stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX32}
  'libvrbcryptini32.so'
  {$ENDIF}
  {$IFDEF LINUX64}
  'libvrbcryptini64.so'
  {$ENDIF}
  name 'inicializar';

  procedure finalizar; stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX32}
  'libvrbcryptini32.so'
  {$ENDIF}
  {$IFDEF LINUX64}
  'libvrbcryptini64.so'
  {$ENDIF}
  name 'finalizar';

  procedure LerString(Secao, Identificador: PChar; out Valor: String); stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX32}
  'libvrbcryptini32.so'
  {$ENDIF}
  {$IFDEF LINUX64}
  'libvrbcryptini64.so'
  {$ENDIF}
  name 'LerString';

  procedure LerInteger(Secao, Identificador: PChar; out Valor: Integer); stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX32}
  'libvrbcryptini32.so'
  {$ENDIF}
  {$IFDEF LINUX64}
  'libvrbcryptini64.so'
  {$ENDIF}
  name 'LerInteger';

  procedure LerBoolean(Secao, Identificador: PChar; out Valor: Boolean); stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX32}
  'libvrbcryptini32.so'
  {$ENDIF}
  {$IFDEF LINUX64}
  'libvrbcryptini64.so'
  {$ENDIF}
  name 'LerBoolean';
  
  procedure LerData(Secao, Identificador: PChar; out Valor: TDate); stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX32}
  'libvrbcryptini32.so'
  {$ENDIF}
  {$IFDEF LINUX64}
  'libvrbcryptini64.so'
  {$ENDIF}
  name 'LerData';
  
  procedure LerHora(Secao, Identificador: PChar; out Valor: TTime); stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX32}
  'libvrbcryptini32.so'
  {$ENDIF}
  {$IFDEF LINUX64}
  'libvrbcryptini64.so'
  {$ENDIF}
  name 'LerHora';
  
  procedure LerDataHora(Secao, Identificador: PChar; out Valor: TDateTime); stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX32}
  'libvrbcryptini32.so'
  {$ENDIF}
  {$IFDEF LINUX64}
  'libvrbcryptini64.so'
  {$ENDIF}
  name 'LerDataHora';
  
  procedure EscreverString(Secao, Identificador, Valor: PChar); stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX32}
  'libvrbcryptini32.so'
  {$ENDIF}
  {$IFDEF LINUX64}
  'libvrbcryptini64.so'
  {$ENDIF}
  name 'EscreverString';

  procedure EscreverInteger(Secao, Identificador: PChar; Valor: Integer); stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX32}
  'libvrbcryptini32.so'
  {$ENDIF}
  {$IFDEF LINUX64}
  'libvrbcryptini64.so'
  {$ENDIF}
  name 'EscreverInteger';
  
  procedure EscreverBoolean(Secao, Identificador: PChar; Valor: Boolean); stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX32}
  'libvrbcryptini32.so'
  {$ENDIF}
  {$IFDEF LINUX64}
  'libvrbcryptini64.so'
  {$ENDIF}
  name 'EscreverBoolean';
  
  procedure EscreverData(Secao, Identificador: PChar; Valor: TDate); stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX32}
  'libvrbcryptini32.so'
  {$ENDIF}
  {$IFDEF LINUX64}
  'libvrbcryptini64.so'
  {$ENDIF}
  name 'EscreverData';
  
  procedure EscreverHora(Secao, Identificador: PChar; Valor: TTime); stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX32}
  'libvrbcryptini32.so'
  {$ENDIF}
  {$IFDEF LINUX64}
  'libvrbcryptini64.so'
  {$ENDIF}
  name 'EscreverHora';
  
  procedure EscreverDataHora(Secao, Identificador: PChar; Valor: TDateTime); stdcall;
  external 'libvrbcryptini32.dll' name 'EscreverDataHora';
  
  procedure ExisteSecao(Secao: PChar; out Existe: Boolean); stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX32}
  'libvrbcryptini32.so'
  {$ENDIF}
  {$IFDEF LINUX64}
  'libvrbcryptini64.so'
  {$ENDIF}
  name 'ExisteSecao';
  
  procedure ExisteValor(Secao, Identificador: PChar; out Existe: Boolean); stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX32}
  'libvrbcryptini32.so'
  {$ENDIF}
  {$IFDEF LINUX64}
  'libvrbcryptini64.so'
  {$ENDIF}
  name 'ExisteValor';

implementation

end.

