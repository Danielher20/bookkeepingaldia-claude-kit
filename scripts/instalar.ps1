# Instalador del kit Bookkeeping al Dia para Claude. Se puede correr las veces que haga falta (actualiza).
# Solo ASCII a proposito: PowerShell 5.1 lee mal los acentos en scripts sin BOM.
param(
    [string]$ClaudeDir = $(if ($env:CLAUDE_CONFIG_DIR) { $env:CLAUDE_CONFIG_DIR } else { Join-Path $env:USERPROFILE ".claude" }),
    [string]$VaultDir = (Join-Path ([Environment]::GetFolderPath("MyDocuments")) "BookkeepingAlDia-Cerebro"),
    [switch]$SinPlugin,
    [switch]$SinPausa
)
$ErrorActionPreference = "Stop"
$kit = Split-Path $PSScriptRoot -Parent
$utf8 = New-Object System.Text.UTF8Encoding($false)
$fallas = New-Object System.Collections.ArrayList

function Paso($t) { Write-Host ""; Write-Host "== $t" -ForegroundColor Cyan }
function Ok($t) { Write-Host "   OK  $t" -ForegroundColor Green }
function Falla($t) { Write-Host "   FALLA  $t" -ForegroundColor Red; [void]$fallas.Add($t) }

# 1. Skills ---------------------------------------------------------------
Paso "Skills"
$skillsDst = Join-Path $ClaudeDir "skills"
New-Item -ItemType Directory -Force $skillsDst | Out-Null
$n = 0
foreach ($d in Get-ChildItem (Join-Path $kit "skills") -Directory) {
    $dst = Join-Path $skillsDst $d.Name
    if (Test-Path $dst) { Remove-Item $dst -Recurse -Force }
    Copy-Item $d.FullName $dst -Recurse -Force
    if (-not (Test-Path (Join-Path $dst "SKILL.md"))) { Falla "Skill sin SKILL.md: $($d.Name)" } else { $n++ }
}
Ok "$n skills copiadas a $skillsDst"

# 2. Vault (el contenido de Johan nunca se pisa) ----------------------------
Paso "Cerebro (carpeta de memoria)"
$vaultSrc = Join-Path $kit "vault"
if (-not (Test-Path $VaultDir)) {
    Copy-Item $vaultSrc $VaultDir -Recurse -Force
    Ok "Creado en $VaultDir"
} else {
    robocopy $vaultSrc $VaultDir /E /XC /XN /XO /NFL /NDL /NJH /NJS /NP | Out-Null
    if ($LASTEXITCODE -ge 8) { Falla "No se pudo actualizar el cerebro (robocopy $LASTEXITCODE)" }
    else { Ok "Ya existia: se agregaron archivos nuevos y no se toco nada de lo que Johan ya tenia" }
}
if (-not (Test-Path (Join-Path $VaultDir "00_LEEME.md"))) { Falla "Falta 00_LEEME.md en el cerebro" }

# 3. CLAUDE.md global --------------------------------------------------------
Paso "Reglas (CLAUDE.md)"
$mdDst = Join-Path $ClaudeDir "CLAUDE.md"
$bloque = [IO.File]::ReadAllText((Join-Path $kit "claude\CLAUDE.md"), $utf8).Replace("{{VAULT}}", $VaultDir).TrimEnd()
$inicio = "<!-- BKAD-KIT:START"
$fin = "<!-- BKAD-KIT:END -->"
if (Test-Path $mdDst) {
    $actual = [IO.File]::ReadAllText($mdDst, $utf8)
    $i = $actual.IndexOf($inicio); $j = $actual.IndexOf($fin)
    if ($i -ge 0 -and $j -gt $i) {
        $nuevo = $actual.Substring(0, $i) + $bloque + $actual.Substring($j + $fin.Length)
    } else {
        Copy-Item $mdDst ($mdDst + ".respaldo-" + (Get-Date -Format "yyyyMMdd-HHmmss")) -Force
        $nuevo = $actual.TrimEnd() + "`r`n`r`n" + $bloque + "`r`n"
    }
} else { $nuevo = $bloque + "`r`n" }
[IO.File]::WriteAllText($mdDst, $nuevo, $utf8)
Ok "Reglas escritas en $mdDst"

