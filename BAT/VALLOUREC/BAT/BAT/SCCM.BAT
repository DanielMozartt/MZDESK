@echo off
set /p numero=Digite o numero 1 para INSTALAR SCCM ou 2 para DESINSTALAR SCCM:
if %numero% == 1 (goto INSTALL)
if %numero% == 2 (goto UNINSTALL)



:INSTALL
echo INSTALL
call \\BBWD8031\X\SCCM2019\SCCM_INSTALL.BAT
T /15
goto fim


:UNINSTALL
echo UNINSTALL
call \\BBWD8031\X\SCCM2019\SCCM_UNINSTALL.BAT
goto fim


:fim
EXIT


