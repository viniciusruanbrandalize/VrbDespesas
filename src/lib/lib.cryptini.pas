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

unit lib.cryptini;

{$mode ObjFPC}{$H+}

interface

  function LerString(Arquivo, key, MD5, Secao, Identificador, Default: PChar): Pchar; stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX}
    {$IFDEF CPU32}
      'libvrbcryptini32.so'
    {$ENDIF}
    {$IFDEF CPU64}
      'libvrbcryptini64.so'
    {$ENDIF}
  {$ENDIF}
  name 'LerString';

  function LerString255(Arquivo, key, MD5, Secao, Identificador, Default: PChar): ShortString; stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX}
    {$IFDEF CPU32}
      'libvrbcryptini32.so'
    {$ENDIF}
    {$IFDEF CPU64}
      'libvrbcryptini64.so'
    {$ENDIF}
  {$ENDIF}
  name 'LerString255';

  function LerInteger(Arquivo, key, MD5, Secao, Identificador: PChar; Default: Integer): Integer; stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX}
    {$IFDEF CPU32}
      'libvrbcryptini32.so'
    {$ENDIF}
    {$IFDEF CPU64}
      'libvrbcryptini64.so'
    {$ENDIF}
  {$ENDIF}
  name 'LerInteger';

  function LerBoolean(Arquivo, key, MD5, Secao, Identificador: PChar; Default: Boolean): Boolean; stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX}
    {$IFDEF CPU32}
      'libvrbcryptini32.so'
    {$ENDIF}
    {$IFDEF CPU64}
      'libvrbcryptini64.so'
    {$ENDIF}
  {$ENDIF}
  name 'LerBoolean';
  
  function LerData(Arquivo, key, MD5, Secao, Identificador: PChar; Default: TDate): TDate; stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX}
    {$IFDEF CPU32}
      'libvrbcryptini32.so'
    {$ENDIF}
    {$IFDEF CPU64}
      'libvrbcryptini64.so'
    {$ENDIF}
  {$ENDIF}
  name 'LerData';
  
  function LerHora(Arquivo, key, MD5, Secao, Identificador: PChar; Default: TTime): TTime; stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX}
    {$IFDEF CPU32}
      'libvrbcryptini32.so'
    {$ENDIF}
    {$IFDEF CPU64}
      'libvrbcryptini64.so'
    {$ENDIF}
  {$ENDIF}
  name 'LerHora';
  
  function LerDataHora(Arquivo, key, MD5, Secao, Identificador: PChar; Default: TDateTime): TDateTime; stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX}
    {$IFDEF CPU32}
      'libvrbcryptini32.so'
    {$ENDIF}
    {$IFDEF CPU64}
      'libvrbcryptini64.so'
    {$ENDIF}
  {$ENDIF}
  name 'LerDataHora';
  
  procedure EscreverString(Arquivo, key, MD5, Secao, Identificador, Valor: PChar); stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX}
    {$IFDEF CPU32}
      'libvrbcryptini32.so'
    {$ENDIF}
    {$IFDEF CPU64}
      'libvrbcryptini64.so'
    {$ENDIF}
  {$ENDIF}
  name 'EscreverString';

  procedure EscreverInteger(Arquivo, key, MD5, Secao, Identificador: PChar; Valor: Integer); stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX}
    {$IFDEF CPU32}
      'libvrbcryptini32.so'
    {$ENDIF}
    {$IFDEF CPU64}
      'libvrbcryptini64.so'
    {$ENDIF}
  {$ENDIF}
  name 'EscreverInteger';
  
  procedure EscreverBoolean(Arquivo, key, MD5, Secao, Identificador: PChar; Valor: Boolean); stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX}
    {$IFDEF CPU32}
      'libvrbcryptini32.so'
    {$ENDIF}
    {$IFDEF CPU64}
      'libvrbcryptini64.so'
    {$ENDIF}
  {$ENDIF}
  name 'EscreverBoolean';
  
  procedure EscreverData(Arquivo, key, MD5, Secao, Identificador: PChar; Valor: TDate); stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX}
    {$IFDEF CPU32}
      'libvrbcryptini32.so'
    {$ENDIF}
    {$IFDEF CPU64}
      'libvrbcryptini64.so'
    {$ENDIF}
  {$ENDIF}
  name 'EscreverData';
  
  procedure EscreverHora(Arquivo, key, MD5, Secao, Identificador: PChar; Valor: TTime); stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX}
    {$IFDEF CPU32}
      'libvrbcryptini32.so'
    {$ENDIF}
    {$IFDEF CPU64}
      'libvrbcryptini64.so'
    {$ENDIF}
  {$ENDIF}
  name 'EscreverHora';
  
  procedure EscreverDataHora(Arquivo, key, MD5, Secao, Identificador: PChar; Valor: TDateTime); stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX}
    {$IFDEF CPU32}
      'libvrbcryptini32.so'
    {$ENDIF}
    {$IFDEF CPU64}
      'libvrbcryptini64.so'
    {$ENDIF}
  {$ENDIF}
  name 'EscreverDataHora';
  
  function ExisteSecao(Arquivo, key, MD5, Secao: PChar): Boolean; stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX}
    {$IFDEF CPU32}
      'libvrbcryptini32.so'
    {$ENDIF}
    {$IFDEF CPU64}
      'libvrbcryptini64.so'
    {$ENDIF}
  {$ENDIF}
  name 'ExisteSecao';
  
  function ExisteValor(Arquivo, key, MD5, Secao, Identificador: PChar): Boolean; stdcall;
  external
  {$IFDEF WIN32}
  'libvrbcryptini32.dll'
  {$ENDIF}
  {$IFDEF WIN64}
  'libvrbcryptini64.dll'
  {$ENDIF}
  {$IFDEF LINUX}
    {$IFDEF CPU32}
      'libvrbcryptini32.so'
    {$ENDIF}
    {$IFDEF CPU64}
      'libvrbcryptini64.so'
    {$ENDIF}
  {$ENDIF}
  name 'ExisteValor';

implementation

end.

