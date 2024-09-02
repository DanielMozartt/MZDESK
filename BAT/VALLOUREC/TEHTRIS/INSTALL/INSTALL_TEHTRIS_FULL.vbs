Set UAC = CreateObject("Shell.Application") 
args = "ELEV " 
For Each strArg in WScript.Arguments 
args = args & strArg & " "  
Next 
UAC.ShellExecute "C:\TEHTRIS_INSTALL\INSTALL\INSTALL_TEHTRIS_FULL.bat", args, "", "runas", 1 