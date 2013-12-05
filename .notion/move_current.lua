move_current={}

function move_current.move(ws, dir)
    local frame=ws:current()
    local cwin=frame:current()
    local frame2=ioncore.navi_next(frame,dir)
    
    if frame2 then
        frame2:attach(cwin, { switchto=true })
    end
    cwin:goto()
end
