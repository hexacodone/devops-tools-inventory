# Complete Zsh Setup Guide - Tested on Ubuntu 24.04

> **Tested on:** Tuxedo Infinity Book 15 with Ubuntu 24.04  
> **Install time:** ~15 minutes  
> **Result:** Professional shell with interactive search, autosuggestions, and a modern theme

## Overview of the Final Installation

After following this guide, you will have:
- ✅ Zsh as the default shell
- ✅ Oh My Zsh framework
- ✅ Powerlevel10k theme (modern and fast)
- ✅ Interactive history search with fzf (Ctrl+R)
- ✅ Intelligent autosuggestions
- ✅ Syntax highlighting for commands
- ✅ 50,000 history entries with duplicate cleanup

---

## 1. Base Installation

```bash
# Update the system
sudo apt update

# Install zsh and curl
sudo apt install zsh curl

# Set zsh as the default shell (IMPORTANT: use usermod!)
sudo usermod -s /usr/bin/zsh $USER

# Log out completely (not just closing the terminal!)
gnome-session-quit --logout --no-prompt
```

**After logging back in, you should automatically be in zsh.**

---

## 2. Install the Oh My Zsh Framework

```bash
# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# If asked whether to change the shell: enter Y
```

---

## 3. Install the Powerlevel10k Theme

```bash
# Download Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

---

## 4. Interactive History Search with fzf

```bash
# Install fzf
sudo apt install fzf

# Enable fzf for zsh
echo 'source /usr/share/doc/fzf/examples/key-bindings.zsh' >> ~/.zshrc
echo 'source /usr/share/doc/fzf/examples/completion.zsh' >> ~/.zshrc
```

---

## 5. Install Zsh Plugins

```bash
# Autosuggestions (grey suggestions while typing)
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Syntax highlighting (colored commands)
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

---

## 6. .zshrc Configuration

**Create a backup of your current .zshrc:**
```bash
cp ~/.zshrc ~/.zshrc.backup
```

**Edit .zshrc:**
```bash
nano ~/.zshrc
```

**Change these important lines:**

1. **Change the theme** (around line 15):
```bash
# From:
ZSH_THEME="robbyrussell"
# To:
ZSH_THEME="powerlevel10k/powerlevel10k"
```

2. **Extend the plugins** (around line 73):
```bash
# From:
plugins=(git)
# To:
plugins=(git sudo web-search copypath history fzf zsh-autosuggestions zsh-syntax-highlighting)
```

3. **Add at the end of the file:**
```bash
# History configuration - extended
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

# Useful aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias cls='clear'
alias h='history'
alias hg='history | grep'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gco='git checkout'

# System aliases
alias update='sudo apt update && sudo apt upgrade'
alias install='sudo apt install'

# fzf tweaks
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_T_OPTS="--preview 'cat {}'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap"
```

---

## 7. Activate the Configuration

```bash
# Load the new configuration
source ~/.zshrc
```

**On first load, the Powerlevel10k configuration wizard starts automatically!**

---

## 8. Configure the Powerlevel10k Theme

The wizard will ask you about:
- **Font:** Choose a Nerd Font for the best display
- **Prompt style:** "Lean" is recommended for a modern look
- **Colors:** Choose to your taste
- **Icons:** "Yes" for better visualization
- **Time:** "24h" for the European format
- **Separator:** "Slanted" or "Round" look modern
- **Prompt height:** "Two lines" for better overview

**If you want to run the wizard again:**
```bash
p10k configure
```

---

## 9. Additional Useful Tools (Optional)

```bash
# Modern alternatives to standard tools
sudo apt install htop tree

# For an even better experience (optional):
sudo apt install bat exa ripgrep
```

**If installed, add these aliases to .zshrc:**
```bash
alias cat='batcat'    # Syntax highlighting for cat
alias ls='exa --icons' # Modern ls alternative
alias grep='rg'       # Faster grep alternative
```

---

## 10. Test the Installation

**Check that everything works:**

```bash
# 1. Check the shell
echo $SHELL
# Should show: /usr/bin/zsh

# 2. Test the plugins
ls ~/.oh-my-zsh/custom/plugins/
# Should show: zsh-autosuggestions zsh-syntax-highlighting

# 3. Check the theme
ls ~/.oh-my-zsh/custom/themes/
# Should show: powerlevel10k

# 4. Test the features:
# - Type 'ls' → you should see grey autosuggestions
# - Press Ctrl+R → you should see interactive history search
# - Commands should be syntax-highlighted
```

---

## 11. Important Keyboard Shortcuts

After installation, you have access to:

| Shortcut | Function |
|----------|----------|
| **Ctrl + R** | Interactive history search with fzf |
| **Ctrl + T** | File search in the current directory |
| **Alt + C** | Directory switching with fzf |
| **Tab** | Advanced tab completion |
| **→** (right arrow) | Accept the autosuggestion |
| **Ctrl + →** | Accept one word of the autosuggestion |

---

## 12. Troubleshooting

### Problem: chsh doesn't work
```bash
# Solution: use usermod instead of chsh
sudo usermod -s /usr/bin/zsh $USER
```

### Problem: shell doesn't change permanently
```bash
# Full logout required:
gnome-session-quit --logout --no-prompt
# NOT just closing the terminal!
```

### Problem: fzf Ctrl+R shows the old "bck-i-search"
```bash
# Reload the fzf key bindings:
source /usr/share/doc/fzf/examples/key-bindings.zsh
```

### Problem: autosuggestions don't work
```bash
# Check the plugin installation:
ls ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
# If empty: reinstall the plugin
```

---

## 13. Final File Structure

After a successful installation, you will have the following files:

```
~/.zshrc              # Main configuration (~5KB)
~/.p10k.zsh           # Theme configuration (~90KB)  
~/.zsh_history        # History file (grows automatically)
~/.zshrc.backup       # Backup of the original .zshrc
~/.oh-my-zsh/         # Oh My Zsh framework
├── custom/
│   ├── plugins/
│   │   ├── zsh-autosuggestions/
│   │   └── zsh-syntax-highlighting/
│   └── themes/
│       └── powerlevel10k/
```

---

## 14. Maintenance and Updates

```bash
# Update Oh My Zsh
omz update

# Update Powerlevel10k  
git -C ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k pull

# Reconfigure the theme
p10k configure
```

---

## ✅ Success!

You now have a professional zsh environment with:
- **Modern look** thanks to Powerlevel10k
- **Intelligent search** thanks to fzf (Ctrl+R)
- **Autosuggestions** for faster typing
- **Syntax highlighting** for better readability
- **Extended history** with 50,000 entries

**Estimated install time:** 10-15 minutes  
**Tested on:** Ubuntu 24.04, Tuxedo Infinity Book 15

---

*This guide is based on a successful installation and covers all the steps needed for a complete zsh setup.*
