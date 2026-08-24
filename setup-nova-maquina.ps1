# setup-nova-maquina.ps1
# Roda isso do ZERO numa máquina nova (PowerShell como Administrador)
# Clona o repo, cria os links simbólicos e instala as extensões — tudo de uma vez

$repoUrl = "https://github.com/GabrielVanderlinde/vscode-dotfiles.git"
$destino = "C:\personal\vscode-dotfiles"

# 1. Clonar o repositório (se ainda não existir)
if (-Not (Test-Path $destino)) {
    Write-Host "Clonando repositório..." -ForegroundColor Cyan
    git clone $repoUrl $destino
} else {
    Write-Host "Pasta já existe, pulando clone." -ForegroundColor Yellow
}

Set-Location $destino

# 2. Remover settings/keybindings padrão do VS Code (se existirem) e criar links simbólicos
$vscodeUserPath = "$env:APPDATA\Code\User"

if (Test-Path "$vscodeUserPath\settings.json") {
    Remove-Item "$vscodeUserPath\settings.json"
}
if (Test-Path "$vscodeUserPath\keybindings.json") {
    Remove-Item "$vscodeUserPath\keybindings.json"
}

New-Item -ItemType SymbolicLink -Path "$vscodeUserPath\settings.json" -Target "$destino\settings.json" | Out-Null
New-Item -ItemType SymbolicLink -Path "$vscodeUserPath\keybindings.json" -Target "$destino\keybindings.json" | Out-Null

Write-Host "Links simbólicos criados." -ForegroundColor Green

# 3. Instalar todas as extensões
$codeCmd = if (Get-Command code -ErrorAction SilentlyContinue) { "code" } else { "code.cmd" }

if (Test-Path "$destino\extensions.txt") {
    Write-Host "Instalando extensões..." -ForegroundColor Cyan
    $extensions = Get-Content "$destino\extensions.txt" | Where-Object { $_.Trim() -ne "" }
    $total = $extensions.Count
    $count = 0
    foreach ($ext in $extensions) {
        $count++
        Write-Host "[$count/$total] $ext" -ForegroundColor DarkCyan
        & $codeCmd --install-extension $ext --force
    }
    Write-Host "Extensões instaladas." -ForegroundColor Green
} else {
    Write-Host "extensions.txt não encontrado — pulei essa etapa." -ForegroundColor Yellow
}

Write-Host "`nSetup completo! Reinicie o VS Code." -ForegroundColor Magenta
