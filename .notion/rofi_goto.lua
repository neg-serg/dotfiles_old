function complete_clientwin()
    return complete_name(ioncore.clientwin_i)
end

function complete_ws()
    return workspacelist(ioncore.region_i)
end

local function mk_completion_add(entries)
    return function(s) 
               if s then
                   table.insert(entries, s)
               end
           end
end

local function sort(entries)
    table.sort(entries, function(a, b) return a.name < b.name end)
    return entries
end

function workspacelist(iter)
    local entries={}
    local ws_add=mk_completion_add(entries)
    
    iter(function(obj)
             if obj_is(obj, "WGroupWS") then
                ws_add(obj:name())
             end
             return true
         end)
    
    return entries
end


function workspace_handler(reg,name)
    local ws=ioncore.lookup_region(name, "WGroupWS")
    if ws then
        ws:goto_focus()
    else
        local tmpl={
            name=(name~="" and name),
            switchto=true
        } 
        layout = "full"
        ioncore.create_ws(reg:screen_of(),tmpl,layout)
    end
end

function complete_name(iter)
    local entries={}
    local tst_add=mk_completion_add(entries)
    
    iter(function(reg)
             if not string.match(reg:name(), "dzen.*title") then
                tst_add(reg:name())
             end
             return true
         end)
    
    return entries
end

function rofi_goto_win()
    local tbl = {}
    local rofi_font = '-font "Pragmata Pro for Powerline bold 12 "'
    local rofi_width = 1850
    local goto_win_file = "/tmp/goto_win"
    local rofi_cmd='rofi -auto-select -dmenu -opacity "90" -lines "10" -yoffset -22 '.. rofi_font .. ' -fg' ..
    '"#666666" -bg "#000" -hlfg "#aaaaaa" -hlbg "#194558" -bc "#202020" -bw 2 -location 6' ..
    ' -padding 2 -width ' .. rofi_width
    local rofi_prefix = ' -p "[go] >> "'
    rofi_pipe = io.popen(rofi_cmd .. rofi_prefix .. "> " .. goto_win_file, "w")
    rofi_pipe:setvbuf("line")
    tbl = complete_clientwin()
    for i in pairs(tbl) do rofi_pipe:write(tbl[i],'\n') end
    rofi_pipe:close() 
    fp = io.open(goto_win_file)
    x = fp:read("*l")
    fp:close()
    local win = ioncore.lookup_clientwin(x)
    if win then
        ioncore.defer(function () win:goto_focus() end)
    end
end

function rofi_goto_or_create_ws(reg)
    local tbl = {}
    local rofi_font = '-font "Pragmata Pro for Powerline bold 12 "'
    local rofi_width = 1850
    local goto_win_file = "/tmp/goto_ws"
    local rofi_cmd='rofi -auto-select -dmenu -opacity "90" -lines "10" -yoffset -22 '.. rofi_font .. ' -fg' ..
    '"#666666" -bg "#000" -hlfg "#aaaaaa" -hlbg "#194558" -bc "#202020" -bw 2 -location 6' ..
    ' -padding 2 -width ' .. rofi_width
    local rofi_prefix = ' -p "[ws] >> "'
    rofi_pipe = io.popen(rofi_cmd .. rofi_prefix .. "> " .. goto_win_file, "w")
    rofi_pipe:setvbuf("line")
    tbl = complete_ws()
    for i in pairs(tbl) do rofi_pipe:write(tbl[i],'\n') end
    rofi_pipe:close() 
    fp = io.open(goto_win_file)
    name = fp:read("*l")
    workspace_handler(reg,name)
    fp:close()
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
    tbl = complete_clientwin()
    for i in pairs(tbl) do rofi_pipe:write(tbl[i],'\n') end
    rofi_pipe:close() 
    fp = io.open("/tmp/attach_win")
    str = fp:read("*l")
    fp:close()
    
    local cwin=ioncore.lookup_clientwin(str)
    if not cwin then
        return
    end
    local reg=cwin:groupleader_of()
    
    local function attach()
        frame:attach(reg, { switchto = true })
    end
    if frame:rootwin_of()~=reg:rootwin_of() then
        
    elseif reg:manager()==frame then
        reg:goto_focus()
    else
        ioncore.defer(function () attach() end)
    end
end
