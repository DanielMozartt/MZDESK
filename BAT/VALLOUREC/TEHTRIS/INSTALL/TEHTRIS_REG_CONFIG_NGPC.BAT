reg add "HKEY_LOCAL_MACHINE\SOFTWARE\TEHTRIS\TEHTRIS EPP Agent" /v PreferredGroup /d "PCNG_BRA" /t reg_sz /f

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\TEHTRIS\TEHTRIS EPP Agent" /v Server /d "valepp1.tehtris.net" /t reg_sz /f

reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\TEHTRIS\TEHTRIS EPP Agent" /v Uid /f
 
reg copy HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName "HKEY_LOCAL_MACHINE\SOFTWARE\TEHTRIS\TEHTRIS EPP Agent" /f

powershell.exe -ExecutionPolicy Bypass -File  "C:\TEHTRIS_INSTALL\RENAME_CHAVE_UID.ps1"

reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\TEHTRIS\TEHTRIS EPP Agent" /ve  /f

REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit" /v "LastKey" /d "HKEY_LOCAL_MACHINE\SOFTWARE\TEHTRIS\TEHTRIS EPP Agent" /f 

start "" regedit

start C:\TEHTRIS_INSTALL\INSTALL\TEHTRIS_EPP_1.2.3_Windows_x86_64.exe /exebasicui SERVER="valepp1.tehtris.net" CONFIG="PCNG_BRA"


exit
