$ErrorActionPreference = 'Stop';

$packageName = 'tidewaysdaemon'
$softwareName = 'tidewaysdaemon*'
$installerType = 'EXE' 

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Join-Path $toolsDir 'daemon_windows_amd64.exe'

$silentArgs = '/qn /norestart'
$validExitCodes = @(0, 3010, 1605, 1614, 1641)
$uninstalled = $false

if (Get-Service -Name "TidewaysDaemon" -ErrorAction SilentlyContinue)
{
    nssm remove TidewaysDaemon confirm
}

Netsh.exe advfirewall firewall remove rule name="Tideways Daemon"
