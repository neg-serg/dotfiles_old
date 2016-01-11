function ncmpcpp(reg)
    notioncore.exec_on(reg, '~/bin/scripts/ncmpcpp')
    named_scratchpad(reg, 'ncmpcpp')
end

function console(reg)
    notioncore.exec_on(reg, '~/bin/scripts/console')
    named_scratchpad(reg, 'console')
end

function ranger(reg)
    notioncore.exec_on(reg, '~/bin/scripts/ranger')
    named_scratchpad(reg, 'ranger')
end

function gdb(reg)
    notioncore.exec_on(reg, '~/bin/scripts/gdb')
    named_scratchpad(reg, 'gdb')
end

function radare2(reg)
    notioncore.exec_on(reg, '~/bin/scripts/radare')
    named_scratchpad(reg, 'radare2')
end

function move_scratch(x, y, w, h)
   notioncore.lookup_region("*scratchpad*"):rqgeom({x=x, y=y, w=w, h=h})
end

function tiling_split(dir)
    local scr = ioncore.find_screen_id(0)
    local cur = scr:mx_current()
    local cur_tile = cur:current()
    local cur_frame = cur_tile:current()
    WTiling.split_at(cur_tile, 
                     cur_frame, 
                     dir, 
                     true)
end

function goto_dir(dir)
    local scr = ioncore.find_screen_id(0)
    local cur = scr:mx_current()
    local cur_tile = cur:current()
    local cur_frame = cur_tile:current()
    notioncore.goto_next(
        cur_frame,
        dir,
        {no_ascend=cur_tile}
    )
end

function tiling_transpose()
    local scr = ioncore.find_screen_id(0)
    local cur = scr:mx_current()
    local cur_tile = cur:current()
    local cur_frame = cur_tile:current()
    WTiling.transpose_at(cur_tile, cur_frame)
end

function tiling_flip()
    local scr = ioncore.find_screen_id(0)
    local cur = scr:mx_current()
    local cur_tile = cur:current()
    local cur_frame = cur_tile:current()
    WTiling.flip_at(cur_tile, cur_frame)
end

function tiling_unsplit()
    local scr = ioncore.find_screen_id(0)
    local cur = scr:mx_current()
    local cur_tile = cur:current()
    local cur_frame = cur_tile:current()
    WTiling.unsplit_at(cur_tile, cur_frame)
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

-- ......................................................................................
function get_hostname()
   local out = io.popen("hostname")
   return out:read()
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

notioncore.get_hook("ioncore_post_layout_setup_hook"):add(resize_scratch)
