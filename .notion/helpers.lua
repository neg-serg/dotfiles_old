function ncmpcpp(reg)
    local exec_str = '/bin/urxvt -fn "xft:Pragmata Pro for Powerline:pixelsize=18" -name mpd-pad2 -e ncmpcpp'
    ioncore.exec_on(reg, '~/bin/scripts/ncmpcpp')
    named_scratchpad(reg, 'ncmpcpp')
    -- named_scratchpad_exec_with_class(reg, 'ncmpcpp', exec_str, 'mpd-pad2')
end

function console(reg)
    ioncore.exec_on(reg, '~/bin/scripts/console')
    named_scratchpad(reg, 'console')
end

function ranger(reg)
    ioncore.exec_on(reg, '~/bin/scripts/ranger')
    named_scratchpad(reg, 'ranger')
end

function gdb(reg)
    ioncore.exec_on(reg, '~/bin/scripts/gdb')
    named_scratchpad(reg, 'gdb')
end

function radare2(reg)
    ioncore.exec_on(reg, '~/bin/scripts/radare')
    named_scratchpad(reg, 'radare2')
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
