local posix = require "posix"

local prefix = "scr_"
local extension = ".png"
local screenshot_path = "/tmp"
local datetime = ""

function screenshot_filename(postfix)
   datetime = os.date("%Y_%m_%d-%H_%M_%S")
   local filename = screenshot_path .. '/' .. prefix .. datetime .. postfix .. extension
   local echo_str = '[ Scr :: {' ..  prefix .. datetime .. postfix .. extension ..'} ]'
   local fd = io.popen("zsh -c \"echo '".. filename .."'|xsel -i\"") fd:close()
   return filename
end

function make_screenshot(windowname, filename)
   notioncore.exec('/usr/bin/import -window "' .. windowname .. '"' ..
                   ' \'' .. filename .. '\'')
   local echo_str = '[ Scr :: { scr_' .. datetime .. '.png} ]'
   local fd = io.popen("notify-send '".. echo_str .."'") fd:close()
end

function make_root_screenshot()
   make_screenshot('root', screenshot_filename(''))
end

-- TODO: add non-acsii window name support
function make_current_window_screenshot()
   local windowname = WRegion.name(notioncore.current())
   make_screenshot(windowname, screenshot_filename(''))
end

function make_current_window_screenshot_with_windowname()
   local windowname = WRegion.name(notioncore.current())
   local safe_winname = string.gsub(windowname, "(/)", "|")
   local scrshot_name_with_winname = screenshot_filename('[ ' .. safe_winname .. ' ]')
   make_screenshot(windowname, scrshot_name_with_winname)
end
