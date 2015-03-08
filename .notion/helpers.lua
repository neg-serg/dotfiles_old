function ncmpcpp(ws)
    ioncore.exec_on(ws, '~/bin/scripts/ncmpcpp')
    named_scratchpad(ws, 'ncmpcpp')
end

function console(ws)
    ioncore.exec_on(ws, '~/bin/scripts/console')
    named_scratchpad(ws, 'console')
end

function ranger(ws)
    ioncore.exec_on(ws, '~/bin/scripts/ranger')
    named_scratchpad(ws, 'console')
end

function gdb(ws)
    ioncore.exec_on(ws, '~/bin/scripts/gdb')
    named_scratchpad(ws, 'gdb')
end

function radare2(ws)
    ioncore.exec_on(ws, '~/bin/scripts/radare')
    named_scratchpad(ws, 'radare2')
end

function nop()
end

function move_scratch(x, y, w, h)
   ioncore.lookup_region("*scratchpad*"):rqgeom({x=x, y=y, w=w, h=h})
end

-- ......................................................................................
function get_hostname()
   local out = io.popen("hostname")
   return out:read()
end

function move_scratch(x, y, w, h)
   ioncore.lookup_region("*scratchpad*"):rqgeom({x=x, y=y, w=w, h=h})
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

ioncore.get_hook("ioncore_post_layout_setup_hook"):add(resize_scratch)
