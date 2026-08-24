# export-extensions.ps1
# Roda isso na máquina que JÁ TEM as extensões que você quer levar
# Gera/atualiza o arquivo extensions.txt dentro da pasta vscode-dotfiles

# Usa o caminho completo do executável para não depender de aliases do profile
$codeCmd = if (Get-Command code -ErrorAction SilentlyContinue) { "code" } else { "code.cmd" }

& $codeCmd --list-extensions | Sort-Object > extensions.txt

Write-Host "Extensões exportadas para extensions.txt" -ForegroundColor Green
Write-Host "Total: $((Get-Content extensions.txt).Count) extensões" -ForegroundColor Cyan
Write-Host "`nNão esqueça de fazer commit e push:" -ForegroundColor Yellow
Write-Host "  git add extensions.txt"
Write-Host "  git commit -m 'atualiza lista de extensoes'"
Write-Host "  git push"
