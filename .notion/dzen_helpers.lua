function wrp(tmplte)
    return "^fg(#287373)[^fg(#cccccc) " .. tmplte .. " ^fg(#287373)]^fg(#cccccc)"
end

function wrp2(tmplte)
    return "^fg(#287373)[^fg(#cccccc)" .. tmplte .. "^fg(#287373)]^fg(#cccccc)"
end

function dzen_update()
    local template = ""
    if date then
        template = template.."^pa(2;)^bg(#000000)^ba()"..wrp(date).."^ba()^bg()"
    end
    if ws_curr then
            template = template..wrp(ws_curr)
    end
    if kbd_template then
            template = template..wrp(kbd_template)
    end
    if netmon then 
        template = template..wrp("net: " .. netmon)
    end
    dzen_pipe:write(template..'\n')
end

function mpd_dzen_update()
    local template = ""
    if mpd_status then
        template = template..mpd_status
    end
    mpd_pipe:write(template..'\n')
end
