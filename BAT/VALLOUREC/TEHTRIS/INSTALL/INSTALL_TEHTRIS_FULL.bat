@echo off

:set

set /p numero=Digite o numero 1 para NGPC ou 2 para VLRSA:

if %numero% == 1 (echo NGPC
call c:\TEHTRIS_INSTALL\INSTALL\TEHTRIS_REG_CONFIG_NGPC.bat)

if %numero% == 2 (echo VLRSA
call c:\TEHTRIS_INSTALL\INSTALL\TEHTRIS_REG_CONFIG_VLRSA.bat)

goto set

:fim
exit
