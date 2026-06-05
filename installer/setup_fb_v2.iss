#define MyAppName "VrbDespesas"
#define MyAppVersion "0.8.0"
#define MyAppPublisher "Vinicius Ruan Brandalize"
#define MyAppExeName "vrbDespesas32.exe"
#define ServDB "127.0.0.1"
#define PortDB "3051"
#define NameDB "DESPESA.FDB"
#define Name2DB "ARQUIVO.FDB"
#define UserDB "SYSDBA"
#define PassDB "masterkey"
#define ServiceDB "FirebirdServer50-vrb"

[Setup]
AppId={{89ED3917-5FEA-48D5-B828-9A4549AD94C6}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName=C:\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=true
OutputDir=bin
OutputBaseFilename=vrbdespesas-setup-fb-v2-x86
Compression=lzma2/ultra64
SolidCompression=true
WizardStyle=modern
WizardSmallImageFile=img\logo_pequena.bmp
WizardImageFile=img\logo_grande.bmp
WizardImageBackColor=clWhite
VersionInfoVersion=0.8.0
VersionInfoCompany=vrb
VersionInfoDescription=vrbDespesas
VersionInfoTextVersion=0.8.0
VersionInfoCopyright=Copyright (c) 2026 Vinícius Ruan Brandalize
VersionInfoProductName=vrbDespesas
VersionInfoProductVersion=0.8.0
LicenseFile=..\LICENSE
DisableWelcomePage=no
ShowLanguageDialog=no
LanguageDetectionMethod=uilanguage

[Languages]
Name: english; MessagesFile: compiler:Default.isl
Name: brazilianportuguese; MessagesFile: compiler:Languages\BrazilianPortuguese.isl

[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked

[Files]
Source: ..\exe\{#MyAppExeName}; DestDir: {app}; Flags: ignoreversion
Source: ..\exe\Configurador32.exe; DestDir: {app}; Flags: ignoreversion
Source: ..\exe\AttIni32.exe; DestDir: {app}; Flags: ignoreversion
Source: ..\exe\fbclient.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\exe\libcrypto-1_1.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\exe\libiconv-2.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\exe\libintl-8.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\exe\libssl-1_1.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\exe\libvrbbcrypt32.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\exe\libvrbcryptini32.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\exe\libexslt.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\exe\libiconv.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\exe\libxml2.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\exe\libxslt.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\LICENSE; DestDir: {app}; DestName: LICENSE.txt; Flags: ignoreversion
Source: ..\database\DESPESA_INSTALACAO.FDB; DestDir: {app}\database; Flags: uninsneveruninstall; DestName: DESPESA.FDB
Source: ..\database\ARQUIVO_INSTALACAO.FDB; DestDir: {app}\database; Flags: uninsneveruninstall; DestName: ARQUIVO.FDB
Source: ..\exe\reports\*.lrf; DestDir: {app}\reports; Flags: ignoreversion
Source: ..\exe\reports\*.png; DestDir: {app}\reports; Flags: ignoreversion
Source: ..\exe\resources\*.*; DestDir: {app}\resources; Flags: ignoreversion
Source: ..\license-third-party\*.*; DestDir: {app}\license-third-party; Flags: ignoreversion
Source: ..\exe\reports\*.lrf; DestDir: {app}\reports; Flags: ignoreversion
Source: ..\database\CREATE_FIREBIRD.SQL; DestDir: {app}\vrb_temp; Flags: deleteafterinstall ignoreversion
Source: ..\database\INSERT_FIREBIRD.SQL; DestDir: {app}\vrb_temp; Flags: deleteafterinstall ignoreversion; Tasks: ; Languages: 
Source: bin_databases\fb\*.*; DestDir: {app}\fb; Components: instalacao_fb
Source: bin_databases\fb\doc\*.*; DestDir: {app}\fb\doc; Flags: recursesubdirs; Components: instalacao_fb
Source: bin_databases\fb\include\*.*; DestDir: {app}\fb\include; Flags: recursesubdirs; Components: instalacao_fb
Source: bin_databases\fb\intl\*.*; DestDir: {app}\fb\intl; Flags: recursesubdirs; Components: instalacao_fb
Source: bin_databases\fb\lib\*.*; DestDir: {app}\fb\lib; Flags: recursesubdirs; Components: instalacao_fb
Source: bin_databases\fb\misc\*.*; DestDir: {app}\fb\misc; Flags: recursesubdirs; Components: instalacao_fb
Source: bin_databases\fb\plugins\*.*; DestDir: {app}\fb\plugins; Flags: recursesubdirs; Components: instalacao_fb
Source: bin_databases\fb\system32\*.*; DestDir: {app}\fb\system32; Flags: recursesubdirs; Components: instalacao_fb
Source: bin_databases\fb\tzdata\*.*; DestDir: {app}\fb\tzdata; Flags: recursesubdirs; Components: instalacao_fb

[Icons]
Name: {group}\{#MyAppName}; Filename: {app}\{#MyAppExeName}
Name: {group}\{cm:UninstallProgram,{#MyAppName}}; Filename: {uninstallexe}
Name: {autodesktop}\{#MyAppName}; Filename: {app}\{#MyAppExeName}; Tasks: desktopicon

[Run]
Filename: {app}\AttIni32.exe; WorkingDir: {app}; StatusMsg: Criando arquivo de configuração de conexão...; Flags: runhidden; Parameters: """Firebird"" ""{#ServDB}"" ""{#PortDB}"" ""{app}\database\{#NameDB}"" ""{#UserDB}"" ""{#PassDB}"" ""fbclient.dll"" ""Firebird"" ""{#ServDB}"" ""{#PortDB}"" ""{app}\database\{#Name2DB}"" ""{#UserDB}"" ""{#PassDB}"" ""fbclient.dll"""
Filename: {sys}\WindowsPowerShell\v1.0\powershell.exe; Parameters: "-NoProfile -ExecutionPolicy Bypass -Command ""(Get-Content ""{app}\fb\firebird.conf"") | ForEach-Object {{ $_ -replace '^\s*#?\s*RemoteServicePort\s*=\s*3050\b.*$', 'RemoteServicePort=""{#PortDB}""' } | Set-Content ""{app}\fb\firebird.conf"""""; WorkingDir: {sys}\WindowsPowerShell\v1.0; StatusMsg: Alterando a porta do banco de dados...; Flags: runhidden; Components: instalacao_fb
Filename: {app}\fb\instsvc.exe; Parameters: "install -auto -name ""{#ServiceDB}"""; WorkingDir: {app}\fb; Flags: runhidden; Components: instalacao_fb; Tasks: ; StatusMsg: Instalando serviço do Firebird...
Filename: {app}\fb\instsvc.exe; Parameters: "start -name ""{#ServiceDB}"""; WorkingDir: {app}\fb; Components: instalacao_fb; Flags: runhidden; Tasks: ; Languages: ; StatusMsg: Iniciando o serviço de banco de dados...
Filename: {app}\{#MyAppExeName}; Description: {cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}; Flags: nowait postinstall skipifsilent

[Dirs]
Name: {app}\fb; Components: instalacao_fb
Name: {app}\database
Name: {app}\reports
Name: {app}\resources
Name: {app}\license-third-party
Name: {app}\vrb_temp; Flags: deleteafterinstall
Name: {app}\fb\doc; Tasks: ; Languages: ; Components: instalacao_fb
Name: {app}\fb\examples; Components: instalacao_fb
Name: {app}\fb\include; Components: instalacao_fb
Name: {app}\fb\intl; Components: instalacao_fb
Name: {app}\fb\lib; Components: instalacao_fb
Name: {app}\fb\misc; Components: instalacao_fb
Name: {app}\fb\plugins; Components: instalacao_fb
Name: {app}\fb\system32; Components: instalacao_fb
Name: {app}\fb\tzdata; Components: instalacao_fb
[UninstallRun]
Filename: {cmd}; Parameters: "/c net stop ""{#ServiceDB}"""; Flags: runhidden; Components: instalacao_fb
Filename: sc.exe; Parameters: "delete ""{#ServiceDB}"""; Flags: runhidden; Tasks: ; Languages: ; Components: instalacao_fb
[Components]
Name: instalacao_fb; Description: Servidor Firebird; Languages: ; Types: full
