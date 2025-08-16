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

unit model.dao.recebimento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, SQLDB, model.dao.padrao,
  model.entity.recebimento, model.connection.conexao1, DateUtils;

type

  { TRecebimentoDAO }

  TRecebimentoDAO = class(TPadraoDAO)
  private

  public
    procedure Listar(lv: TListView; Tipo: Integer);
    procedure Pesquisar(lv: TListView; Campo, Busca: String); overload; deprecated;
    procedure Pesquisar(lv: TListView; Campo, Busca: String; DataInicial, DataFinal: TDateTime; Tipo: Integer); overload;
    function BuscarPorId(Recebimento : TRecebimento; Id: Integer; out Erro: String): Boolean;
    function Inserir(Recebimento: TRecebimento; out Erro: string): Boolean;
    function Editar(Recebimento: TRecebimento; out Erro: string): Boolean;
    function Excluir(Id: Integer; out Erro: string): Boolean;
    procedure PesquisarContaBancaria(cbNome: TComboBox; lbId: TListBox; busca: String;
                                      Limitacao: Integer; out QtdRegistro: Integer);
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

{ TRecebimentoDAO }

procedure TRecebimentoDAO.Listar(lv: TListView; Tipo: Integer);
var
  sql: String;
  item : TListItem;
begin
  try

    if Driver = DRV_FIREBIRD then
    begin
      sql := 'select first 100 r.*, p.nome as nome_pagador from recebimento r ' +
             'left join participante p on p.id = r.id_pagador ' +
             'where r.tipo = :tipo and r.id_dono_cadastro = :id_dono_cadastro and ' +
             'r.data between :data_inicial and :data_final ' +
             'order by r.data desc';
    end
    else
    if Driver in [DRV_MYSQL, DRV_MARIADB, DRV_POSTGRESQL] then
    begin
      sql := 'select r.*, p.nome as nome_pagador from recebimento r ' +
             'left join participante p on p.id = r.id_pagador ' +
             'where r.tipo = :tipo and r.id_dono_cadastro = :id_dono_cadastro and ' +
             'r.data between :data_inicial and :data_final ' +
             'order by r.data desc ' +
             'limit 100';
    end;

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('tipo').AsInteger := Tipo;
    Qry.ParamByName('id_dono_cadastro').AsInteger := dmConexao1.DonoCadastro.Id;
    Qry.ParamByName('data_inicial').AsDateTime    := StartOfTheMonth(Now);
    Qry.ParamByName('data_final').AsDateTime      := EndOfTheMonth(Now);
    Qry.Open;

    Qry.First;

    while not Qry.EOF do
    begin
      item := lv.Items.Add;
      item.Caption := Qry.FieldByName('id').AsString;
      item.SubItems.Add(qry.FieldByName('data').AsString);
      item.SubItems.Add(qry.FieldByName('nome_pagador').AsString);
      case tipo of
        0:
        begin
          item.SubItems.Add(FormatFloat(',#0.00', qry.FieldByName('hora_extra').AsFloat));
          item.SubItems.Add(FormatFloat(',#0.00', qry.FieldByName('inss').AsFloat));
          item.SubItems.Add(FormatFloat(',#0.00', qry.FieldByName('ir').AsFloat));
          item.SubItems.Add(FormatFloat(',#0.00', qry.FieldByName('valor_base').AsFloat));
        end;
        1:
        begin
          item.SubItems.Add(qry.FieldByName('descricao').AsString);
        end;
      end;
      item.SubItems.Add(FormatFloat(',#0.00', qry.FieldByName('valor_total').AsFloat));
      Qry.Next;
    end;

  finally
    Qry.Close;
  end;
end;

procedure TRecebimentoDAO.Pesquisar(lv: TListView; Campo, Busca: String);
var
  sql: String;
  item : TListItem;
  valor: Double;
begin
  try

    if TryStrToFloat(Busca, valor) then
    begin
      sql := 'select * from recebimento ' +
             'where '+campo+' = :busca ' +
             'id_dono_cadastro = :id_dono_cadastro '+
             'order by data desc';
    end
    else
    begin
      sql := 'select * from recebimento ' +
             'where UPPER('+campo+') like :busca ' +
             'id_dono_cadastro = :id_dono_cadastro '+
             'order by data desc';
    end;

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('busca').AsString := '%'+UpperCase(Busca)+'%';
    Qry.ParamByName('id_dono_cadastro').AsInteger := dmConexao1.DonoCadastro.Id;
    Qry.Open;

    Qry.First;

    while not Qry.EOF do
    begin
      item := lv.Items.Add;
      item.Caption := Qry.FieldByName('id').AsString;
      item.SubItems.Add(qry.FieldByName('nome').AsString);
      Qry.Next;
    end;

  finally
    qry.Close;
  end;
end;

