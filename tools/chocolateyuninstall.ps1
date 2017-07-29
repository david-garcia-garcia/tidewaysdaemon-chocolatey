# IMPORTANT: Before releasing this package, copy/paste the next 2 lines into PowerShell to remove all comments from this file:
#   $f='c:\path\to\thisFile.ps1'
#   gc $f | ? {$_ -notmatch "^\s*#"} | % {$_ -replace '(^.*?)\s*?[^``]#.*','$1'} | Out-File $f+".~" -en utf8; mv -fo $f+".~" $f

## NOTE: In 80-90% of the cases (95% with licensed versions due to Package Synchronizer and other enhancements), you may 
## not need this file due to AutoUninstaller. See https://chocolatey.org/docs/commands-uninstall

## If this is an MSI, cleaning up comments is all you need.
## If this is an exe, change installerType and silentArgs
## Auto Uninstaller should be able to detect and handle registry uninstalls (if it is turned on, it is in preview for 0.9.9).
## - https://chocolatey.org/docs/helpers-uninstall-chocolatey-package

$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName = 'tidewaysdaemon'
$softwareName = 'tidewaysdaemon*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
$installerType = 'EXE' 

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Join-Path $toolsDir 'daemon_windows_amd64.exe'

$silentArgs = '/qn /norestart'
# https://msdn.microsoft.com/en-us/library/aa376931(v=vs.85).aspx
$validExitCodes = @(0, 3010, 1605, 1614, 1641)
$uninstalled = $false

if (Get-Service -Name "TidewaysDaemon" -ErrorAction SilentlyContinue)
{
    nssm remove TidewaysDaemon confirm
}

Netsh.exe advfirewall firewall remove rule name="Tideways Daemon"


