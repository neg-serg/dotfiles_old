function start_mpdstat()
    ioncore.exec('lua ~/.notion/mpd_dzen.lua')
end
function start_rofi()
    ioncore.exec('rofi -levenshtein-sort -font \"Pragmata Pro for Powerline 12 bold\" -lines 10 -width 1850 -yoffset -22 -key mod1-g -location 6')
    ioncore.exec('rofi -levenshtein-sort -font \"Pragmata Pro for Powerline 12 bold\" -lines 10 -width 1850 -yoffset -22 -rkey mod1-grave -location 6')
end
start_mpdstat()
start_rofi()
