start \\BBWD8031\X\BAT\GPUPDATE.BAT

start \\BBWD8031\X\BAT\LUSRMGR.bat

md C:\NGPC

md C:\SAP

md C:\dms

XCOPY /h /r /e \\bk10450\PenDrive2\Prog_NGPC C:\NGPC

XCOPY /h /r /e C:\NGPC\SAP C:\SAP

XCOPY /h /r /e C:\NGPC\dms C:\dms

COPY C:\NGPC\NGPC.LNK %USERPROFILE%\DESKTOP



pause

pause

pause



CD C:\NGPC

start Ativador_Win_11.bat

start AcroRdrDC1900820071_pt_BR.exe /sAll

start system_update_5.07.0136.exe

CD C:\NGPC\Office_2010_Standard_x64

start Setup.exe /adminfile MSP.MSP

CD C:\NGPC

start DWGTrueView_2022_English_64bit_dlm.sfx

start setupAll.lnk

start gui770_03_1-70004692.exe

start SCRLTESP76000_0-80004481.exe

start TeamViewer_15.8.3.exe


PAUSE