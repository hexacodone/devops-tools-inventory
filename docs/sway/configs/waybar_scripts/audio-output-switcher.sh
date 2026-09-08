#!/bin/bash
# ~/.config/waybar/scripts/audio-output-switcher.sh
# Audio Output Switcher für Waybar

# Alle verfügbaren Sinks auflisten (ohne Monitor-Devices)
SINKS=$(pactl list short sinks | awk '{print $2}')

# Aktuelle Default Sink
CURRENT=$(pactl get-default-sink)

# Schöne Namen für die Anzeige erstellen
SINK_LIST=""
while IFS= read -r sink; do
    # Beschreibung holen
    DESC=$(pactl list sinks | grep -A 10 "Name: $sink" | grep "Description:" | cut -d':' -f2 | xargs)
    [ -z "$DESC" ] && DESC="$sink"

    # Markiere aktuelles Device
    if [ "$sink" = "$CURRENT" ]; then
        SINK_LIST="${SINK_LIST}✓ ${DESC}\n"
    else
        SINK_LIST="${SINK_LIST}  ${DESC}\n"
    fi
done <<< "$SINKS"

# Zeige Auswahl mit wofi
CHOICE=$(echo -e "$SINK_LIST" | wofi --dmenu -p "Audio Output" -i)

# Wenn etwas ausgewählt wurde
if [ -n "$CHOICE" ]; then
    # Entferne das ✓ oder Leerzeichen am Anfang
    CHOICE=$(echo "$CHOICE" | sed 's/^[✓ ]*//')

    # Finde den passenden Sink-Namen
    SELECTED_SINK=$(pactl list sinks | grep -B 5 "Description: $CHOICE" | grep "Name:" | cut -d':' -f2 | xargs)

    # Setze als Default
    if [ -n "$SELECTED_SINK" ]; then
        pactl set-default-sink "$SELECTED_SINK"

        # Verschiebe alle laufenden Streams zum neuen Output
        pactl list short sink-inputs | awk '{print $1}' | while read -r stream; do
            pactl move-sink-input "$stream" "$SELECTED_SINK" 2>/dev/null
        done

        notify-send -t 2000 "[OUTPUT]" "Gewechselt zu: $CHOICE"
    fi
fi