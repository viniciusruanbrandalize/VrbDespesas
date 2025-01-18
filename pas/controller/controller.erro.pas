unit controller.erro;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, model.error.ini, lib.util, view.mensagem;

type

  { TErroController }

  TErroController = class
  private
    procedure gravarArquivoErro(ExNativo, ExTratado: String; Sender: TObject; Ex: Exception);
  public
    procedure TrataException(Sender: TObject; E: Exception);
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TErroController }

procedure TErroController.gravarArquivoErro(ExNativo, ExTratado: String;
  Sender: TObject; Ex: Exception);

  procedure PreencherComponente(Err: TErroINI; ExNativo, ExTratado: String;
      Sender: TObject; Ex: Exception);
    begin

      Err.Data := Now;
      Err.Hora := Now;
      Err.NomeComputador  := retornarPc();
      Err.IPComputador    := retornarIP();
      Err.Mensagem        := StringReplace(Ex.Message, #10, ' ', [rfReplaceAll]);
      Err.MensagemTratada := ExTratado;
      Err.FuncaoErro      := 'gravarArquivoErro(ExNativo, ExTratado: String; Sender: TObject; Ex: Exception)';
      Err.LinhaErro       := 274;

      if Assigned(Screen) and Assigned(Screen.ActiveForm) then
      begin
        Err.NomeFormAtivo    := Screen.ActiveForm.Name;
        Err.TituloFormAtivo  := Screen.ActiveForm.Caption;
        Err.UnidadeFormAtivo := Screen.ActiveForm.UnitName;
      end
      else
      begin
        if Assigned(Sender) then
        begin
          if Sender is TForm then
          begin
            Err.NomeFormAtivo    := (Sender as TForm).Name;
            Err.TituloFormAtivo  := (Sender as TForm).Caption;
            Err.UnidadeFormAtivo := (Sender as TForm).UnitName;
          end;
        end;
      end;

      if Assigned(Sender) then
      begin
        if Sender is TComponent then
        begin
          err.NomeObjAtivo    := (Sender as TComponent).Name;
          err.TituloObjAtivo  := (Sender as TComponent).Name;
          err.UnidadeObjAtivo := (Sender as TComponent).UnitName;
        end
        else
        begin
          err.NomeObjAtivo    := Sender.ClassName;
          err.TituloObjAtivo  := Sender.ClassName;
          err.UnidadeObjAtivo := Sender.UnitName;
        end;
      end;

      if Assigned(Ex) then
      begin
        Err.ClasseErro     := Ex.ClassName;
        Err.UnidadeErro    := Ex.UnitName;
      end;

      Err.VersaoExe := '1.0.0.0';
      Err.DataVersaoExe := StrToDate('12/12/2024');
      Err.DiretorioExe := ExtractFilePath(ParamStr(0));

      {$IFDEF MSWINDOWS}
        Err.SistemaOperacional := retornarInfoSistemaWindows;
      {$ELSE}
        Err.SistemaOperacional := 'NULL';
      {$ENDIF}

      {$IFDEF WIN32}
        Err.ArquiteturaExe := '32';
      {$ENDIF}
      {$IFDEF WIN64}
        Err.ArquiteturaExe := '64';
      {$ENDIF}
      {$IFDEF LINUX32}
        Err.ArquiteturaExe := '32';
      {$ENDIF}
      {$IFDEF LINUX64}
        Err.ArquiteturaExe := '64';
      {$ENDIF}

      {$IFOPT D+}
        Err.ModoExe       := 'DEBUG';
      {$ELSE}
        Err.ModoExe       := 'RELEASE';
      {$ENDIF}

      Err.TituloObjErro    := 'NULL';
      Err.NomeObjErro      := 'NULL';
      Err.UnidadeObjErro   := 'NULL';

    end;

var
  Erro: TErroINI;
begin
  Erro := TErroINI.Create;
  try
    PreencherComponente(Erro, ExNativo, ExTratado, Sender, Ex);
    Erro.Escrever;
  finally
    Erro.Free;
  end;
end;

procedure TErroController.TrataException(Sender: TObject; E: Exception);
var
  Texto,
  Texto2,
  ErroTratado: String;
begin

  if pos('violates foreign key', E.Message) <> 0 then
  begin
    ErroTratado := 'Violação de Chave Estrangeira!';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if pos('Access violation', E.Message) <> 0 then
  begin
    ErroTratado := 'Acesso Violado !'+#13+'Objeto requisitado não existe ou não foi criado.'+#13+'Contate o administrador do sistema!';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if pos('is not in an edit or insert state', E.Message) <> 0 then
  begin
    ErroTratado := 'Os dados não estão em edição ou inserção!';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if pos('is an invalid float', E.Message) <> 0 then
  begin
    Texto := Copy(e.Message, 2);
    Texto := '"'+Copy(Texto, 0, Pos('"', Texto));
    ErroTratado := 'Impossível converter '+Texto+' para valor numerico (Ponto Flutuante).';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if pos('is an invalid integer', E.Message) <> 0 then
  begin
    Texto := Copy(e.Message, 2);
    Texto := '"'+Copy(Texto, 0, Pos('"', Texto));
    ErroTratado := 'Impossível converter '+Texto+' para valor numerico (Inteiro). ';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if pos('is not a valid date format', E.Message) <> 0 then
  begin
    Texto := Copy(e.Message, 2);
    Texto := '"'+Copy(Texto, 0, Pos('"', Texto));
    ErroTratado := 'A data '+Texto+' está em um formato inválido! ';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if pos('is not a valid time', E.Message) <> 0 then
  begin
    Texto := Copy(e.Message, 2);
    Texto := '"'+Copy(Texto, 0, Pos('"', Texto));
    ErroTratado := 'A Hora '+Texto+' está inválida! ';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if pos('null value in column', E.Message) <> 0 then
  begin
    Texto := Copy(e.Message, pos('column "', E.Message), pos('" of', E.Message));
    Texto := Copy(Texto, 9);
    Texto := '"'+Copy(Texto, 0, pos('"', Texto));
    Texto := StringReplace(Texto, '_', '', [rfReplaceAll, rfIgnoreCase]);
    ErroTratado := 'O Campo '+Texto+' deve ser preenchido! ';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'C', [mbOk]);
  end
  else
  if pos('Field not found', E.Message) <> 0 then
  begin
    Texto := copy(e.Message, pos(': "', E.Message));
    Texto := Copy(texto, 3);
    ErroTratado := 'O Campo '+Texto+' não existe!';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if pos('Operation cannot be performed on an inactive dataset', E.Message) <> 0 then
  begin
    ErroTratado := 'A operação não pode ser executada em um conjunto de dados inativo!';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if pos('Cannot focus a disabled or invisible window', E.Message) <> 0 then
  begin
    ErroTratado := 'Não é possível focar em uma janela/componente desativado ou invisível';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if pos('List index (1) out of bounds', E.Message) <> 0 then
  begin
    ErroTratado := 'Falha ao tentar acessar um elemento inexistente na lista!';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if pos('List index (-1) out of bounds', E.Message) <> 0 then
  begin
    ErroTratado := 'Falha ao tentar acessar um elemento inexistente na lista!';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if pos('Invalid operation in AutoCommit mode', E.Message) <> 0 then
  begin
    ErroTratado := 'Operação inválida no modo AutoCommit!';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if pos('Invalid operation in non AutoCommit mode', E.Message) <> 0 then
  begin
    ErroTratado := 'Operação inválida em modo não AutoCommit!';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if pos('Operation aborted', E.Message) <> 0 then
  begin
    ErroTratado := 'Operação Abortada!';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if pos('deve ser preenchido!', E.Message) <> 0 then
  begin
    ErroTratado := E.Message;
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'C', [mbOk]);
  end
  else
  if pos('could not connect to server: Connection timed out', E.Message) <> 0 then
  begin
    ErroTratado := 'Não foi possível conectar ao servidor!';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if (pos('database', E.Message) <> 0) and (pos('does not exist', E.Message) <> 0) then
  begin
    ErroTratado := 'O Banco de dados informado não existe!';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if pos('password authentication failed for user', E.Message) <> 0 then
  begin
    ErroTratado := 'Falha de autenticação no banco de dados!'+#13+'Usuário/Senha incorreto!';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if pos('Unable to open file', E.Message) <> 0 then
  begin
    Texto := copy(e.Message, pos('"', E.Message), Length(e.Message)-1);
    ErroTratado := 'Impossível abrir o arquivo '+Texto;
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if pos('no connection to the server', E.Message) <> 0 then
  begin
    ErroTratado := 'Sem conexão com o servidor!';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if pos('server closed the connection unexpectedly', E.Message) <> 0 then
  begin
    ErroTratado := 'O Servidor fechou a conexão inesperadamente, ' +
                   'isso provavelmente significa que o servidor foi encerrado ' +
                   'de forma anormal antes ou durante o processamento da solicitação!';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if pos('File not open', E.Message) <> 0 then
  begin
    ErroTratado := 'O Arquivo não está aberto!';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if (pos('ERROR:  relation', E.Message) <> 0) and (pos('does not exist', E.Message) <> 0) then
  begin
    Texto := copy(e.Message, pos('relation "', E.Message));
    Texto := Copy(texto, 11);
    Texto := Copy(texto, 1, Pos('" does not exist', Texto)-1);
    ErroTratado := 'Relação "'+Texto+'" não existe!';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if pos('Error executing query: Lost connection to MySQL server during query', E.Message) <> 0 then
  Begin
    ErroTratado := 'Erro ao executar a consulta: conexão perdida com o servidor durante a consulta!';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if pos('Dataset is read-only', E.Message) <> 0 then
  begin
    ErroTratado := 'O conjunto de dados é somente leitura!';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if Pos('is required, but not supplied', E.Message) <> 0 then
  begin
    Texto := StringReplace(e.Message, ' : Field', '', [rfIgnoreCase]);
    Texto := Copy(Texto, 1, Pos('is', Texto)-1);
    ErroTratado := 'O Campo "'+Texto+'" deve ser preenchido! ';
    TfrmMessage.Mensagem(ErroTratado, 'Aviso', 'C', [mbOk]);
  end
  else
  if Pos('MySQL server has gone away', E.Message) <> 0 then
  begin
    ErroTratado := 'O Servidor MySQL foi desconectado por inatividade!';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if Pos('Server connect failed', E.Message) <> 0 then
  begin
    ErroTratado := 'Falha ao conectar com o servidor!';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if Pos('Failed to select database: Unknown database', E.Message) <> 0 then
  begin
    ErroTratado := 'O Banco de dados informado não existe!';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if Pos('Can not load MySQL library', E.Message) <> 0 then
  begin
    ErroTratado := 'Não é possível carregar a biblioteca do driver de conexão!'+#13+
                   'Verifique se há compatibilidade com o software x86/x64 e se o arquivo existe.';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if Pos('Database connect string (DatabaseName) not filled in', E.Message) <> 0 then
  begin
    ErroTratado := 'Nome do banco de dados está vazio!';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if Pos('can not work with the installed MySQL client version:', E.Message) <> 0 then
  begin
    Texto := E.Message;
    Texto := Copy(Texto, Pos('Expected', Texto), Texto.Length-1);
    Texto := Copy(Texto, 10, Texto.Length);
    Texto := StringReplace(Texto, ')', '', [rfReplaceAll]);
    Texto := StringReplace(Texto, '(', '', [rfReplaceAll]);
    Texto2 := Copy(Texto, Pos('got', Texto)+4, Texto.Length-2);
    Texto := Copy(Texto, 1, Pos(',', Texto)-1);

    ErroTratado := 'Não é possível conectar ao servidor com a biblioteca do ' +
                   'driver de conexão instalada!'+#13+
                   'Versão esperada: '+Texto+', versão instalada: '+Texto2;
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if Pos('Abstract method called', E.Message) <> 0 then
  begin
    ErroTratado := 'Chamada de Método abstrato não implementado na classe filha!';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  if Pos('LOST CONNECTION TO SERVER AT ', UpperCase(E.Message)) <> 0 then
  begin
    ErroTratado := 'Conexão perdida com o servidor!';
    TfrmMessage.Mensagem(ErroTratado, 'Erro', 'E', [mbOk]);
  end
  else
  begin
    ErroTratado := 'Erro Desconhecido!';
    TfrmMessage.Mensagem('Erro Desconhecido: '+e.Message, 'Erro', 'E', [mbOk]);
  end;

  gravarArquivoErro(E.Message, ErroTratado, Sender, E);

end;

constructor TErroController.Create;
begin
  //
end;

destructor TErroController.Destroy;
begin
  inherited Destroy;
end;

end.

