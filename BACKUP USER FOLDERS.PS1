Add-Type -AssemblyName System.Windows.Forms

function InputBox {
    param ($message, $title)
    Add-Type -AssemblyName Microsoft.VisualBasic
    [Microsoft.VisualBasic.Interaction]::InputBox($message, $title, "")
}

function Copy-FolderContents {
    param ($source, $destination)
    try {
        if (Test-Path $source) {
            if (-not (Test-Path $destination)) { New-Item -ItemType Directory -Path $destination }
            Copy-Item -Path (Join-Path $source "*") -Destination $destination -Recurse -Force -ErrorAction Stop
        }
        else {
            Write-Error "Caminho não encontrado: $source"
        }
    }
    catch {
        Write-Error "Erro ao copiar conteúdo de ${source}: $($_.Exception.Message)"
    }
}

function GetKnownFolderPath {
    param ($folderName)
    $knownFolders = @{
        "Desktop"   = [System.Environment]::GetFolderPath("Desktop")
        "Documents" = [System.Environment]::GetFolderPath("MyDocuments")
        "Pictures"  = [System.Environment]::GetFolderPath("MyPictures")
        "Music"     = [System.Environment]::GetFolderPath("MyMusic")
        "Videos"    = [System.Environment]::GetFolderPath("MyVideos")
        "OneDrive"  = "$HOME\OneDrive"
        "Downloads" = [System.Environment]::GetFolderPath("UserProfile") + "\Downloads"
    }
    $knownFolders[$folderName]
}

function Backup-Folders {
    $OS = InputBox "Digite o número do OS:" "Número do OS"
    $CLIENTNAME = InputBox "Digite o nome do cliente:" "Nome do Cliente"

    if (-not $OS -or -not $CLIENTNAME) {
        [System.Windows.Forms.MessageBox]::Show("Número do OS e nome do cliente são obrigatórios.")
        return
    }

    $destinationPath = "\\Mozart\Z\BKP\OS $OS - $CLIENTNAME"
    $credential = New-Object System.Management.Automation.PSCredential("MZT", (ConvertTo-SecureString "#MZT" -AsPlainText -Force))

    New-PSDrive -Name "Z" -PSProvider FileSystem -Root "\\Mozart\Z" -Credential $credential -Persist

    if (-not (Test-Path $destinationPath)) { New-Item -ItemType Directory -Path $destinationPath }

    $folders = @("Desktop", "Documents", "Pictures", "Music", "Videos", "OneDrive", "Downloads")

    foreach ($folder in $folders) {
        $sourcePath = GetKnownFolderPath $folder
        $destPath = Join-Path $destinationPath $folder
        try {
            if ($folder -eq "Documents") {
                $excludeFolders = @("Meus Vídeos", "Minhas Imagens", "Minhas Músicas")
                Get-ChildItem -Path $sourcePath | Where-Object { $excludeFolders -notcontains $_.Name } | ForEach-Object {
                    Copy-FolderContents -source $_.FullName -destination (Join-Path $destPath $_.Name)
                }
            }
            else {
                Copy-FolderContents -source $sourcePath -destination $destPath
            }
        }
        catch {
            Write-Error "Erro ao copiar conteúdo de ${sourcePath}: $($_.Exception.Message)"
        }
    }

    Remove-PSDrive -Name "Z"
    [System.Windows.Forms.MessageBox]::Show("Backup concluído com sucesso.")
}

function Restore-Folders {
    $OS = InputBox "Digite o número do OS:" "Número do OS"
    $CLIENTNAME = InputBox "Digite o nome do cliente:" "Nome do Cliente"

    if (-not $OS -or -not $CLIENTNAME) {
        [System.Windows.Forms.MessageBox]::Show("Número do OS e nome do cliente são obrigatórios.")
        return
    }

    $sourcePath = "\\MOZART\Z\BKP\OS $OS - $CLIENTNAME"
    $credential = New-Object System.Management.Automation.PSCredential("MZT", (ConvertTo-SecureString "#MZT" -AsPlainText -Force))

    New-PSDrive -Name "Z" -PSProvider FileSystem -Root "\\MOZART\Z" -Credential $credential -Persist

    if (-not (Test-Path $sourcePath)) {
        Write-Error "Caminho de origem não encontrado: $sourcePath"
        return
    }

    $folders = @("Desktop", "Documents", "Pictures", "Music", "Videos", "OneDrive", "Downloads")

    foreach ($folder in $folders) {
        $sourceFolderPath = Join-Path $sourcePath $folder
        $destFolderPath = GetKnownFolderPath $folder
        try {
            if (Test-Path $sourceFolderPath) {
                Copy-FolderContents -source $sourceFolderPath -destination $destFolderPath
            }
            else {
                Write-Error "Caminho não encontrado: ${sourceFolderPath}"
            }
        }
        catch {
            Write-Error "Erro ao copiar conteúdo de ${sourceFolderPath}: $($_.Exception.Message)"
        }
    }

    Remove-PSDrive -Name "Z"
    [System.Windows.Forms.MessageBox]::Show("Restauração concluída com sucesso.")
}

