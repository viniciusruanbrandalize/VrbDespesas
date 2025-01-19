program projectVrbDespesas;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, view.principal, view.mensagem, controller.banco, controller.principal,
  controller.erro, model.entity.banco, model.entity.compra,
  model.entity.confbackup, model.entity.configuracao, model.entity.devedor,
  model.entity.formapagamento, model.entity.login, model.entity.loja,
  model.entity.recebimento, model.entity.usuario, model.entity.subtipodespesa,
  model.entity.tipodespesa, model.entity.participante, model.entity.pais,
  model.entity.estado, model.entity.cidade, model.entity.fornecedor,
  model.entity.donocadastro, model.entity.contabancaria, model.entity.bandeira,
  model.entity.usuariodonocadastro, model.entity.pix, model.connection.ini,
  model.connection.conexao1, model.connection.conexao2, model.dao.banco,
  model.error.ini, lib.cryptini, lib.util, lib.types, indylaz,
  view.cadastropadrao, view.banco, lib.bcrypt, view.formapagamento,
  view.tipodespesa, model.dao.formapagamento, controller.formapagamento,
  controller.tipodespesa, model.dao.tipodespesa;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TdmConexao1, dmConexao1);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.

