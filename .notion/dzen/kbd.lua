function kbd_update()
    local f = io.popen(home_.."/bin/mon/klay3", "r")
    local klay = f:read("*l") f:close()
    local t = ""
    if klay ~= nil then t = t..klay end
    dmain.kbd = t
    dzen_update()
end
kbd_update()
