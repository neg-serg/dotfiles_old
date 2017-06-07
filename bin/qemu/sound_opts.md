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
