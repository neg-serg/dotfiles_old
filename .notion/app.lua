app={}
moveapp={}

function app.match_class(class, instance)
    -- Return matching client windows as a table.
    -- If the current window is among them, it's placed last on the list
    -- and its successor at the beginning of the list. This facilitates
    -- cycling multiple windows of an application.
    local result = {}
    local offset = 0
    local currwin = ioncore.current()
    ioncore.clientwin_i(function (win)
        if class == win:get_ident().class then
            if instance then
                if instance == win:get_ident().instance then
                    table.insert(result, #(result)-offset+1, win)
                end
            else
                table.insert(result, #(result)-offset+1, win)
            end
        end
        if win == currwin then
            -- Current client window found, continue filling the table from
            -- the beginning.
            offset = #(result)
        end
        return true
    end)

    return result
end

function app.byname(prog, name, where)
    local win = ioncore.lookup_clientwin(name)
    if win then
        ioncore.defer(function () win:goto_focus() end)
    else
        if where then
            ioncore.exec_on(where, prog)
        else
            ioncore.exec(prog)
        end
    end
end

function app.byclass(prog, class, where)
    local win = app.match_class(class)[1]
    if win then
        ioncore.defer(function () win:goto_focus() end)
    else
        if where then
            ioncore.exec_on(where, prog)
        else
            ioncore.exec(prog)
        end
    end
end

function app.byinstance(prog, class, instance, where)
    local win = app.match_class(class, instance)[1]
    if win then
        ioncore.defer(function () win:goto_focus() end)
    else
        if where then
            ioncore.exec_on(where, prog)
        else
            ioncore.exec(prog)
        end
    end
end

function app.match_class_withtag(class, instance, tag)
    local result = {}
    local offset = 0
    local currwin = ioncore.current()
    ioncore.clientwin_i(function (win)
        local winprop = ioncore.getwinprop(win)
        if winprop and winprop.tag and winprop.tag == tag then
            table.insert(result, #(result)-offset+1, win)
        end
        if class == win:get_ident().class then
            if instance then
                if instance == win:get_ident().instance then
                    table.insert(result, #(result)-offset+1, win)
                end
            else
                table.insert(result, #(result)-offset+1, win)
            end
        end
        if win == currwin then
            -- Current client window found, continue filling the table from
            -- the beginning.
            offset = #(result)
        end
        return true
    end)
    return result
end

function app.byclass_withtag(prog, class, where, tag)
    local win = app.match_class_withtag(class,nil,tag)[1]
    if win then
        ioncore.defer(function () win:goto_focus() end)
    else
        if where then
            ioncore.exec_on(where, prog)
        else
            ioncore.exec(prog)
        end
    end
end

function app.byinstance_withtag(prog, class, instance, where, tag)
    local win = app.match_class_withtag(class, instance, tag)[1]
    if win then
        ioncore.defer(function () win:goto_focus() end)
    else
        if where then
            ioncore.exec_on(where, prog)
        else
            ioncore.exec(prog)
        end
    end
end

function moveapp.byclass(ws, class)
    local win = app.match_class(class)[1]
    if win then
        local frame = ws:current()
        frame:attach(win, { switchto = true })
        win:goto_focus()
    end
end
