#define MyAppName "VrbDespesas"
#define MyAppVersion "0.8.0"
#define MyAppPublisher "Vinicius Ruan Brandalize"
#define MyAppExeName "vrbDespesas32.exe"
#define ServDB "127.0.0.1"
#define PortDB "5418"
#define NameDB "vrb_despesa"
#define UserDB "pgvrb"
#define PassDB "adm*3030"
#define ServiceDB "postgresql-x64-18-vrb"

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
OutputBaseFilename=vrbdespesas-setup-pgsql-x86
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
Source: ..\exe\libpq.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\exe\pgenlist.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\exe\pgenlista.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\exe\pgxalib.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\exe\psqlodbc30a.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\exe\psqlodbc35w.dll; DestDir: {app}; Flags: ignoreversion
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
Source: ..\exe\reports\*.lrf; DestDir: {app}\reports; Flags: ignoreversion
Source: ..\exe\reports\*.png; DestDir: {app}\reports; Flags: ignoreversion
Source: ..\exe\resources\*.*; DestDir: {app}\resources; Flags: ignoreversion
Source: ..\license-third-party\*.*; DestDir: {app}\license-third-party; Flags: ignoreversion
Source: ..\exe\reports\*.lrf; DestDir: {app}\reports; Flags: ignoreversion
Source: ..\database\CREATE_POSTGRESQL.SQL; DestDir: {app}\vrb_temp; Flags: deleteafterinstall ignoreversion
Source: ..\database\INSERT_POSTGRESQL.SQL; DestDir: {app}\vrb_temp; Flags: deleteafterinstall ignoreversion; Tasks: ; Languages: 
Source: pw_file.txt; DestDir: {app}\vrb_temp; Flags: deleteafterinstall ignoreversion
Source: bin_databases\pgsql\*.*; DestDir: {app}\pgsql; Components: instalacao_pgsql
Source: bin_databases\pgsql\bin\*.*; DestDir: {app}\pgsql\bin; Flags: recursesubdirs; Components: instalacao_pgsql
Source: bin_databases\pgsql\include\*.*; DestDir: {app}\pgsql\include; Flags: recursesubdirs; Components: instalacao_pgsql
Source: bin_databases\pgsql\lib\*.*; DestDir: {app}\pgsql\lib; Flags: recursesubdirs; Components: instalacao_pgsql
Source: bin_databases\pgsql\share\*.*; DestDir: {app}\pgsql\share; Flags: recursesubdirs; Components: instalacao_pgsql

[Icons]
Name: {group}\{#MyAppName}; Filename: {app}\{#MyAppExeName}
Name: {group}\{cm:UninstallProgram,{#MyAppName}}; Filename: {uninstallexe}
Name: {autodesktop}\{#MyAppName}; Filename: {app}\{#MyAppExeName}; Tasks: desktopicon

[Run]
Filename: {app}\AttIni32.exe; WorkingDir: {app}; StatusMsg: Criando arquivo de configuração de conexão...; Flags: runhidden; Parameters: """PostgreSQL"" ""{#ServDB}"" ""{#PortDB}"" ""{#NameDB}"" ""{#UserDB}"" ""{#PassDB}"" ""libpq.dll"" ""PostgreSQL"" ""{#ServDB}"" ""{#PortDB}"" ""{#NameDB}"" ""{#UserDB}"" ""{#PassDB}"" ""libpq.dll"""
Filename: {cmd}; Parameters: "/c echo ""{#PassDB}"" > pw_file.txt"; StatusMsg: Criando arquivo pw_file...; Flags: runhidden; Components: instalacao_pgsql; WorkingDir: {app}\vrb_temp
Filename: {app}\pgsql\bin\initdb.exe; Parameters: "-D ""{app}\database"" -U ""{#UserDB}"" -E UTF8 --no-locale --pwfile=""{app}\vrb_temp\pw_file.txt"""; WorkingDir: {app}\pgsql\bin; StatusMsg: Criando arquivos do PostgreSQL...; Flags: runhidden; Components: instalacao_pgsql
Filename: {sys}\WindowsPowerShell\v1.0\powershell.exe; Parameters: "-NoProfile -ExecutionPolicy Bypass -Command ""(Get-Content ""{app}\database\postgresql.conf"") | ForEach-Object {{ $_ -replace '^\s*#?\s*port\s*=\s*5432\b.*$', 'port=""{#PortDB}""' } | Set-Content ""{app}\database\postgresql.conf"""""; StatusMsg: Alterando a porta do banco de dados...; WorkingDir: {sys}\WindowsPowerShell\v1.0; Flags: runhidden; Components: instalacao_pgsql
Filename: {app}\pgsql\bin\pg_ctl.exe; Parameters: "register -N ""{#ServiceDB}"" -D ""{app}\database"""; StatusMsg: Instalando serviço do PostgreSQL...; WorkingDir: {app}\pgsql\bin; Flags: runhidden; Components: instalacao_pgsql
Filename: {cmd}; Parameters: /c net start {#ServiceDB}; StatusMsg: Iniciando o serviço de banco de dados...; Flags: runhidden; Components: instalacao_pgsql
Filename: {cmd}; Parameters: "/c set PGPASSWORD=""{#PassDB}""&& createdb -U ""{#UserDB}"" -h ""{#ServDB}"" -p ""{#PortDB}"" -E UTF8 ""{#NameDB}"" && psql -h ""{#ServDB}"" -p ""{#PortDB}"" -U ""{#UserDB}"" -d ""{#NameDB}"" -E ""SET client_encoding = ""UTF8"";"" -f ""{app}\vrb_temp\CREATE_POSTGRESQL.SQL"" -f ""{app}\vrb_temp\INSERT_POSTGRESQL.SQL"""; StatusMsg: Criando base de dados...; Flags: runhidden; WorkingDir: {app}\pgsql\bin; Components: instalacao_pgsql
Filename: {app}\{#MyAppExeName}; Description: {cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}; Flags: nowait postinstall skipifsilent

[Dirs]
Name: {app}\pgsql; Components: instalacao_pgsql
Name: {app}\database
Name: {app}\reports
Name: {app}\resources
Name: {app}\license-third-party
Name: {app}\vrb_temp; Flags: deleteafterinstall
Name: {app}\pgsql\bin; Components: instalacao_pgsql
Name: {app}\pgsql\doc; Components: instalacao_pgsql
Name: {app}\pgsql\include; Components: instalacao_pgsql
Name: {app}\pgsql\lib; Components: instalacao_pgsql
Name: {app}\pgsql\share; Components: instalacao_pgsql
Name: {app}\pgsql\StackBuilder
[UninstallRun]
Filename: {cmd}; Parameters: "/c net stop ""{#ServiceDB}"""; Flags: runhidden; Components: instalacao_pgsql
Filename: sc.exe; Parameters: "delete ""{#ServiceDB}"""; Flags: runhidden; Tasks: ; Languages: ; Components: instalacao_pgsql
[Components]
Name: instalacao_pgsql; Description: Servidor PostgreSQL; Languages: ; Types: full
