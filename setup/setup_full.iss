; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define AppVersion GetFileVersion('..\bin\permis.exe')

[Setup]
AppName=秋风人事档案管理系统
AppVerName=秋风人事档案管理系统 v{#AppVersion}
AppPublisher=秋风软件工作室
AppPublisherURL=http://www.awindsoft.net
AppSupportURL=http://www.awindsoft.net
AppUpdatesURL=http://www.awindsoft.net
DefaultDirName={pf}\APermis
DefaultGroupName=秋风人事档案管理系统
LicenseFile=..\bin\license.txt
VersionInfoVersion={#AppVersion}
OutputDir=.
OutputBaseFilename=apermis_full
;SetupIconFile=..\ico\install.ico
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Messages]
english.BeveledLabel=秋风软件

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: checkablealone

[Files]
Source: "..\bin\permis.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\help.chm"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\AWData.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\pdata.mdb"; DestDir: "{app}"; Flags: ignoreversion onlyifdoesntexist
Source: "..\bin\bg.jpg"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\calendar.html"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\photos\*.*"; DestDir: "{app}\photos"; Flags: ignoreversion onlyifdoesntexist
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Dirs]
Name: "{app}"; Permissions: users-full
Name: "{app}\backup"; Permissions: users-full

[Icons]
Name: "{group}\秋风人事档案管理系统"; Filename: "{app}\permis.exe";
Name: "{group}\帮助"; Filename: "{app}\help.chm"
Name: "{group}\{cm:ProgramOnTheWeb,秋风软件}"; Filename: "http://www.awindsoft.net"
Name: "{group}\{cm:UninstallProgram,秋风人事档案管理系统}"; Filename: "{uninstallexe}"
Name: "{userdesktop}\秋风人事档案管理系统"; Filename: "{app}\permis.exe"; Tasks: desktopicon

;清除注册表项
[Registry]
Root: HKCU; Subkey: "Software\APermis"; Flags: uninsdeletekey

;卸载时删除程序运行期生成的文件
[UninstallDelete]
Type: files; Name: "{app}\config.ini"
Type: files; Name: "{app}\log.dat"
Type: filesandordirs; Name: "{app}\photos"
Type: filesandordirs; Name: "{app}\backup"

[Run]
Filename: "{app}\permis.exe"; Description: "{cm:LaunchProgram,秋风人事档案管理系统}"; Flags: nowait postinstall skipifsilent

[Code]

procedure CurStepChanged(CurStep: TSetupStep);
var
  ErrorCode: Integer;
begin
  if CurStep = ssPostInstall then
    ShellExec('', 'http://www.awindsoft.net/reg.asp?act=install&pid=1&ver=' + ExpandConstant('{#AppVersion}'), '', '', SW_SHOW, ewNoWait, ErrorCode);
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  //在Vista下以管理员身份运行
  if CurPageID = wpSelectDir then
  begin
    RegWriteStringValue(HKEY_CURRENT_USER, 'Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers',
      WizardDirValue() + '\permis.exe', 'RUNASADMIN');
  end;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  ErrorCode: Integer;
begin
  if CurUninstallStep = usPostUninstall then
  begin
    RegDeleteValue(HKEY_CURRENT_USER, 'Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers', ExpandConstant('{app}') + '\permis.exe');
    ShellExec('', 'http://www.awindsoft.net/reg.asp?act=uninstall&pid=1&ver=' + ExpandConstant('{#AppVersion}'), '', '', SW_SHOW, ewNoWait, ErrorCode);
  end;
end;
