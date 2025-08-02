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

unit model.entity.logbackup;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TLogBackup }

  TLogBackup = class
  private
    FId:   Integer;
    FData: TDate;
    FHora: TTime;
    FLocalArquivo: String;
    function GetData: TDate;
    function GetHora: TTime;
    function GetId: Integer;
    function GetLocalArquivo: String;
    procedure SetData(AValue: TDate);
    procedure SetHora(AValue: TTime);
    procedure SetId(AValue: Integer);
    procedure SetLocalArquivo(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Id: Integer read GetId write SetId;
    property LocalArquivo: String read GetLocalArquivo write SetLocalArquivo;
    property Data: TDate read GetData write SetData;
    property Hora: TTime read GetHora write SetHora;
  end;

implementation

{ TLogBackup }

function TLogBackup.GetId: Integer;
begin
  Result := FId;
end;

function TLogBackup.GetLocalArquivo: String;
begin
  Result := FLocalArquivo;
end;

function TLogBackup.GetData: TDate;
begin
  Result := FData;
end;

function TLogBackup.GetHora: TTime;
begin
  Result := FHora;
end;

procedure TLogBackup.SetData(AValue: TDate);
begin
  FData := AValue;
end;

procedure TLogBackup.SetHora(AValue: TTime);
begin
  FHora := AValue;
end;

procedure TLogBackup.SetId(AValue: Integer);
begin
  FId := AValue;
end;

procedure TLogBackup.SetLocalArquivo(AValue: String);
begin
  FLocalArquivo := AValue;
end;

constructor TLogBackup.Create;
begin
  //
end;

destructor TLogBackup.Destroy;
begin
  inherited Destroy;
end;

end.

