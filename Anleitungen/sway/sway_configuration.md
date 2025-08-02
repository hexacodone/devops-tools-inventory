# Sway Window Manager Setup Guide

This guide covers the complete installation and configuration of Sway on a fresh Ubuntu 24.04 LTS system, based on an actual working configuration with a custom color scheme and optimized layout.

## Installation Process

### Step 1: System Update
```bash
sudo apt update && sudo apt upgrade -y
```

### Step 2: Install Sway and Essential Components
```bash
# Core Sway components
sudo apt install sway swaylock swayidle waybar

# Terminal and launcher
sudo apt install foot bemenu

# Screenshot tools
sudo apt install grim slurp wl-clipboard
```

**Package explanations:**
- `sway`: The window manager itself
- `swaylock`: Screen locker
- `swayidle`: Idle management (auto-lock, display power management)
- `waybar`: Modern status bar
- `foot`: Lightweight Wayland terminal
- `bemenu`: Simple application launcher
- `grim`/`slurp`: Screenshot tools
- `wl-clipboard`: Clipboard utilities

### Step 3: Configuration Setup

Create the configuration directories:
```bash
mkdir -p ~/.config/sway
mkdir -p ~/.config/waybar
```

## Sway Configuration

Create the main Sway configuration file:
```bash
cat > ~/.config/sway/config << 'EOF'
# Optimierte Sway Konfiguration mit neuer Farbpalette
# Farbpalette: #FFC4EB (Rosa), #197278 (Teal), #89CE94 (Grün), #2B2D42 (Dunkelblau), #000000 (Schwarz)

### Variables
set $mod Mod4
set $left h
set $down j
set $up k
set $right l
set $term foot
set $menu bemenu-run

include /etc/sway/config-vars.d/*

### Output configuration
output * bg #2B2D42 solid_color

### Idle configuration
exec swayidle -w \
         timeout 300 'swaylock -f -c 2B2D42' \
         timeout 600 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
         before-sleep 'swaylock -f -c 2B2D42'

### Input configuration
input type:touchpad {
    dwt enabled
    tap enabled
    natural_scroll enabled
    middle_emulation enabled
    scroll_method two_finger
}

input type:keyboard {
    xkb_layout "us"
    xkb_variant "intl"
}

### Key bindings
bindsym $mod+Return exec $term
bindsym $mod+Shift+q kill
bindsym $mod+d exec $menu
floating_modifier $mod normal
bindsym $mod+Shift+c reload
bindsym $mod+Shift+e exec swaynag -t warning -m 'Sway beenden?' -B 'Ja, beenden' 'swaymsg exit'
bindsym $mod+Ctrl+l exec swaylock -f -c 2B2D42

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
for_window [window_role="pop-up"] floating enable
for_window [window_role="bubble"] floating enable
for_window [window_role="dialog"] floating enable
for_window [window_type="dialog"] floating enable

### Fenster-Styling mit neuer Farbpalette
default_border pixel 2
default_floating_border pixel 2
gaps inner 5
gaps outer 2

# Fensterfarben basierend auf der Farbpalette
client.focused          #197278 #197278 #ffffff #000000 #197278
client.focused_inactive #2B2D42 #2B2D42 #89CE94 #2B2D42 #2B2D42
client.unfocused        #000000 #000000 #89CE94 #000000 #000000
client.urgent           #FFC4EB #FFC4EB #000000 #FFC4EB #FFC4EB
client.placeholder      #2B2D42 #2B2D42 #89CE94 #2B2D42 #2B2D42
client.background       #2B2D42

### Autostart applications
exec waybar

# Screenshot shortcuts
bindsym Print exec grim ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png
bindsym Shift+Print exec grim -g "$(slurp)" ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png
bindsym Ctrl+Print exec grim -g "$(slurp)" - | wl-copy

include /etc/sway/config.d/*
EOF
```

## Waybar Configuration

