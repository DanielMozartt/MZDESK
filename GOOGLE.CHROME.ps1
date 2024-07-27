#Desabilitar notificações do Google Chrome.
FUNCTION DISABLENOTIFICATIONS {
    $settings = 
    [PSCustomObject]@{
        Path  = 'SOFTWARE\Policies\Google\Chrome'
        Value = 2
        Name  = 'DefaultNotificationsSetting'
    } | Group-Object Path

    foreach ($setting in $settings) {
        $registry = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey($setting.Name, $true)
        if ($null -eq $registry) {
            $registry = [Microsoft.Win32.Registry]::LocalMachine.CreateSubKey($setting.Name, $true)
        }
        $setting.Group | ForEach-Object {
            $registry.SetValue($_.name, $_.value)
        }
        $registry.Dispose()
    }
}

DISABLENOTIFICATIONS

#-----------------------------------------------------------------------------------------------------


#Definir o Google Chrome como administrador via Chocolatey.

FUNCTION CHROMEDEFAULTCHOCO {

    #Requires -RunAsAdministrator

    # Set this to $false to silence the Write-Verbose calls below.
    $verbose = $true

    # Install SetDefaultBrowswer.exe, if necessary.
    if (-not (Get-Command -ErrorAction Ignore SetDefaultBrowser.exe)) {

        # Install Chocolatey first, if necessary.
        if (-not (Get-Command -ErrorAction Ignore choco.exe)) {
            Write-Verbose -Verbose:$verbose 'Installing Chocolatey (this will take a while)...'
            # Note: We silence success output, Write-Host and Write-Warning messages. The progress display from the Expand-Archive
            #       call can only be silenced if $ProgressPreference is *globally* set
            $prevProgressPref = $global:ProgressPreference; $global:ProgressPreference = 'SilentlyContinue'
            try {
                Invoke-RestMethod -ErrorAction Stop https://chocolatey.org/install.ps1 | Invoke-Expression >$null 3>$null 6>$null
                if (-not (Get-Command -ErrorAction Ignore choco.exe)) {
                    throw 'Installation of Chocolatey failed.' 
                }
            }
            finally {
                $global:ProgressPreference = $prevProgressPref
            }
        }

        Write-Verbose -Verbose:$verbose 'Installing SetDefaultBrowser...'
        # Note: Place the -y (for automated installation) *at the end* of the command line.
        choco install SetDefaultBrowser -y >$null
        if ($LASTEXITCODE) {
            Write-Error 'Installation of SetDefaultBrowser failed.'; exit $LASTEXITCODE 
        }

        # Refresh the environment so that SetDefaultBrowser.exe can be called by name only.
        # Do so via Chocolatey's Update-SessionEnvironment cmdlet, which is part of the Chocolatey profile module.
        $env:ChocolateyInstall = Convert-Path "$((Get-Command choco.exe).Path)\..\.."   
        Import-Module -ErrorAction Stop "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
        Update-SessionEnvironment

    }

    Write-Verbose -Verbose:$verbose 'Calling SetDefaultBrowser.exe ...'

    # Switch to Google Chrome as the default browser.
    SetDefaultBrowser chrome
    if ($LASTEXITCODE) {
        exit $LASTEXITCODE 
    }

    Write-Verbose -Verbose:$verbose "The user's default browser was successfully changed to Google Chrome."

}

CHROMEDEFAULTCHOCO