function Create-SymbolicLinkWithUserInput {
    # Função para abrir uma janela de seleção de pasta
    function Select-FolderDialog {
        param (
            [string]$description
        )
        Add-Type -AssemblyName System.Windows.Forms
        $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
        $folderBrowser.Description = $description
        $folderBrowser.ShowDialog() | Out-Null
        return $folderBrowser.SelectedPath
    }

    # Solicita ao usuário para selecionar a pasta de origem
    $sourcePath = Select-FolderDialog -description "Selecione a pasta de origem"
    # Solicita ao usuário para selecionar a pasta de destino
    $destinationPath = Select-FolderDialog -description "Selecione a pasta de destino"
    Set-Location $destinationPath

    # Define a função para criar links simbólicos
    function Create-SymbolicLink {
        param (
            [string]$Name,
            [string]$Target
        )
        New-Item -ItemType SymbolicLink -Path . -Name $Name -Value $Target
    }

    # Nome do link simbólico
    $linkName = "RECOVERY DATA"

    # Verifica se o link simbólico já existe
    if (Test-Path -Path (Join-Path -Path $destinationPath -ChildPath $linkName)) {
        $response = Read-Host "O link simbólico '$linkName' já existe. Deseja removê-lo e criar um novo? (S/N)"
        if ($response -eq 'S') {
            Remove-Item -Path (Join-Path -Path $destinationPath -ChildPath $linkName)
            Create-SymbolicLink -Name $linkName -Target $sourcePath
            Write-Host "Link simbólico '$linkName' criado com sucesso."
        }
        else {
            Write-Host "Operação cancelada pelo usuário."
        }
    }
    else {
        Create-SymbolicLink -Name $linkName -Target $sourcePath
        Write-Host "Link simbólico '$linkName' criado com sucesso."
    }
}

# Chama a função para executar o script
Create-SymbolicLinkWithUserInput
