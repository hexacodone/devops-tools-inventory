# Fixing a Proxmox Boot Problem After an Update

## Problem Description

After a Proxmox update from version 12-4 to 12-9, the new version was not available in the GRUB boot menu. The old version 12-4 booted, but the VMs would not start. The new version 12-9 did not appear in the boot options.

## Cause

The problem was caused by a broken GRUB configuration on UEFI systems after the update:

1. **New kernel files present**: The new kernel 6.8.12-9-pve was installed and available in `/boot/`
2. **GRUB configuration outdated**: GRUB had not picked up the new kernel files in the boot configuration
3. **EFI partition not mounted**: The EFI system partition was not permanently mounted, which caused GRUB updates to fail

## Diagnostic Steps

### 1. Use the GRUB command line

Press `c` in the GRUB menu to open the command line:

```bash
# Show available partitions
ls

# Check partition contents
ls (hd0,gpt2)/efi/proxmox/
ls (lvm/pve-root)/boot/
```

### 2. Understand the system layout

Typical Proxmox UEFI configuration:
- `(hd0,gpt1)` = BIOS boot partition (~1MB)
- `(hd0,gpt2)` = EFI system partition (FAT32)
- `(hd0,gpt3)` = ZFS/LVM partition (main system)

## Solution

### Step 1: Manual boot (immediate fix)

Press `c` in the GRUB menu and enter the following commands:

```bash
set root=(lvm/pve-root)
linux /boot/vmlinuz-6.8.12-9-pve root=/dev/pve/root
initrd /boot/initrd.img-6.8.12-9-pve
boot
```

### Step 2: Repair the GRUB configuration

After booting successfully:

```bash
# Regenerate the GRUB configuration
sudo update-grub
```

### Step 3: Mount the EFI partition

```bash
# Mount the EFI partition
sudo mount /dev/sda2 /boot/efi

# Check the mount
ls -la /boot/efi/EFI/proxmox/
```

### Step 4: Install GRUB for UEFI

**Important**: Do not use `grub-install /dev/sda` on UEFI systems!

```bash
# Install GRUB for UEFI
sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=proxmox
```

### Step 5: Make it permanent

```bash
# Determine the UUID of the EFI partition
sudo blkid /dev/sda2

# Edit fstab
sudo nano /etc/fstab

# Add this line (adjust the UUID):
UUID=EBB7-8EB0 /boot/efi vfat defaults 0 0
```

### Step 6: Test the system

```bash
# Reboot
sudo reboot

# Check the kernel version after reboot
uname -r
```

## Avoiding Common Mistakes

### ❌ Wrong commands for UEFI systems
```bash
# Do NOT use this on UEFI:
sudo grub-install /dev/sda
```

### ✅ Correct commands for UEFI systems
```bash
# UEFI-specific installation:
sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=proxmox
```

### ❌ EFI partition not mounted
```bash
# Error: "boot efi doesn't look like an efi partition"
```

### ✅ Mount the EFI partition correctly
```bash
# Mount first, then install GRUB
sudo mount /dev/sda2 /boot/efi
```

## Preventive Measures

1. **Regular backups**: Always create VM backups before updates
2. **Check EFI mount**: Run `mount | grep efi` after updates
3. **GRUB test**: Check the boot menu for available options after updates
4. **Documentation**: Document boot parameters and configuration

## Signs of the Problem

- Old Proxmox version boots, but VMs don't start
- New version does not appear in the GRUB boot menu
- `update-grub` finds the new kernel files
- `grub-install /dev/sda` fails with an EFI error
- EFI partition is not mounted at `/boot/efi`

## Signs of a Successful Fix

- New kernel version visible in the GRUB menu
- `uname -r` shows the new version (6.8.12-9-pve)
- VMs start normally again
- Proxmox web interface shows the correct version
- Automatic booting into the new version works

---

**Note**: This guide applies to Proxmox VE on UEFI systems with an LVM/ZFS configuration. Paths may differ on other configurations.
