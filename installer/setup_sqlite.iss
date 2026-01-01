#define MyAppName "VrbDespesas"
#define MyAppVersion "0.5.1"
#define MyAppPublisher "Vinicius Ruan Brandalize"
#define MyAppExeName "vrbDespesas32.exe"

[Setup]
AppId={{02509966-C885-43D0-9CC2-904F18D2D81E}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName=C:\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=true
OutputDir=bin
OutputBaseFilename=vrbdespesas-setup-sqlite3-x86
Compression=lzma2/ultra64
SolidCompression=true
WizardStyle=modern
WizardSmallImageFile=img\logo_pequena.bmp
WizardImageFile=img\logo_grande.bmp
WizardImageBackColor=clWhite
VersionInfoVersion=0.5.1
VersionInfoCompany=vrb
VersionInfoDescription=vrbDespesas
VersionInfoTextVersion=0.5.1
VersionInfoCopyright=Copyright (c) 2025 Vinícius Ruan Brandalize
VersionInfoProductName=vrbDespesas
VersionInfoProductVersion=0.5.1
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
Source: ..\exe\SQLite3.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\exe\libcrypto-1_1.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\exe\libiconv-2.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\exe\libintl-8.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\exe\libssl-1_1.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\exe\libvrbbcrypt32.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\exe\libvrbcryptini32.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\LICENSE; DestDir: {app}; DestName: LICENSE.txt; Flags: ignoreversion
Source: ..\database\ARQUIVO_INSTALACAO.db3; DestDir: {app}\database; DestName: ARQUIVO.db3; Flags: ignoreversion
Source: ..\database\DESPESA_INSTALACAO.db3; DestDir: {app}\database; DestName: DESPESA.db3; Flags: ignoreversion
Source: ..\exe\reports\*.lrf; DestDir: {app}\reports; Flags: ignoreversion
Source: ..\exe\reports\*.png; DestDir: {app}\reports; Flags: ignoreversion
Source: ..\exe\resources\*.*; DestDir: {app}\resources; Flags: ignoreversion
Source: ..\license-cpts\*.*; DestDir: {app}\license-cpts; Flags: ignoreversion

[Icons]
Name: {group}\{#MyAppName}; Filename: {app}\{#MyAppExeName}
Name: {group}\{cm:UninstallProgram,{#MyAppName}}; Filename: {uninstallexe}
Name: {autodesktop}\{#MyAppName}; Filename: {app}\{#MyAppExeName}; Tasks: desktopicon

[Run]
Filename: {app}\AttIni32.exe; WorkingDir: {app}; StatusMsg: Criando arquivo de configuração de conexão...; Flags: runhidden; Parameters: """SQLite3"" ""127.0.0.1"" ""0"" ""{app}\database\DESPESA.db3"" """" """" ""SQLite3.dll"" ""SQLite3"" ""127.0.0.1"" ""0"" ""{app}\database\ARQUIVO.db3"" """" """" ""SQLite3.dll"""
Filename: {app}\{#MyAppExeName}; Description: {cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}; Flags: nowait postinstall skipifsilent

[Dirs]
Name: {app}\database
Name: {app}\reports
Name: {app}\resources
Name: {app}\license-cpts
Name: {app}\vrb_temp; Flags: deleteafterinstall
