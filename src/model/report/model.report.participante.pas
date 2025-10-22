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

unit model.report.participante;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, StrUtils, StdCtrls, model.report.conexao, model.dao.padrao;

type

  { TParticipanteReport }

  TParticipanteReport = Class
  private
    DAO: TPadraoDAO;
    FSQL: String;
  public
    dmRelatorio: TdmConexaoReport;

    {$Region 'Relatorios'}
    function Telemarketing(out Erro: String): Boolean;
    function Completo(out Erro: String): Boolean;
    {$EndRegion}

    {$Region 'Buscas Filtros'}
    procedure PesquisaGenerica(Tabela: TTabela; objNome: TObject; lbId: TListBox; busca: String;
                                Limitacao: Integer; out QtdRegistro: Integer);
    {$EndRegion}

    constructor Create;
    destructor Destroy; override;
end;

implementation

{ TParticipanteReport }

function TParticipanteReport.Telemarketing(out Erro: String): Boolean;
begin
  try

    FSQL := 'select nome, fantasia, telefone, celular, email, cadastro from participante ' +
            'where dono_cadastro = :dono_cadastro and id_dono_cadastro = :id_dono_cadastro ' +
            'and excluido = :excluido ' +
            'order by nome, fantasia';

    dmConexaoReport.qryPadrao.Close;
    dmConexaoReport.qryPadrao.SQL.Clear;
    dmConexaoReport.qryPadrao.SQL.Add(FSQL);
    dmConexaoReport.qryPadrao.ParamByName('id_dono_cadastro').AsInteger := dmConexaoReport.IDDonoCadastro;
    dmConexaoReport.qryPadrao.ParamByName('excluido').AsBoolean := False;
    dmConexaoReport.qryPadrao.ParamByName('dono_cadastro').AsBoolean := False;
    dmConexaoReport.qryPadrao.Open;

    dmConexaoReport.frReport.LoadFromFile(dmConexaoReport.DiretorioRelatorios +
                                         'participante_telemarketing.lrf');
    dmConexaoReport.CarregarLogo();
    dmConexaoReport.frReport.ShowReport;

    Result := True;

  except
    on e: Exception do
    begin
      Erro := 'Erro ao gerar o relatório: ' + e.Message;
      Result := False;
    end;
  end;
end;

function TParticipanteReport.Completo(out Erro: String): Boolean;
begin
  try

    FSQL := 'select p.*, c.nome as nome_cidade, c.uf as uf from participante p ' +
            'left join cidade c on c.id = p.id_cidade ' +
            'where p.dono_cadastro = :dono_cadastro and p.id_dono_cadastro = :id_dono_cadastro ' +
            'and p.excluido = :excluido ' +
            'order by p.nome, p.fantasia';

    dmConexaoReport.qryPadrao.Close;
    dmConexaoReport.qryPadrao.SQL.Clear;
    dmConexaoReport.qryPadrao.SQL.Add(FSQL);
    dmConexaoReport.qryPadrao.ParamByName('id_dono_cadastro').AsInteger := dmConexaoReport.IDDonoCadastro;
    dmConexaoReport.qryPadrao.ParamByName('excluido').AsBoolean := False;
    dmConexaoReport.qryPadrao.ParamByName('dono_cadastro').AsBoolean := False;
    dmConexaoReport.qryPadrao.Open;

    dmConexaoReport.frReport.LoadFromFile(dmConexaoReport.DiretorioRelatorios +
                                         'participante_completo.lrf');
    dmConexaoReport.CarregarLogo();
    dmConexaoReport.frReport.ShowReport;

    Result := True;

  except
    on e: Exception do
    begin
      Erro := 'Erro ao gerar o relatório: ' + e.Message;
      Result := False;
    end;
  end;
end;

procedure TParticipanteReport.PesquisaGenerica(Tabela: TTabela; objNome: TObject;
  lbId: TListBox; busca: String; Limitacao: Integer; out QtdRegistro: Integer);
begin
  DAO.PesquisaGenerica(Tabela, objNome, lbId, busca, Limitacao, QtdRegistro);
end;

constructor TParticipanteReport.Create;
begin
  DAO := TPadraoDAO.Create;
  FSQL := '';
  dmRelatorio := dmConexaoReport;
end;

destructor TParticipanteReport.Destroy;
begin
  FreeAndNil(DAO);
  inherited Destroy;
end;

end.