procedure TRecebimentoDAO.Pesquisar(lv: TListView; Campo, Busca: String;
  DataInicial, DataFinal: TDateTime; Tipo: Integer);
var
  sql: String;
  item : TListItem;
  valor: Double;
begin
  try

    if TryStrToFloat(Busca, valor) then
    begin
      sql := 'select r.*, p.nome as nome_pagador from recebimento r ' +
             'left join participante p on p.id = r.id_pagador ' +
             'where '+campo+' = :busca and r.tipo = :tipo and ' +
             'r.id_dono_cadastro = :id_dono_cadastro and ' +
             'r.data between :data_inicial and :data_final ' +
             'order by r.data desc';
    end
    else
    begin
      sql := 'select r.*, p.nome as nome_pagador from recebimento r ' +
             'left join participante p on p.id = r.id_pagador ' +
             'where UPPER('+campo+') like :busca and r.tipo = :tipo and ' +
             'r.id_dono_cadastro = :id_dono_cadastro and '+
             'r.data between :data_inicial and :data_final ' +
             'order by r.data desc';
    end;

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('busca').AsString := '%'+UpperCase(Busca)+'%';
    Qry.ParamByName('id_dono_cadastro').AsInteger := dmConexao1.DonoCadastro.Id;
    Qry.ParamByName('tipo').AsInteger             := Tipo;
    Qry.ParamByName('data_inicial').AsDateTime    := DataInicial;
    Qry.ParamByName('data_final').AsDateTime      := DataFinal;
    Qry.Open;

    Qry.First;

    while not Qry.EOF do
    begin
      item := lv.Items.Add;
      item.Caption := Qry.FieldByName('id').AsString;
      item.SubItems.Add(qry.FieldByName('data').AsString);
      item.SubItems.Add(qry.FieldByName('nome_pagador').AsString);
      case Tipo of
        0:
        begin
          item.SubItems.Add(FormatFloat(',#0.00', qry.FieldByName('hora_extra').AsFloat));
          item.SubItems.Add(FormatFloat(',#0.00', qry.FieldByName('inss').AsFloat));
          item.SubItems.Add(FormatFloat(',#0.00', qry.FieldByName('ir').AsFloat));
          item.SubItems.Add(FormatFloat(',#0.00', qry.FieldByName('valor_base').AsFloat));
        end;
        1:
        begin
          item.SubItems.Add(qry.FieldByName('descricao').AsString);
        end;
      end;
      item.SubItems.Add(FormatFloat(',#0.00', qry.FieldByName('valor_total').AsFloat));
      Qry.Next;
    end;

  finally
    qry.Close;
  end;
end;

function TRecebimentoDAO.BuscarPorId(Recebimento: TRecebimento; Id: Integer; out Erro: String): Boolean;
var
  sql: String;
begin
  try

    sql := 'select r.*, p.nome as nome_pagador, f.nome as nome_forma_pgto, ' +
           'bco.nome as nome_banco, cb.numero as numero_conta, cb.agencia as agencia_conta ' +
           'from recebimento r ' +
           'left join participante p on p.id = r.id_pagador ' +
           'left join forma_pgto f on f.id = r.id_forma_pgto ' +
           'left join conta_bancaria cb on cb.id = r.id_conta_bancaria ' +
           'left join banco bco on bco.id = cb.id_banco ' +
           'where r.id = :id ' +
           'order by r.id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger := id;
    Qry.Open;

    if Qry.RecordCount = 1 then
    begin
      Recebimento.Id                  := Qry.FieldByName('id').AsInteger;
      Recebimento.Tipo                := Qry.FieldByName('tipo').AsInteger;
      Recebimento.Descricao           := Qry.FieldByName('descricao').AsString;
      Recebimento.Data                := Qry.FieldByName('data').AsDateTime;
      Recebimento.HoraExtra           := Qry.FieldByName('hora_extra').AsFloat;
      Recebimento.HoraExtra           := Qry.FieldByName('hora_extra').AsFloat;
      Recebimento.IR                  := Qry.FieldByName('ir').AsFloat;
      Recebimento.INSS                := Qry.FieldByName('inss').AsFloat;
      Recebimento.ValorTotal          := Qry.FieldByName('valor_total').AsFloat;
      Recebimento.ValorBase           := Qry.FieldByName('valor_base').AsFloat;
      Recebimento.ValorDecimoTerceiro := Qry.FieldByName('valor_13salario').AsFloat;
      Recebimento.ValorFerias         := Qry.FieldByName('valor_ferias').AsFloat;
      Recebimento.Antecipacao         := Qry.FieldByName('antecipacao').AsFloat;
      Recebimento.DecimoTerceiro      := Qry.FieldByName('salario13').AsBoolean;
      Recebimento.Ferias              := Qry.FieldByName('ferias').AsBoolean;
      Recebimento.Cadastro            := Qry.FieldByName('cadastro').AsDateTime;
      Recebimento.Alteracao           := Qry.FieldByName('alteracao').AsDateTime;
      Recebimento.FormaPagamento.Id   := Qry.FieldByName('id_forma_pgto').AsInteger;
      if Qry.FieldByName('id_conta_bancaria').AsInteger > 0 then
        Recebimento.ContaBancaria.Id    := Qry.FieldByName('id_conta_bancaria').AsInteger
      else
        Recebimento.ContaBancaria.Id  := -1;
      Recebimento.Pagador.Id          := Qry.FieldByName('id_pagador').AsInteger;
      Recebimento.FormaPagamento.Nome := Qry.FieldByName('nome_forma_pgto').AsString;
      Recebimento.Pagador.Nome        := Qry.FieldByName('nome_pagador').AsString;
      Result := True;
    end
    else
    if Qry.RecordCount > 1 then
    begin
      Erro := 'Mais de um objeto foi retornado na busca por código!';
      Result := False;
    end
    else
    begin
      Erro := 'Nenhum objeto foi encontrado!';
      Result := False;
    end;

  finally
    Qry.Close;
  end;
