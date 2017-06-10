Only the first method works for me

# ac97
    `-soundhw ac97`
    nearly perfect (some glitches)
    driver: http://www.realtek.com.tw/downloads/downloadsCheck.aspx?Langid=1&PNid=14&PFid=23&Level=4&Conn=3&DownTypeID=3&GetDown=false 

# usb pass to vm(?)
    `-device usb-audio and QEMU_AUDIO_TIMER_PERIOD=10`
    better but high CPU, may glitch under heavy load (or after closing program) 

# hda pass to vm(?)
    `device ich9-intel-hda,bus=pcie.0,addr=1b.0,id=sound0 -device hda-duplex,id=sound0-codec0,bus=sound0.0,cad=0`
    audio glitches (even with timer period to 0) 

```
[~/.config/pulse] >> pactl list sinks |& grep -i buff
device.buffering.buffer_size = "1048572"
device.buffering.fragment_size = "524286"
[~/.config/pulse] >> echo $[1048572./(192000*24)]
0.22755468749999999
[~/.config/pulse] >> echo $[524286./(192000*24)]
0.11377734375
```

```
[/mnt/home/torrent/data] >> s zsh -c 'echo 2048 > /sys/class/rtc/rtc0/max_user_freq'
[/mnt/home/torrent/data] >> s zsh -c 'echo 2048 > /proc/sys/dev/hpet/max-user-freq'
```
