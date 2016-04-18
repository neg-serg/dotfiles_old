function spawn(prog)
    notioncore.exec_on(notioncore.current(), prog)
end

function nsp_hide()
    local scr = ioncore.find_screen_id(0)
    local cur = scr:current()
    if cur:is_grattr("scratchpad", "set") then
        WMPlex.set_hidden(
            scr,
            cur,
            'set'
        )
    end
end

function ns_exec(class, prog, ns, instance)
    reg = notioncore.current()
    local win = app.match_class(class)[1]
    if not win then
        notioncore.exec_on(reg, prog)
    end
    named_scratchpad(reg, ns)
end

function namsc(class)
    named_scratchpad(notioncore.current(), class)
end

function ncmpcpp()
    local st_font='"PragmataPro for Powerline:pixelsize=18"'
    ns_exec(
        'mpd-pad2', -- class
        'st-bright -f '..st_font..' -c mpd-pad2 -e ncmpcpp',
        'ncmpcpp'   --ns
    )
end

function mutt()
    ns_exec(
        'mutt', --class
        '~/bin/scripts/run_mutt',
        'mutt'  --ns
    )
end

function console()
    local st_font='"PragmataPro for Powerline:pixelsize=18"'
    ns_exec(
        'console', --class
        'st -f '..st_font..' -c console',
        'console'  --ns
    )
end

function ranger()
    local ranger_font='"PragmataPro for Powerline:size=16"'
    ns_exec(
        'ranger', --class
        'xterm -class ranger -fa'..ranger_font..'-e tmux new ranger',
        'ranger'  --ns
    )
end

function gdb()
    ns_exec(
        'gdb', --class
        'st -c gdb -e bash -c "tmux -L gdb new gdb"',
        'gdb'  --ns
    )
end

function radare2()
    ns_exec(
        'radare', --class
        "st -c radare -e bash -c 'tmux -L radare'",
        'radare2' --ns
    )
end

function weechat()
    ns_exec(
        '_weechat_', --class
        'pidof weechat || st -c _weechat_ -f \'Terminus Re33:size=14:style=Bold\' zsh -c \'tmux -S ~/1st_level/weechat.socket new weechat\'', 
        'weechat'
    )
end

function webcam()
    ns_exec(
        'webcam_mpv', --class
        '~/bin/webcam',
        '_webcam_'    --ns
    )
end

function nicotine()
    ns_exec(
        'Nicotine.py', --class
        'nicotine.py || nicotine',
        'nicotine' --ns
    )
end

function move_scratch(x, y, w, h)
   notioncore.lookup_region("*scratchpad*"):rqgeom({x=x, y=y, w=w, h=h})
end

function tiling_split(dir)
    local scr = ioncore.find_screen_id(0)
    local cur = scr:mx_current()
    local cur_tile = cur:current()
    local cur_frame = cur_tile:current()
    if dir == nil or dir == "" then
        dir = 'left'
    end
    WTiling.split_at(cur_tile, 
                     cur_frame, 
                     dir, 
                     true)
end


function tiling_root_split(dir)
    local scr = ioncore.find_screen_id(0)
    local cur = scr:mx_current()
    local cur_tile = cur:current()
    if dir == nil or dir == "" then
        dir = 'left'
    end
    WTiling.split_at(cur_tile, 
                     dir, 
                     true)
end

function goto_dir(dir)
    local scr = ioncore.find_screen_id(0)
    local cur = scr:mx_current()
    local cur_tile = cur:current()
    local cur_frame = cur_tile:current()
    if dir == nil or dir == "" then
        dir = 'top'
    end
    notioncore.goto_next(
        cur_frame,
        dir,
        {no_ascend=cur_tile}
    )
end

function tiling_transpose(root)
    local scr = ioncore.find_screen_id(0)
    local cur = scr:mx_current()
    local cur_tile = cur:current()
    local cur_frame = cur_tile:current()
    if root ~= nil then
        if root == 1 then
            WTiling.transpose_at(cur_tile)
        end
    else
        WTiling.transpose_at(cur_tile, cur_frame)
    end
    