end;

function TRecebimentoDAO.Inserir(Recebimento: TRecebimento; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'insert into recebimento (id, data, hora_extra, inss, ir, valor_total, ' +
           'valor_base, salario13, ferias, valor_13salario, valor_ferias, antecipacao, ' +
           'id_forma_pgto, id_conta_bancaria, id_pagador, id_dono_cadastro, id_usuario_cadastro, ' +
           'cadastro, tipo, descricao) values (:id, :data, :hora_extra, :inss, :ir, :valor_total, ' +
           ':valor_base, :salario13, :ferias, :valor_13salario, :valor_ferias, :antecipacao, ' +
           ':id_forma_pgto, :id_conta_bancaria, :id_pagador, :id_dono_cadastro, :id_usuario_cadastro, ' +
           ':cadastro, :tipo, :descricao)';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);

    if not AutoInc then
    begin
      Recebimento.Id := GerarId(SEQ_ID_Recebimento);
      Qry.ParamByName('id').AsInteger := Recebimento.Id;
    end;

    Qry.ParamByName('tipo').AsInteger             := Recebimento.Tipo;
    if Trim(Recebimento.Descricao) <> EmptyStr then
      Qry.ParamByName('descricao').AsString       := Recebimento.Descricao;
    Qry.ParamByName('data').AsDate                := Recebimento.Data;
    Qry.ParamByName('hora_extra').AsFloat         := Recebimento.HoraExtra;
    Qry.ParamByName('inss').AsFloat               := Recebimento.INSS;
    Qry.ParamByName('ir').AsFloat                 := Recebimento.IR;
    Qry.ParamByName('valor_total').AsFloat        := Recebimento.ValorTotal;
    Qry.ParamByName('valor_base').AsFloat         := Recebimento.ValorBase;
    Qry.ParamByName('valor_13salario').AsFloat    := Recebimento.ValorDecimoTerceiro;
    Qry.ParamByName('valor_ferias').AsFloat       := Recebimento.ValorFerias;
    Qry.ParamByName('antecipacao').AsFloat        := Recebimento.Antecipacao;
    Qry.ParamByName('salario13').AsBoolean        := Recebimento.DecimoTerceiro;
    Qry.ParamByName('ferias').AsBoolean           := Recebimento.Ferias;
    Qry.ParamByName('cadastro').AsDateTime        := Recebimento.Cadastro;
    Qry.ParamByName('id_forma_pgto').AsInteger    := Recebimento.FormaPagamento.Id;
    Qry.ParamByName('id_pagador').AsInteger       := Recebimento.Pagador.Id;
    Qry.ParamByName('id_usuario_cadastro').AsInteger := Recebimento.UsuarioCadastro.Id;
    Qry.ParamByName('id_dono_cadastro').AsInteger := Recebimento.DonoCadastro.Id;

    if Recebimento.ContaBancaria.Id > 0 then
      Qry.ParamByName('id_conta_bancaria').AsInteger := Recebimento.ContaBancaria.Id;

    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao inserir Recebimento: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TRecebimentoDAO.Editar(Recebimento: TRecebimento; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'update recebimento set data=:data, hora_extra=:hora_extra, inss=:inss, ' +
           'ir=:ir, valor_total=:valor_total, valor_base=:valor_base, salario13=:salario13, ' +
           'ferias=:ferias, valor_13salario=:valor_13salario, valor_ferias=:valor_ferias, ' +
           'antecipacao=:antecipacao, id_forma_pgto=:id_forma_pgto, ' +
           'id_conta_bancaria=:id_conta_bancaria, id_pagador=:id_pagador, ' +
           'alteracao=:alteracao, descricao=:descricao '+
           'where id = :id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger               := Recebimento.Id;
    if Trim(Recebimento.Descricao) <> EmptyStr then
      Qry.ParamByName('descricao').AsString       := Recebimento.Descricao;
    Qry.ParamByName('data').AsDate                := Recebimento.Data;
    Qry.ParamByName('hora_extra').AsFloat         := Recebimento.HoraExtra;
    Qry.ParamByName('inss').AsFloat               := Recebimento.INSS;
    Qry.ParamByName('ir').AsFloat                 := Recebimento.IR;
    Qry.ParamByName('valor_total').AsFloat        := Recebimento.ValorTotal;
    Qry.ParamByName('valor_base').AsFloat         := Recebimento.ValorBase;
    Qry.ParamByName('valor_13salario').AsFloat    := Recebimento.ValorDecimoTerceiro;
    Qry.ParamByName('valor_ferias').AsFloat       := Recebimento.ValorFerias;
    Qry.ParamByName('antecipacao').AsFloat        := Recebimento.Antecipacao;
    Qry.ParamByName('salario13').AsBoolean        := Recebimento.DecimoTerceiro;
    Qry.ParamByName('ferias').AsBoolean           := Recebimento.Ferias;
    Qry.ParamByName('alteracao').AsDateTime       := Recebimento.Alteracao;
    Qry.ParamByName('id_forma_pgto').AsInteger    := Recebimento.FormaPagamento.Id;
    Qry.ParamByName('id_pagador').AsInteger       := Recebimento.Pagador.Id;

    if Recebimento.ContaBancaria.Id > 0 then
      Qry.ParamByName('id_conta_bancaria').AsInteger := Recebimento.ContaBancaria.Id;

    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      dmConexao1.SQLTransaction.Rollback;
      Erro := 'Ocorreu um erro ao alterar Recebimento: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TRecebimentoDAO.Excluir(Id: Integer; out Erro: string): Boolean;
var
  sql: String;
begin
  try

    sql := 'delete from recebimento where id = :id';

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('id').AsInteger  := Id;
    Qry.ExecSQL;
    dmConexao1.SQLTransaction.Commit;

    Result := True;

  except on E: Exception do
    begin
      Erro := 'Ocorreu um erro ao excluir Recebimento: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

procedure TRecebimentoDAO.PesquisarContaBancaria(cbNome: TComboBox;
  lbId: TListBox; busca: String; Limitacao: Integer; out QtdRegistro: Integer);
var
  sql: String;
  CmdLimit: String;
begin
  try

    CmdLimit := '';

    if Driver = DRV_FIREBIRD then
    begin
      if Limitacao <> -1 then
        CmdLimit := 'first '+Limitacao.ToString;

      sql := 'select '+CmdLimit+' cb.id, cb.numero, cb.agencia, bnc.nome as nome_banco ' +
             'from conta_bancaria cb ' +
             'left join banco bnc on bnc.id = cb.id_banco '+
             'where UPPER(cb.numero) like :busca and cb.excluido = false and ' +
             'cb.id_dono_cadastro = :id_dono_cadastro '+
             'order by cb.numero';
    end
    else
    if Driver in [DRV_MARIADB, DRV_MYSQL, DRV_POSTGRESQL] then
    begin
      if Limitacao <> -1 then
        CmdLimit := 'limit '+Limitacao.ToString;

      sql := 'select cb.id, cb.numero, cb.agencia, bnc.nome as nome_banco ' +
             'from conta_bancaria cb ' +
             'left join banco bnc on bnc.id = cb.id_banco '+
             'where UPPER(cb.numero) like :busca and cb.excluido = false and ' +
             'cb.id_dono_cadastro = :id_dono_cadastro '+
             'order by cb.numero '+CmdLimit;
    end;

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(sql);
    Qry.ParamByName('busca').AsString := '%'+UpperCase(Busca)+'%';
    Qry.ParamByName('id_dono_cadastro').AsInteger := dmConexao1.DonoCadastro.Id;
    Qry.Open;

    Qry.First;

    QtdRegistro := Qry.RecordCount;

    cbNome.Items.Clear;
    cbNome.Height := 100;

    lbId.Items.Clear;

    while not Qry.EOF do
    begin
      lbId.Items.Add(Qry.FieldByName('id').AsString);
      cbNome.Items.Add('Nº. '+qry.FieldByName('numero').AsString+' Ag. '+
                       qry.FieldByName('agencia').AsString+' - '+
                       qry.FieldByName('nome_banco').AsString);
      Qry.Next;
    end;

  finally
    qry.Close;
  end;
end;

constructor TRecebimentoDAO.Create;
begin
  inherited;
end;

destructor TRecebimentoDAO.Destroy;
begin
  inherited Destroy;
end;

end.

