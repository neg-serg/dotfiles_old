sp_app = {}

local sp_app_private = {}

local sp_apps = {}
local sp_launching = {}
local sp_launched = {}

local function add_to_apps (xid, spname, table)
    sp_apps[xid] = spname
    sp_launching[table] = nil
    sp_launched[spname] = true
end

function sp_app_private.mapped_hook (clientwin)
    local class = clientwin:get_ident().class
    local instance = clientwin:get_ident().instance
    local name = clientwin:name()
    dbg.echo("Class: "..class.."\tInstance: "..instance..
        "\t\tTitle: "..name.."\tXid: "..clientwin:xid())
    dbg.echo(sp_launching)
    dbg.echo(sp_launched)
    for k, v in pairs(sp_launching) do
        dbg.echo("c: "..k.class.." i: "..k.instance)
        if k.instance then
            dbg.echo("a")
            if k.instance == instance and k.class == class then
            dbg.echo("b")
                add_to_apps(clientwin:xid(), v, k)
            end
        elseif k.class then
            if k.class == class then
                add_to_apps(clientwin:xid(), v, k)
            end
        elseif k.name == name then
            add_to_apps(clientwin:xid(), v, k)
        end
    end
end

function sp_app_private.unmapped_hook (xid)
    dbg.echo("Xid: "..xid)
    dbg.echo(sp_apps)
    if sp_apps[xid] then
        local sp = ioncore.lookup_region(sp_apps[xid], "WFrame")
        dbg.echo("sp")
        dbg.echo(sp)
        dbg.echo(sp_apps[xid])
            mod_sp.set_shown(sp, "unset")
        sp_launched[sp_apps[xid]]=nil
        sp_apps[xid] = nil
    end
end

function sp_app_private.init ()
    ioncore.get_hook("clientwin_mapped_hook"):add(sp_app_private.mapped_hook)
    ioncore.get_hook("clientwin_unmapped_hook"):add(sp_app_private.unmapped_hook)
end

function sp_app.deinit ()
    ioncore.get_hook("clientwin_mapped_hook"):remove(sp_app_private.mapped_hook)
    ioncore.get_hook("clientwin_unmapped_hook"):remove(sp_app_private.unmapped_hook)
end

function sp_app.toggle (reg, cmdline, mtable)
    local spname;
    local mtype;
    if mtable.instance then
        mtype="instance"
        spname=mtable.instance
    else
        mtype="class"
        spname=mtable.class
    end

    if reg:current():name() == spname then
            named_scratchpad(reg, spname, "unset")
    else
            named_scratchpad(reg, spname, "set")
        if not sp_launched[spname] then
            sp_launching[mtable] = spname
            if mtype=="class" then
                    app.byclass(cmdline, mtable.class)
            elseif mtype=="instance" then
                app.byinstance(cmdline, mtable.class, mtable.instance)
            end
        end
    end
end

sp_app_private.init()
