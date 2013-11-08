#!/bin/bash
# nvidia -> nouveau

/usr/bin/sudo /bin/sed -i 's/#*options nouveau modeset=1/options nouveau modeset=1/' /etc/modprobe.d/modprobe.conf
/usr/bin/sudo /bin/sed -i 's/#*MODULES="nouveau"/MODULES="nouveau"/' /etc/mkinitcpio.conf

/usr/bin/sudo /usr/bin/pacman -Rdds --noconfirm nvidia-173xx{,-utils}
/usr/bin/sudo /usr/bin/pacman -S --noconfirm nouveau-dri xf86-video-nouveau

#/usr/bin/sudo /bin/cp {10-monitor,20-nouveau}.conf /etc/X11/xorg.conf.d/

/usr/bin/sudo /sbin/mkinitcpio -p linux
