$exe = @{
  Name = "IVENTOY"
  BinaryPathName = 'C:\iventoy-1.0.20\iVentoy_64.exe'
  DisplayName = "IVENTOY"
  StartupType = "Automatic"
  Description = "Run iVentoy"
}
New-Service @exe

$bat = @{
  Name = "IVENTOYBAT"
  BinaryPathName = 'C:\iventoy-1.0.20\iVentoy.bat'
  DisplayName = "IVENTOYBAT"
  StartupType = "Automatic"
  Description = "Run iVentoy"
}
New-Service @bat