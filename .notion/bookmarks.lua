-- 
-- Bookmarks support for Ion3
-- 
-- MOD1+b n        Go to bookmark n (n=0..9)
-- MOD1+b Shift+n  Set bookmark n
-- 

local bms={}
bookmarks={}

function bookmarks.set(bm, frame)
    bms[bm]=frame
end

function bookmarks.goto_focus(bm)
    if bms[bm] then
        bms[bm]:goto_focus()
    end
end


for k=0, 9 do
    local bm=tostring(k)
    defbindings("WScreen", {
        submap("Mod4+4", {
            kpress(bm, function() bookmarks.goto_focus(bm) end),
        })
    })
    defbindings("WFrame", {
        submap("Mod4+4", {
            kpress("Shift+"..bm, 
                   function(frame) bookmarks.set(bm, frame) end),
        })
    })
end

