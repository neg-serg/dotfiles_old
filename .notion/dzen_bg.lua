local timers,callbacks = {}, {}
local remove_lines = false
gdata = ""

if not dzen_tab then
    dzen_tab = {
        { name="mpd", prog = "mpd.lua", delay = 500},
        -- { name="mpd", prog = "echo -e olool", delay = 500},
    }
end

-- Just print out stderr for now.
local function flush_stderr(partial_data)
    local result = ""
    while partial_data do
        result = result .. partial_data
        -- Yield until we get more input.  popen_bgread will call resume on us.
        partial_data = coroutine.yield()
    end
    print(result, "\n")
end

local function init_dzen()
    if dzen_bg_pipe == nil then
        dzen_bg_pipe = io.popen(
            "dzen2 -dock -bg ".. 
            neg.dzen.bg_ ..
            " -h ".. neg.dzen.h_ ..
            " -tw 0 -x 0 -ta r -w ".. 
            neg.dzen.mpd_w_ .. 
            " -p -fn ".. 
            neg.dzen.panel_font_ .. 
            " ", "w"
        )
        dzen_bg_pipe:setvbuf("line")
    end
end

local function pipe_write(pipe, d)
    pipe:write(d)
end

--remove all but the last line
local function remove_all_but_last_line(str)
    str = string.gsub(str, "\n$", "")
    str = string.gsub(str, ".*\n", "")
end

-- Execute a program.  This will continuously retrieve output from the program.
function start_execute(key)
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

            if remove_lines then remove_all_but_last_line(data) end
        
            gdata = data
            gdata = string.gsub(gdata, "\n", "")

            -- If no updates, then just schedule another run
            if not data or data == "" then
                return timers[key]:set(dzen_tab[key].delay, callbacks[key])
            end
            return timers[key]:set(dzen_tab[key].delay, callbacks[key])
        end
    )
    -- We need to pass it the key before calling a background call.
    coroutine.resume(handle_output_changes, key)
    notioncore.popen_bgread(dzen_tab[key].prog,
                            function(cor) 
                                pipe_write(dzen_bg_pipe,gdata..'\n')
                                coroutine.resume(handle_output_changes, cor) 
                            end,
                            function()
                                coroutine.wrap(flush_stderr)
                            end
    )
end

init_dzen()
for key in pairs(dzen_tab) do
    timers[key] = notioncore.create_timer()
	callbacks[key] = loadstring("start_execute("..key..")")
    start_execute(key)
end
