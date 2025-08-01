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
# Optimierte Sway Konfiguration
# Basierend auf der Standard-Config mit Verbesserungen

### Variables
set $mod Mod4
set $left h
set $down j
set $up k
set $right l
set $term gnome-terminal
# Verbessertes Menü mit wofi
set $menu wofi --show drun

include /etc/sway/config-vars.d/*

### Output configuration
# Wallpaper
output * bg /usr/share/backgrounds/sway/Sway_Wallpaper_Blue_1920x1080.png fill

# Beispiel für Multi-Monitor Setup (auskommentiert)
# output HDMI-A-1 resolution 1920x1080 position 1920,0
# output eDP-1 resolution 1920x1080 position 0,0

### Idle configuration - Aktiviert für automatisches Sperren
exec swayidle -w \
         timeout 300 'swaylock -f -c 000000' \
         timeout 600 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
         before-sleep 'swaylock -f -c 000000'

### Input configuration
# Touchpad Konfiguration (passen Sie den Namen an Ihr Gerät an)
# Gerätename finden mit: swaymsg -t get_inputs
input type:touchpad {
    dwt enabled
    tap enabled
    natural_scroll enabled
    middle_emulation enabled
    scroll_method two_finger
}

# Tastatur für internationale Zeichen (Umlaute mit AltGr)
input type:keyboard {
    xkb_layout "us"
    xkb_variant "intl"
}

### Key bindings

# Basics:
bindsym $mod+Return exec $term
bindsym $mod+Shift+q kill
bindsym $mod+d exec $menu
floating_modifier $mod normal
bindsym $mod+Shift+c reload
bindsym $mod+Shift+e exec swaynag -t warning -m 'Sway beenden?' -B 'Ja, beenden' 'swaymsg exit'

# Bildschirmsperre
bindsym $mod+Ctrl+l exec swaylock -f -c 000000

# Moving around:
bindsym $mod+$left focus left
bindsym $mod+$down focus down
bindsym $mod+$up focus up
bindsym $mod+$right focus right
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

bindsym $mod+Shift+$left move left
bindsym $mod+Shift+$down move down
bindsym $mod+Shift+$up move up
bindsym $mod+Shift+$right move right
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# Workspaces:
bindsym $mod+1 workspace number 1
bindsym $mod+2 workspace number 2
bindsym $mod+3 workspace number 3
bindsym $mod+4 workspace number 4
bindsym $mod+5 workspace number 5
bindsym $mod+6 workspace number 6
bindsym $mod+7 workspace number 7
bindsym $mod+8 workspace number 8
bindsym $mod+9 workspace number 9
bindsym $mod+0 workspace number 10

bindsym $mod+Shift+1 move container to workspace number 1
bindsym $mod+Shift+2 move container to workspace number 2
bindsym $mod+Shift+3 move container to workspace number 3
bindsym $mod+Shift+4 move container to workspace number 4
bindsym $mod+Shift+5 move container to workspace number 5
bindsym $mod+Shift+6 move container to workspace number 6
bindsym $mod+Shift+7 move container to workspace number 7
bindsym $mod+Shift+8 move container to workspace number 8
bindsym $mod+Shift+9 move container to workspace number 9
bindsym $mod+Shift+0 move container to workspace number 10

# Layout stuff:
bindsym $mod+b splith
bindsym $mod+v splitv
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split
bindsym $mod+f fullscreen
bindsym $mod+Shift+space floating toggle
bindsym $mod+space focus mode_toggle
bindsym $mod+a focus parent

# Scratchpad:
bindsym $mod+Shift+minus move scratchpad
bindsym $mod+minus scratchpad show

# Resizing containers:
mode "resize" {
    bindsym $left resize shrink width 10px
    bindsym $down resize grow height 10px
    bindsym $up resize shrink height 10px
    bindsym $right resize grow width 10px
    bindsym Left resize shrink width 10px
    bindsym Down resize grow height 10px
    bindsym Up resize shrink height 10px
    bindsym Right resize grow width 10px
    bindsym Return mode "default"
    bindsym Escape mode "default"
}
bindsym $mod+r mode "resize"

### Window rules
# Standard floating rules
for_window [window_role="pop-up"] floating enable
for_window [window_role="bubble"] floating enable
for_window [window_role="dialog"] floating enable
for_window [window_type="dialog"] floating enable

### Autostart applications
exec waybar
exec mako

### Status Bar (auskommentiert, da waybar verwendet wird)
# bar {
#     position top
#     status_command while date +'%Y-%m-%d %X'; do sleep 1; done
#     colors {
#         statusline #ffffff
#         background #323232
#         inactive_workspace #32323200 #32323200 #5c5c5c
#     }
# }

include /etc/sway/config.d/*
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