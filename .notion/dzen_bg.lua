--------------------------------------------------------------------------------------------------------------------------------------------
mpd_pipe = io.popen("dzen2 -dock -bg '#000000' -h 19 -tw 0  -x 0 -ta r -w 910 -p -fn 'PragmataPro for Powerline:style=bold:size=12' ", "w")
mpd_pipe:setvbuf("line")

local mpd_defaults={
    update_interval=500, -- 500 or less makes seconds increment relatively smoothly while playing
    address="localhost", -- mpd server info (localhost:6600 are mpd defaults)
    port=6600,
    password=nil, -- mpd password (if any)
}

--------------------------------------------------------------------------------------------------------------------------------------------

if not dzen_tab then
    dzen_tab = {
        { t = 'dateb', prog = 'lua ~/.notion/mpd.lua', delay = 1 * 1000, },
    }
end

local timers = {}
local callbacks = {}

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

-- Execute a program.  This will continuously retrieve output from the program.
function start_execute(key)
   -- Read output from the program and (if data) then update the statusbar
   local handle_output_changes = coroutine.create(
       function(input_data)
            local key = input_data
            local data = ""
            local partial_data = ""
            -- Keep reading data until we have it all
            while partial_data do
                data = data .. partial_data
                -- Yield until we get more input.
                -- popen_bgread will call resume on us.
                partial_data = coroutine.yield()
            end
        
            -- If no updates, then just schedule another run
            if not data or data == "" then
                return timers[key]:set(dzen_tab[key].delay, callbacks[key])
            end
        
            -- remove all but the last line
            data = string.gsub( data, "\n$", "" )
            data = string.gsub( data, ".*\n", "" );
        
            local sets = dzen_tab[key]
            local t_key = sets.t
            local t_length = sets.meter_length
            local h_regexp = sets.hint_regexp
        
            if not tlength or t_length < 1 then
                t_length = string.len( data )
            end

            mpc = data
            -- mod_statusbar.inform( t_key, data )
            -- mod_statusbar.inform(t_key .. "_template", string.rep( ' ', t_length))
        
            if not h_regexp then h_regexp = {} end
        
            -- mod_statusbar.update()
            mpd_dzen_update()
        
            return timers[key]:set(
                    dzen_tab[key].delay,
                    callbacks[key])
                    end
                )

            -- We need to pass it the key before calling a background call.
            coroutine.resume(handle_output_changes, key)
            notioncore.popen_bgread(dzen_tab[key].prog,
                                    function(cor) coroutine.resume(handle_output_changes, cor) end,
                                    coroutine.wrap(flush_stderr))
end

for key in pairs(dzen_tab) do
    timers[key] = notioncore.create_timer()
	callbacks[key] = loadstring("start_execute("..key..")")
    start_execute(key)
end

function mpd_dzen_update()
    mpd_pipe:write(mpc..'\n')
end
