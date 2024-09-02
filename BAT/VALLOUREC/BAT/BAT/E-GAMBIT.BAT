@echo off

md C:\E-GAMBIT

copy \\bbwd8031\X\E-GAMBIT C:\E-GAMBIT

cd C:\E-GAMBIT

msiexec.exe /i C:\e-gambit\eGambit_1.6.28.msi SERVER="10.4.1.32, valapp2.egambit.net"
ALLUSERS="1"
proxy = 
TAG="VAL_SA_BB"
protection = False
debug_mode = 0

pause
