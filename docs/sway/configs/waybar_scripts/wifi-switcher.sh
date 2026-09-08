#!/bin/bash
# ~/.config/waybar/scripts/wifi-switcher.sh
# WiFi Network Switcher für Waybar

# Aktuelles Netzwerk
CURRENT=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes' | cut -d':' -f2)

# Scanne verfügbare Netzwerke (ohne Duplikate)
nmcli dev wifi rescan 2>/dev/null
sleep 1

# Liste verfügbare WiFi-Netzwerke mit Signal-Stärke
WIFI_LIST=$(nmcli -f SSID,SIGNAL,SECURITY dev wifi list | tail -n +2 | sort -k2 -rn | awk '
{
    ssid=$1;
    signal=$2;
    security=$3;
    if (ssid != "--" && ssid != "") {
        # Signal-Balken in eckigen Klammern
        bars = int(signal/20);
        if (bars == 5) icon="[████]";
        else if (bars == 4) icon="[███_]";
        else if (bars == 3) icon="[██__]";
        else if (bars == 2) icon="[█___]";
        else icon="[____]";

        # Security in eckigen Klammern
        if (security ~ /WPA/) sec="[SEC]";
        else sec="[---]";

        # Checkmark für aktuelles Netzwerk
        check = (ssid == "'"$CURRENT"'" ? "[✓]" : "[ ]");

        printf "%s %s %3s%% [%s] %s\n", check, icon, signal, ssid, sec;
    }
}' | sort -k5)

# Zeige Auswahl mit wofi
CHOICE=$(echo "$WIFI_LIST" | wofi --dmenu -p "WiFi Network" -i | sed 's/.*\[\(.*\)\].*/\1/')

# Wenn ein Netzwerk ausgewählt wurde
if [ -n "$CHOICE" ]; then
    # Prüfe ob bereits verbunden
    if [ "$CHOICE" = "$CURRENT" ]; then
        notify-send -t 2000 "[NET]" "Bereits verbunden mit: $CHOICE"
        exit 0
    fi

    # Prüfe ob gespeicherte Verbindung existiert
    if nmcli connection show "$CHOICE" &>/dev/null; then
        # Verbinde mit gespeichertem Netzwerk
        nmcli connection up "$CHOICE" && \
            notify-send -t 2000 "[NET]" "Verbunden mit: $CHOICE" || \
            notify-send -t 2000 "[NET]" "Verbindung fehlgeschlagen!"
    else
        # Neues Netzwerk - frage nach Passwort
        foot -e bash -c "
            echo '[NET] Verbinde mit: $CHOICE';
            echo '';
            nmcli device wifi connect '$CHOICE' --ask;
            echo '';
            read -p 'Drücke Enter zum Schließen...'
        "
    fi
fi