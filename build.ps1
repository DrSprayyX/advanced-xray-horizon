$ErrorActionPreference = 'Stop'

$root = $PSScriptRoot
$compatibility = Get-Content -LiteralPath (Join-Path $root 'compatibility.json') -Raw | ConvertFrom-Json

if ($compatibility.hooks -lt 1) {
    throw 'compatibility.json must declare a positive hooks API version.'
}
if ($compatibility.horizon_revision -notmatch '^[0-9a-f]{40}$') {
    throw 'compatibility.json must contain a 40-character horizon_revision.'
}
if ($compatibility.horizon_mixins_revision -notmatch '^[0-9a-f]{40}$') {
    throw 'compatibility.json must contain a 40-character horizon_mixins_revision.'
}

$mixinFiles = @(Get-ChildItem -LiteralPath (Join-Path $root 'mixins') -Filter 'horizon-mixin.toml' -File -Recurse)
if ($mixinFiles.Count -ne 1) {
    throw 'A .hnmod must contain exactly one mixins/<id>/horizon-mixin.toml.'
}

$mixinFile = $mixinFiles[0]
$bundle = $mixinFile.Directory
$toml = Get-Content -LiteralPath $mixinFile.FullName -Raw
$modSection = [regex]::Match($toml, '(?ms)^\[mod\]\s*(.*?)(?=^\[|\z)').Groups[1].Value
$idMatch = [regex]::Match($modSection, '(?m)^id\s*=\s*"(?<value>[^"]+)"\s*$')
$versionMatch = [regex]::Match($modSection, '(?m)^version\s*=\s*"(?<value>[^"]+)"\s*$')

if (-not $idMatch.Success -or -not $versionMatch.Success) {
    throw 'The [mod] section must declare id and version in horizon-mixin.toml.'
}

$modId = $idMatch.Groups['value'].Value
$version = $versionMatch.Groups['value'].Value
if ($bundle.Name -ne $modId) {
    throw "The bundle folder 'mixins/$($bundle.Name)' must match the mod id '$modId'."
}
if ($modId -notmatch '^[a-z0-9_]+$') {
    throw "The mod id '$modId' must contain only lowercase letters, digits and underscores."
}

$manifest = [ordered]@{
    schema  = 1
    id      = $modId
    version = $version
    game    = $compatibility.game
    horizon = $compatibility.horizon_revision
    mixins  = $compatibility.horizon_mixins_revision
    hooks   = [int]$compatibility.hooks
}

$target = Join-Path $root 'target'
New-Item -ItemType Directory -Path $target -Force | Out-Null
$staging = Join-Path $target ('.hnmod-staging-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $staging | Out-Null
$output = Join-Path $target "$modId-$version.hnmod"
$zipOutput = Join-Path $target ('.hnmod-' + [guid]::NewGuid().ToString('N') + '.zip')

try {
    $manifestPath = Join-Path $staging 'horizon-native.json'
    $manifestJson = $manifest | ConvertTo-Json
    [System.IO.File]::WriteAllBytes($manifestPath, [System.Text.Encoding]::UTF8.GetBytes($manifestJson + "`n"))

    foreach ($file in Get-ChildItem -LiteralPath $bundle.FullName -File -Recurse | Where-Object { $_.Extension -in '.rs', '.toml' }) {
        $relativePath = $file.FullName.Substring($root.Length).TrimStart('\').Replace('\', '/')
        $destination = Join-Path $staging ($relativePath.Replace('/', '\'))
        $destinationDirectory = Split-Path -Parent $destination
        New-Item -ItemType Directory -Path $destinationDirectory -Force | Out-Null
        Copy-Item -LiteralPath $file.FullName -Destination $destination
    }

    Compress-Archive -Path (Join-Path $staging '*') -DestinationPath $zipOutput -CompressionLevel Optimal
    if (-not (Test-Path -LiteralPath $zipOutput) -or (Get-Item -LiteralPath $zipOutput).Length -eq 0) {
        throw 'The .hnmod archive was not created.'
    }
    Move-Item -LiteralPath $zipOutput -Destination $output -Force

    Write-Host "Created $output"
}
finally {
    Remove-Item -LiteralPath $staging -Recurse -Force
    if (Test-Path -LiteralPath $zipOutput) {
        Remove-Item -LiteralPath $zipOutput -Force
    }
}
