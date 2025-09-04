#!/bin/bash
# Build script for FBI-OS ISO (CentOS compatible)
set -e
WORKDIR="$(pwd)/build"
ISO_NAME="fbi-os.iso"

# Install required packages
sudo dnf install -y epel-release
sudo dnf install -y debootstrap squashfs-tools xorriso grub2-pc mtools git-lfs feh conky

# Bootstrap minimal system (if debootstrap is available)
# CentOS may not have debootstrap by default; consider using mock or a minimal chroot
# For demonstration, we'll use a placeholder for chroot creation
mkdir -p "$WORKDIR/chroot"
# Copy custom files
cp -r ../assets "$WORKDIR/chroot/root/assets"
cp -r ../config "$WORKDIR/chroot/root/config"

# Chroot and configure system (requires manual setup for CentOS)
# You may need to use mock or manually install packages in chroot
# Placeholder for chroot configuration
# ...

# Create SquashFS filesystem
sudo mksquashfs "$WORKDIR/chroot" "$WORKDIR/squashfs.img" -e boot

# Set up ISO directory structure
mkdir -p "$WORKDIR/iso/boot/grub"
# Copy kernel and initrd (paths may differ in CentOS)
# sudo cp "$WORKDIR/chroot/boot/vmlinuz*" "$WORKDIR/iso/boot/vmlinuz"
# sudo cp "$WORKDIR/chroot/boot/initrd*" "$WORKDIR/iso/boot/initrd"

# Create basic GRUB config
cat <<EOT > "$WORKDIR/iso/boot/grub/grub.cfg"
set default=0
set timeout=5
menuentry "FBI-OS" {
    linux /boot/vmlinuz boot=live
    initrd /boot/initrd
}
EOT

# Build the ISO
sudo xorriso -as mkisofs -iso-level 3 -o "$ISO_NAME" -b boot/grub/i386-pc/eltorito.img -no-emul-boot -boot-load-size 4 -boot-info-table "$WORKDIR/iso"

echo "ISO build complete: $WORKDIR/$ISO_NAME"
