--toggle_frame_size.lua
--
--toggle size of pointed frame to emulate frame hidding\showing.
--
----toggle_frame_size('FrameName',min width,max wifth ,min height, max height, 'frame position')
--Use zero for unused parameters.
--
--Example:
--toggle_frame_size('Frame1',1,100,0,0,'left')
--
--this will hide (will set it's width=1) Frame1 which is situated at the left side of screen
--and has width equial 100 or more.
--
--The next call will show frame again (width=100).
--
--Keybindings example:
-- defbindings("WFrame", {
-- kpress(META.."F11", "toggle_frame_size('LazOP',1,300,0,0,'left')"),
-- kpress(META.."F12", "toggle_frame_size('LazMes',0,0,1,176,'bottom')"),
-- kpress(META.."F10", "toggle_frame_size('LazMain',0,0,1,96,'top')"),
-- })

--Author: Dmitry Kolomiets <B4rr4cuda at rambler dot ru>

function toggle_frame_size(fname,minw,maxw,minh,maxh,pos)
local frm=ioncore.lookup_region(fname,'WFrame');

if frm==nil then
print("Frame "..fname.." is a nil value");
return;
end

local t=WFrame.geom(frm);

--увеличиваем до maxw
if t.w<maxw then
if pos=='left' then
t.w=maxw;
elseif pos=='right' then
t.x=t.x-maxw;
end
else --уменьшаем до minw
if pos=='left' then
t.w=minw;
elseif pos=='right' then
t.x=t.x+maxw;
end
end

--увеличиваем до maxh
if t.h<maxh then
if pos=='top' then
t.h=maxh;
elseif pos=='bottom' then
t.y=t.y-maxh;
end
else --уменьшаем до minh
if pos=='top' then
t.h=minh;
elseif pos=='bottom' then
t.y=t.y+maxh;
end
end
WFrame.rqgeom(frm,t);
end
