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

