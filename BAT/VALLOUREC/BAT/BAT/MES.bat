@echo off

md c:\MES_INSTALL
copy \\BBWD8031\X\PROGRAMAS\MES\INSTALL c:\MES_INSTALL

:set

set /p numero=Digite o numero 1 para MES BARREIRO ou 2 para MES JECEABA:

if %numero% == 1 (echo BARREIRO
goto barreiro
)

if %numero% == 2 (echo JECEABA
goto jeceaba)

goto set

:barreiro
set /p numerob=Digite o numero 1 para X64 ou 2 para X32:
if %numerob% == 1 (echo BARREIRO X64
copy "\\BBWD8031\X\PROGRAMAS\MES\Barreiro\AtalhoMESx64\NOVO MES Barreiro - PRD.url" "C:\Users\Public\Desktop"
copy "\\BBWD8031\X\PROGRAMAS\MES\Barreiro\AtalhoMESx64\icone-NOZ.ico" "C:\Users\Public\Desktop"
attrib +h %userprofile%\Desktop\icone-NOZ.ico
start c:\MES_INSTALL\MES_X64.vbs
)

if %numerob% == 2 (echo BARREIRO X32
copy "\\BBWD8031\X\PROGRAMAS\MES\Barreiro\AtalhoMESx86\NOVO MES Barreiro - PRD.url" "C:\Users\Public\Desktop"
copy "\\BBWD8031\X\PROGRAMAS\MES\Barreiro\AtalhoMESx86\icone-NOZ.ico" "C:\Users\Public\Desktop"
attrib +h %userprofile%\Desktop\icone-NOZ.ico
start c:\MES_INSTALL\MES_X86.vbs
)

goto fim

:jeceaba

set /p numeroc=Digite o numero 1 para X64 ou 2 para X32:
if %numeroc% == 1 (echo JECEABA X64
copy "\\BBWD8031\X\PROGRAMAS\MES\Jeceaba\AtalhoMESx64\NOVO MES Jeceaba - PRD.url" "C:\Users\Public\Desktop"
copy "\\BBWD8031\X\PROGRAMAS\MES\Jeceaba\AtalhoMESx64\icone-NOZ.ico" "C:\Users\Public\Desktop"
attrib +h %userprofile%\Desktop\icone-NOZ.ico
start c:\MES_INSTALL\MES_X64.vbs
)

if %numeroc% == 2 (echo JECEABA X32
copy "\\BBWD8031\X\PROGRAMAS\MES\Jeceaba\AtalhoMESx86\NOVO MES Jeceaba - PRD.url" "%userprofile%\Desktop"
copy "\\BBWD8031\X\PROGRAMAS\MES\Jeceaba\AtalhoMESx86\icone-NOZ.ico" "%userprofile%\Desktop"
attrib +h %userprofile%\Desktop\icone-NOZ.ico
start c:\MES_INSTALL\MES_X86.vbs
)

goto fim

:fim

pause