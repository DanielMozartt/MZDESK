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

#SELECIONA LOCAL ATUAL DA PASTA DO ONEDRIVE JÁ CRIADA PREVIAMENTE.
Set-Location $HOME\OneDrive

#EXEMPLO 1 - CRIA UM LINK SIMBÓLICO DA UNIDADE D: COM UMA PASTA DE NOME TESTE
New-Item -ItemType symboliclink -Path . -Name TESTE -Value D:\

#EXEMPLO 2 - CRIA UM LINK SIMBÓLICO DA PASTA TESTE na UNIDADE D:
New-Item -ItemType symboliclink -Path . -Name TESTE -Value D:\TESTE

#EXEMPLO 3 - CRIA UM LINK SIMBÓLICO DO ARQUIVO TESTE.txt localizado na pasta TESTE na UNIDADE D:
New-Item -ItemType symboliclink -Path . -Name TESTE.txt -Value D:\TESTE\TESTE.txt

EXIT