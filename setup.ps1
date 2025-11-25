# Releases
$komorebiRelease = "https://github.com/LGUG2Z/komorebi/releases/download/v0.1.38/komorebi-0.1.38-x86_64-pc-windows-msvc.zip"
$whkdRelease = "https://github.com/LGUG2Z/whkd/releases/download/v0.2.10/whkd-0.2.10-x86_64-pc-windows-msvc.zip"

# User Directories
$userDir = $env:USERPROFILE
$pathDir = Join-Path $userDir "AppData\Local\Microsoft\WindowsApps"
$downloadDir = Join-Path $userDir "Downloads"

# Ensure Downloads exists
if (-not (Test-Path $downloadDir)) { New-Item -ItemType Directory -Path $downloadDir | Out-Null }

# Downloaded file paths
$komorebiZip = Join-Path $downloadDir "komorebi.zip"
$whkdZip = Join-Path $downloadDir "whkd.zip"
$komorebiUnzip = [System.IO.Path]::ChangeExtension($komorebiZip, $null)
$whkdUnzip = [System.IO.Path]::ChangeExtension($whkdZip, $null)

# Download files
Invoke-WebRequest -Uri $komorebiRelease -OutFile $komorebiZip
Invoke-WebRequest -Uri $whkdRelease -OutFile $whkdZip

# Extract archives
Expand-Archive -Path $komorebiZip -DestinationPath $komorebiUnzip -Force
Expand-Archive -Path $whkdZip -DestinationPath $whkdUnzip -Force

# Move files to WindowsApps
Get-ChildItem $komorebiUnzip -File | Copy-Item -Destination $pathDir -Force
Get-ChildItem $whkdUnzip -File | Copy-Item -Destination $pathDir -Force
