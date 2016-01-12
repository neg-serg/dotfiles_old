function start_rofi()
    local colors = ' -fg '..neg.rofi.fg..' -bg '..neg.rofi.bg..' -hlfg '..neg.rofi.hlfg..' -hlbg '..neg.rofi.hlbg..' -bc '..neg.rofi.bc
    notioncore.exec('/usr/bin/rofi ' .. rofi.font() ..  
                                        colors .. 
                                        ' -b -disable-history -columns 10 -lines 1 -width '
                                        ..rofi.width..
                                        ' -yoffset -22 -key-run Alt-grave -location 6'
                                        .. rofi.pid
                   )
end
start_rofi()
