-- local utf8 = require 'lua-utf8'

neg      = {}
neg.dzen = {}
neg.rofi = {}

neg.font       = "PragmataPro for Powerline"
neg.font_size  = "12"
neg.basefont   = "xft:".. neg.font .."-"..neg.font_size..":bold"
neg.statusfont = "xft:".. neg.font .."-"..neg.font_size..":bold"

neg.padding_color     = "#000000"
neg.def_bg            = "#000000"
neg.def_fg            = "#666666"
neg.scratchpad_border = "#1f3b4f"
neg.frame_def_border  = "#000000"

neg.rofi.bg   = "\"#000000\""
neg.rofi.fg   = "\"#666666\""
neg.rofi.hlfg = "\"#aaaaaa\""
neg.rofi.hlbg = "\"#194558\""
neg.rofi.bc   = "\"#202020\""

neg.dzen.panel_font_ = "'".. neg.font..":bold:size=".. neg.font_size .."'"
neg.dzen.bg_         = '"#000000"'
neg.dzen.h_          = 19
neg.dzen.main_w_     = "1000"
neg.dzen.mpd_w_      = "910"

function wrp(tmplte, left_side, right_side)
    local bracket_color = "#287373"
    local fg_color      = "#cccccc"
    local left_side     = left_side or "[ "
    local right_side    = right_side or " ]"
    local function setcol(color)
        return "^fg(".. color .. ")"
    end
    return setcol(bracket_color) .. left_side ..
           setcol(fg_color) .. tmplte .. setcol(bracket_color) 
           .. right_side .. setcol(fg_color)
end