function Show-Menu {
    $menuForm = New-Object System.Windows.Forms.Form
    $menuForm.Text = "Menu de Backup e Restauração"
    $menuForm.Size = New-Object System.Drawing.Size(300, 150)
    $menuForm.StartPosition = "CenterScreen"

    $backupButton = New-Object System.Windows.Forms.Button
    $backupButton.Text = "Fazer Backup"
    $backupButton.Size = New-Object System.Drawing.Size(120, 30)
    $backupButton.Location = New-Object System.Drawing.Point(90, 20)
    $backupButton.Add_Click({ Backup-Folders })

    $restoreButton = New-Object System.Windows.Forms.Button
    $restoreButton.Text = "Restaurar Backup"
    $restoreButton.Size = New-Object System.Drawing.Size(120, 30)
    $restoreButton.Location = New-Object System.Drawing.Point(90, 60)
    $restoreButton.Add_Click({ Restore-Folders })

    $menuForm.Controls.Add($backupButton)
    $menuForm.Controls.Add($restoreButton)

    $menuForm.ShowDialog()
}

Show-Menu
Agora, o script exibirá apenas mensagens de erro no terminal e no menu. Se precisar de mais alguma modificação, estou à disposição!




O conteúdo gerado por IA pode estar incorreto
You said:

Modifique o script para mostrar apenas outputs se houver erros além do erros no terminal além do menu.
Copilot said:
Copilot
Claro! Aqui está a versão modificada do seu script para mostrar apenas mensagens de erro no terminal e no menu:

Add-Type -AssemblyName System.Windows.Forms

function InputBox {
    param ($message, $title)
    Add-Type -AssemblyName Microsoft.VisualBasic
    [Microsoft.VisualBasic.Interaction]::InputBox($message, $title, "")
}

function Copy-FolderContents {
    param ($source, $destination)
    try {
        if (Test-Path $source) {
            if (-not (Test-Path $destination)) { New-Item -ItemType Directory -Path $destination }
            Copy-Item -Path (Join-Path $source "*") -Destination $destination -Recurse -Force -ErrorAction Stop
        }
        else {
            $errorMsg = "Caminho não encontrado: $source"
            Write-Error $errorMsg
            [System.Windows.Forms.MessageBox]::Show($errorMsg)
        }
    }
    catch {
        $errorMsg = "Erro ao copiar conteúdo de ${source}: $($_.Exception.Message)"
        Write-Error $errorMsg
        [System.Windows.Forms.MessageBox]::Show($errorMsg)
    }
}

function GetKnownFolderPath {
    param ($folderName)
    $knownFolders = @{
        "Desktop"   = [System.Environment]::GetFolderPath("Desktop")
        "Documents" = [System.Environment]::GetFolderPath("MyDocuments")
        "Pictures"  = [System.Environment]::GetFolderPath("MyPictures")
        "Music"     = [System.Environment]::GetFolderPath("MyMusic")
        "Videos"    = [System.Environment]::GetFolderPath("MyVideos")
        "OneDrive"  = "$HOME\OneDrive"
        "Downloads" = [System.Environment]::GetFolderPath("UserProfile") + "\Downloads"
    }
    $knownFolders[$folderName]
}

