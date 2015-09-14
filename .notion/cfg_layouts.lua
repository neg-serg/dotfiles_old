local function regmax(win)
    WFrame.maximize_horiz(win)
    WFrame.maximize_vert(win)
    WRegion.rqorder(win, 'front')
end
---------------------------------[[ LAYOUTS ]]-------------------------------------
local a_frame={
    type="WSplitRegion",
    regparams={
        type="WFrame",
        frame_style="frame-tiled",
    }
}

local function mksplit(dir, tl, br, float)
return {
    type = (float and "WSplitFloat" or "WSplitSplit"),
    dir = dir,tls = 1,brs = 1,tl = tl,br = br,}
end

local function mktiling(split_tree)
    return {managed={{type = "WTiling",bottom = true,split_tree = split_tree,}}}
end

-- Tiling with single 1:1 horizontal split
local tmp=mktiling(mksplit("horizontal", a_frame, a_frame))
notioncore.deflayout("hsplit", tmp)
notioncore.deflayout("default", tmp)
-- Tiling with single 1:1 vertical split
notioncore.deflayout("vsplit",mktiling(mksplit("vertical", a_frame, a_frame)))
-- Tiling with single 1:1 floating horizontal split
notioncore.deflayout("hfloat",mktiling(mksplit("horizontal", a_frame, a_frame, true)))
-- Tiling with single 1:1 floating vertical split
notioncore.deflayout("vfloat",mktiling(mksplit("vertical", a_frame, a_frame, true)))
-- Tiling with horizontal and then vertical splits
notioncore.deflayout("2x2",
    mktiling(mksplit("horizontal", 
    mksplit("vertical", a_frame, a_frame),
    mksplit("vertical", a_frame, a_frame))
    )
)
-- Tiling with single full screen frame
notioncore.deflayout("full", mktiling(a_frame))
