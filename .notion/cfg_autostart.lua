function start_mpdstat()
    ioncore.exec('lua ~/.notion/mpd_dzen.lua')
end
function start_rofi()
    local rofi_font = '-font "Pragmata Pro for Powerline bold 12 "'
    ioncore.exec('/usr/bin/rofi ' .. rofi_font ..  ' -lines 10 -width 1850 -yoffset -22 -key-window mod1-g -key-run mod1-grave -location 6')
end
start_mpdstat()
start_rofi()
