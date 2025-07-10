unit lib.version;

{
   Essa unit usa o Versionamento Semântico

   Em Resumo:
   Dado um número de versão MAJOR.MINOR.PATCH, incremente:

   Versão MAJOR quando você faz alterações de API incompatíveis.
   Versão MINOR quando você adiciona funcionalidade de maneira compatível
   com versões anteriores.
   Versão PATCH quando você faz correções de bugs compatíveis com versões
   anteriores.

}

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

const
  NUMERO_VERSAO = '0.2.3-alpha';
const
  DATA_VERSA0   = '10/07/2025';

implementation

end.
