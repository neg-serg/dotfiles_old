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
