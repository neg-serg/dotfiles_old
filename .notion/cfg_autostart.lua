function start_mpdstat()
    ioncore.exec('lua ~/.notion/mpd_dzen.lua')
end
function start_rofi()
    local rofi_font = '-font "Pragmata Pro for Powerline bold 12 "'
    ioncore.exec('rofi ' .. rofi_font ..  ' -lines 10 -width 1850 -yoffset -22 -key mod1-g -location 6')
    ioncore.exec('rofi ' .. rofi_font ..  ' -lines 10 -width 1850 -yoffset -22 -rkey mod1-grave -location 6')
end
start_mpdstat()
start_rofi()
