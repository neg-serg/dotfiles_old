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
    "dbg",
    "cfg_settings",   
    "cfg_rules",
    "autoprop",       
    "cfg_layouts",
    "app",            
    "named_scratchpad",
    "min_tabs",       
    "net_client_list",
    "directions",     
    "screenshot",
    "cfg_dzen",       
    "rofi",
    "cfg_autostart",  
    "functions",
    "cfg_kb",         
    "cfg_xrandr",
    "transparency",   
    "dzen_bg",
    "lua_repl",       
}

for i,mod in ipairs(cfg_list) do
    load_file(mod)
end
