#!/bin/sh
/sbin/kexec -l /boot/$KERNEL --append="$KERNELPARAMTERS" --initrd=/boot/$INITRD; sync; /sbin/kexec -e
