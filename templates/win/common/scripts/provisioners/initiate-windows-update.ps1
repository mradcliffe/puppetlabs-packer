
# Initiate the Windows Update operation.

$ErrorActionPreference = 'Stop'

. C:\Packer\Scripts\windows-env.ps1

Write-Output "Setting up Windows Update"

Install-7ZipPackage
if (-not (Test-Path "$PackerLogs\PSWindowsUpdate.installed")) {
  # Download and install PSWindows Update Modules.
  Download-File "https://artifactory.delivery.puppetlabs.net/artifactory/generic/buildsources/windows/pswindowsupdate/PSWindowsUpdate.1.6.1.1.zip" "$Env:TEMP/pswindowsupdate.zip"
  mkdir -Path "$Env:TEMP\PSWindowsUpdate"
  $zproc = Start-Process "$7zip" @SprocParms -ArgumentList "x $Env:TEMP/pswindowsupdate.zip -y -o$PackerPsModules"
  $zproc.WaitForExit()
  Touch-File "$PackerLogs\PSWindowsUpdate.installed"
}

Write-Output "========== Initiating Windows Update ========"
Write-Output "========== This will take some time  ========"
Write-Output "========== a log and update report   ========"
Write-Output "========== will be given at the end  ========"
Write-Output "========== of the update cycle       ========"

# Need to pick up Admin Username/Password from Environment for sched task
Write-Output "Create Bootstrap Scheduled Task"
schtasks /create /tn PackerWinUpdate /rl HIGHEST /ru "$ENV:ADMIN_USERNAME" /RP "$ENV:ADMIN_PASSWORD" /IT /F /SC ONSTART /DELAY 0000:20 /TR 'cmd /c c:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe -sta -WindowStyle Normal -ExecutionPolicy Bypass -NonInteractive -NoProfile -File C:\Packer\Scripts\packer-windows-update.ps1 >> C:\Packer\Logs\windows-update.log'

# Disable WinRM until further notice.
Set-Service "WinRM" -StartupType Disabled
