md C:\Office365
 
xcopy /h /r /e "\\bbwd8031\X\OFFICE\OFFICE_365\ZIP" "C:\Office365"

cd C:\Office365

powershell expand-archive C:\Office365\Office365ProPlus_x86.zip C:\Office365\Office365

CD C:\Office365\Office365\Office365Pro+_x86

setup.exe /configure configuration-Office365-x64.xml

CD C:\Office365

setuplanguagepack.x64.pt-br.exe

pause