# 4. Permisos para que no pregunte a cada rato ---------------------------------
Paso "Permisos"
$setPath = Join-Path $ClaudeDir "settings.json"
$cfg = if (Test-Path $setPath) { [IO.File]::ReadAllText($setPath, $utf8) | ConvertFrom-Json } else { New-Object psobject }
if (-not $cfg) { $cfg = New-Object psobject }
if (-not $cfg.PSObject.Properties["permissions"]) { $cfg | Add-Member -NotePropertyName permissions -NotePropertyValue (New-Object psobject) }
$p = $cfg.permissions
function Union($actual, $nuevos) { $l = New-Object System.Collections.ArrayList; foreach ($x in @($actual) + @($nuevos)) { if ($x -and -not $l.Contains($x)) { [void]$l.Add($x) } }; ,@($l) }
$allow = Union $p.allow @("WebSearch", "WebFetch", "Bash(python *)", "Bash(py *)", "Bash(pip install *)", "Bash(pip *)")
$dirs = Union $p.additionalDirectories @($VaultDir)
foreach ($pair in @(@("allow", $allow), @("additionalDirectories", $dirs), @("defaultMode", "acceptEdits"))) {
    if ($p.PSObject.Properties[$pair[0]]) { $p.($pair[0]) = $pair[1] } else { $p | Add-Member -NotePropertyName $pair[0] -NotePropertyValue $pair[1] }
}
[IO.File]::WriteAllText($setPath, ($cfg | ConvertTo-Json -Depth 20), $utf8)
Ok "Edicion de archivos y herramientas de oficina sin preguntar; el cerebro queda accesible"

# 5. Coleccion Vibe CPA (se baja del repo oficial, no va dentro de este kit) -------------
Paso "Coleccion fiscal Vibe CPA"
if ($SinPlugin) { Write-Host "   (omitido por -SinPlugin)" -ForegroundColor Yellow } else {
    $vibeDst = Join-Path $skillsDst "vibe-cpa-pack"
    $tmp = Join-Path ([IO.Path]::GetTempPath()) ("bkad-vibe-" + [guid]::NewGuid().ToString("N").Substring(0, 8))
    try {
        New-Item -ItemType Directory -Force $tmp | Out-Null
        $zip = Join-Path $tmp "vibe.zip"
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest "https://codeload.github.com/KisaesDevLab/vibe-claude-tax-research-skills/zip/refs/heads/main" -OutFile $zip -UseBasicParsing
        Expand-Archive $zip (Join-Path $tmp "x") -Force
        $root = Get-ChildItem (Join-Path $tmp "x") -Directory | Select-Object -First 1
        if (Test-Path $vibeDst) { Remove-Item $vibeDst -Recurse -Force }
        Move-Item $root.FullName $vibeDst
        # El manifiesto original usa rutas que el Claude Code actual rechaza: se corrigen y se quitan los comandos de desarrollo del repo.
        $mf = Join-Path $vibeDst ".claude-plugin\plugin.json"
        $m = [IO.File]::ReadAllText($mf, $utf8) | ConvertFrom-Json
        $m.skills = @($m.skills | ForEach-Object { "./" + $_.TrimStart("./") })
        $m.PSObject.Properties.Remove("commands")
        [IO.File]::WriteAllText($mf, ($m | ConvertTo-Json -Depth 10), $utf8)
        $cuantas = @(Get-ChildItem (Join-Path $vibeDst "skills") -Directory | Where-Object { Test-Path (Join-Path $_.FullName "SKILL.md") }).Count
        if ($cuantas -ge 40) { Ok "Vibe CPA instalado ($cuantas skills fiscales)" } else { Falla "Vibe CPA quedo incompleto ($cuantas skills)" }
    } catch { Falla "No pude instalar Vibe CPA: $($_.Exception.Message)" }
    finally { if (Test-Path $tmp) { Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue } }
}

# 6. Resumen -------------------------------------------------------------------
Paso "Resumen"
if ($fallas.Count -eq 0) {
    Write-Host "   TODO INSTALADO. Abre Claude, entra a la carpeta del cerebro y escribe tu primer mensaje:" -ForegroundColor Green
    Write-Host "   $VaultDir"
} else {
    Write-Host "   Quedaron $($fallas.Count) problema(s):" -ForegroundColor Red
    $fallas | ForEach-Object { Write-Host "    - $_" -ForegroundColor Red }
}
if (-not $SinPausa) { Write-Host ""; Read-Host "Presiona Enter para cerrar" | Out-Null }
if ($fallas.Count -gt 0) { exit 1 }
