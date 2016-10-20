local function date_update()
    dmain.date = os.date("%H:%M")
    dzen_update()
    date_timer:set((60-os.date("%S"))*1000, date_update)
end

date_timer = notioncore.create_timer()
date_timer:set(1000, date_update)
