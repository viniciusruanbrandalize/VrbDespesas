{
*******************************************************************************
*   VRBDespesas                                                               *
*   Controle e gerenciamento de despesas.                                     *
*                                                                             *
*   Copyright (C) 2025 Vinícius Ruan Brandalize.                              *
*                                                                             *
*   This program is free software: you can redistribute it and/or modify      *
*   it under the terms of the GNU General Public License as published by      *
*   the Free Software Foundation, either version 3 of the License, or         *
*   (at your option) any later version.                                       *
*                                                                             *
*   This program is distributed in the hope that it will be useful,           *
*   but WITHOUT ANY WARRANTY; without even the implied warranty of            *
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             *
*   GNU General Public License for more details.                              *
*                                                                             *
*   You should have received a copy of the GNU General Public License         *
*   along with this program.  If not, see <https://www.gnu.org/licenses/>.    *
*                                                                             *
*   Contact: viniciusbrandalize2@gmail.com.                                   *
*                                                                             *
*******************************************************************************
}

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
  NUMERO_VERSAO = '0.3.0-alpha';
const
  DATA_VERSA0   = '16/08/2025';

implementation

end.
