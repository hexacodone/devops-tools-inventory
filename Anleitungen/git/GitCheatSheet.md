# Git Cheat Sheet für DevOps - Umfassende Referenz

> Ein vollständiges Git-Nachschlagewerk für DevOps-Einsteiger und Fortgeschrittene

## 📋 Inhaltsverzeichnis

1. [Git Grundlagen](#git-grundlagen)
2. [Repository Setup](#repository-setup)
3. [Branching & Merging](#branching--merging)
4. [Remote Repositories](#remote-repositories)
5. [Staging & Commits](#staging--commits)
6. [Historie & Logs](#historie--logs)
7. [Rückgängig machen](#rückgängig-machen)
8. [Stashing](#stashing)
9. [Tags & Releases](#tags--releases)
10. [Konfliktlösung](#konfliktlösung)
11. [Git Workflows](#git-workflows)
12. [Advanced Commands](#advanced-commands)
13. [Git Konfiguration](#git-konfiguration)
14. [Troubleshooting](#troubleshooting)

---

## Git Grundlagen

### Was ist Git?
Git ist ein **verteiltes Versionskontrollsystem**, das Änderungen an Dateien über die Zeit verfolgt. Jeder Entwickler hat eine vollständige Kopie der gesamten Projekthistorie.

### Die drei Bereiche in Git
```
Working Directory → Staging Area → Repository
     (Workspace)      (Index)       (HEAD)
```

- **Working Directory**: Deine aktuellen Dateien
- **Staging Area**: Vorbereitungsbereich für den nächsten Commit
- **Repository**: Gespeicherte Versionen (Commits)

---

## Repository Setup

### Neues Repository erstellen
```bash
# Neues Repository initialisieren
git init

# Repository mit erstem Commit erstellen
git init
git add .
git commit -m "Initial commit"
```

### Bestehendes Repository klonen
```bash
# Repository klonen
git clone <repository-url>

# Mit spezifischem Ordnername klonen
git clone <repository-url> <folder-name>

# Nur den main/master Branch klonen
git clone --single-branch --branch main <repository-url>
```

### Repository Status prüfen
```bash
# Aktueller Status anzeigen
git status

# Kompakte Statusanzeige
git status -s

# Ignorierte Dateien auch anzeigen
git status --ignored
```

---

## Branching & Merging

### Branch Grundlagen
```bash
# Alle Branches anzeigen
git branch

# Remote Branches auch anzeigen
git branch -a

# Neuen Branch erstellen
git branch <branch-name>

# Branch erstellen und direkt wechseln
git checkout -b <branch-name>
# Oder mit neuerem Befehl:
git switch -c <branch-name>
```

### Branch Navigation
```bash
# Zu Branch wechseln
git checkout <branch-name>
# Oder:
git switch <branch-name>

# Zum vorherigen Branch wechseln
git checkout -
git switch -

# Branch umbenennen
git branch -m <old-name> <new-name>
git branch -m <new-name>  # Aktuellen Branch umbenennen
```

### Merging
```bash
# Branch in aktuellen Branch mergen
git merge <branch-name>

# Merge ohne Fast-Forward (erstellt immer Merge-Commit)
git merge --no-ff <branch-name>

# Merge abbrechen (bei Konflikten)
git merge --abort
```

### Branch löschen
```bash
# Branch löschen (nur wenn gemergt)
git branch -d <branch-name>

# Branch forciert löschen
git branch -D <branch-name>

# Remote Branch löschen
git push origin --delete <branch-name>
```

---

## Remote Repositories

### Remote Verbindungen verwalten
```bash
# Remote Repositories anzeigen
git remote -v

# Remote Repository hinzufügen
git remote add <name> <url>
git remote add origin https://github.com/user/repo.git

# Remote URL ändern
git remote set-url origin <new-url>

# Remote entfernen
git remote remove <name>
```

### Push & Pull
```bash
# Änderungen hochladen
git push origin <branch-name>

# Ersten Push mit Upstream setzen
git push -u origin <branch-name>

# Alle Branches pushen
git push --all

# Tags mitpushen
git push --tags
```

```bash
# Änderungen herunterladen und mergen
git pull origin <branch-name>

# Nur herunterladen ohne mergen
git fetch origin

# Alle Remote Branches fetchen
git fetch --all

# Pull mit Rebase statt Merge
git pull --rebase origin <branch-name>
```

---

## Staging & Commits

### Dateien zum Staging hinzufügen
```bash
# Einzelne Datei stagen
git add <filename>

# Alle Dateien stagen
git add .

# Alle modifizierten Dateien stagen (nicht neue)
git add -u

# Interaktives Staging
git add -i

# Teile einer Datei stagen
git add -p <filename>
```

### Commits erstellen
```bash
# Commit mit Message
git commit -m "Commit message"

# Mehrzeilige Commit Message
git commit -m "Titel" -m "Detaillierte Beschreibung"

# Alle modifizierten Dateien committen (überspringt Staging)
git commit -a -m "Message"

# Letzten Commit ändern
git commit --amend

# Commit Message des letzten Commits ändern
git commit --amend -m "Neue Message"
```

### Commit Message Best Practices
```
Format: <type>(<scope>): <subject>

<body>

<footer>
```

**Beispiele:**
```
feat(auth): add user login functionality
fix(api): resolve timeout issue in user service
docs(readme): update installation instructions
style(css): fix button alignment
refactor(utils): simplify date formatting function
test(auth): add unit tests for login flow
chore(deps): update dependencies to latest versions
```

---

## Historie & Logs

### Commit Historie anzeigen
```bash
# Einfacher Log
git log

# Kompakter Log (eine Zeile pro Commit)
git log --oneline

# Log mit Graph
git log --graph --oneline --all

# Letzten X Commits anzeigen
git log -5

# Log für bestimmte Datei
git log <filename>

# Log mit Änderungsstatistiken
git log --stat
```

### Erweiterte Log-Optionen
```bash
# Log zwischen zwei Commits
git log <commit1>..<commit2>

# Log für bestimmten Autor
git log --author="Name"

# Log seit bestimmtem Datum
git log --since="2 weeks ago"
git log --since="2025-01-01"

# Log mit Diff
git log -p

# Schöner formatierter Log
git log --pretty=format:"%h - %an, %ar : %s"
```

### Änderungen anzeigen
```bash
# Änderungen im Working Directory
git diff

# Änderungen im Staging
git diff --staged
git diff --cached

# Änderungen zwischen Branches
git diff branch1..branch2

# Änderungen einer bestimmten Datei
git diff <filename>
```

---

## Rückgängig machen

### Änderungen verwerfen
```bash
# Änderungen in einer Datei verwerfen
git checkout -- <filename>
# Oder:
git restore <filename>

# Alle Änderungen im Working Directory verwerfen
git checkout -- .
git restore .

# Datei aus Staging entfernen
git reset HEAD <filename>
# Oder:
git restore --staged <filename>
```

### Commits rückgängig machen
```bash
# Letzten Commit rückgängig (behält Änderungen)
git reset --soft HEAD~1

# Letzten Commit und Staging rückgängig
git reset HEAD~1

# Letzten Commit komplett löschen (VORSICHT!)
git reset --hard HEAD~1

# Bestimmten Commit rückgängig (erstellt neuen Commit)
git revert <commit-hash>
```

### Reset vs Revert
- **Reset**: Verändert die Historie (gefährlich bei geteilten Branches)
- **Revert**: Erstellt neuen Commit, der Änderungen rückgängig macht (sicher)

---

## Stashing

### Temporäre Änderungen speichern
```bash
# Änderungen stashen
git stash

# Stash mit Nachricht
git stash save "Work in progress on feature X"

# Auch ungetrackte Dateien stashen
git stash -u

# Alle Stashes anzeigen
git stash list

# Stash anwenden
git stash apply

# Neuesten Stash anwenden und löschen
git stash pop

# Bestimmten Stash anwenden
git stash apply stash@{2}
```

### Stash Verwaltung
```bash
# Stash anzeigen
git stash show

# Stash Inhalt detailliert anzeigen
git stash show -p

# Stash löschen
git stash drop stash@{1}

# Alle Stashes löschen
git stash clear

# Stash als Branch erstellen
git stash branch <branch-name>
```

---

## Tags & Releases

### Tags erstellen
```bash
# Leichtgewichtigen Tag erstellen
git tag v1.0.0

# Annotierten Tag erstellen (empfohlen)
git tag -a v1.0.0 -m "Version 1.0.0 release"

# Tag für bestimmten Commit
git tag -a v1.0.0 <commit-hash> -m "Message"

# Alle Tags anzeigen
git tag

# Tags mit Pattern suchen
git tag -l "v1.*"
```

### Tags verwalten
```bash
# Tag Details anzeigen
git show v1.0.0

# Tag löschen
git tag -d v1.0.0

# Remote Tag löschen
git push origin --delete v1.0.0

# Tags pushen
git push origin v1.0.0
git push origin --tags  # Alle Tags
```

---

## Konfliktlösung

### Merge Konflikte verstehen
```
<<<<<<< HEAD
Deine Änderungen
=======
Eingehende Änderungen
>>>>>>> branch-name
```

### Konflikte lösen
```bash
# Konflikte manuell lösen, dann:
git add <resolved-file>
git commit

# Merge-Tool verwenden
git mergetool

# Merge abbrechen
git merge --abort

# Konflikt-Status anzeigen
git status
```

### Rebase Konflikte
```bash
# Rebase fortsetzen nach Konfliktlösung
git rebase --continue

# Rebase abbrechen
git rebase --abort

# Aktuellen Commit während Rebase überspringen
git rebase --skip
```

---

## Git Workflows

### Feature Branch Workflow
```bash
# 1. Neuen Feature Branch erstellen
git checkout -b feature/neue-funktion

# 2. Entwickeln und committen
git add .
git commit -m "feat: add neue funktion"

# 3. Branch pushen
git push -u origin feature/neue-funktion

# 4. Pull Request erstellen (GitHub/GitLab)

# 5. Nach Merge: Branch aufräumen
git checkout main
git pull origin main
git branch -d feature/neue-funktion
```

### Gitflow Workflow
```bash
# Feature starten
git checkout -b feature/neue-funktion develop

# Feature fertigstellen
git checkout develop
git merge --no-ff feature/neue-funktion
git branch -d feature/neue-funktion

# Release vorbereiten
git checkout -b release/1.0.0 develop

# Release abschließen
git checkout main
git merge --no-ff release/1.0.0
git tag -a v1.0.0 -m "Release version 1.0.0"
git checkout develop
git merge --no-ff release/1.0.0
```

---

## Advanced Commands

### Interactive Rebase
```bash
# Letzten 3 Commits interaktiv bearbeiten
git rebase -i HEAD~3

# Rebase auf anderen Branch
git rebase -i main

# Optionen im Interactive Mode:
# pick = Commit verwenden
# reword = Commit verwenden, Message ändern
# edit = Commit verwenden, für Änderungen anhalten
# squash = Commit mit vorherigem zusammenfassen
# drop = Commit löschen
```

### Cherry-Pick
```bash
# Bestimmten Commit auf aktuellen Branch anwenden
git cherry-pick <commit-hash>

# Mehrere Commits cherry-picken
git cherry-pick <commit1> <commit2>

# Cherry-pick ohne Commit (nur staging)
git cherry-pick -n <commit-hash>
```

### Bisect (Bug-Suche)
```bash
# Bisect starten
git bisect start

# Aktuellen Commit als schlecht markieren
git bisect bad

# Guten Commit markieren
git bisect good <commit-hash>

# Git wechselt automatisch zu mittlerem Commit
# Testen und markieren:
git bisect good  # oder git bisect bad

# Bisect beenden
git bisect reset
```

### Submodules
```bash
# Submodule hinzufügen
git submodule add <repository-url> <path>

# Submodules initialisieren
git submodule init

# Submodules aktualisieren
git submodule update

# Repository mit Submodules klonen
git clone --recursive <repository-url>
```

---

## Git Konfiguration

### Globale Konfiguration
```bash
# Benutzerdaten setzen
git config --global user.name "Dein Name"
git config --global user.email "deine@email.com"

# Standard Editor setzen
git config --global core.editor "code --wait"  # VS Code
git config --global core.editor "vim"          # Vim

# Default Branch Name
git config --global init.defaultBranch main

# Automatisches CRLF Handling
git config --global core.autocrlf true   # Windows
git config --global core.autocrlf input  # Linux/Mac
```

### Aliases (Abkürzungen)
```bash
# Nützliche Aliases
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'

# Erweiterte Aliases
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
```

### Konfiguration anzeigen
```bash
# Alle Konfigurationen anzeigen
git config --list

# Bestimmte Konfiguration anzeigen
git config user.name

# Konfiguration bearbeiten
git config --global --edit
```

---

## Troubleshooting

### Häufige Probleme

#### "Your branch is ahead of origin/main"
```bash
# Lösung: Änderungen pushen
git push origin main
```

#### "Your branch is behind origin/main"
```bash
# Lösung: Änderungen pullen
git pull origin main
```

#### "fatal: not a git repository"
```bash
# Lösung: Repository initialisieren oder in richtiges Verzeichnis wechseln
git init
# oder
cd /path/to/your/repository
```

#### Versehentlich falschen Branch gelöscht
```bash
# Reflog anzeigen
git reflog

# Branch wiederherstellen
git checkout -b <branch-name> <commit-hash>
```

#### Push rejected wegen Konflikten
```bash
# Lösung 1: Pull und Merge
git pull origin main
# Konflikte lösen, dann:
git push origin main

# Lösung 2: Pull mit Rebase
git pull --rebase origin main
# Konflikte lösen, dann:
git push origin main
```

### Nützliche Debugging-Befehle
```bash
# Zeigt welcher Commit jede Zeile zuletzt geändert hat
git blame <filename>

# Zeigt Referenz-Log (alle HEAD Bewegungen)
git reflog

# Zeigt was in einem Commit geändert wurde
git show <commit-hash>

# Überprüft Repository Integrität
git fsck

# Bereinigt nicht referenzierte Objekte
git gc

# Repository Statistiken
git count-objects -v
```

---

## 📝 Git Cheat Sheet - Quick Reference

### Essential Commands
```bash
git status              # Repository Status
git add .               # Alle Änderungen stagen
git commit -m "msg"     # Commit erstellen
git push origin main    # Änderungen hochladen
git pull origin main    # Änderungen herunterladen
git branch              # Branches anzeigen
git checkout -b new     # Neuen Branch erstellen
git merge branch-name   # Branch mergen
git log --oneline       # Commit Historie
```

### Emergency Commands
```bash
git stash               # Änderungen temporär speichern
git reset --hard HEAD~1 # Letzten Commit löschen (VORSICHT!)
git revert <commit>     # Commit sicher rückgängig machen
git merge --abort       # Merge abbrechen
git rebase --abort      # Rebase abbrechen
git checkout -- .       # Alle Änderungen verwerfen
```

---

## 🎯 Empfohlene Workflows für DevOps

### Daily Workflow
```bash
# 1. Morgens: Aktuellen Stand holen
git checkout main
git pull origin main

# 2. Feature Branch erstellen
git checkout -b feature/ticket-123

# 3. Entwickeln
git add .
git commit -m "feat: implement new feature"

# 4. Regelmäßig pushen
git push -u origin feature/ticket-123

# 5. Nach Review: Cleanup
git checkout main
git pull origin main
git branch -d feature/ticket-123
```

### Release Workflow
```bash
# 1. Release Branch erstellen
git checkout -b release/v1.2.0 develop

# 2. Version bumpen, testen
git commit -m "chore: bump version to 1.2.0"

# 3. Release mergen
git checkout main
git merge --no-ff release/v1.2.0
git tag -a v1.2.0 -m "Release v1.2.0"

# 4. Zurück zu develop mergen
git checkout develop
git merge --no-ff release/v1.2.0

# 5. Pushen
git push origin main develop --tags
```

---

## 📚 Weiterführende Ressourcen

- [Pro Git Book](https://git-scm.com/book) - Kostenlos online
- [Atlassian Git Tutorials](https://www.atlassian.com/git/tutorials)
- [GitHub Git Handbook](https://guides.github.com/introduction/git-handbook/)
- [Interactive Git Tutorial](https://learngitbranching.js.org/)

---

*Dieses Cheat Sheet wächst mit deiner DevOps-Reise. Speichere es als Referenz und erweitere es nach Bedarf!*

**Letzte Aktualisierung:** Juli 2025  
**Schwierigkeitsgrad:** Einsteiger bis Fortgeschritten  
**Verwendung:** DevOps, Softwareentwicklung, Versionskontrolle
