FUNCTION REGXML {

    $REG = 
    [PSCustomObject]@{
        Path  = ''
        Value = 'XML'
        Name  = ''
    } | Group-Object Path

    foreach ($REG in $REG) {
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

REGXML