dbg = {}

function dbg.echon(s)
        io.stderr:write(dbg.tostring(s))
end

function dbg.tostring(obj)
        local mt
        local tname
        local o
        if type(obj) == 'userdata' then
                mt = getmetatable(obj)
                o = '['
                if mt and mt.__index then
                        tname = mt.__index.__typename
                        if tname then
                                o = o .. tname
                        end
                end
                if obj.name then
                        if tname and tname == 'WClientWin' then
                                o = o .. ': ' .. dbg.tostring(obj:get_ident())
                        else
                                o = o .. ': ' .. obj:name()
                        end
                end
                return o .. ']'
        elseif type(obj) == 'table' then
                o = '{'
                sep = ''
                for k, v in pairs(obj)
                do
                    o = o .. sep .. dbg.tostring(k) .. '='
                    o = o .. dbg.tostring(v)
                    sep = ', '
                end
                return o .. '}'
        end
        return tostring(obj)
end

--[[ Save Table to File Load Table from File v 1.0 
Lua 5.2 compatible

Only Saves Tables, Numbers and Strings
Insides Table References are saved
Does not save Userdata, Metatables, Functions and indices of these
----------------------------------------------------
table.save( table , filename )

on failure: returns an error msg

----------------------------------------------------
table.load( filename or stringtable )

Loads a table that has been saved via the table.save function

on success: returns a previously saved table
on failure: returns as second argument an error msg
----------------------------------------------------

Licensed under the same terms as Lua itself.
]]--
do
-- declare local variables
--// exportstring( string )
--// returns a "Lua" portable version of the string
local function exportstring( s )
   return string.format("%q", s)
end

--// The Save Function
function table.save(  tbl,filename )
   local charS,charE = "   ","\n"
   local file,err = io.open( filename, "wb" )
   if err then return err end

   -- initiate variables for save procedure
   local tables,lookup = { tbl },{ [tbl] = 1 }
   file:write( "return {"..charE )

   for idx,t in ipairs( tables ) do
      file:write( "-- Table: {"..idx.."}"..charE )
      file:write( "{"..charE )
      local thandled = {}

      for i,v in ipairs( t ) do
         thandled[i] = true
         local stype = type( v )
         -- only handle value
         if stype == "table" then
            if not lookup[v] then
               table.insert( tables, v )
               lookup[v] = #tables
            end
            file:write( charS.."{"..lookup[v].."},"..charE )
         elseif stype == "string" then
            file:write(  charS..exportstring( v )..","..charE )
         elseif stype == "number" then
            file:write(  charS..tostring( v )..","..charE )
         end
      end

      for i,v in pairs( t ) do
         -- escape handled values
         if (not thandled[i]) then
         
            local str = ""
            local stype = type( i )
            -- handle index
            if stype == "table" then
               if not lookup[i] then
                  table.insert( tables,i )
                  lookup[i] = #tables
               end
               str = charS.."[{"..lookup[i].."}]="
            elseif stype == "string" then
               str = charS.."["..exportstring( i ).."]="
            elseif stype == "number" then
               str = charS.."["..tostring( i ).."]="
            end
         
            if str ~= "" then
               stype = type( v )
               -- handle value
               if stype == "table" then
                  if not lookup[v] then
                     table.insert( tables,v )
                     lookup[v] = #tables
                  end
                  file:write( str.."{"..lookup[v].."},"..charE )
               elseif stype == "string" then
                  file:write( str..exportstring( v )..","..charE )
               elseif stype == "number" then
                  file:write( str..tostring( v )..","..charE )
               end
            end
         end
      end
      file:write( "},"..charE )
   end
   file:write( "}" )
   file:close()
end

--// The Load Function
function table.load( sfile )
   local ftables,err = loadfile( sfile )
   if err then return _,err end
   local tables = ftables()
   for idx = 1,#tables do
      local tolinki = {}
      for i,v in pairs( tables[idx] ) do
         if type( v ) == "table" then
            tables[idx][i] = tables[v[1]]
         end
         if type( i ) == "table" and tables[i[1]] then
            table.insert( tolinki,{ i,tables[i[1]] } )
         end
      end
      -- link indices
      for _,v in ipairs( tolinki ) do
         tables[idx][v[2]],tables[idx][v[1]] =  tables[idx][v[1]],nil
      end
   end
   return tables[1]
end
-- close do
end

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


