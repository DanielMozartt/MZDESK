Add-Type -AssemblyName System.Windows.Forms

function Backup-Folders {
    # Função para abrir uma janela de entrada de texto
    function InputBox {
        param (
            [string]$message,
            [string]$title
        )
        Add-Type -AssemblyName Microsoft.VisualBasic
        return [Microsoft.VisualBasic.Interaction]::InputBox($message, $title, "")
    }

    # Solicita ao usuário o número do OS e o nome do cliente
    $OS = InputBox -message "Digite o número do OS:" -title "Número do OS"
    $CLIENTNAME = InputBox -message "Digite o nome do cliente:" -title "Nome do Cliente"

    # Verifica se os valores foram fornecidos
    if (-not $OS -or -not $CLIENTNAME) {
        [System.Windows.Forms.MessageBox]::Show("Número do OS e nome do cliente são obrigatórios.")
        return
    }

    # Define o caminho de destino
    $destinationPath = "\\Mozart\Z\BKP\OS $OS - $CLIENTNAME"

    # Adiciona as credenciais de rede
    $username = "MZT"
    $password = "#MZT"
    $securePassword = ConvertTo-SecureString $password -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential($username, $securePassword)

    # Mapeia a unidade de rede com as credenciais fornecidas
    New-PSDrive -Name "Z" -PSProvider FileSystem -Root "\\Mozart\Z" -Credential $credential -Persist

    # Cria a pasta de destino se não existir
    if (-not (Test-Path -Path $destinationPath)) {
        New-Item -ItemType Directory -Path $destinationPath
    }

    # Define as pastas a serem copiadas com nomes válidos
    $folders = @("Desktop", "Documents", "Pictures", "Music", "Videos", "OneDrive")

    # Cria a janela de progresso
    $progressForm = New-Object System.Windows.Forms.Form
    $progressForm.Text = "Progresso do Backup"
    $progressForm.Size = New-Object System.Drawing.Size(400, 100)
    $progressForm.StartPosition = "CenterScreen"

    $progressBar = New-Object System.Windows.Forms.ProgressBar
    $progressBar.Minimum = 0
    $progressBar.Maximum = $folders.Length
    $progressBar.Step = 1
    $progressBar.Dock = [System.Windows.Forms.DockStyle]::Fill
    $progressForm.Controls.Add($progressBar)

    $progressForm.Show()

    # Função para copiar pastas
    function Copy-Folder {
        param (
            [string]$source,
            [string]$destination
        )
        Copy-Item -Path $source -Destination $destination -Recurse -Force
    }

    # Função para obter o caminho da pasta, verificando também no OneDrive
    function Get-FolderPath {
        param (
            [string]$folderName
        )
        $path = Join-Path -Path $HOME -ChildPath $folderName
        if (-not (Test-Path -Path $path)) {
            $path = Join-Path -Path "$HOME\OneDrive" -ChildPath $folderName
        }
        return $path
    }

    # Copia as pastas para o destino
    foreach ($folder in $folders) {
        $sourcePath = Get-FolderPath -folderName $folder
        $destPath = Join-Path -Path $destinationPath -ChildPath $folder
        Copy-Folder -source $sourcePath -destination $destPath
        $progressBar.PerformStep()
    }

    # Fecha a janela de progresso
    $progressForm.Close()

    # Remove o mapeamento de rede
    Remove-PSDrive -Name "Z"

    [System.Windows.Forms.MessageBox]::Show("Backup concluído com sucesso.")
}

# Chama a função para executar o script
Backup-Folders