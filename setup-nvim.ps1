# create symbolic link nvim

$nvimDir = "$env:USERPROFILE\AppData\Local\nvim"

if (-not (Test-Path $nvimDir)) {
    New-Item -ItemType SymbolicLink -Path $nvimDir -Value $env:USERPROFILE\DotFiles\nvim
}
