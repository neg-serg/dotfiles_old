#!/bin/bash
# nouveau -> nvidia

/usr/bin/sudo /bin/sed  -i 's/options nouveau modeset=1/#options nouveau modeset=1/' /etc/modprobe.d/modprobe.conf
/usr/bin/sudo /bin/sed -i 's/MODULES="nouveau"/#MODULES="nouveau"/' /etc/mkinitcpio.conf

/usr/bin/sudo /usr/bin/pacman -Rdds --noconfirm nouveau-dri xf86-video-nouveau libgl
/usr/bin/sudo /usr/bin/pacman -S --noconfirm nvidia-173xx{,-utils}

#/usr/bin/sudo /bin/rm /etc/X11/xorg.conf.d/{10-monitor,20-nouveau}.conf

/usr/bin/sudo /sbin/mkinitcpio -p linux
