# Necessário antes intalar o Windows ADK:

# Winget Install Microsoft.WindowsADK

# $WINDOWS_ISO_FOLDER = Onde a pasta com a ISO extraída e ou modificada se encontra. EXEMPLO: C:\WINDOWSISO
# $WINDOWS_ISO_FILE_OUT = Onde será salva a ISO . EXEMPLO: C:\WINDOWS_ISO_OUT

$WINDOWS_ISO_FOLDER = 'D:'
$WINDOWS_ISO_FILE_OUT = 'C:\WINDOWS_ISO_OUT'
$OSCDIMG = 'C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg\oscdimg.exe'

[System.IO.Directory]::CreateDirectory($WINDOWS_ISO_FILE_OUT)

# Path to the Extracted or Mounted Windows ISO 
$ISOMediaFolder = 'E:\'

# Path to new re-mastered ISO
$ISOFile = 'C:\Users\lamw\Desktop\Windows2016.iso'

# Need to specify the root directory of the oscdimg.exe utility which you need to download
$PathToOscdimg = 'C:\Program Files\Windows AIK\Tools\PETools'

# Instead of pointing to normal efisys.bin, use the *_noprompt instead
$BootData = '2#p0,e,b"{0}"#pEF,e,b"{1}"' -f "$ISOMediaFolder\boot\etfsboot.com", "$ISOMediaFolder\efi\Microsoft\boot\efisys_noprompt.bin"

# re-master Windows ISO
Start-Process -FilePath "$PathToOscdimg\oscdimg.exe" -ArgumentList @("-bootdata:$BootData", '-u2', '-udfver102', "$ISOMediaFolder", "$ISOFile") -PassThru -Wait -NoNewWindow

Start-Process "$OSCDIMG" -ArgumentList "-m -o -u2 -udfver102 -bootdata:2#p0, e, b$WINDOWS_ISO_FOLDER\boot\etfsboot.com#pEF, e, b$WINDOWS_ISO_FOLDER\efi\microsoft\boot\efisys.bin $WINDOWS_ISO_FOLDER $WINDOWS_ISO_FILE_OUT\WINDOWS.iso"



Set-Location C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg\

oscdimg.exe -m -o -u2 -udfver102 -bootdata:2#p0, e, bc:\w\boot\etfsboot.com#pEF, e, bc:\w\efi\microsoft\boot\efisys.bin c:\w c:\w\w.iso
oscdimg.exe -m -o -u2 -udfver102 -bootdata:2#p0, e, bd:\iso_files\boot\etfsboot.com#pEF, e, bd:\iso_files\efi\microsoft\boot\efisys.bin d:\iso_files d:\14986PROx64.iso


