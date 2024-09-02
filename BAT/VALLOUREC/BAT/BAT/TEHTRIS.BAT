md C:\TEHTRIS_INSTALL
md C:\TEHTRIS_INSTALL\INSTALL

copy \\bbwd8031\X\TEHTRIS C:\TEHTRIS_INSTALL
copy \\bbwd8031\X\TEHTRIS\INSTALL C:\TEHTRIS_INSTALL\INSTALL

cls

echo Arquivos Copiados para C:\TEHTRIS_INSTALL

:set

set /p numero=Digite o numero 1 para INSTALAR TEHTRIS ou 2 para DESINSTALAR TEHTRIS:

if %numero% == 1 (echo INSTALL 
start c:\TEHTRIS_INSTALL\INSTALL\INSTALL_TEHTRIS_FULL.vbs 
goto fim)

if %numero% == 2 (echo UNINSTALL 
start /b c:\TEHTRIS_INSTALL\RMV_TEMP_LOCALAPPDATA.BAT
start /b c:\TEHTRIS_INSTALL\UNNINSTALL_TEHTRIS_FULL.vbs
goto fim)

goto set

:fim
exit