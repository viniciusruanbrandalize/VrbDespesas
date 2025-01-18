unit lib.cryptini;

{$mode ObjFPC}{$H+}

interface

  procedure inicializar(Arquivo, key, MD5: PChar); stdcall;
  external 'libvrbcryptini32.dll' name 'inicializar';

  procedure finalizar; stdcall;
  external 'libvrbcryptini32.dll' name 'finalizar';

  procedure LerString(Secao, Identificador: PChar; out Valor: String); stdcall;
  external 'libvrbcryptini32.dll' name 'LerString';

  procedure LerInteger(Secao, Identificador: PChar; out Valor: Integer); stdcall;
  external 'libvrbcryptini32.dll' name 'LerInteger';

  procedure LerBoolean(Secao, Identificador: PChar; out Valor: Boolean); stdcall;
  external 'libvrbcryptini32.dll' name 'LerBoolean';
  
  procedure LerData(Secao, Identificador: PChar; out Valor: TDate); stdcall;
  external 'libvrbcryptini32.dll' name 'LerData';
  
  procedure LerHora(Secao, Identificador: PChar; out Valor: TTime); stdcall;
  external 'libvrbcryptini32.dll' name 'LerHora';
  
  procedure LerDataHora(Secao, Identificador: PChar; out Valor: TDateTime); stdcall;
  external 'libvrbcryptini32.dll' name 'LerDataHora';
  
  procedure EscreverString(Secao, Identificador, Valor: PChar); stdcall;
  external 'libvrbcryptini32.dll' name 'EscreverString';

  procedure EscreverInteger(Secao, Identificador: PChar; Valor: Integer); stdcall;
  external 'libvrbcryptini32.dll' name 'EscreverInteger';
  
  procedure EscreverBoolean(Secao, Identificador: PChar; Valor: Boolean); stdcall;
  external 'libvrbcryptini32.dll' name 'EscreverBoolean';
  
  procedure EscreverData(Secao, Identificador: PChar; Valor: TDate); stdcall;
  external 'libvrbcryptini32.dll' name 'EscreverData';
  
  procedure EscreverHora(Secao, Identificador: PChar; Valor: TTime); stdcall;
  external 'libvrbcryptini32.dll' name 'EscreverHora';
  
  procedure EscreverDataHora(Secao, Identificador: PChar; Valor: TDateTime); stdcall;
  external 'libvrbcryptini32.dll' name 'EscreverDataHora';
  
  procedure ExisteSecao(Secao: PChar; out Existe: Boolean); stdcall;
  external 'libvrbcryptini32.dll' name 'ExisteSecao';
  
  procedure ExisteValor(Secao, Identificador: PChar; out Existe: Boolean); stdcall;
  external 'libvrbcryptini32.dll' name 'ExisteValor';

implementation

end.

