Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

# Obtém o ID e o Objeto de Segurança do usuário atual.
$myWindowsID = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal = New-Object System.Security.Principal.WindowsPrincipal($myWindowsID)

# Obtém o Objeto de Segurança do usuário Administrador.
$adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator
  
# Verifica se o script está sendo executado como administrador.

if ($myWindowsPrincipal.IsInRole($adminRole)) {
    
    # Executando como administrador. Formatação e estilo aplicadas.

    $Host.UI.RawUI.WindowTitle = 'SYMLINK ZX > ONEDRIVE ⭡'
    $Host.UI.RawUI.BackgroundColor = 'DarkBlue'
    $H = Get-Host
    $Win = $H.UI.RawUI.WindowSize
    $Win.Height = 20
    $Win.Width = 58
    $H.UI.RawUI.Set_WindowSize($Win)
    
    Clear-Host
}
else {
    
    # Não está executando como administrador.
    
    # Fecha o processo atual e inicia um novo com o script como administrador solicitando UAC.

    $newProcess = New-Object System.Diagnostics.ProcessStartInfo 'PowerShell'
    $newProcess.Arguments = $myInvocation.MyCommand.Definition
    $newProcess.Verb = 'runas'
    [System.Diagnostics.Process]::Start($newProcess) | Out-Null     
    exit

}

#SELECIONA LOCAL DA PASTA DO ONEDRIVE.
Set-Location K:\OneDrive

#CRIA UM LINK SYMBÓLICO DA UNIDADE X: COM NOME MZT.DM
New-Item -ItemType symboliclink -Path . -Name MZT.DM -Value X:\

#CRIA UM LINK SYMBÓLICO DA UNIDADE Z: COM NOME MZT.TI
New-Item -ItemType symboliclink -Path . -Name MZT.IT -Value Z:\

EXIT