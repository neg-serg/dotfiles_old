function create_run_env(mplex)
    local origenv
    if _ENV then origenv=_ENV else origenv=getfenv() end
    local meta={__index=origenv, __newindex=origenv}
    local env={
        _=mplex, 
        _sub=mplex:current(),
        print=my_print
    }
    setmetatable(env, meta)
    return env
end

function do_handle_lua(mplex, env, code)
    local print_res
    local function collect_print(...)
        local tmp=""
        local arg={...}
        local l=#arg
        for i=1,l do
            tmp=tmp..tostring(arg[i])..(i==l and "\n" or "\t")
        end
        print_res=(print_res and print_res..tmp or tmp)
    end


    if _ENV then
        env.print=collect_print
        local f, err=load(code,nil, nil, env)
        if not f then
            dbg.echon("err="..err)
            return
        end
        err=collect_errors(f)
    else
        local f, err=loadstring(code)
        if not f then
            dbg.echon("err="..err)
            return
        end
        env.print=collect_print
        setfenv(f, env)
        err=collect_errors(f)
    end

    -- if err then
    --     mod_query.warn(mplex, err)
    -- elseif print_res then
    --     mod_query.message(mplex, print_res)
    -- end
    -- if not err then
    --     if print_res then
    --         print(print_res)
    --     end
    -- end
    dbg.echon("print_res="..print_ress)
end

local function getindex(t)
    local mt=getmetatable(t)
    if mt then return mt.__index end
    return nil
end

function do_complete_lua(env, str)
    -- Get the variable to complete, including containing tables.
    -- This will also match string concatenations and such because
    -- Lua's regexps don't support optional subexpressions, but we
    -- handle them in the next step.
    local comptab=env
    local metas=true
    local _, _, tocomp=string.find(str, "([%w_.:]*)$")
    
    -- Descend into tables
    if tocomp and string.len(tocomp)>=1 then
        for t in string.gmatch(tocomp, "([^.:]*)[.:]") do
            metas=false
            if string.len(t)==0 then
                comptab=env;
            elseif comptab then
                if type(comptab[t])=="table" then
                    comptab=comptab[t]
                elseif type(comptab[t])=="userdata" then
                    comptab=getindex(comptab[t])
                    metas=true
                else
                    comptab=nil
                end
            end
        end
    end
    
    if not comptab then return {} end
    
    local compl={}
    
    -- Get the actual variable to complete without containing tables
    _, _, compl.common_beg, tocomp=string.find(str, "(.-)([%w_]*)$")
    
    local l=string.len(tocomp)
    
    local tab=comptab
    local seen={}
    while true do
        if type(tab) == "table" then
            for k in pairs(tab) do
                if type(k)=="string" then
                    if string.sub(k, 1, l)==tocomp then
                        table.insert(compl, k)
                    end
                end
            end
        end

        -- We only want to display full list of functions for objects, not 
        -- the tables representing the classes.
        --if not metas then break end
        
        seen[tab]=true
        tab=getindex(tab)
        if not tab or seen[tab] then break end
    end
    
    -- If there was only one completion and it is a string or function,
    -- concatenate it with "." or "(", respectively.
    if #compl==1 then
        if type(comptab[compl[1]])=="table" then
            compl[1]=compl[1] .. "."
        elseif type(comptab[compl[1]])=="function" then
            compl[1]=compl[1] .. "("
        end
    end
    
    return compl
end


--DOC
-- This query asks for Lua code to execute. It sets the variable '\var{\_}'
-- in the local environment of the string to point to the mplex where the
-- query was created. It also sets the table \var{arg} in the local
-- environment to \code{\{_, _:current()\}}.
function query_lua(mplex)
    local env=create_run_env(mplex)
    
    local function complete(cp, code)
        cp:set_completions(do_complete_lua(env, code))
    end
    
    local function handler(mplex, code)
        return do_handle_lua(mplex, env, code)
    end
    
    -- query(mplex, TR("Lua code:"), nil, handler, complete, "lua")
end

-- }}}

function query_lua_code(mplex, code)
    local env=create_run_env(mplex)
    print(do_complete_lua(env, code))
end

function execute_luacode(code)
    local scr = ioncore.find_screen_id(0)
    local cur = scr:mx_current()
    local cur_tile = cur:current()

    local env=create_run_env(cur_tile)
    do_handle_lua(cur_tile, env, code)
end

function print_lua(code)
    local scr = ioncore.find_screen_id(0)
    local cur = scr:mx_current()
    local cur_tile = cur:current()

    local env=create_run_env(cur_tile)
    dbg.echon( do_complete_lua(env, code) )
end
