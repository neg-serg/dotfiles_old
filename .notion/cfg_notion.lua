require("lfs")
os.setlocale(os.getenv("LANG"))

home_        = os.getenv("HOME")
notion_path_ = home_ .. "/.notion/"
core = notioncore

dofile(notion_path_.."load_file"..".lua")

local mod_list = {
    "mod_notionflux",    -- socket-based notion ipc
    "mod_tiling",        -- static tiling notion module
    "mod_xrandr",        -- xrandr support for notion
    "mod_dock",          -- dock support for notion
    "mod_xkbevents",     -- xkbevents support
}

local cfg_list = { 
    "lib/dbg",               -- functions for stderr debbuging
    "lib/app",               -- module to jump by class, tag, instance etc
    "cfg_settings",          -- notioncore.set
    "cfg_rules",             -- window placement rules
    "cfg_layouts",           -- a bunch of default layouts
    "lib/named_scratchpad",  -- named scratchpad module
    "lib/hide_tabs",         -- hide tabs
    "lib/net_client_list",   -- net client list to provide `wmctrl -l`
    "lib/directions",        -- 2bwm-like directions
    "lib/screenshot",        -- screenshot script
    "cfg_dzen",              -- dzen config
    "rofi",                  -- rofi module for menu
    "functions",             -- helpers. Primarily for cfg_kb.lua
    "cfg_kb",                -- keybindings
    "cfg_xrandr",            -- xrandr config
    "transparency",          -- autoset transparency
    "lua_repl",              -- experimental script standalone lua repl
}

for _,mod in ipairs(mod_list) do
    dopath(mod)
end

for _,mod in ipairs(cfg_list) do
    load_file(mod)
end
