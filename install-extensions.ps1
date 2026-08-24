# install-extensions.ps1
# Roda isso na máquina NOVA, depois de clonar o repositório vscode-dotfiles
# Lê extensions.txt e instala cada extensão automaticamente

if (-Not (Test-Path ".\extensions.txt")) {
    Write-Host "Arquivo extensions.txt não encontrado nesta pasta." -ForegroundColor Red
    Write-Host "Certifique-se de estar dentro da pasta vscode-dotfiles clonada." -ForegroundColor Yellow
    exit 1
}

# Usa o caminho completo do executável para não depender de aliases do profile
$codeCmd = if (Get-Command code -ErrorAction SilentlyContinue) { "code" } else { "code.cmd" }

$extensions = Get-Content ".\extensions.txt" | Where-Object { $_.Trim() -ne "" }
$total = $extensions.Count
$count = 0
$falhas = @()

foreach ($ext in $extensions) {
    $count++
    Write-Host "[$count/$total] Instalando $ext..." -ForegroundColor Cyan
    & $codeCmd --install-extension $ext --force
    if ($LASTEXITCODE -ne 0) {
        $falhas += $ext
    }
}

Write-Host "`nInstalação concluída." -ForegroundColor Green

if ($falhas.Count -gt 0) {
    Write-Host "`nAs seguintes extensões falharam e precisam ser instaladas manualmente:" -ForegroundColor Red
    $falhas | ForEach-Object { Write-Host "  - $_" -ForegroundColor Red }
} else {
    Write-Host "Todas as $total extensões foram instaladas com sucesso!" -ForegroundColor Green
}

Write-Host "`nReinicie o VS Code para garantir que tudo carregou corretamente." -ForegroundColor Yellow
