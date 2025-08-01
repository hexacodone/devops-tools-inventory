# Komplette Zsh Setup Anleitung - Getestet auf Ubuntu 24.04

> **Getestet auf:** Tuxedo Infinity Book 15 mit Ubuntu 24.04  
> **Installationszeit:** ~15 Minuten  
> **Ergebnis:** Professionelle Shell mit interaktiver Suche, Autosuggestions und modernem Theme

## Übersicht der finalen Installation

Nach dieser Anleitung haben Sie:
- ✅ Zsh als Standard-Shell
- ✅ Oh My Zsh Framework
- ✅ Powerlevel10k Theme (modern und schnell)
- ✅ Interaktive History-Suche mit fzf (Ctrl+R)
- ✅ Intelligente Autosuggestions
- ✅ Syntax-Highlighting für Befehle
- ✅ 50.000 History-Einträge mit Duplikat-Bereinigung

---

## 1. Basis-Installation

```bash
# System aktualisieren
sudo apt update

# Zsh und curl installieren
sudo apt install zsh curl

# Zsh als Standard-Shell setzen (WICHTIG: usermod verwenden!)
sudo usermod -s /usr/bin/zsh $USER

# Komplett abmelden (nicht nur Terminal schließen!)
gnome-session-quit --logout --no-prompt
```

**Nach dem Neuanmelden sollten Sie automatisch in zsh sein.**

---

## 2. Oh My Zsh Framework installieren

```bash
# Oh My Zsh installieren
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Wenn gefragt wird, ob Shell gewechselt werden soll: Y eingeben
```

---

## 3. Powerlevel10k Theme installieren

```bash
# Powerlevel10k herunterladen
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

---

## 4. Interaktive History-Suche mit fzf

```bash
# fzf installieren
sudo apt install fzf

# fzf für zsh aktivieren
echo 'source /usr/share/doc/fzf/examples/key-bindings.zsh' >> ~/.zshrc
echo 'source /usr/share/doc/fzf/examples/completion.zsh' >> ~/.zshrc
```

---

## 5. Zsh-Plugins installieren

```bash
# Autosuggestions (graue Vorschläge während der Eingabe)
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Syntax-Highlighting (farbige Befehle)
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

---

## 6. .zshrc Konfiguration

**Erstellen Sie ein Backup der aktuellen .zshrc:**
```bash
cp ~/.zshrc ~/.zshrc.backup
```

**Bearbeiten Sie die .zshrc:**
```bash
nano ~/.zshrc
```

**Ändern Sie diese wichtigen Zeilen:**

1. **Theme ändern** (ca. Zeile 15):
```bash
# Von:
ZSH_THEME="robbyrussell"
# Zu:
ZSH_THEME="powerlevel10k/powerlevel10k"
```

2. **Plugins erweitern** (ca. Zeile 73):
```bash
# Von:  
plugins=(git)
# Zu:
plugins=(git sudo web-search copypath history fzf zsh-autosuggestions zsh-syntax-highlighting)
```

3. **Am Ende der Datei hinzufügen:**
```bash
# History Konfiguration - Erweitert
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# Nützliche Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias cls='clear'
alias h='history'
alias hg='history | grep'

# Git Aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gco='git checkout'

# System Aliases
alias update='sudo apt update && sudo apt upgrade'
alias install='sudo apt install'

# fzf Optimierungen
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_T_OPTS="--preview 'cat {}'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap"
```

---

## 7. Konfiguration aktivieren

```bash
# Neue Konfiguration laden
source ~/.zshrc
```

**Beim ersten Laden startet automatisch der Powerlevel10k Konfigurationswizard!**

---

## 8. Powerlevel10k Theme konfigurieren

Der Wizard fragt Sie nach:
- **Schriftart:** Wählen Sie eine Nerd Font für beste Darstellung
- **Prompt-Stil:** "Lean" wird empfohlen für moderne Optik
- **Farben:** Nach Geschmack wählen
- **Icons:** "Yes" für bessere Visualisierung
- **Zeit:** "24h" für europäisches Format
- **Separator:** "Slanted" oder "Round" sehen modern aus
- **Prompt-Höhe:** "Two lines" für bessere Übersicht

**Falls Sie den Wizard nochmal starten möchten:**
```bash
p10k configure
```

