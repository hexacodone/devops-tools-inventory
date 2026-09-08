#!/bin/bash
# ~/.config/waybar/scripts/audio-input-switcher.sh
# Audio Input Switcher für Waybar

# Alle verfügbaren Sources (ohne Monitor-Devices)
SOURCES=$(pactl list short sources | grep -v monitor | awk '{print $2}')

# Aktuelle Default Source
CURRENT=$(pactl get-default-source)

# Schöne Namen für die Anzeige erstellen
SOURCE_LIST=""
while IFS= read -r source; do
    # Beschreibung holen
    DESC=$(pactl list sources | grep -A 10 "Name: $source" | grep "Description:" | cut -d':' -f2 | xargs)
    [ -z "$DESC" ] && DESC="$source"

    # Markiere aktuelles Device
    if [ "$source" = "$CURRENT" ]; then
        SOURCE_LIST="${SOURCE_LIST}✓ ${DESC}\n"
    else
        SOURCE_LIST="${SOURCE_LIST}  ${DESC}\n"
    fi
done <<< "$SOURCES"

# Zeige Auswahl mit wofi
CHOICE=$(echo -e "$SOURCE_LIST" | wofi --dmenu -p "Audio Input" -i)

# Wenn etwas ausgewählt wurde
if [ -n "$CHOICE" ]; then
    # Entferne das ✓ oder Leerzeichen am Anfang
    CHOICE=$(echo "$CHOICE" | sed 's/^[✓ ]*//')

    # Finde den passenden Source-Namen
    SELECTED_SOURCE=$(pactl list sources | grep -B 5 "Description: $CHOICE" | grep "Name:" | cut -d':' -f2 | xargs)

    # Setze als Default
    if [ -n "$SELECTED_SOURCE" ]; then
        pactl set-default-source "$SELECTED_SOURCE"

        # Verschiebe alle laufenden Recording-Streams
        pactl list short source-outputs | awk '{print $1}' | while read -r stream; do
            pactl move-source-output "$stream" "$SELECTED_SOURCE" 2>/dev/null
        done

        notify-send -t 2000 "[INPUT]" "Gewechselt zu: $CHOICE"
    fi
fi