function Backup-Folders {
    $OS = InputBox "Digite o número do OS:" "Número do OS"
    $CLIENTNAME = InputBox "Digite o nome do cliente:" "Nome do Cliente"

    if (-not $OS -or -not $CLIENTNAME) {
        [System.Windows.Forms.MessageBox]::Show("Número do OS e nome do cliente são obrigatórios.")
        return
    }

    $destinationPath = "\\Mozart\Z\BKP\OS $OS - $CLIENTNAME"
    $credential = New-Object System.Management.Automation.PSCredential("MZT", (ConvertTo-SecureString "#MZT" -AsPlainText -Force))

    New-PSDrive -Name "Z" -PSProvider FileSystem -Root "\\Mozart\Z" -Credential $credential -Persist

    if (-not (Test-Path $destinationPath)) { New-Item -ItemType Directory -Path $destinationPath }

    $folders = @("Desktop", "Documents", "Pictures", "Music", "Videos", "OneDrive", "Downloads")

    foreach ($folder in $folders) {
        $sourcePath = GetKnownFolderPath $folder
        $destPath = Join-Path $destinationPath $folder
        try {
            if ($folder -eq "Documents") {
                $excludeFolders = @("Meus Vídeos", "Minhas Imagens", "Minhas Músicas")
                Get-ChildItem -Path $sourcePath | Where-Object { $excludeFolders -notcontains $_.Name } | ForEach-Object {
                    Copy-FolderContents -source $_.FullName -destination (Join-Path $destPath $_.Name)
                }
            }
            else {
                Copy-FolderContents -source $sourcePath -destination $destPath
            }
        }
        catch {
            $errorMsg = "Erro ao copiar conteúdo de ${sourcePath}: $($_.Exception.Message)"
            Write-Error $errorMsg
            [System.Windows.Forms.MessageBox]::Show($errorMsg)
        }
    }

    Remove-PSDrive -Name "Z"
    [System.Windows.Forms.MessageBox]::Show("Backup concluído com sucesso.")
}

function Restore-Folders {
    $OS = InputBox "Digite o número do OS:" "Número do OS"
    $CLIENTNAME = InputBox "Digite o nome do cliente:" "Nome do Cliente"

    if (-not $OS -or -not $CLIENTNAME) {
        [System.Windows.Forms.MessageBox]::Show("Número do OS e nome do cliente são obrigatórios.")
        return
    }

    $sourcePath = "\\MOZART\Z\BKP\OS $OS - $CLIENTNAME"
    $credential = New-Object System.Management.Automation.PSCredential("MZT", (ConvertTo-SecureString "#MZT" -AsPlainText -Force))

    New-PSDrive -Name "Z" -PSProvider FileSystem -Root "\\MOZART\Z" -Credential $credential -Persist

    if (-not (Test-Path $sourcePath)) {
        $errorMsg = "Caminho de origem não encontrado: $sourcePath"
        Write-Error $errorMsg
        [System.Windows.Forms.MessageBox]::Show($errorMsg)
        return
    }

    $folders = @("Desktop", "Documents", "Pictures", "Music", "Videos", "OneDrive", "Downloads")

    foreach ($folder in $folders) {
        $sourceFolderPath = Join-Path $sourcePath $folder
        $destFolderPath = GetKnownFolderPath $folder
        try {
            if (Test-Path $sourceFolderPath) {
                Copy-FolderContents -source $sourceFolderPath -destination $destFolderPath
            }
            else {
                $errorMsg = "Caminho não encontrado: ${sourceFolderPath}"
                Write-Error $errorMsg
                [System.Windows.Forms.MessageBox]::Show($errorMsg)
            }
        }
        catch {
            $errorMsg = "Erro ao copiar conteúdo de ${sourceFolderPath}: $($_.Exception.Message)"
            Write-Error $errorMsg
            [System.Windows.Forms.MessageBox]::Show($errorMsg)
        }
    }

    Remove-PSDrive -Name "Z"
    [System.Windows.Forms.MessageBox]::Show("Restauração concluída com sucesso.")
}

function Show-Menu {
    $menuForm = New-Object System.Windows.Forms.Form
    $menuForm.Text = "Menu de Backup e Restauração"
    $menuForm.Size = New-Object System.Drawing.Size(300, 150)
    $menuForm.StartPosition = "CenterScreen"

    $backupButton = New-Object System.Windows.Forms.Button
    $backupButton.Text = "Fazer Backup"
    $backupButton.Size = New-Object System.Drawing.Size(120, 30)
    $backupButton.Location = New-Object System.Drawing.Point(90, 20)
    $backupButton.Add_Click({ Backup-Folders })

    $restoreButton = New-Object System.Windows.Forms.Button
    $restoreButton.Text = "Restaurar Backup"
    $restoreButton.Size = New-Object System.Drawing.Size(120, 30)
    $restoreButton.Location = New-Object System.Drawing.Point(90, 60)
    $restoreButton.Add_Click({ Restore-Folders })

    $menuForm.Controls.Add($backupButton)
    $menuForm.Controls.Add($restoreButton)

    $menuForm.ShowDialog()
}

Show-Menu