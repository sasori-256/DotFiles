# Dotfiles Managed PowerShell Profile
# Original source merged from: OneDrive\Documents\PowerShell\Microsoft.PowerShell_profile.ps1

# --- 1. Environment & Utilities ---
function Update-PathVariable {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") +
    ";" +
    [System.Environment]::GetEnvironmentVariable("Path", "User")
}

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# WinGet Command Not Found Module
if (Get-Module -ListAvailable -Name Microsoft.WinGet.CommandNotFound) {
    Import-Module -Name Microsoft.WinGet.CommandNotFound
}

# --- 2. Modules ---
if (Get-Module -ListAvailable -Name posh-git) {
    Import-Module posh-git
}

# --- 3. Starship ---
if (Get-Command starship -ErrorAction SilentlyContinue) {
    # Transient Prompt (コマンド実行後にプロンプトを簡略化する機能)
    function Invoke-Starship-TransientFunction {
        &starship module character
    }
    Invoke-Expression (&starship init powershell)
    Enable-TransientPrompt
}

# --- 4. Aliases ---
# Editors
Set-Alias -Name vim -Value nvim
Set-Alias -Name v -Value nvim

# Git
Set-Alias -Name g -Value git
if (Get-Command lazygit -ErrorAction SilentlyContinue) {
    Set-Alias -Name lg -Value lazygit
}

# Sudo
if (Get-Command gsudo -ErrorAction SilentlyContinue) {
    Set-Alias -Name sudo -Value gsudo
}

# Modern Replacements (if installed via Scoop/Winget)
if (Get-Command eza -ErrorAction SilentlyContinue) {
    Set-Alias -Name ls -Value eza
    function ll() {
        eza -la --icons --git --group-directories-first $args
    }
    function lt() {
        eza -la --icons --git --group-directories-first -T -L 2 $args
    }
}

if (Get-Command bat -ErrorAction SilentlyContinue) {
    Set-Alias -Name cat -Value bat
}

if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& {
        $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
        (zoxide init --hook $hook powershell | Out-String)
    })
    Set-Alias -Name cd -Value "z" -Option AllScope
}

# --- 5. Proto (Version Manager) ---
# Assuming Proto is in Path, if env vars needed:
# $env:PROTO_HOME = "$env:USERPROFILE\.proto"
# $env:PATH = "$env:PROTO_HOME\shims;$env:PROTO_HOME\bin;$env:PATH"
