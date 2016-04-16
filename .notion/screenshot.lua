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
    local scr_pipe = io.popen('/usr/bin/import -window "' .. windowname .. '"' ..
    ' \'' .. filename .. '\'; echo $?')
    scr_pipe:close()
    local echo_str = '[ Scr :: { scr_' .. datetime .. '.png} ]'
    local fd = io.popen("notify-send '".. echo_str .."'") fd:close()
end

function make_root_screenshot()
    make_screenshot('root',screenshot_filename(''))
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

function make_scr()
    local postfix = ""
    local filename = screenshot_path .. '/' .. prefix .. datetime .. postfix .. extension
    local screen_bg_pipe = 0xDEADBEEF
    -- Read output from the program and (if data) then update the statusbar
    local handle_output_changes = coroutine.create(
    function(input_data)
        local key = input_data
        local data, partial_data = "", ""
        -- Keep reading data until we have it all
        while partial_data do
            data = data .. partial_data
            -- Yield until we get more input.
            -- popen_bgread will call resume on us.
            partial_data = coroutine.yield()
        end
        local datetime = os.date("%Y_%m_%d-%H_%M_%S")
        local echo_str = '[ Scr :: { scr_' .. datetime .. '.png} ]'
        local fd = io.popen("notify-send '".. echo_str .."'") fd:close()
    end
    )
    coroutine.resume(handle_output_changes, key)
    notioncore.popen_bgread('/usr/bin/import -window "root" '..filename,
        function(cor) coroutine.resume(handle_output_changes, cor) end
    )
end
