
function DownloadWithProgress {

    $LINK = ''
    $FILE = ''
   
    $webClient = New-Object System.Net.WebClient
    $task = $webClient.DownloadFileTaskAsync($LINK, $FILE)
    
    Register-ObjectEvent -InputObject $webClient -EventName DownloadProgressChanged -SourceIdentifier WebClient.DownloadProgressChanged | Out-Null
    
    Start-Sleep -Seconds 3
    
    while (!($task.IsCompleted)) {
        $EventData = Get-Event -SourceIdentifier WebClient.DownloadProgressChanged | Select-Object -ExpandProperty 'SourceEventArgs' -Last 1
    
        $ReceivedData = ($EventData | Select-Object -ExpandProperty 'BytesReceived')
        $TotalToReceive = ($EventData | Select-Object -ExpandProperty 'TotalBytesToReceive')
        $TotalPercent = $EventData | Select-Object -ExpandProperty 'ProgressPercentage'
    
        Start-Sleep -Seconds 2
    
        function convertFileSize {
            param(
                $bytes
            )
    
            if ($bytes -lt 1MB) {
                return "$([Math]::Round($bytes / 1KB, 2)) KB"
            }
            elseif ($bytes -lt 1GB) {
                return "$([Math]::Round($bytes / 1MB, 2)) MB"
            }
            elseif ($bytes -lt 1TB) {
                return "$([Math]::Round($bytes / 1GB, 2)) GB"
            }
        }

        Write-Progress -Activity 'Downloading File' -Status "Percent Complete: $($TotalPercent)%" -CurrentOperation "Downloaded $(convertFileSize -bytes $ReceivedData) / $(convertFileSize -bytes $TotalToReceive)" -PercentComplete $TotalPercent
    
    }
    
    Unregister-Event -SourceIdentifier WebClient.DownloadProgressChanged
    $webClient.Dispose()

}

DownloadWithProgress