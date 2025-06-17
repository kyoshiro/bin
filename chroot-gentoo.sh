#!/bin/bash
mount -t btrfs -o noatime,compress=zstd:1,ssd,discard=async,space_cache=v2,subvol=/root /dev/mapper/luks /mnt/
mount -t btrfs -o noatime,compress=zstd:1,ssd,discard=async,space_cache=v2,subvol=/home /dev/mapper/luks /mnt/home/
mount -t proc /proc /mnt/proc
mount --rbind /sys /mnt/sys
mount --make-rslave /mnt/sys
mount --rbind /dev /mnt/dev
mount --make-rslave /mnt/dev
mount --bind /run /mnt/run
mount --make-slave /mnt/run
cp --dereference /etc/resolv.conf /mnt/etc/
chroot /mnt /bin/bash
