function mod_query.query_lua(mplex)
    local env=mod_query.create_run_env(mplex)

    local function complete(cp, code)
        cp:set_completions(mod_query.do_complete_lua(env, code))
    end

    local function handler(mplex, code)
        return mod_query.do_handle_lua(mplex, env, code)
    end

    mod_query.query(mplex, TR("Lua code:"), nil, handler, complete, "lua")
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

    local f, err=loadstring(code)
    if not f then
        mod_query.warn(mplex, err)
        return
    end

    env.print=collect_print
    setfenv(f, env)

    local result
    err=collect_errors(function () result = f() end)

    if err then
        mod_query.warn(mplex, err)
    elseif print_res then
       mod_query.message(mplex, print_res .. "\nResult: "..tostring(result))
    end
end

function repl(ws)
   local env=mod_query.create_run_env(ws)

   local function complete(cp, code)
        cp:set_completions(mod_query.do_complete_lua(env, code))
     end

   local function handler(mplex, code)
      return do_handle_lua(mplex, env, code)
   end

mod_query.query(ws, "[Lua] >> ", nil, handler, complete, "lua")
end


