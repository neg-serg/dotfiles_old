function start_mpdstat()
    local fd1 = io.popen("pgrep -f 'dzen2 -dock -bg #000000 -h 19 -tw 0 -x 0 -ta l -w 1000 -p -fn PragmataPro for Powerline:style=bold:size=12'","r")
    local exists = fd1:read("*l")
    fd1:close()
    local fd2 = io.popen("pidof mpd","r")
    local mpd_run = fd2:read("*l")
    fd2:close()
    if (exists ~= nil) and (mpd_run ~= nil) then
        notioncore.exec('lua ~/.notion/mpd_dzen.lua')
    end
end

function start_rofi()
    local colors = ' -fg '..neg.rofi.fg..' -bg '..neg.rofi.bg..' -hlfg '..neg.rofi.hlfg..' -hlbg '..neg.rofi.hlbg..' -bc '..neg.rofi.bc
    notioncore.exec('/usr/bin/rofi ' .. rofi.font ..  
                                        colors .. 
                                        ' -b -disable-history -columns 10 -lines 1 -width '
                                        ..rofi.width..
                                        ' -yoffset -22 -key-run Alt-grave -location 6'
                                        .. rofi.pid
                   )
end

start_rofi()
start_mpdstat()
