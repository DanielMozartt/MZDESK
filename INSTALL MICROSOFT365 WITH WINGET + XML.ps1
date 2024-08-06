function Office365 {

    $Host.UI.RawUI.WindowTitle = 'OFFICE365'
    $Host.UI.RawUI.BackgroundColor = 'DarkBlue'

    #Cria o arquivo XML de instalação personalizada no diretório C:\365.
    
    [xml]$XML = @'
<Configuration ID="646616bb-84c9-4354-9908-8abd74c04f4c">
  <Add OfficeClientEdition="64" Channel="Current" MigrateArch="TRUE">
    <Product ID="O365ProPlusEEANoTeamsRetail">
      <Language ID="pt-br" />
      <Language ID="MatchPreviousMSI" />
      <ExcludeApp ID="Groove" />
      <ExcludeApp ID="Lync" />
    </Product>
  </Add>
  <Updates Enabled="TRUE" />
  <RemoveMSI />
  <AppSettings>
    <User Key="software\microsoft\office\16.0\excel\options" Name="defaultformat" Value="60" Type="REG_DWORD" App="excel16" Id="L_SaveExcelfilesas" />
    <User Key="software\microsoft\office\16.0\powerpoint\options" Name="defaultformat" Value="52" Type="REG_DWORD" App="ppt16" Id="L_SavePowerPointfilesas" />
    <User Key="software\microsoft\office\16.0\word\options" Name="defaultformat" Value="ODT" Type="REG_SZ" App="word16" Id="L_SaveWordfilesas" />
    <User Key="software\microsoft\office\16.0\word\options" Name="verticalruler" Value="1" Type="REG_DWORD" App="word16" Id="L_VerticalrulerPrintviewonly" />
  </AppSettings>
  <Display Level="Full" AcceptEULA="TRUE" />
</Configuration> 
'@
     
    $365 = 'C:\365'
    
    #Se o diretório $365 já existir, é deletado.

    if ($365) {

        Remove-Item -Path "$365"-Recurse -Force -ErrorAction SilentlyContinue
    }
    
    #Cria o diretório $365.
    
    [System.IO.Directory]::CreateDirectory($365) | Out-Null
    
    #Cria o arquivo XML no diretório $365.

    $XML.save("$365\OFFICE365.xml") 
   
    $365XML = "$365\OFFICE365.xml"

    #Instala o Microsoft365 com as configuraçoes do XML $365XML.

    Winget Install --Id Microsoft.Office --Override "/configure $365XML" --Accept-Source-Agreements --Accept-Package-Agreements

    #Remove o diretório $365.

    Remove-Item -Path "$365"-Recurse -Force -ErrorAction SilentlyContinue
    
    Clear-Host

    Exit
}

Office365