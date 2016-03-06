function kbd_update()
    local klay f = nil t = ""
    f = io.popen(home_.."/bin/mon/klay2", "r")
    klay = f:read("*l") f:close()
    t = t..klay
    dmain.kbd = t
    dzen_update()
end
kbd_update()
