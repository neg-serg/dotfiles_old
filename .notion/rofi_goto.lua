local function addto(list)
    return function(tgt, attr)
        local e=menuentry(tgt:name(), function() tgt:goto_focus() end)
        e.attr=attr;
        print(e.attr)
        table.insert(list, e)
        return true
    end
end
    
local function sort(entries)
    table.sort(entries, function(a, b) return a.name < b.name end)
    return entries
end

function windowlist_for_rofi()
    local entries={}
    ioncore.clientwin_i(addto(entries))
    return sort(entries)
end

function rofi_goto_win()
    local tbl = {}
    local rofi_font = '-font "Pragmata Pro for Powerline bold 12 "'
    local rofi_width = 1850
    local goto_win_file = "/tmp/goto_win"
    local rofi_cmd='rofi -dmenu -opacity "90" -lines "10" -yoffset -22 '.. rofi_font .. ' -fg' ..
    '"#666666" -bg "#000" -hlfg "#aaaaaa" -hlbg "#194558" -bc "#202020" -bw 2 -location 6' ..
    ' -padding 2 -width ' .. rofi_width
    local rofi_prefix = ' -p "[go] >> "'
    rofi_pipe = io.popen(rofi_cmd .. rofi_prefix .. "> " .. goto_win_file, "w")
    rofi_pipe:setvbuf("line")
    tbl = windowlist_for_rofi()
    function print_to_rofi(i)
        rofi_pipe:write(tbl[i].name,'\n')
    end
    table.foreachi( tbl, print_to_rofi  )
    rofi_pipe:close() 
    fp = io.open(goto_win_file)
    x = fp:read("*l")
    fp:close()
    local win = ioncore.lookup_clientwin(x)
    if win then
        ioncore.defer(function () win:goto_focus() end)
    end
end

function rofi_attach_win(frame, str)
    tbl = {}
    local rofi_font = '-font "Pragmata Pro for Powerline bold 12 "'
    local rofi_width = 1850
    rofi_cmd='rofi -dmenu -opacity "90" -lines "10" -yoffset -22 '.. rofi_font .. ' -fg' ..
    '"#666666" -bg "#000" -hlfg "#aaaaaa" -hlbg "#194558" -bc "#202020" -bw 2 -location 6' ..
    ' -padding 2 -width ' .. rofi_width
    prefix = ' -p "[attach] >> "'
    rofi_pipe = io.popen(rofi_cmd .. prefix .. "> /tmp/attach_win", "w")
    rofi_pipe:setvbuf("line")
    tbl = windowlist_for_rofi()
    function PrintSomething(i)
        rofi_pipe:write(tbl[i].name,'\n')
    end
    table.foreachi( tbl, PrintSomething  )
    rofi_pipe:close() 
    fp = io.open("/tmp/attach_win")
    str = fp:read("*l")
    fp:close()
    
    local cwin=ioncore.lookup_clientwin(str)
    if not cwin then
        mod_query.warn(frame, TR("Could not find client window %s.", str))
        return
    end
    local reg=cwin:groupleader_of()
    
    local function attach()
        frame:attach(reg, { switchto = true })
    end
    if frame:rootwin_of()~=reg:rootwin_of() then
        mod_query.warn(frame, TR("Cannot attach: different root windows."))
    elseif reg:manager()==frame then
        reg:goto_focus()
    else
        mod_query.call_warn(frame, attach)
    end
end
