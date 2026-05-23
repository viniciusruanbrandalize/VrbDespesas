#define MyAppName "VrbDespesas"
#define MyAppVersion "0.8.0"
#define MyAppPublisher "Vinicius Ruan Brandalize"
#define MyAppExeName "vrbDespesas32.exe"

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
OutputBaseFilename=vrbdespesas-setup-mariadb-x86
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
Source: ..\exe\libmysql.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\exe\libmariadb.dll; DestDir: {app}; Flags: ignoreversion
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
Source: ..\database\CREATE_MYSQL.SQL; DestDir: {app}\vrb_temp; Flags: deleteafterinstall ignoreversion
Source: ..\database\INSERT_MYSQL.SQL; DestDir: {app}\vrb_temp; Flags: deleteafterinstall ignoreversion
Source: bin_databases\mariadb\*.*; DestDir: {app}\mariadb
Source: bin_databases\mariadb\bin\*.*; DestDir: {app}\mariadb\bin; Flags: recursesubdirs
Source: bin_databases\mariadb\data\my.ini; DestDir: {app}\mariadb\data; Flags: onlyifdoesntexist
Source: bin_databases\mariadb\include\*.*; DestDir: {app}\mariadb\include; Flags: recursesubdirs
Source: bin_databases\mariadb\lib\*.*; DestDir: {app}\mariadb\lib; Flags: recursesubdirs
Source: bin_databases\mariadb\share\*.*; DestDir: {app}\mariadb\share; Flags: recursesubdirs

[Icons]
Name: {group}\{#MyAppName}; Filename: {app}\{#MyAppExeName}
Name: {group}\{cm:UninstallProgram,{#MyAppName}}; Filename: {uninstallexe}
Name: {autodesktop}\{#MyAppName}; Filename: {app}\{#MyAppExeName}; Tasks: desktopicon

[Run]
Filename: {app}\AttIni32.exe; WorkingDir: {app}; StatusMsg: Criando arquivo de configuração de conexão...; Flags: runhidden; Parameters: """MySQL 5.6"" ""127.0.0.1"" ""3388"" ""vrb_despesa"" ""root"" ""adm*3030"" ""libmysql.dll"" ""MySQL 5.6"" ""127.0.0.1"" ""3388"" ""vrb_despesa"" ""root"" ""adm*3030"" ""libmysql.dll"""
Filename: {app}\mariadb\bin\mariadb-install-db.exe; Parameters: "--datadir=""{app}\database"" --password=adm*3030"; WorkingDir: {app}\mariadb\bin; StatusMsg: Criando arquivos do MariaDB...; Flags: runhidden
Filename: {app}\mariadb\bin\mariadbd.exe; Parameters: "--install ""MariaDB_VRB"" --defaults-file=""{app}\mariadb\data\my.ini"""; StatusMsg: Instalando serviço do MariaDB...; WorkingDir: {app}\mariadb\bin; Flags: runhidden
Filename: {cmd}; Parameters: /c net start MariaDB_VRB; StatusMsg: Iniciando o serviço de banco de dados...; Flags: runhidden
Filename: {cmd}; Parameters: "/c mariadb -u root -padm*3030 -e ""CREATE DATABASE vrb_despesa CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"" && mariadb -u root -padm*3030 vrb_despesa < ""{app}\vrb_temp\CREATE_MYSQL.SQL"" && mariadb -u root -padm*3030 vrb_despesa < ""{app}\vrb_temp\INSERT_MYSQL.SQL"""; WorkingDir: {app}\mariadb\bin; StatusMsg: Criando base de dados...; Flags: runhidden
Filename: {app}\{#MyAppExeName}; Description: {cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}; Flags: nowait postinstall skipifsilent

[Dirs]
Name: {app}\mariadb
Name: {app}\database
Name: {app}\reports
Name: {app}\resources
Name: {app}\license-third-party
Name: {app}\vrb_temp; Flags: deleteafterinstall
Name: {app}\mariadb\bin
Name: {app}\mariadb\data
Name: {app}\mariadb\include
Name: {app}\mariadb\lib
Name: {app}\mariadb\share
[INI]
Filename: {app}\mariadb\data\my.ini; Section: mysqld; Key: datadir; String: {app}\database
Filename: {app}\mariadb\data\my.ini; Section: mysqld; Key: port; String: 3388
Filename: {app}\mariadb\data\my.ini; Section: mysqld; Key: innodb_buffer_pool_size; String: 1508M
Filename: {app}\mariadb\data\my.ini; Section: client; Key: port; String: 3388
Filename: {app}\mariadb\data\my.ini; Section: client; Key: plugin-dir; String: {app}\mariadb\lib\plugin
[UninstallRun]
Filename: {cmd}; Parameters: /c net stop MariaDB_VRB; Flags: runhidden
Filename: sc.exe; Parameters: delete MariaDB_VRB; Flags: runhidden; Tasks: ; Languages: 
