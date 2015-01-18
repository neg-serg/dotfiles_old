function screenshot_filename(postfix)
   local prefix = "screenshot"
   local datetime = os.date("%Y_%m_%d-%H_%M")
   local home_path = os.getenv("HOME")
   local screenshot_path = home_path .. "/pic/shots"
   local extension = ".png"
   local filename = screenshot_path .. '/' .. prefix .. '-' .. datetime .. postfix .. extension
   return filename
end


function screenshot_filename(postfix)
   local prefix = "screenshot"
   local datetime = os.date("%Y_%m_%d-%H_%M")
   local screenshot_path = "/tmp"
   local extension = ".png"
   local filename = screenshot_path .. '/' .. prefix .. '-' .. datetime .. postfix .. extension
   return filename
end

function make_screenshot(windowname, filename)
   ioncore.exec('/usr/bin/import -window "' .. windowname .. '"' ..
                   ' \'' .. filename .. '\'')
end

function make_root_screenshot()
   make_screenshot('root', screenshot_filename(''))
end

-- TODO: add non-acsii window name support
function make_current_window_screenshot()
   local windowname = WRegion.name(ioncore.current())
   make_screenshot(windowname, screenshot_filename(''))
end

function make_current_window_screenshot_with_windowname()
   local windowname = WRegion.name(ioncore.current())
   local safe_winname = string.gsub(windowname, "(/)", "|")
   local scrshot_name_with_winname = screenshot_filename('[ ' .. safe_winname .. ' ]')
   make_screenshot(windowname, scrshot_name_with_winname)
end
