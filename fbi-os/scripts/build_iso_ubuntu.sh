#!/bin/bash
# Build script for FBI-OS ISO (Ubuntu/Debian compatible)
set -e
WORKDIR="$(pwd)/build"
ISO_NAME="fbi-os.iso"

# Install required packages
sudo apt-get update
sudo apt-get install -y debootstrap squashfs-tools xorriso grub-pc-bin grub-efi-amd64-bin mtools git-lfs feh conky-all

# Bootstrap minimal Ubuntu system
sudo debootstrap --arch=amd64 focal "$WORKDIR/chroot" http://archive.ubuntu.com/ubuntu/

# Copy custom files
cp -r ../assets "$WORKDIR/chroot/root/assets"
cp -r ../config "$WORKDIR/chroot/root/config"

# Chroot and configure system
sudo chroot "$WORKDIR/chroot" /bin/bash <<EOF
apt-get update
apt-get install -y xorg openbox lxterminal pcmanfm tor chromium-browser git-lfs feh conky-all
cp -r /root/assets /usr/share/fbi-os-assets
cp -r /root/config /etc/fbi-os-config
EOF

# Create SquashFS filesystem
sudo mksquashfs "$WORKDIR/chroot" "$WORKDIR/squashfs.img" -e boot

# Set up ISO directory structure
mkdir -p "$WORKDIR/iso/boot/grub"
# Copy kernel and initrd
sudo cp "$WORKDIR/chroot/boot/vmlinuz*" "$WORKDIR/iso/boot/vmlinuz"
sudo cp "$WORKDIR/chroot/boot/initrd.img*" "$WORKDIR/iso/boot/initrd"

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
sudo xorriso -as mkisofs -iso-level 3 -o "$WORKDIR/$ISO_NAME" -b boot/grub/i386-pc/eltorito.img -no-emul-boot -boot-load-size 4 -boot-info-table "$WORKDIR/iso"

# Move ISO to ISO directory
mkdir -p "$(pwd)/../../ISO"
mv "$WORKDIR/$ISO_NAME" "$(pwd)/../../ISO/$ISO_NAME"
echo "ISO build complete: $(pwd)/../../ISO/$ISO_NAME"
