$ErrorActionPreference = 'Stop';

$packageName= 'tidewaysdaemon'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Join-Path $toolsDir 'daemon_windows_amd64.exe'

Netsh.exe advfirewall firewall add rule name="Tideways Daemon" program=$fileLocation protocol=tcp dir=out enable=yes action=allow

$destinationPath = $fileLocation
$destinationDir = $toolsDir

if (!(Get-Service -Name "TidewaysDaemon" -ErrorAction SilentlyContinue))
{
    nssm install TidewaysDaemon $destinationPath
}


nssm set TidewaysDaemon Application  $destinationPath
nssm set TidewaysDaemon AppDirectory $destinationDir
nssm set TidewaysDaemon AppParameters '--address="127.0.0.1:8136"'

nssm set TidewaysDaemon DisplayName Tideways Daemon
nssm set TidewaysDaemon Description The Tideways Profiler Daemon
nssm set TidewaysDaemon Start SERVICE_AUTO_START

nssm start TidewaysDaemon