# Hook SessionStart: le entrega a Claude la memoria de Johan al abrir cada sesion.
# Solo ASCII a proposito (PowerShell 5.1). Lee los archivos del cerebro en UTF-8.
param([Parameter(Mandatory = $true)][string]$VaultDir)
$utf8 = New-Object System.Text.UTF8Encoding($false)
[Console]::OutputEncoding = $utf8
function Leer($rel) {
    $f = Join-Path $VaultDir $rel
    if (Test-Path $f) { Write-Output "===== $rel ====="; Write-Output ([IO.File]::ReadAllText($f, $utf8).Trim()); Write-Output "" }
}
Write-Output "MEMORIA DE JOHAN (cargada al iniciar). Aplicala sin que la pida. Carpeta del cerebro: $VaultDir"
Write-Output ""
Leer "02_Voz-y-Escritura\Preferencias-aprendidas.md"
Leer "02_Voz-y-Escritura\Voz-de-Johan.md"
Leer "01_Negocio\Bookkeeping-al-Dia.md"
$cli = Join-Path $VaultDir "05_Clientes"
if (Test-Path $cli) {
    $notas = @(Get-ChildItem $cli -Filter *.md | Where-Object { $_.Name -notlike "_*" } | ForEach-Object { $_.BaseName })
    Write-Output "===== Clientes con nota en 05_Clientes ($($notas.Count)) ====="
    if ($notas.Count) { Write-Output ($notas -join ", ") } else { Write-Output "(ninguno todavia)" }
}
$mes = Join-Path $VaultDir ("06_Diario\" + (Get-Date -Format "yyyy-MM") + ".md")
if (Test-Path $mes) {
    Write-Output ""
    Write-Output "===== Ultimo trabajo registrado este mes ====="
    Get-Content $mes -Encoding UTF8 -Tail 15
}
exit 0
