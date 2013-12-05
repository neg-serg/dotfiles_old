---------------------------[[  QUERY  ]]----------------------------------------
defbindings("WEdln", {
    --Move one character forward/backward
    kpress("Control+F", "WEdln.forward(_)"),
    kpress("Control+B", "WEdln.back(_)"),
    --kpress("Right", "WEdln.forward(_)"),
    --kpress("Left", "WEdln.back(_)"),
    --Go to end/beginning
    kpress("Control+E", "WEdln.eol(_)"),
    kpress("Control+A", "WEdln.bol(_)"),
    kpress("End", "WEdln.eol(_)"),
    kpress("Home", "WEdln.bol(_)"),
    --Skip one word forward/backward
    kpress("Control+X", "WEdln.skip_word(_)"),
    kpress("Control+Z", "WEdln.bskip_word(_)"),
    --Delete next character
    kpress("Control+D", "WEdln.delete(_)"),
    kpress("Delete", "WEdln.delete(_)"),
    --Delete previous character
    kpress("BackSpace", "WEdln.backspace(_)"),
    kpress("Control+H", "WEdln.backspace(_)"),
    --Delete one word forward/backward
    kpress("Control+W", "WEdln.kill_word(_)"),
    kpress("Control+O", "WEdln.bkill_word(_)"),
    --Delete to end of line
    kpress("Control+J", "WEdln.kill_to_eol(_)"),
    --Delete the whole line
    kpress("Control+Y", "WEdln.kill_line(_)"),
    --Transpose characters
    kpress("Control+T", "WEdln.transpose_chars(_)"),
    --Select next/previous (matching) history entry
    kpress("Control+P", "WEdln.history_prev(_)"),
    kpress("Control+N", "WEdln.history_next(_)"),
    kpress("Up", "WEdln.history_prev(_)"),
    kpress("Down", "WEdln.history_next(_)"),
    kpress("Control+Up", "WEdln.history_prev(_, true)"),
    kpress("Control+Down", "WEdln.history_next(_, true)"),
    --Paste from the clipboard
    mclick("Button2", "WEdln.paste(_)"),
--  submap("Control+K", {
    kpress("Mod1+C", "WEdln.paste(_)"),
    --Set mark/begin selection
    kpress("Mod1+B", "WEdln.set_mark(_)"),
    --Cut selection
    kpress("Mod1+Y", "WEdln.cut(_)"),
    --Copy selection
    kpress("Mod1+K", "WEdln.copy(_)"),
    --Clear mark/cancel selection
    kpress("Mod1+G", "WEdln.clear_mark(_)"),
    --Transpose words
    kpress("Mod1+T", "WEdln.transpose_words(_)"),
--  }),
    --Try to complete the entered text or cycle through completions
    kpress("Tab", "WEdln.complete(_, 'next', 'normal')"), 
    kpress("Shift+Tab", "WEdln.complete(_, 'prev', 'normal')"),
    --Do not cycle; only force evaluation of new completions
    kpress("Control+Tab", "WEdln.complete(_, nil, 'normal')"),
    --Complete from history
    kpress("Control+R", "WEdln.complete(_, 'next', 'history')"),
    kpress("Control+S", "WEdln.complete(_, 'prev', 'history')"),
    --Close the query and execute bound action
    kpress("Control+M", "WEdln.finish(_)"),
    kpress("Return", "WEdln.finish(_)"),
    kpress("KP_Enter", "WEdln.finish(_)"),
})

defbindings("WInput", {
    --Close the query/message box, not executing bound actions
    kpress("Escape", "WInput.cancel(_)"),
    kpress("Control+G", "WInput.cancel(_)"),
    kpress("Control+C", "WInput.cancel(_)"),
    --Scroll the message or completions up/down
    kpress("Control+U", "WInput.scrollup(_)"),
    kpress("Control+V", "WInput.scrolldown(_)"),
    --kpress("Page_Up", "WInput.scrollup(_)"),
    --kpress("Page_Down", "WInput.scrolldown(_)"),
})

mod_query.set{autoshowcompl=true,autoshowcompl_delay=10,caseicompl=true,substrcompl=true,}
