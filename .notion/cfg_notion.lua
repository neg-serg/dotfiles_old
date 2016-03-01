function load_file(path)
    local home_ = os.getenv("HOME")
    local notion_dir_ = home_ .. "/.notion/"
    if type(path) == "string" then
        file_path=notion_dir_..path..".lua"
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

load_file("cfg_settings")
load_file("cfg_rules")
load_file("autoprop")
load_file("cfg_layouts")
load_file("app")
load_file("named_scratchpad")
load_file("min_tabs")
load_file("net_client_list")
load_file("directions")
load_file("screenshot")
load_file("cfg_dzen")
load_file("rofi")
load_file("cfg_autostart")
load_file("functions")
load_file("cfg_kb")
load_file("cfg_xrandr")
load_file("transparency")
load_file("dzen_bg")
load_file("lua_repl")
load_file("dbg")