Create the Waybar configuration file:
```bash
cat > ~/.config/waybar/config << 'EOF'
{
    "layer": "top",
    "position": "bottom",
    "height": 35,
    "spacing": 4,
    
    "modules-left": [
        "sway/workspaces", 
        "sway/mode"
    ],
    "modules-center": [
        "sway/window"
    ],
    "modules-right": [
        "pulseaudio",
        "network", 
        "cpu", 
        "memory", 
        "battery", 
        "clock"
    ],
    
    "sway/workspaces": {
        "disable-scroll": true,
        "all-outputs": true,
        "format": "{name}",
        "format-icons": {
            "urgent": "",
            "focused": "",
            "default": ""
        }
    },
    
    "sway/window": {
        "format": "{}",
        "max-length": 50
    },

    "clock": {
        "format": "{:%H:%M}",
        "format-alt": "{:%A, %d. %B %Y}",
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
        "calendar": {
            "mode": "month",
            "mode-mon-col": 3,
            "weeks-pos": "right",
            "on-scroll": 1,
            "on-click-right": "mode",
            "format": {
                "months": "<span color='#FFC4EB'><b>{}</b></span>",
                "days": "<span color='#89CE94'><b>{}</b></span>",
                "weeks": "<span color='#197278'><b>W{}</b></span>",
                "weekdays": "<span color='#FFC4EB'><b>{}</b></span>",
                "today": "<span color='#000000' background='#FFC4EB'><b><u>{}</u></b></span>"
            }
        },
        "actions": {
            "on-click-right": "mode",
            "on-scroll-up": "shift_up",
            "on-scroll-down": "shift_down"
        }
    },
    
    "battery": {
        "states": {
            "good": 95,
            "warning": 30,
            "critical": 15
        },
        "format": "{capacity}% [BAT]",
        "format-charging": "{capacity}% [CHG]",
        "format-plugged": "{capacity}% [AC]",
        "format-alt": "{time} [BAT]",
        "interval": 30
    },

    "network": {
        "format-wifi": "{essid} ({signalStrength}%) [WIFI]",
        "format-ethernet": "{ipaddr}/{cidr} [ETH]",
        "format-linked": "{ifname} (No IP) [LINK]",
        "format-disconnected": "Disconnected [OFF]",
        "format-alt": "{ifname}: {ipaddr}/{cidr}",
        "interval": 10
    },

    "pulseaudio": {
        "scroll-step": 1,
        "format": "{volume}% [VOL]",
        "format-bluetooth": "{volume}% [BT]",
        "format-bluetooth-muted": "MUTE [BT]",
        "format-muted": "MUTE [VOL]",
        "on-click-right": "pactl set-sink-mute @DEFAULT_SINK@ toggle"
    },

    "cpu": {
        "format": "{usage}% [CPU]",
        "tooltip": true,
        "interval": 5
    },

    "memory": {
        "format": "{}% [RAM]",
        "tooltip-format": "RAM: {used:0.1f}G/{total:0.1f}G",
        "interval": 5
    }
}
EOF
```

Create the Waybar style file:
```bash
cat > ~/.config/waybar/style.css << 'EOF'
/* Waybar Style - Neue Farbpalette */
/* Farben: #FFC4EB (Rosa), #197278 (Teal), #89CE94 (Grün), #2B2D42 (Dunkelblau), #000000 (Schwarz) */

* {
    border: none;
    border-radius: 0;
    font-family: "Source Code Pro", "Font Awesome 6 Free";
    font-size: 13px;
    min-height: 0;
}

window#waybar {
    background-color: #2B2D42;
    border-bottom: 3px solid #197278;
    color: #ffffff;
}

window#waybar.hidden {
    opacity: 0.2;
}

/* Workspaces */
#workspaces {
    margin: 0 4px;
}

#workspaces button {
    padding: 0 5px;
    background-color: transparent;
    color: #89CE94;
    border-bottom: 3px solid transparent;
}

#workspaces button:hover {
    background: rgba(25, 114, 120, 0.3);
    box-shadow: inset 0 -3px #FFC4EB;
}

#workspaces button.focused {
    background-color: #197278;
    border-bottom: 3px solid #FFC4EB;
    color: #ffffff;
}

#workspaces button.urgent {
    background-color: #FFC4EB;
    color: #000000;
}

/* Window title */
#window {
    margin: 0 4px;
    font-weight: bold;
    color: #89CE94;
}

/* Mode indicator */
#mode {
    background-color: #197278;
    border-bottom: 3px solid #FFC4EB;
    margin: 0 4px;
    padding: 0 8px;
    color: #ffffff;
}

/* Right side modules */
#clock,
#battery,
#cpu,
#memory,
#network,
#pulseaudio {
    padding: 0 10px;
    margin: 0 2px;
    color: #ffffff;
}

/* Individual module styling */
#clock {
    background-color: #197278;
    font-weight: bold;
    color: #ffffff;
}

#battery {
    background-color: #89CE94;
    color: #000000;
}

#battery.charging, #battery.plugged {
    background-color: #197278;
    color: #ffffff;
}

@keyframes blink {
    to {
        background-color: #FFC4EB;
        color: #000000;
    }
}

#battery.critical:not(.charging) {
    background-color: #FFC4EB;
    color: #000000;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

#cpu {
    background-color: #89CE94;
    color: #000000;
}

#memory {
    background-color: #FFC4EB;
    color: #000000;
}

#network {
    background-color: #197278;
    color: #ffffff;
}

#network.disconnected {
    background-color: #000000;
    color: #FFC4EB;
}

#pulseaudio {
    background-color: #2B2D42;
    color: #89CE94;
    border: 1px solid #197278;
}

#pulseaudio.muted {
    background-color: #000000;
    color: #89CE94;
}

/* Tooltips */
tooltip {
    background: #2B2D42;
    border: 1px solid #197278;
    border-radius: 5px;
}

tooltip label {
    color: #89CE94;
}
EOF
```