end

function tiling_flip(root)
    local scr = ioncore.find_screen_id(0)
    local cur = scr:mx_current()
    local cur_tile = cur:current()
    local cur_frame = cur_tile:current()
    if root ~= nil then
        if root == 1 then
            WTiling.flip_at(cur_tile)
        end
    else
        WTiling.flip_at(cur_tile, cur_frame)
    end
end

function tiling_unsplit()
    local scr = ioncore.find_screen_id(0)
    local cur = scr:mx_current()
    local cur_tile = cur:current()
    local cur_frame = cur_tile:current()
    WTiling.unsplit_at(cur_tile, cur_frame)
end

function tiling_untile()
    local scr = ioncore.find_screen_id(0)
    local cur = scr:mx_current()
    local cur_tile = cur:current()
    local cur_frame = cur_tile:current()
    mod_tiling.untile(cur_tile)
end

function new_tiling()
    local scr = ioncore.find_screen_id(0)
    local cur = scr:mx_current()
    local cur_tile = cur:current()
    mod_tiling.mkbottom(cur_tile)
end

function set_floating(dir)
    local scr = ioncore.find_screen_id(0)
    local cur = scr:mx_current()
    local cur_tile = cur:current()
    local cur_frame = cur_tile:current()
    if dir == nil or dir == "" then
        dir = 'left'
    end
    WTiling.set_floating_at(cur_tile, cur_frame, 'toggle', dir)
end

function dereattach()
    notioncore.detach(notioncore.current(), 'toggle')
end

move_current={}
function move_current.move(ws, dir)
    local frame=ws:current()
    local cwin=frame:current()
    local frame2=notioncore.navi_next(frame,dir)
    
    if frame2 then
        frame2:attach(cwin, { switchto=true })
    end
    cwin:goto_focus()
end

dynamic_view = {}
dynamic_view.cache = {}

function dynamic_view.toggle (active_ws, target_ws_name, direction)
    local target_ws = notioncore.lookup_region(target_ws_name, 'WGroupWS')
    if not target_ws then return end
    local target_frame = target_ws:current():current()
    local key = active_ws:name()
    if not dynamic_view.cache[key] then dynamic_view.cache[key] = {} end
    local grabbed = dynamic_view.cache[key]
    
    if not grabbed[target_ws_name] then
        if target_frame:mx_count() == 0 then return end
        local temp_frame = active_ws:split_at(active_ws:current(), direction, false)
        dynamic_view.move_clients(target_frame, temp_frame)
        grabbed[target_ws_name] = temp_frame
    else
        temp_frame = grabbed[target_ws_name]
        dynamic_view.move_clients(temp_frame, target_frame)
        active_ws:unsplit_at(active_ws:current())
        grabbed[target_ws_name] = nil
    end
end

function dynamic_view.move_clients (from_frame, to_frame)
    from_frame:mx_i(function (cwin)
        notioncore.defer(function ()
            to_frame:attach(cwin)
        end)
        return true
    end)
end

function move_reg(name, x, y, w, h)
    if name ~= nil and name ~= "" then
        notioncore.lookup_region(name):rqgeom({x=x, y=y, w=w, h=h})
    else
        notioncore.current():rqgeom({x=x, y=y, w=w, h=h})
    end
end

function move_scratch(x, y, w, h)
   notioncore.lookup_region("*scratchpad*"):rqgeom({x=x, y=y, w=w, h=h})
end

function get_display()
   local out = io.popen("xrandr")
   local line = out:read()

   while line do
      local b, e, id = string.find(line, "^(%w.+) connected %d+x%d+")

      if id then
         return id
      end

      line = out:read()
   end
end

function resize_scratch()
   if get_display() == "HDMI-0" then
      move_scratch(300, 160, 1361, 744)
   else
      move_scratch(2200, 260, 1361, 744)
   end
end
-- notioncore.get_hook("ioncore_post_layout_setup_hook"):add(resize_scratch)
