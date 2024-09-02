@echo off

:set

set /p numero=Digite o numero 1 para NGPC ou 2 para VLRSA:
if %numero% == 1 (echo NGPC
start /b c:\TEHTRIS_INSTALL\RMV_WIN_TEMP.BAT
start /b c:\TEHTRIS_INSTALL\TEHTRIS_REG_CONFIG_NGPC.bat
goto fim)

if %numero% == 2 (echo VLRSA
start /b c:\TEHTRIS_INSTALL\RMV_WIN_TEMP.BAT
start /b c:\TEHTRIS_INSTALL\TEHTRIS_REG_CONFIG_VLRSA.bat
goto fim)

goto set

:fim
exit