## Configuration Choices Made

### Key Design Decisions

**Color Scheme**: Custom 5-color palette:
- **#FFC4EB** (Pink) - Accents and urgent states
- **#197278** (Teal) - Primary highlights and focused elements
- **#89CE94** (Green) - Secondary text and indicators
- **#2B2D42** (Dark Blue) - Main background
- **#000000** (Black) - Window borders and contrast elements

**Terminal**: `foot` - Lightweight, fast Wayland-native terminal

**Application Launcher**: `bemenu-run` - Simple and minimal launcher

**Background**: Solid color (#2B2D42) instead of wallpaper for clean aesthetics

**Status Bar**: Waybar positioned at the bottom with system monitoring modules

**Window Styling**: 2px colored borders with 5px inner gaps and 2px outer gaps

**Keyboard Layout**: US International to support special characters (umlauts) via AltGr combinations

**Idle Management**: Screen lock after 5 minutes, display power off after 10 minutes

**Removed Features**: Scratchpad bindings, notification daemon (mako), background images, and unused tools

## Essential Keyboard Shortcuts

### System Controls
| Shortcut | Action |
|----------|--------|
| `Super + Return` | Open terminal (foot) |
| `Super + d` | Open application launcher (bemenu) |
| `Super + Shift + q` | Close focused window |
| `Super + Shift + c` | Reload Sway configuration |
| `Super + Shift + e` | Exit Sway |
| `Super + Ctrl + l` | Lock screen |

### Screenshot Controls
| Shortcut | Action |
|----------|--------|
| `Print` | Full screen screenshot |
| `Shift + Print` | Area selection screenshot |
| `Ctrl + Print` | Area selection to clipboard |

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

## Monitor/Display Management

### Basic Display Commands
```bash
# List all outputs
swaymsg -t get_outputs

# Example multi-monitor setup (add to config)
output HDMI-A-1 resolution 1920x1080 position 1920,0
output eDP-1 resolution 1920x1080 position 0,0
```

## Status Bar Features

The Waybar configuration includes:
- **Workspaces**: Visual workspace indicator with color-coded states
- **Window Title**: Current focused window name (center)
- **System Monitoring**: CPU usage, RAM usage, network status
- **Audio Control**: Volume display with mute toggle (right-click)
- **Battery**: Charging status with critical battery animation
- **Clock**: Time display with interactive calendar tooltip

## Quality of Life Features

- **Custom color scheme** with consistent theming across all components
- **Automatic screen locking** after 5 minutes of inactivity
- **Display power management** (turns off after 10 minutes)
- **Touchpad gestures** (tap-to-click, natural scrolling, disable-while-typing)
- **Floating dialogs** (popup windows automatically float)
- **International character support** (umlauts via AltGr combinations)
- **Screenshot functionality** with area selection and clipboard support
- **Window gaps and borders** for visual separation
- **Bottom status bar** with comprehensive system information

## Troubleshooting

### Check Sway logs
```bash
journalctl --user -f
```

### Validate configuration
```bash
sway -C ~/.config/sway/config
```

### Restart Waybar
```bash
pkill waybar && waybar &
```

### Check screenshot directory
```bash
ls -la ~/Pictures/screenshot*
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

This configuration provides a clean, efficient workspace with a cohesive color scheme and streamlined functionality focused on productivity without unnecessary bloat.