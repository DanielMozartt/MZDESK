Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

# Obtém o ID e o Objeto de Segurança do usuário atual.
$myWindowsID = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal = New-Object System.Security.Principal.WindowsPrincipal($myWindowsID)

# Obtém o Objeto de Segurança do usuário Administrador.
$adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator
  
# Verifica se o script está sendo executado como administrador.

if ($myWindowsPrincipal.IsInRole($adminRole)) {
    
    # Executando como administrador. Título alterado.

    $Host.UI.RawUI.WindowTitle = 'POWERSHELL AUTO-ELEVATE'
        
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
