home_ = os.getenv("HOME")
notion_path_ = home_ .. "/.notion/"

function load_file(path)
    if type(path) == "string" then
        file_path=notion_path_..path..".lua"
        local f=io.open(file_path,"r")
        if f~=nil then 
            --file exists
            io.close(f)
            dofile(file_path)
        else 
            --file not exists
        end
    end
end

dopath("mod_notionflux")
dopath("mod_tiling")
dopath("mod_xrandr")
dopath("mod_dock")
dopath("mod_xkbevents")

local cfg_list = { 
    "dbg",               -- functions for stderr debbuging
    "cfg_settings",      -- notioncore.set
    "cfg_rules",         -- window placement rules
    "autoprop",          -- autoprop module
    "cfg_layouts",       -- a bunch of default layouts
    "app",               -- module to jump by class, tag, instance etc
    "named_scratchpad",  -- named scratchpad module
    "min_tabs",          -- hide tabs
    "net_client_list",   -- net client list to provide `wmctrl -l`
    "directions",        -- 2bwm-like directions
    "screenshot",        -- screenshot script
    "cfg_dzen",          -- dzen config
    "rofi",              -- rofi module for menu
    "cfg_autostart",     -- apps autostart
    "functions",         -- helpers. Primarily for cfg_kb.lua
    "cfg_kb",            -- keybindings
    "cfg_xrandr",        -- xrandr config
    "transparency",      -- autoset transparency
    "dzen_bg",           -- background reader for dzen
    "lua_repl",          -- Lua REPL
}

for i,mod in ipairs(cfg_list) do
    load_file(mod)
end
