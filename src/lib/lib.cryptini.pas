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

  procedure inicializar(Arquivo, key, MD5: PChar); stdcall;
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
  name 'inicializar';

  procedure finalizar; stdcall;
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
  name 'finalizar';

  procedure LerString(Secao, Identificador: PChar; out Valor: String); stdcall;
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

  procedure LerInteger(Secao, Identificador: PChar; out Valor: Integer); stdcall;
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

  procedure LerBoolean(Secao, Identificador: PChar; out Valor: Boolean); stdcall;
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
  
  procedure LerData(Secao, Identificador: PChar; out Valor: TDate); stdcall;
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
  
  procedure LerHora(Secao, Identificador: PChar; out Valor: TTime); stdcall;
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
  
  procedure LerDataHora(Secao, Identificador: PChar; out Valor: TDateTime); stdcall;
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
  
  procedure EscreverString(Secao, Identificador, Valor: PChar); stdcall;
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

  procedure EscreverInteger(Secao, Identificador: PChar; Valor: Integer); stdcall;
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
  
  procedure EscreverBoolean(Secao, Identificador: PChar; Valor: Boolean); stdcall;
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
  
  procedure EscreverData(Secao, Identificador: PChar; Valor: TDate); stdcall;
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
  
  procedure EscreverHora(Secao, Identificador: PChar; Valor: TTime); stdcall;
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
  
  procedure EscreverDataHora(Secao, Identificador: PChar; Valor: TDateTime); stdcall;
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
  
  procedure ExisteSecao(Secao: PChar; out Existe: Boolean); stdcall;
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
  
  procedure ExisteValor(Secao, Identificador: PChar; out Existe: Boolean); stdcall;
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

