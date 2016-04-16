require "lfs"

local screenshot_path = os.getenv("HOME").."/tmp/shots"
lfs.mkdir(screenshot_path)

function scr_info(postfix)
    local prefix = "scr_"
    local extension = ".png"
    local datetime = os.date("%Y_%m_%d-%H_%M_%S")
    local filename = screenshot_path .. '/' .. prefix .. datetime .. postfix .. extension
    local msg = '[ Scr :: {' ..  prefix .. datetime .. postfix .. extension ..'} ]'
    local fd = io.popen("zsh -c \"echo '".. filename .."'|xsel -i\"") fd:close()
    return {["filename"]=filename,["msg"]=msg}
end

function make_scr_cur()
    local windowname=WRegion.name(notioncore.current())
    local safe_winname=string.gsub(windowname, "(/)", "|")
    local scrshot_name_with_winname=screenshot_filename('[ '..safe_winname..' ]')
    make_scr(windowname, scrshot_name_with_winname)
end

function make_scr(wname)
    if wname == nil or wname == '' then wname = 'root' end
    local si = scr_info('')
    local filename = si["filename"]
    local stdout_cor = coroutine.create(
        function(input_data)
            local key=input_data
            local data, pdata = "", ""
            while pdata do data=data..pdata pdata = coroutine.yield() end
            local msg = si["msg"]
            local fd = io.popen("notify-send '"..msg.."'") fd:close()
        end
    )
    coroutine.resume(stdout_cor, key)
    notioncore.popen_bgread('/usr/bin/import -window "'..wname..'" '..filename,
        function(_) coroutine.resume(stdout_cor, _) end
    )
end
