# Dotfiles Setup Script for Windows
# Optimized for local pathing (Non-OneDrive) and multi-drive setups

$ErrorActionPreference = "Stop"

# --- 0. Pre-checks ---
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$isAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "Warning: Not running as Administrator. Symlinks may fail if Developer Mode is off." -ForegroundColor Yellow
}

function Install-Scoop {
    Write-Host "`n[1/4] Setting up Scoop..." -ForegroundColor Cyan
    if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
        Write-Host "Installing Scoop..."
        Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
        Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    }
    
    Write-Host "Adding Scoop buckets..."
    scoop bucket add extras 2>$null
    scoop bucket add versions 2>$null
    scoop bucket add nerd-fonts 2>$null
}

function Install-CLI-Tools {
    Write-Host "`n[2/4] Installing CLI tools via Scoop..." -ForegroundColor Cyan
    $apps = @("git", "neovim", "gcc", "ripgrep", "fd", "lazygit", "starship", "fzf", "eza", "bat", "delta", "zoxide")
    foreach ($app in $apps) {
        if (-not (Get-Command $app -ErrorAction SilentlyContinue)) {
            Write-Host "Installing $app..."
            scoop install $app
        }
    }
}

function Install-GUI-Apps {
    Write-Host "`n[3/4] Installing GUI apps via Winget..." -ForegroundColor Cyan
    $apps = @(
        "wez.wezterm",
        "Microsoft.VisualStudioCode",
        "Unity.UnityHub",
        "TigerVNC.TigerVNC",
        "Discord.Discord",
        "Brave.Brave"
    )
    foreach ($id in $apps) {
        $installed = winget list --id $id | Select-String $id
        if (-not $installed) {
            Write-Host "Installing $id..."
            winget install --id $id -e --source winget --accept-source-agreements --accept-package-agreements
        }
    }
}

function Setup-Symlinks {
    Write-Host "`n[4/4] Linking Dotfiles & Configuring Profiles..." -ForegroundColor Cyan
    
    $dotfiles = $PSScriptRoot
    $config   = "$env:USERPROFILE\.config"
    if (-not (Test-Path $config)) { New-Item -ItemType Directory -Path $config -Force | Out-Null }

    function Link-Item {
        param($Src, $Dest)
        if (Test-Path $Dest) {
            Write-Host "  Removing existing $Dest..." -ForegroundColor DarkGray
            Remove-Item -Path $Dest -Force -Recurse
        }
        Write-Host "  Linking $Dest -> $Src"
        New-Item -ItemType SymbolicLink -Path $Dest -Value $Src | Out-Null
    }

    # Symlinks
    Link-Item -Src "$dotfiles\nvim" -Dest "$env:LOCALAPPDATA\nvim"
    Link-Item -Src "$dotfiles\wezterm" -Dest "$config\wezterm"
    Link-Item -Src "$dotfiles\starship.toml" -Dest "$config\starship.toml"

    # --- PowerShell Profiles (5.1 & 7+) ---
    # Dynamically find the current local Documents folder
    $myDocs = [Environment]::GetFolderPath("MyDocuments")
    $profiles = @(
        "$myDocs\WindowsPowerShell\Microsoft.PowerShell_profile.ps1",
        "$myDocs\PowerShell\Microsoft.PowerShell_profile.ps1"
    )

    $currentProfileLine = '. "{0}\powershell\profile.ps1"' -f $dotfiles

    foreach ($p in $profiles) {
        $pDir = Split-Path $p
        if (-not (Test-Path $pDir)) { New-Item -ItemType Directory -Path $pDir -Force | Out-Null }

        if (Test-Path $p) {
            $content = Get-Content $p -Raw
            $pattern = '\. ".*?[Dd]ot[Ff]iles[\\/]powershell[\\/]profile\.ps1"'
            
            if ($content -match $pattern) {
                if ($content -notmatch [regex]::Escape($currentProfileLine)) {
                    Write-Host "  Updating outdated DotFiles path in $p" -ForegroundColor Yellow
                    $newContent = $content -replace $pattern, $currentProfileLine
                    Set-Content -Path $p -Value $newContent
                } else {
                    Write-Host "  Profile $p is already correct." -ForegroundColor DarkGray
                }
            } else {
                Write-Host "  Appending DotFiles to $p"
                Add-Content -Path $p -Value "`n$currentProfileLine"
            }
        } else {
            Write-Host "  Creating new profile $p"
            Set-Content -Path $p -Value $currentProfileLine
        }
    }
}

# --- Execution ---
Install-Scoop
Install-CLI-Tools
Install-GUI-Apps
Setup-Symlinks

Write-Host "`nSetup Complete! Restart your terminal to see the changes." -ForegroundColor Green
