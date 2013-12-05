-- xinerama_switcher.lua
-- 
-- Goes to the frame in the specified direction. If there is no frame in the
-- given direction (the user is trying to move off the edge of the screen), it
-- switches workspace or screen. I assume that left/right switch between
-- screens, since xinerama displays are usually next to each other. Up/down,
-- on the other hand switch between workspaces. For me, the next workspace is
-- down as if I was reading a webpage.
--
-- The following keybindings may be useful:
--
--defbindings("WIonWS", {
--    kpress(MOD1.."Up", "xinerama_switcher_up(_)"),
--    kpress(MOD1.."Down", "xinerama_switcher_down(_)"),
--    kpress(MOD1.."Right", "xinerama_switcher_right(_)"),
--    kpress(MOD1.."Left", "xinerama_switcher_left(_)"),
--})
--
-- Based on go_desk_or_desk lua by Rene van Bevern <rvb@pro-linux.de>, 2005
--
-- This script is (c) copyright 2005 by martin f. krafft <madduck@madduck.net>
-- and released under the terms of the Artistic Licence.
--
-- Version 2005.08.14.1515
-- 
-- TODO: prevent switching screens when there is none on that side. E.g.
-- moving off the left edge of the left screen should either do nothing or
-- wrap to the right side of the right screen. This likely needs
-- a configuration file which would also solve the problem about assigning
-- left/right to next/prev according to xinerama configuration.
-- When solving this, don't just solve it for dual-head. :)
--

function goto_right_screen()
  -- do whatever it takes to switch to the screen on the right
  -- this may be either the previous or next screen, depending on how you set
  -- up xinerama.
  
  return ioncore.goto_prev_screen()
  --return ioncore.goto_next_screen()
end

function goto_left_screen()
  -- do whatever it takes to switch to the screen on the right
  -- this may be either the previous or next screen, depending on how you set
  -- up xinerama.

  --return ioncore.goto_prev_screen()
  return ioncore.goto_next_screen()
end

function goto_workspace_down(screen)
  -- do whatever it takes to switch to the workspace below
  -- in my book, that's the next workspace
  screen:switch_next()
end

function goto_workspace_up(screen)
  -- do whatever it takes to switch to the workspace below
  -- in my book, that's the previous workspace
  screen:switch_prev()
end
  
function xinerama_switcher(workspace, direction)

  if workspace:nextto(workspace:current(), direction, false) then
    -- there is a region in the sought direction, so just go to it
    workspace:goto_dir(direction)
  else
    -- the user is trying to move off the edge of the screen

    if direction == "left" then
      -- we move to the screen on the left
      local screen = goto_left_screen()
      screen:current():farthest("right"):goto()
    
    elseif direction == "right" then
      -- we move to the screen on the right
      local screen = goto_right_screen()
      screen:current():farthest("left"):goto()
    
    elseif direction == "up" then
      -- we switch to the workspace above this one
      local screen = workspace:screen_of()
      goto_workspace_up(screen)
      screen:current():farthest("down"):goto()
    
    elseif direction == "down" then
      -- we switch to the workspace below this one
      local screen = workspace:screen_of()
      goto_workspace_down(screen)
      screen:current():farthest("up"):goto()
      
    end
  end
end

-- helper functions for easier keybindings (see top of the file)

function xinerama_switcher_left(reg)
   xinerama_switcher(reg, "left")
end

function xinerama_switcher_right(reg)
   xinerama_switcher(reg, "right")
end

function xinerama_switcher_up(reg)
   xinerama_switcher(reg, "up")
end

function xinerama_switcher_down(reg)
   xinerama_switcher(reg, "down")
end


-- A version of ioncore.goto_next that may be useful on multihead setups
-- Replace ioncore.goto_next with goto_multihead.goto_next in cfg_tiling.lua
-- to use it.

goto_multihead={}

function goto_multihead.goto_next(ws, dir)
    if dir=="up" or dir=="down" then
        ioncore.goto_next(ws:current(), dir)
        return
    end
    
    local nxt, nxtscr
    
    nxt=ioncore.navi_next(ws:current(), dir, {nowrap=true})
    
    if not nxt then
        local otherdir
        local fid=ioncore.find_screen_id
        if dir=="right" then
            otherdir="left"
            nxtscr=fid(ws:screen_of():id()+1) or fid(0)
        else
            otherdir="right"
            nxtscr=fid(ws:screen_of():id()-1) or fid(-1)
        end
        nxt=nxtscr:current():current()
        if obj_is(nxt, "WTiling") then
            nxt=nxt:farthest(otherdir)
        end
    end
    
    nxt:goto()
end


-- Goes to the frame in the specified direction. If there is no frame in the
-- given direction, it goes to the next workspace in the direction, being:
-- 	left  = previous workspace
-- 	right = next workspace
--
-- By Rene van Bevern <rvb@pro-linux.de>, 2005
-- 	Public Domain
--
-- If you are about to go to a frame that would be left to the leftmost frame,
-- the function switches to a previous workspace and goes to its rightmost frame.
-- If you are about to go to a frame that would be right of the rightmost frame,
-- the function switches to the next workspace and goes to its leftmost frame.
--
-- To use this function you need to bind keys for WIonWS, for exmaple:
--
--defbindings("WIonWS", {
--    kpress(MOD1.."Up", "go_frame_or_desk_up(_)"),
--    kpress(MOD1.."Down", "go_frame_or_desk_down(_)"),
--    kpress(MOD1.."Right", "go_frame_or_desk_right(_)"),
--    kpress(MOD1.."Left", "go_frame_or_desk_left(_)"),
--})

function go_frame_or_desk(workspace, direction)
   local region = workspace:current()
   local screen = workspace:screen_of()
   if workspace:nextto(region,direction,false) then
      workspace:goto_dir(direction)
   elseif direction == "left" then
      screen:switch_prev()
      screen:current():farthest("right"):goto()
   elseif direction == "right" then
      screen:switch_next()
      screen:current():farthest("left"):goto()
   end
end

function go_frame_or_desk_left(reg)
   go_frame_or_desk(reg, "left")
end

function go_frame_or_desk_right(reg)
   go_frame_or_desk(reg, "right")
end

function go_frame_or_desk_up(reg)
   go_frame_or_desk(reg, "up")
end

function go_frame_or_desk_down(reg)
   go_frame_or_desk(reg, "down")
end

