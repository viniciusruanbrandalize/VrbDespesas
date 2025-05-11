unit lib.util;

{$mode ObjFPC}{$H+}

interface

uses
  {$IFDEF MSWINDOWS}
  System.NetEncoding, Windows,
  {$ENDIF}
  {$IFDEF LINUX}
  IdStackUnix,
  {$ENDIF}
  Classes, SysUtils, md5, Sha1, TypInfo, Forms, controls,
  ExtCtrls;

  {$IFDEF MSWINDOWS}
  function retornarInfoSistemaWindows: String;
  {$ENDIF}

  function retornarIP(): String;
  function retornarPc(): String;
  function encryptMD5(const texto:string):string;
  function encryptSha1(const texto: string): string;
  function TamanhoArquivoEhValido(DirArquivo: String; TamanhoLimite: Integer): Boolean;
  procedure CriarForm(Formulario: TForm; ClasseForm: TFormClass; Modal: Boolean=True;
                       AParent: TWinControl=nil; FormularioPai: TForm=nil); overload;
  procedure CriarForm(Formulario: TForm; ClasseForm: TFormClass;
                       FormularioPai: TForm; out mr: TModalResult); overload;

implementation

function retornarIP: String;
{var
  IP: TIdIPWatch; }
begin
  {IP := TIdIPWatch.Create;
  try
    Result := IP.LocalIP;
  finally
    IP.Free;
  end;}
  Result := '127.0.0.1';
end;

function retornarPc: String;
{var
  {$IFDEF MSWINDOWS}
  IdStack : TIdStackWindows;
  {$ENDIF}
  {$IFDEF LINUX}
  IdStack : TIdStackUnix;
  {$ENDIF}}
begin
  {{$IFDEF MSWINDOWS}
  IdStack := TIdStackWindows.Create;
  {$ENDIF}
  {$IFDEF LINUX}
  IdStack := TIdStackUnix.Create;
  {$ENDIF}
  try
    Result := IdStack.HostName;
  finally
    IdStack.Free;
  end;}
  result := 'LOCALHOST';
end;

{$IFDEF MSWINDOWS}
function retornarInfoSistemaWindows: String;
var
  OSVersionInfo: TOSVersionInfo;
begin
  OSVersionInfo.dwOSVersionInfoSize := SizeOf(OSVersionInfo);
  if GetVersionEx(OSVersionInfo) then
    Result := Format('Windows %d.%d (Build %d)',
      [OSVersionInfo.dwMajorVersion, OSVersionInfo.dwMinorVersion,
      OSVersionInfo.dwBuildNumber])
  else
    Result := 'NULL';
end;
{$ENDIF}

function encryptMD5(const texto: string): string;
begin
  result := MD5Print(MD5String(texto));
end;

function encryptSha1(const texto: string): string;
var
  hashTexto : TSHA1Digest;
begin
   hashTexto := Sha1String(texto);
   Result := SHA1Print(hashTexto);
end;

function TamanhoArquivoEhValido(DirArquivo: String;
  TamanhoLimite: Integer): Boolean;
var
  arqStream : TMemoryStream;
begin
  try
    arqStream := TMemoryStream.Create;
    arqStream.LoadFromFile(DirArquivo);
    Result := (arqStream.Size <= TamanhoLimite);
  finally
    arqStream.Free;
  end;
end;

procedure CriarForm(Formulario: TForm; ClasseForm: TFormClass; Modal: Boolean;
  AParent: TWinControl; FormularioPai: TForm);
begin

  Formulario := ClasseForm.Create(FormularioPai);

  if Modal then
  begin
    Formulario.ShowModal;
    FreeAndNil(Formulario);
  end
  else
  begin
    if AParent <> nil then
    begin
      Formulario.Parent := AParent;
      Formulario.Align  := alClient;
    end;
    Formulario.Show;
  end;

end;

procedure CriarForm(Formulario: TForm; ClasseForm: TFormClass;
  FormularioPai: TForm; out mr: TModalResult);
begin
  Formulario := ClasseForm.Create(FormularioPai);
  try
    Mr := Formulario.ShowModal;
  finally
    FreeAndNil(Formulario);
  end;
end;

end.
