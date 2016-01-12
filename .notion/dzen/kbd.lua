function kbd_update()
    local klay
    local f        = nil
    local template = ""

    f = io.popen("/home/neg/bin/mon/klay2", "r")
    klay = f:read("*l")
    f:close()
    template = template..klay

    dmain.kbd = template
    dzen_update()
end

kbd_update()