---

## 9. Zusätzliche nützliche Tools (Optional)

```bash
# Moderne Alternativen zu Standard-Tools
sudo apt install htop tree

# Für noch bessere Experience (optional):
sudo apt install bat exa ripgrep
```

**Wenn installiert, fügen Sie diese Aliases zur .zshrc hinzu:**
```bash
alias cat='batcat'    # Syntax-highlighting für cat
alias ls='exa --icons' # Moderne ls-Alternative
alias grep='rg'       # Schnellere grep-Alternative
```

---

## 10. Installation testen

**Prüfen Sie, ob alles funktioniert:**

```bash
# 1. Shell prüfen
echo $SHELL
# Sollte zeigen: /usr/bin/zsh

# 2. Plugins testen
ls ~/.oh-my-zsh/custom/plugins/
# Sollte zeigen: zsh-autosuggestions zsh-syntax-highlighting

# 3. Theme prüfen  
ls ~/.oh-my-zsh/custom/themes/
# Sollte zeigen: powerlevel10k

# 4. Features testen:
# - Tippen Sie 'ls' → sollten graue Autosuggestions sehen
# - Drücken Sie Ctrl+R → sollten interaktive History-Suche sehen
# - Befehle sollten farbig hervorgehoben sein
```

---

## 11. Wichtige Keyboard-Shortcuts

Nach der Installation stehen Ihnen zur Verfügung:

| Shortcut | Funktion |
|----------|----------|
| **Ctrl + R** | Interaktive History-Suche mit fzf |
| **Ctrl + T** | Datei-Suche im aktuellen Verzeichnis |
| **Alt + C** | Verzeichnis-Wechsel mit fzf |
| **Tab** | Erweiterte Tab-Completion |
| **→** (Pfeil rechts) | Autosuggestion übernehmen |
| **Ctrl + →** | Wort der Autosuggestion übernehmen |

---

## 12. Fehlerbehebung

### Problem: chsh funktioniert nicht
```bash
# Lösung: usermod verwenden statt chsh
sudo usermod -s /usr/bin/zsh $USER
```

### Problem: Shell wechselt nicht permanent
```bash
# Komplett abmelden erforderlich:
gnome-session-quit --logout --no-prompt
# NICHT nur Terminal schließen!
```

### Problem: fzf Ctrl+R zeigt altes "bck-i-search"
```bash
# fzf key-bindings neu laden:
source /usr/share/doc/fzf/examples/key-bindings.zsh
```

### Problem: Autosuggestions funktionieren nicht
```bash
# Plugin-Installation prüfen:
ls ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
# Falls leer: Plugin neu installieren
```

---

## 13. Finale Dateistruktur

Nach erfolgreicher Installation haben Sie folgende Dateien:

```
~/.zshrc              # Hauptkonfiguration (~5KB)
~/.p10k.zsh           # Theme-Konfiguration (~90KB)  
~/.zsh_history        # History-Datei (wächst automatisch)
~/.zshrc.backup       # Backup der ursprünglichen .zshrc
~/.oh-my-zsh/         # Oh My Zsh Framework
├── custom/
│   ├── plugins/
│   │   ├── zsh-autosuggestions/
│   │   └── zsh-syntax-highlighting/
│   └── themes/
│       └── powerlevel10k/
```

---

## 14. Wartung und Updates

```bash
# Oh My Zsh updaten
omz update

# Powerlevel10k updaten  
git -C ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k pull

# Theme neu konfigurieren
p10k configure
```

---

## ✅ Erfolg!

Sie haben jetzt eine professionelle Zsh-Umgebung mit:
- **Moderner Optik** durch Powerlevel10k
- **Intelligenter Suche** durch fzf (Ctrl+R)
- **Autosuggestions** für schnellere Eingabe
- **Syntax-Highlighting** für bessere Lesbarkeit
- **Erweiterte History** mit 50.000 Einträgen

**Geschätzte Installationszeit:** 10-15 Minuten  
**Getestet auf:** Ubuntu 24.04, Tuxedo Infinity Book 15

---

*Diese Anleitung basiert auf einer erfolgreichen Installation und enthält alle notwendigen Schritte für eine vollständige Zsh-Einrichtung.*