# Script cài đặt cho Windows
# Author: dung204
# --------------------------------

# Các package sẽ cài đặt: Chocolatey, Unikey, Git, Google Chrome, NodeJS, yarn, OpenJDK (java), MinGW (gcc), WSL 

# --- Kiểm tra xem file này có chạy trên quyền Admin không
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())

$RunningAsAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if( $RunningAsAdmin -eq $False)
{
	Write-Host "ERROR: This script must be run as administrator" -Foreground "Red" -Background "Yellow"
	pause # Press any key to continue ...
	exit
}


# --- Cài  chocolatey
Write-Host "Installing Chocolatey ..." -Foreground "Green"
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072 
iex ((New-Object System.Net.WebClient).DownloadString("https://community.chocolatey.org/install.ps1"))
refreshenv

# --- Cài Git
Write-Host "Installing git ..." -Foreground "Green"
choco install -y git
refreshenv

# Thêm git vào PATH để git có thể hoạt động được
$GitBinPath = (Resolve-Path -Path "$env:UserProfile\..\..\Program Files\Git\bin").Path
$env:PATH += ";$GitBinPath"
refreshenv

# --- Cài Unikey
Write-Host "Installing Unikey ..." -Foreground "Green"
choco install -y unikey
Copy-Item "$env:UserProfile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Unikey\UnikeyNT.lnk" -Destination "$env:UserProfile\Desktop" # Copy unikey shortcut to desktop

# --- Cài Google Chrome
Write-Host "Installing Google Chrome ..." -Foreground "Green"
choco install -y googlechrome

# --- Cài VSCode
Write-Host "Installing Visual Studio Code ..." -Foreground "Green"
choco install -y vscode
refreshenv

# --- Cài NodeJS LTS
Write-Host "Installing NodeJS LTS ..." -Foreground "Green"
choco install -y nodejs-lts
refreshenv

# Thêm node vào PATH (giống như git)
$NodeBinPath = (Resolve-Path -Path "$env:UserProfile\..\..\Program Files\nodejs").Path
$env:PATH += ";$NodeBinPath"
refreshenv

# --- Cài yarn
Write-Host "Installing yarn ..."
cmd.exe /c "npm install -g yarn"

# --- Cài OpenJDK (java)
Write-Host "Installing OpenJDK (java) ..." - Foreground "Green"
choco install -y openjdk
$JDKBinPath = (Resolve-Path -Path "$env:UserProfile\..\..\Program Files\OpenJDK\*\bin").Path
$env:PATH += ";$JDKBinPath"
refreshenv

# --- Cài MinGW (gcc, g++ and gdb)
Write-Host "Install MinGW (gcc, g++ and gdb) ..." -Foreground "Green"
choco install -y mingw
refreshenv

# --- Cài WSL (Windows Subsystem for Linux)
Write-Host "Install WSL (and Ubuntu as well) ..." -Foreground "Green"
wsl --install # Also installed Ubuntu
Write-Host "Please restart to start using WSL"
