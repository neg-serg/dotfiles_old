function start_mpdstat()
    local fd = io.popen("pgrep -f 'dzen2 -dock -bg #000000 -h 19 -tw 0 -x 0 -ta l -w 1000 -p -fn PragmataPro for Powerline:style=bold:size=12'","r")
    local exists = fd:read("*l")
    fd:close()
    if exists ~= nil then
        notioncore.exec('lua ~/.notion/mpd_dzen.lua')
    end
end

function start_rofi()
    notioncore.exec('/usr/bin/rofi ' .. rofi.font ..  ' -b -disable-history -columns 10 -lines 1 -width '..rofi.width..' -yoffset -22 -key-run mod1-grave -location 6')
end

start_mpdstat()
start_rofi()
