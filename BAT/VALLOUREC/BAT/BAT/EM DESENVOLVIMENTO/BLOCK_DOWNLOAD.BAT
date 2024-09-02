cd %localappdata%\microsoft

taskkill /f /im msedge.exe 

taskkill /f Teams.exe

taskkill /f OneDrive.exe

rmdir /S /Q Edge

del /q /f /s "C:\Windows\System32\GroupPolicy"

:start

set /a var+=1
if %var% EQU 3 goto end

gpupdate /force

goto start

:end

md "%programFiles%\Microsoft Workplace Join\"
md "C:\Program Files\Microsoft Workplace Join\"


copy "\\bbwd8001\Publico\POLITICA DE DOWNLOAD OUTLOOK\Workplace_x64\Microsoft Workplace Join" "%programFiles%\Microsoft Workplace Join\"

copy "\\bbwd8001\Publico\POLITICA DE DOWNLOAD OUTLOOK\Workplace_x64\Microsoft Workplace Join" "C:\Program Files\Microsoft Workplace Join\"

cd %programFiles%\Microsoft Workplace Join\


"%programFiles%\Microsoft Workplace Join\autoworkplace.exe" /i

:start2

set /a var+=1
if %var% EQU 5 goto end2

"%programFiles%\Microsoft Workplace Join\autoworkplace.exe" /i

goto start

:end2

pause




