# vscode-dotfiles

Backup e sincronização completa das configurações do VS Code: `settings.json`, `keybindings.json` e as 33 extensões instaladas.

## Estrutura da pasta

```
vscode-dotfiles/
├── settings.json              (link simbólico com o VS Code)
├── keybindings.json           (link simbólico com o VS Code)
├── extensions.txt             (lista das 33 extensões instaladas)
├── export-extensions.ps1      (gera/atualiza extensions.txt)
├── install-extensions.ps1     (instala tudo do extensions.txt)
└── setup-nova-maquina.ps1     (faz tudo de uma vez numa máquina nova)
```

---

## 🖥️ Configurando uma MÁQUINA NOVA (do zero)

Abra o PowerShell **como Administrador**:

```powershell
git clone https://github.com/GabrielVanderlinde/vscode-dotfiles.git C:\personal\vscode-dotfiles
cd C:\personal\vscode-dotfiles
.\setup-nova-maquina.ps1
```

Esse script sozinho:
1. Clona o repositório (se ainda não existir)
2. Remove o `settings.json`/`keybindings.json` padrão que o VS Code cria
3. Cria os links simbólicos apontando pro repositório
4. Instala as 33 extensões da lista

Depois só reiniciar o VS Code.

> **Erro comum:** se aparecer `code : o termo não é reconhecido`, é porque existe um alias antigo no seu `$PROFILE` do PowerShell apontando `code` para `code-insiders`. Os scripts aqui já contornam isso automaticamente, mas se quiser resolver na raiz, edite `notepad $PROFILE` e remova qualquer linha `Set-Alias code code-insiders`.

---

## 🔄 Atualizando o backup (na máquina do dia a dia)

Você **não precisa mexer manualmente** em `settings.json` nem `keybindings.json` — como são links simbólicos, qualquer mudança feita pela interface do VS Code já grava direto no repositório.

O que precisa de ação manual é só a lista de extensões, porque o VS Code não salva isso em arquivo sozinho:

```powershell
cd C:\personal\vscode-dotfiles
.\export-extensions.ps1
git add .
git commit -m "descreva o que mudou"
git push
```

Faça isso sempre que instalar ou remover uma extensão.

---

## ❓ Perguntas frequentes

**Preciso apagar o settings.json/keybindings.json manualmente?**
Não, na máquina atual (que já tem os links funcionando) não mexe em nada. Numa máquina **nova**, o `setup-nova-maquina.ps1` já remove os arquivos padrão e recria como link simbólico — é automático.

**Por que as extensões não vêm junto quando eu só copio o settings.json?**
Porque extensões são gerenciadas pelo VS Code numa pasta separada (`.vscode\extensions`), não dentro dos arquivos de configuração. Por isso existe o `extensions.txt` — ele é a "lista de compras" que o `install-extensions.ps1` usa pra reinstalar tudo.

**E se eu quiser usar o Settings Sync nativo do VS Code também?**
Pode usar os dois juntos sem conflito. Ative em `Ctrl+Shift+P` → "Settings Sync: Turn On" — sincroniza automaticamente entre máquinas logadas na mesma conta. Esse repositório Git continua servindo como backup versionado, útil em máquinas onde você não vai logar com sua conta, ou se quiser ver histórico de mudanças (`git log`).

**Uma extensão falhou na instalação, e agora?**
O `install-extensions.ps1` lista no final quais falharam (se houver). Basta instalar manualmente pelo nome no Marketplace, dentro do VS Code.

---

## 📦 Extensões incluídas (33)

Produtividade geral, temas, Nest/TypeScript, Docker e qualidade de código — a lista completa está em `extensions.txt` e é sempre a fonte da verdade (gerada direto da máquina, sem digitação manual).
