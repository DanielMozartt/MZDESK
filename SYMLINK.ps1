Add-Type -AssemblyName System.Windows.Forms

function Create-SymbolicLinkWithUserInput {
    # Função para abrir uma janela de seleção de pasta
    function Select-FolderDialog {
        param (
            [string]$description
        )
        $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
        $folderBrowser.Description = $description
        $folderBrowser.ShowDialog() | Out-Null
        return $folderBrowser.SelectedPath
    }

    # Cria a janela principal
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Criar Link Simbólico"
    $form.Size = New-Object System.Drawing.Size(400, 200)
    $form.StartPosition = "CenterScreen"

    # Botão para selecionar a pasta de origem
    $sourceButton = New-Object System.Windows.Forms.Button
    $sourceButton.Text = "Selecionar Pasta de Origem"
    $sourceButton.Location = New-Object System.Drawing.Point(10, 20)
    $sourceButton.Size = New-Object System.Drawing.Size(360, 30)
    $form.Controls.Add($sourceButton)

    # Botão para selecionar a pasta de destino
    $destinationButton = New-Object System.Windows.Forms.Button
    $destinationButton.Text = "Selecionar Pasta de Destino"
    $destinationButton.Location = New-Object System.Drawing.Point(10, 60)
    $destinationButton.Size = New-Object System.Drawing.Size(360, 30)
    $form.Controls.Add($destinationButton)

    # Botão para criar o link simbólico
    $createButton = New-Object System.Windows.Forms.Button
    $createButton.Text = "Criar Link Simbólico"
    $createButton.Location = New-Object System.Drawing.Point(10, 100)
    $createButton.Size = New-Object System.Drawing.Size(360, 30)
    $form.Controls.Add($createButton)

    # Variáveis para armazenar os caminhos selecionados
    $sourcePath = ""
    $destinationPath = ""

    # Evento para selecionar a pasta de origem
    $sourceButton.Add_Click({
            $sourcePath = Select-FolderDialog -description "Selecione a pasta de origem"
            if ($sourcePath) {
                [System.Windows.Forms.MessageBox]::Show("Pasta de origem selecionada: $sourcePath")
            }
        })

    # Evento para selecionar a pasta de destino
    $destinationButton.Add_Click({
            $destinationPath = Select-FolderDialog -description "Selecione a pasta de destino"
            if ($destinationPath) {
                [System.Windows.Forms.MessageBox]::Show("Pasta de destino selecionada: $destinationPath")
            }
        })

    # Evento para criar o link simbólico
    $createButton.Add_Click({
            if ($sourcePath -and $destinationPath) {
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
                    $response = [System.Windows.Forms.MessageBox]::Show("O link simbólico '$linkName' já existe. Deseja removê-lo e criar um novo?", "Confirmação", [System.Windows.Forms.MessageBoxButtons]::YesNo)
                    if ($response -eq [System.Windows.Forms.DialogResult]::Yes) {
                        Remove-Item -Path (Join-Path -Path $destinationPath -ChildPath $linkName)
                        Create-SymbolicLink -Name $linkName -Target $sourcePath
                        [System.Windows.Forms.MessageBox]::Show("Link simbólico '$linkName' criado com sucesso.")
                    }
                    else {
                        [System.Windows.Forms.MessageBox]::Show("Operação cancelada pelo usuário.")
                    }
                }
                else {
                    Create-SymbolicLink -Name $linkName -Target $sourcePath
                    [System.Windows.Forms.MessageBox]::Show("Link simbólico '$linkName' criado com sucesso.")
                }
            }
            else {
                [System.Windows.Forms.MessageBox]::Show("Por favor, selecione as pastas de origem e destino.")
            }
        })

    # Exibe a janela
    $form.ShowDialog()
}

# Chama a função para executar o script
Create-SymbolicLinkWithUserInput