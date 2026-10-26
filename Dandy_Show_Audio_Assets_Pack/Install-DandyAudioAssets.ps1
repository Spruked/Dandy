param(
    [string]$DandyRoot = 'C:\dev\Desktop\The Real Dandy\Dandy'
)

$ErrorActionPreference = 'Stop'
$PackRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

if (-not (Test-Path $DandyRoot)) {
    throw "Dandy root not found: $DandyRoot"
}

$src = Join-Path $PackRoot 'asset_library'
$dst = Join-Path $DandyRoot 'asset_library'

New-Item -ItemType Directory -Force $dst | Out-Null
Copy-Item -Path (Join-Path $src '*') -Destination $dst -Recurse -Force

Write-Host "Installed Dandy audio assets into: $dst"
Write-Host ""
Write-Host "Installed files:"
Get-ChildItem $src -Recurse -File | ForEach-Object {
    $relative = $_.FullName.Substring($src.Length).TrimStart('\')
    Write-Host "  asset_library\$relative"
}
