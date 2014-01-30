dbg = {}
function dbg.echo(s)
        dbg.echon(s)
        dbg.echon('\n')
end

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
