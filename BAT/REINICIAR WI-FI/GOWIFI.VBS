Dim objShell

Set objShell = CreateObject("WScript.Shell")

strCMD = "powershell -sta -noProfile -NonInteractive -nologo -command " & Chr(34) & "C:\Users\danie\Desktop\WIFION-OFF.bat" & Chr(34)

objShell.Run strCMD,0

