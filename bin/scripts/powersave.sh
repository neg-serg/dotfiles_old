if on_ac_power; then
  echo 0 > /proc/sys/vm/laptop_mode
  echo 10 > /proc/sys/vm/dirty_ratio
  echo 5 > /proc/sys/vm/dirty_background_ratio
  echo 6000 > /proc/sys/vm/dirty_writeback_centisecs
  echo 0 > /sys/module/snd_hda_intel/parameters/power_save
  echo max_performance > /sys/class/scsi_host/host0/link_power_management_policy
  echo max_performance > /sys/class/scsi_host/host1/link_power_management_policy
  echo max_performance > /sys/class/scsi_host/host2/link_power_management_policy
  echo max_performance > /sys/class/scsi_host/host3/link_power_management_policy
  echo max_performance > /sys/class/scsi_host/host4/link_power_management_policy
  echo max_performance > /sys/class/scsi_host/host5/link_power_management_policy
  echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 
  modprobe uvcvideo
  echo default > /sys/module/pcie_aspm/parameters/policy
  #setpci -s 00:02.0 F4.B=FF
  hal-disable-polling --enable-polling --device /dev/cdrom
  echo 0 > /sys/devices/system/cpu/sched_mc_power_savings
else
  echo 5 > /proc/sys/vm/laptop_mode
  echo 90 > /proc/sys/vm/dirty_ratio
  echo 1 > /proc/sys/vm/dirty_background_ratio
  echo 60000 > /proc/sys/vm/dirty_writeback_centisecs
  echo 10 > /sys/module/snd_hda_intel/parameters/power_save
  echo min_power > /sys/class/scsi_host/host0/link_power_management_policy
  echo min_power > /sys/class/scsi_host/host1/link_power_management_policy
  echo min_power > /sys/class/scsi_host/host2/link_power_management_policy
  echo min_power > /sys/class/scsi_host/host3/link_power_management_policy
  echo min_power > /sys/class/scsi_host/host4/link_power_management_policy
  echo min_power > /sys/class/scsi_host/host5/link_power_management_policy
  echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 
  echo ondemand > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor 
  modprobe -r uvcvideo
  echo powersave > /sys/module/pcie_aspm/parameters/policy
  #setpci -s 00:02.0 F4.B=40
  hal-disable-polling --device /dev/cdrom
  echo 1 > /sys/devices/system/cpu/sched_mc_power_savings
fi
