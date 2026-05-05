param(
    [string]$Token,

    [string]$RepoName = "mimo-orbit-creator-proof",

    [string]$Description = "AI creator workflow proof for Xiaomi MiMo Orbit application"
)

$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$gh = Join-Path (Split-Path -Parent $root) ".tools\bin\gh.exe"

if (-not (Test-Path $gh)) {
    throw "GitHub CLI not found at $gh"
}

Push-Location $root
try {
    if ($Token) {
        $Token | & $gh auth login --with-token
    }
    else {
        & $gh auth status
    }

    & $gh repo create $RepoName --public --description $Description --source . --remote origin --push
    & $gh repo view $RepoName --web
}
finally {
    Pop-Location
}
