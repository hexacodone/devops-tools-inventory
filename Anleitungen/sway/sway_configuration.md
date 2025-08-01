# Sway Window Manager Setup Guide

This guide covers the complete installation and configuration of Sway on a fresh Ubuntu 24.04 LTS system, including the configuration choices we made and essential keyboard shortcuts.

## Installation Process

### Step 1: System Update
```bash
sudo apt update && sudo apt upgrade -y
```

### Step 2: Install Sway and Essential Components
```bash
# Core Sway components
sudo apt install sway swaylock swayidle swaybg waybar wofi

# Additional useful tools
sudo apt install brightnessctl playerctl grim slurp wl-clipboard mako-notifier
```

**Package explanations:**
- `sway`: The window manager itself
- `swaylock`: Screen locker
- `swayidle`: Idle management (auto-lock, display power management)
- `swaybg`: Background image handler
- `waybar`: Modern status bar
- `wofi`: Application launcher (dmenu replacement)
- `brightnessctl`: Brightness control
- `playerctl`: Media control
- `grim`/`slurp`: Screenshot tools
- `wl-clipboard`: Clipboard utilities
- `mako-notifier`: Notification daemon

### Step 3: Configuration Setup

Create the configuration directory:
```bash
mkdir -p ~/.config/sway
```

Apply our optimized configuration:
```bash
cat > ~/.config/sway/config << 'EOF'
[The complete configuration we created]
EOF
```

## Configuration Choices Made

### Key Design Decisions

**Terminal**: Using `gnome-terminal` instead of foot for consistency with GNOME workflow

**Application Launcher**: Wofi instead of dmenu for a more modern interface

**Keyboard Layout**: US International to support special characters (umlauts) via AltGr combinations:
- `AltGr + q` = ä
- `AltGr + y` = ü
- `AltGr + p` = ö

**Idle Management**: Enabled automatic screen locking after 5 minutes of inactivity

**Touchpad**: Configured with tap-to-click, natural scrolling, and disable-while-typing

**Status Bar**: Waybar instead of the default sway bar for better functionality

## Essential Keyboard Shortcuts

### System Controls
| Shortcut | Action |
|----------|--------|
| `Super + Return` | Open terminal |
| `Super + d` | Open application launcher |
| `Super + Shift + q` | Close focused window |
| `Super + Shift + c` | Reload Sway configuration |
| `Super + Shift + e` | Exit Sway |
| `Super + Ctrl + l` | Lock screen |

### Window Navigation
| Shortcut | Action |
|----------|--------|
| `Super + h/j/k/l` | Focus left/down/up/right |
| `Super + Arrow Keys` | Focus in direction |
| `Super + Shift + h/j/k/l` | Move window left/down/up/right |
| `Super + Shift + Arrow Keys` | Move window in direction |
| `Super + a` | Focus parent container |

### Workspace Management
| Shortcut | Action |
|----------|--------|
| `Super + 1-9,0` | Switch to workspace 1-10 |
| `Super + Shift + 1-9,0` | Move window to workspace 1-10 |

### Window Layout
| Shortcut | Action |
|----------|--------|
| `Super + b` | Split horizontally |
| `Super + v` | Split vertically |
| `Super + s` | Stacking layout |
| `Super + w` | Tabbed layout |
| `Super + e` | Toggle split layout |
| `Super + f` | Toggle fullscreen |
| `Super + Shift + Space` | Toggle floating mode |
| `Super + Space` | Toggle focus between tiling/floating |

### Resizing Windows
| Shortcut | Action |
|----------|--------|
| `Super + r` | Enter resize mode |
| `h/j/k/l` or `Arrow Keys` | Resize in resize mode |
| `Return` or `Escape` | Exit resize mode |

### Scratchpad (Hidden Windows)
| Shortcut | Action |
|----------|--------|
| `Super + Shift + -` | Move window to scratchpad |
| `Super + -` | Show/hide scratchpad window |

## Useful Text Selection Shortcuts

These work in most applications within Sway:

### Basic Text Navigation
| Shortcut | Action |
|----------|--------|
| `Ctrl + a` | Select all |
| `Ctrl + c` | Copy |
| `Ctrl + v` | Paste |
| `Ctrl + x` | Cut |
| `Ctrl + z` | Undo |
| `Ctrl + y` | Redo |

### Advanced Text Selection
| Shortcut | Action |
|----------|--------|
| `Shift + Home` | Select to beginning of line |
| `Shift + End` | Select to end of line |
| `Ctrl + Shift + Left/Right` | Select word by word |
| `Ctrl + Shift + Home` | Select to beginning of document |
| `Ctrl + Shift + End` | Select to end of document |
| `Shift + Page Up/Down` | Select page by page |

### Terminal-Specific (in gnome-terminal)
| Shortcut | Action |
|----------|--------|
| `Ctrl + Shift + c` | Copy (in terminal) |
| `Ctrl + Shift + v` | Paste (in terminal) |
| `Ctrl + Shift + t` | New tab |
| `Ctrl + Shift + w` | Close tab |
| `Ctrl + Page Up/Down` | Switch tabs |

## Monitor/Display Management

### Basic Display Commands
```bash
# List all outputs
swaymsg -t get_outputs

# Example multi-monitor setup (add to config)
output HDMI-A-1 resolution 1920x1080 position 1920,0
output eDP-1 resolution 1920x1080 position 0,0
```

### Moving Windows Between Displays
| Shortcut | Action |
|----------|--------|
| `Super + Shift + h/l` | Move window to left/right display |

Note: For more complex multi-monitor setups, configure specific output arrangements in the Sway config file.

## Quality of Life Features Enabled

- **Automatic screen locking** after 5 minutes
- **Display power management** (turns off after 10 minutes)
- **Touchpad gestures** (tap-to-click, natural scrolling)
- **Floating dialogs** (popup windows automatically float)
- **International character support** (umlauts via AltGr)
- **Modern application launcher** (wofi with app search)
- **Notification system** (mako for desktop notifications)

## Troubleshooting

### Check Sway logs
```bash
journalctl --user -u sway
```

### Validate configuration
```bash
sway -C ~/.config/sway/config
```

### Start Sway with debug output
```bash
sway -d 2>&1 | tee sway.log
```

## Starting Sway

### From login manager
Select "Sway" as your session type at the login screen.

### From console
```bash
# Switch to TTY (Ctrl+Alt+F3)
# Login and run:
sway
```

This setup provides a solid foundation for a productive Sway workflow while maintaining simplicity and reliability.