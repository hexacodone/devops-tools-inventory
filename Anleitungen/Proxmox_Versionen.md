# Proxmox Boot-Problem nach Update beheben

## Problem-Beschreibung

Nach einem Proxmox-Update von Version 12-4 auf 12-9 war die neue Version nicht im GRUB-Boot-Menü verfügbar. Die alte Version 12-4 bootete zwar, aber die VMs starteten nicht. Die neue Version 12-9 erschien nicht in den Boot-Optionen.

## Ursache

Das Problem lag an einer fehlerhaften GRUB-Konfiguration bei UEFI-Systemen nach dem Update:

1. **Neue Kernel-Dateien vorhanden**: Der neue Kernel 6.8.12-9-pve war installiert und in `/boot/` verfügbar
2. **GRUB-Konfiguration veraltet**: GRUB hatte die neuen Kernel-Dateien nicht in der Boot-Konfiguration erfasst
3. **EFI-Partition nicht gemountet**: Die EFI-System-Partition war nicht permanent gemountet, wodurch GRUB-Updates fehlschlugen

## Diagnose-Schritte

### 1. GRUB-Kommandozeile nutzen

Im GRUB-Menü `c` drücken für die Kommandozeile:

```bash
# Verfügbare Partitionen anzeigen
ls

# Partition-Inhalte prüfen
ls (hd0,gpt2)/efi/proxmox/
ls (lvm/pve-root)/boot/
```

### 2. System-Layout verstehen

Typische Proxmox UEFI-Konfiguration:
- `(hd0,gpt1)` = BIOS Boot Partition (~1MB)
- `(hd0,gpt2)` = EFI System Partition (FAT32)
- `(hd0,gpt3)` = ZFS/LVM Partition (Hauptsystem)

## Lösung

### Schritt 1: Manueller Boot (Sofortlösung)

Im GRUB-Menü `c` drücken und folgende Befehle eingeben:

```bash
set root=(lvm/pve-root)
linux /boot/vmlinuz-6.8.12-9-pve root=/dev/pve/root
initrd /boot/initrd.img-6.8.12-9-pve
boot
```

### Schritt 2: GRUB-Konfiguration reparieren

Nach dem erfolgreichen Boot:

```bash
# GRUB-Konfiguration neu generieren
sudo update-grub
```

### Schritt 3: EFI-Partition mounten

```bash
# EFI-Partition mounten
sudo mount /dev/sda2 /boot/efi

# Mount prüfen
ls -la /boot/efi/EFI/proxmox/
```

### Schritt 4: GRUB für UEFI installieren

**Wichtig**: Bei UEFI-Systemen nicht `grub-install /dev/sda` verwenden!

```bash
# GRUB für UEFI installieren
sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=proxmox
```

### Schritt 5: Permanent konfigurieren

```bash
# UUID der EFI-Partition ermitteln
sudo blkid /dev/sda2

# fstab bearbeiten
sudo nano /etc/fstab

# Diese Zeile hinzufügen (UUID anpassen):
UUID=EBB7-8EB0 /boot/efi vfat defaults 0 0
```

### Schritt 6: System testen

```bash
# Reboot durchführen
sudo reboot

# Nach dem Reboot Kernel-Version prüfen
uname -r
```

## Häufige Fehler vermeiden

### ❌ Falsche Befehle für UEFI-Systeme
```bash
# NICHT verwenden bei UEFI:
sudo grub-install /dev/sda
```

### ✅ Richtige Befehle für UEFI-Systeme
```bash
# UEFI-spezifische Installation:
sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=proxmox
```

### ❌ EFI-Partition nicht gemountet
```bash
# Fehler: "boot efi doesn't look like an efi partition"
```

### ✅ EFI-Partition korrekt mounten
```bash
# Erst mounten, dann GRUB installieren
sudo mount /dev/sda2 /boot/efi
```

## Präventive Maßnahmen

1. **Regelmäßige Backups**: Vor Updates immer VM-Backups erstellen
2. **EFI-Mount prüfen**: Nach Updates `mount | grep efi` prüfen
3. **GRUB-Test**: Nach Updates Boot-Menü auf verfügbare Optionen prüfen
4. **Dokumentation**: Boot-Parameter und Konfiguration dokumentieren

## Erkennungsmerkmale des Problems

- Alte Proxmox-Version bootet, aber VMs starten nicht
- Neue Version erscheint nicht im GRUB-Boot-Menü
- `update-grub` findet neue Kernel-Dateien
- `grub-install /dev/sda` schlägt mit EFI-Fehler fehl
- EFI-Partition ist nicht in `/boot/efi` gemountet

## Erfolgreiche Lösung erkennbar durch

- Neue Kernel-Version im GRUB-Menü sichtbar
- `uname -r` zeigt neue Version (6.8.12-9-pve)
- VMs starten wieder normal
- Proxmox Web-Interface zeigt korrekte Version an
- Automatisches Booten in neue Version funktioniert

---

**Hinweis**: Diese Anleitung gilt für Proxmox VE auf UEFI-Systemen mit LVM/ZFS-Konfiguration. Bei anderen Konfigurationen können die Pfade abweichen.
